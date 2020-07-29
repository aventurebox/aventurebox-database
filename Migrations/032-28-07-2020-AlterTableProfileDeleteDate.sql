/*
 Migration  : 032 Developer  : Alex Souza
 Data       : 28-07-2020
 Description: Alter table user_profile para deletar perfis;
*/

ALTER TABLE user_profile ADD COLUMN dt_delete_request TIMESTAMP;
ALTER TABLE user_profile_log ADD COLUMN dt_delete_request TIMESTAMP;

DROP TRIGGER tg_user_profile_insert ON user_profile;
DROP TRIGGER tg_user_profile_update ON user_profile;
DROP FUNCTION fn_user_profile_insert();
DROP FUNCTION fn_user_profile_update();

CREATE FUNCTION fn_user_profile_insert()
	RETURNS trigger
	LANGUAGE 'plpgsql'
	COST 100
	VOLATILE NOT LEAKPROOF 
AS $BODY$
BEGIN
INSERT INTO user_profile_log(type_log, data_log, id_user_profile, name, picture, dt_register, bio, website, location, token, panoramic_photo, primary_tab, id_user_login, type, user_, inactive, suspended, dt_delete_request)
	VALUES (1, NOW(), new.id, new.name, new.picture, new.dt_register, new.bio, new.website, new.location, new.token, new.panoramic_photo, new.primary_tab, new.id_user_login, new.type, new.user_, new.inactive, new.suspended, new.dt_delete_request);
	return new;
   END; 
	$BODY$;
CREATE TRIGGER tg_user_profile_insert AFTER INSERT ON user_profile FOR EACH ROW EXECUTE PROCEDURE fn_user_profile_insert();

CREATE FUNCTION fn_user_profile_update()
	RETURNS trigger
	LANGUAGE 'plpgsql'
	COST 100
	VOLATILE NOT LEAKPROOF 
AS $BODY$
BEGIN
INSERT INTO user_profile_log(type_log, data_log, id_user_profile, name, picture, dt_register, bio, website, location, token, panoramic_photo, primary_tab, id_user_login, type, user_, inactive, suspended, dt_delete_request)
	VALUES (2, NOW(), new.id, new.name, new.picture, new.dt_register, new.bio, new.website, new.location, new.token, new.panoramic_photo, new.primary_tab, new.id_user_login, new.type, new.user_, new.inactive, new.suspended, new.dt_delete_request);
	return new;
   END; 
	$BODY$;
CREATE TRIGGER tg_user_profile_update AFTER UPDATE ON user_profile FOR EACH ROW EXECUTE PROCEDURE fn_user_profile_update();

CREATE FUNCTION fn_user_profile_delete()
	RETURNS trigger
	LANGUAGE 'plpgsql'
	COST 100
	VOLATILE NOT LEAKPROOF 
AS $BODY$
BEGIN
INSERT INTO user_profile_log(type_log, data_log, id_user_profile, name, picture, dt_register, bio, website, location, token, panoramic_photo, primary_tab, id_user_login, type, user_, inactive, suspended, dt_delete_request)
	VALUES (3, NOW(), old.id, old.name, old.picture, old.dt_register, old.bio, old.website, old.location, old.token, old.panoramic_photo, old.primary_tab, old.id_user_login, old.type, old.user_, old.inactive, old.suspended, old.dt_delete_request);
	return old;
   END; 
	$BODY$;
CREATE TRIGGER tg_user_profile_delete AFTER DELETE ON user_profile FOR EACH ROW EXECUTE PROCEDURE fn_user_profile_delete();


grant select on all tables in schema public to "aventurebox";
grant insert on all tables in schema public to "aventurebox";
grant update on all tables in schema public to "aventurebox";
grant delete on all tables in schema public to "aventurebox";
grant all privileges on all sequences in schema public to "aventurebox";

INSERT INTO migration VALUES(31,'Altera a tabela user_profile para registro da data de solicitao de exclusao do perfil','2020-07-28', now());
