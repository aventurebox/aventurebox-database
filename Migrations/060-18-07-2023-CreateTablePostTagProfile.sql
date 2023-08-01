/*
 Migration  : 060 Developer  : Giselle Hoekveld
 Data       : 18-07-2023
 Description: Cria tabela post_tag_profile e insere novos tipos de notificações
*/

--------------- AVENTUREBOX LOG --------------------
CREATE TABLE post_tag_profile_log(
	id SERIAL NOT NULL PRIMARY KEY,
	id_post INT NOT NULL,
	id_user INT NOT NULL,
	notified BOOLEAN DEFAULT FALSE,
	show_profile BOOLEAN DEFAULT TRUE,
	approved BOOLEAN NOT NULL DEFAULT FALSE,
	type_log INTEGER,
	dt_log TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
--------------- END AVENTUREBOX LOG --------------------

--------------- AVENTUREBOX --------------------
CREATE TABLE post_tag_profile(
	id SERIAL NOT NULL PRIMARY KEY,
	id_post INT NOT NULL,
	id_user INT NOT NULL,
	notified BOOLEAN DEFAULT FALSE,
	show_profile BOOLEAN DEFAULT TRUE,
	approved BOOLEAN NOT NULL DEFAULT FALSE,
	FOREIGN KEY (id_post) REFERENCES post(id) ON DELETE CASCADE,
	FOREIGN KEY (id_user) REFERENCES user_profile(id) ON DELETE CASCADE
);

INSERT INTO notification_type(id, name) VALUES (21, 'post_tag_profile');
INSERT INTO notification_type(id, name) VALUES (22, 'comment_on_post_profile_tagged');
INSERT INTO notification_type(id, name) VALUES (23, 'post_tag_profile_approved');
INSERT INTO notification_type(id, name) VALUES (24, 'post_tag_profile_denied');

--------------- FOREIGN TABLES 
CREATE FOREIGN TABLE post_tag_profile_log (
	id_post INT NOT NULL,
	id_user INT NOT NULL,
	notified BOOLEAN DEFAULT FALSE,
	show_profile BOOLEAN DEFAULT TRUE,
	approved BOOLEAN NOT NULL DEFAULT FALSE,
	type_log INTEGER,
	dt_log TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) SERVER aventurebox_log OPTIONS (table_name 'post_tag_profile_log');

--------------- TRIGGERS
CREATE FUNCTION fn_post_tag_profile_delete()
	RETURNS trigger
	LANGUAGE 'plpgsql'
	COST 100
	VOLATILE NOT LEAKPROOF 
AS $BODY$
BEGIN
INSERT INTO post_tag_profile_log(type_log,dt_log,id_post,id_user,notified,show_profile,approved)
	VALUES (3,NOW(),old.id_post,old.id_user,old.notified,old.show_profile,old.approved);
	return old;
	END; 
	$BODY$;
CREATE TRIGGER tg_post_tag_profile_delete AFTER DELETE ON post_tag_profile FOR EACH ROW EXECUTE PROCEDURE fn_post_tag_profile_delete();

CREATE FUNCTION fn_post_tag_profile_update()
	RETURNS trigger
	LANGUAGE 'plpgsql'
	COST 100
	VOLATILE NOT LEAKPROOF 
AS $BODY$
BEGIN
INSERT INTO post_tag_profile_log(type_log,dt_log,id_post,id_user,notified,show_profile,approved)
	VALUES (2,NOW(),old.id_post,old.id_user,old.notified,old.show_profile,old.approved);
	return old;
	END; 
	$BODY$;
CREATE TRIGGER tg_post_tag_profile_update AFTER UPDATE ON post_tag_profile FOR EACH ROW EXECUTE PROCEDURE fn_post_tag_profile_update();

grant select on all tables in schema public to "user-production";
grant insert on all tables in schema public to "user-production";
grant update on all tables in schema public to "user-production";
grant delete on all tables in schema public to "user-production";
grant all privileges on all sequences in schema public to "user-production";

INSERT INTO migration VALUES(60, 'Cria tabela post_tag_profile e insere novos tipos de notificações', '2023-7-18', now());
--------------- END AVENTUREBOX --------------------