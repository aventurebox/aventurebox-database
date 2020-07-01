/*
 Migration  : 031 Developer  : Alex Souza
 Data       : 30-06-2020
 Description: Alter table user_login e user_profile para uso das paginas;
*/

-- ALTER FOREIGN KEY NAS TABELAS PARA APONTAR PARA O USER_PROFILE;
ALTER TABLE adventure ADD CONSTRAINT adventure_id_user_fkey FOREIGN KEY (id_user) REFERENCES user_profile (id);

ALTER TABLE adventure_comment DROP CONSTRAINT comment_id_user_fkey;
ALTER TABLE adventure_comment ADD CONSTRAINT adventure_comment_id_user_fkey FOREIGN KEY (id_user) REFERENCES user_profile (id);

ALTER TABLE adventure_competition DROP CONSTRAINT adventure_competition_id_user_fkey;
ALTER TABLE adventure_competition ADD CONSTRAINT adventure_competition_id_user_fkey FOREIGN KEY (id_user) REFERENCES user_profile (id);

ALTER TABLE adventure_complaint DROP CONSTRAINT adventure_complaint_id_user_fkey;
ALTER TABLE adventure_complaint ADD CONSTRAINT adventure_complaint_id_user_fkey FOREIGN KEY (id_user) REFERENCES user_profile (id);

ALTER TABLE adventure_hide DROP CONSTRAINT adventure_hide_id_user_fkey;
ALTER TABLE adventure_hide ADD CONSTRAINT adventure_hide_id_user_fkey FOREIGN KEY (id_user) REFERENCES user_profile (id);

ALTER TABLE adventure_participant DROP CONSTRAINT adventure_participant_id_user_fkey;
ALTER TABLE adventure_participant ADD CONSTRAINT adventure_participant_id_user_fkey FOREIGN KEY (id_user) REFERENCES user_profile (id);

ALTER TABLE adventure_rox DROP CONSTRAINT rox_id_user_fkey;
ALTER TABLE adventure_rox ADD CONSTRAINT rox_id_user_fkey FOREIGN KEY (id_user) REFERENCES user_profile (id);

ALTER TABLE concact_refuse DROP CONSTRAINT concact_refuse_id_user_fkey;
ALTER TABLE concact_refuse DROP CONSTRAINT concact_refuse_id_user_fkey1;
ALTER TABLE concact_refuse DROP CONSTRAINT concact_refuse_id_user_refused_fkey;
ALTER TABLE concact_refuse DROP CONSTRAINT concact_refuse_id_user_refused_fkey1;
ALTER TABLE concact_refuse ADD CONSTRAINT concact_refuse_id_user_fkey FOREIGN KEY (id_user) REFERENCES user_profile (id);
ALTER TABLE concact_refuse ADD CONSTRAINT concact_refuse_id_user_refused_fkey FOREIGN KEY (id_user_refused) REFERENCES user_profile (id);

ALTER TABLE contact DROP CONSTRAINT contact_id_user_guest_fkey;
ALTER TABLE contact DROP CONSTRAINT contact_id_user_inviter_fkey;
ALTER TABLE contact ADD CONSTRAINT contact_id_user_follower_fkey FOREIGN KEY (id_user_follower) REFERENCES user_profile (id);
ALTER TABLE contact ADD CONSTRAINT contact_id_user_following_fkey FOREIGN KEY (id_user_following) REFERENCES user_profile (id);

ALTER TABLE email_invite DROP CONSTRAINT id_id_user_login;
ALTER TABLE email_invite ADD CONSTRAINT email_invite_id_user_fkey FOREIGN KEY (id_user) REFERENCES user_profile (id);

ALTER TABLE notification DROP CONSTRAINT notification_id_user_receiver_fkey;
ALTER TABLE notification DROP CONSTRAINT notification_id_user_sender_fkey;
ALTER TABLE notification ADD CONSTRAINT notification_id_user_receiver_fkey FOREIGN KEY (id_user_receiver) REFERENCES user_profile (id);
ALTER TABLE notification ADD CONSTRAINT notification_id_user_sender_fkey FOREIGN KEY (id_user_sender) REFERENCES user_profile (id);

ALTER TABLE post DROP CONSTRAINT post_id_user_fkey;
ALTER TABLE post ADD CONSTRAINT post_id_user_fkey FOREIGN KEY (id_user) REFERENCES user_profile (id);

ALTER TABLE post_comment DROP CONSTRAINT post_comment_id_user_fkey;
ALTER TABLE post_comment ADD CONSTRAINT post_comment_id_user_fkey FOREIGN KEY (id_user) REFERENCES user_profile (id);

ALTER TABLE post_complaint DROP CONSTRAINT post_complaint_id_user_fkey;
ALTER TABLE post_complaint ADD CONSTRAINT post_complaint_id_user_fkey FOREIGN KEY (id_user) REFERENCES user_profile (id);

ALTER TABLE post_hide DROP CONSTRAINT post_hide_id_user_fkey;
ALTER TABLE post_hide ADD CONSTRAINT post_hide_id_user_fkey FOREIGN KEY (id_user) REFERENCES user_profile (id);

ALTER TABLE post_rox DROP CONSTRAINT post_rox_id_user_fkey;
ALTER TABLE post_rox ADD CONSTRAINT post_rox_id_user_fkey FOREIGN KEY (id_user) REFERENCES user_profile (id);

ALTER TABLE session_app DROP CONSTRAINT session_app_id_user_fkey;
ALTER TABLE session_app ADD CONSTRAINT session_app_id_user_fkey FOREIGN KEY (id_user) REFERENCES user_profile (id);

ALTER TABLE thing_rox DROP CONSTRAINT thing_rox_id_user_fkey;
ALTER TABLE thing_rox ADD CONSTRAINT thing_rox_id_user_fkey FOREIGN KEY (id_user) REFERENCES user_profile (id);

ALTER TABLE user_blocked DROP CONSTRAINT user_blocked_id_user_blocked_fkey;
ALTER TABLE user_blocked DROP CONSTRAINT user_blocked_id_user_fkey;
ALTER TABLE user_blocked ADD CONSTRAINT user_blocked_id_user_blocked_fkey FOREIGN KEY (id_user_blocked) REFERENCES user_profile (id);
ALTER TABLE user_blocked ADD CONSTRAINT user_blocked_id_user_fkey FOREIGN KEY (id_user) REFERENCES user_profile (id);

ALTER TABLE user_complaint DROP CONSTRAINT user_complaint_id_user_complaint_fkey;
ALTER TABLE user_complaint DROP CONSTRAINT user_complaint_id_user_fkey;
ALTER TABLE user_complaint ADD CONSTRAINT user_complaint_id_user_complaint_fkey FOREIGN KEY (id_user_complaint) REFERENCES user_profile (id);
ALTER TABLE user_complaint ADD CONSTRAINT user_complaint_id_user_fkey FOREIGN KEY (id_user) REFERENCES user_profile (id);

ALTER TABLE user_featured DROP CONSTRAINT user_featured_id_user_fkey;
ALTER TABLE user_featured ADD CONSTRAINT user_featured_id_user_fkey FOREIGN KEY (id_user) REFERENCES user_profile (id);

ALTER TABLE user_muted DROP CONSTRAINT user_muted_id_user_fkey;
ALTER TABLE user_muted DROP CONSTRAINT user_muted_id_user_muted_fkey;
ALTER TABLE user_muted ADD CONSTRAINT user_muted_id_user_fkey FOREIGN KEY (id_user) REFERENCES user_profile (id);
ALTER TABLE user_muted ADD CONSTRAINT user_muted_id_user_muted_fkey FOREIGN KEY (id_user_muted) REFERENCES user_profile (id);

-- ALTERA A TABELA USER_PROFILE
	-- CRIA O CAMPO PARA O ID_USER_LOGIN (DONO DO PROFILE)
ALTER TABLE user_profile ADD COLUMN id_user_login INT NOT NULL DEFAULT 0;
ALTER TABLE user_profile ALTER COLUMN id_user_login DROP DEFAULT;
ALTER TABLE user_profile DROP CONSTRAINT user_profile_id_fkey;
BEGIN TRANSACTION;
UPDATE user_profile SET id_user_login = user_profile.id;
END TRANSACTION;
ALTER TABLE user_profile ADD CONSTRAINT user_profile_id_user_login_fkey FOREIGN KEY (id_user_login) REFERENCES user_login (id);
    -- TORNA O ID AUTO INCREMENT
CREATE SEQUENCE user_profile_id_seq OWNED BY user_profile.id;
SELECT setval('user_profile_id_seq', coalesce(max(id), 0) + 1, false) FROM user_profile;
ALTER TABLE user_profile ALTER COLUMN id SET DEFAULT nextval('user_profile_id_seq'); 
	-- CRIA UM CAMPO PARA O TIPO DE PERFIL (MEMBRO/PAGINA)
ALTER TABLE user_profile ADD COLUMN user_profile_type INT NOT NULL DEFAULT 1;
ALTER TABLE user_profile ALTER COLUMN user_profile_type DROP DEFAULT;

	-- CRIA OS CAMPOS QUE SERAO TRANSFERIDOS DA TABELA USER_LOGIN
ALTER TABLE user_profile ADD COLUMN user_ VARCHAR(40) NOT NULL DEFAULT '';
ALTER TABLE user_profile ALTER COLUMN user_ DROP DEFAULT;
ALTER TABLE user_profile ADD COLUMN inactive BOOLEAN NOT NULL DEFAULT false;
ALTER TABLE user_profile ADD COLUMN suspended BOOLEAN NOT NULL DEFAULT false;
BEGIN TRANSACTION;
UPDATE user_profile SET user_ = q.user_, inactive = q.inactive, suspended = q.suspended FROM (SELECT id, user_, inactive, suspended FROM user_login) AS q WHERE user_profile.id_user_login = q.id;
END TRANSACTION;

ALTER TABLE user_profile ADD CONSTRAINT user_unique UNIQUE (user_);

-- ALTERA A TABELA USER_LOGIN
	-- CRIA OS CAMPOS QUE SERAO TRANSFERIDOS DA TABELA USER_PROFILE
ALTER TABLE user_login ADD COLUMN genus CHAR(1) NOT NULL DEFAULT '';
ALTER TABLE user_login ALTER COLUMN genus DROP DEFAULT;
ALTER TABLE user_login ADD COLUMN birth DATE NOT NULL DEFAULT NOW();
ALTER TABLE user_login ALTER COLUMN birth DROP DEFAULT;
ALTER TABLE user_login ADD COLUMN language INTEGER NOT NULL DEFAULT 1;
ALTER TABLE user_login ALTER COLUMN language DROP DEFAULT;
ALTER TABLE user_login ADD COLUMN country INTEGER NOT NULL DEFAULT 1;
ALTER TABLE user_login ALTER COLUMN country DROP DEFAULT;
ALTER TABLE user_login ADD COLUMN time_zone INTEGER NOT NULL DEFAULT 1;
ALTER TABLE user_login ALTER COLUMN time_zone DROP DEFAULT;
ALTER TABLE user_login ADD COLUMN period_notification INTEGER NOT NULL DEFAULT 1;
ALTER TABLE user_login ADD COLUMN last_external_notification TIMESTAMP;
ALTER TABLE user_login ADD COLUMN email_failed BOOLEAN DEFAULT false;
ALTER TABLE user_login ADD COLUMN notification_cancel_token VARCHAR(40);
ALTER TABLE user_login ADD COLUMN last_notification_id INTEGER;
BEGIN TRANSACTION;
UPDATE user_login SET genus = q.genus, birth = q.birth, language = q.language, country = q.country, time_zone = q.time_zone, period_notification = q.period_notification, last_external_notification = q.last_external_notification, email_failed = q.email_failed, notification_cancel_token = q.notification_cancel_token, last_notification_id = q.last_notification_id FROM (SELECT id_user_login, genus, birth, language, country, time_zone, period_notification, last_external_notification, email_failed, notification_cancel_token, last_notification_id FROM user_profile) AS q WHERE user_login.id = q.id_user_login;
END TRANSACTION;

-- REMOVE AS COLUNAS COPIADAS
ALTER TABLE user_profile DROP COLUMN genus, DROP COLUMN birth, DROP COLUMN language, DROP COLUMN country, DROP COLUMN time_zone, DROP COLUMN period_notification, DROP COLUMN last_external_notification, DROP COLUMN email_failed,  DROP COLUMN notification_cancel_token, DROP COLUMN last_notification_id;
ALTER TABLE user_login DROP COLUMN user_, DROP COLUMN inactive;

-- ALTERA AS TABELAS, TRIGGERS E FUNCTIONS DE LOG
ALTER TABLE user_profile_log ALTER COLUMN name DROP NOT NULL, ALTER COLUMN picture DROP NOT NULL, ALTER COLUMN birth DROP NOT NULL, ALTER COLUMN genus DROP NOT NULL, ALTER COLUMN dt_register DROP NOT NULL, ALTER COLUMN token DROP NOT NULL, ALTER COLUMN language DROP NOT NULL, ALTER COLUMN country DROP NOT NULL, ALTER COLUMN time_zone DROP NOT NULL;
ALTER TABLE user_profile_log ADD COLUMN id_user_login INTEGER, ADD COLUMN user_profile_type INTEGER, ADD COLUMN user_ VARCHAR(40), ADD COLUMN inactive BOOLEAN, ADD COLUMN suspended BOOLEAN;
ALTER TABLE user_login_log ALTER COLUMN user_ DROP NOT NULL, ALTER COLUMN email DROP NOT NULL, ALTER COLUMN pass DROP NOT NULL, ALTER COLUMN inactive DROP NOT NULL;
ALTER TABLE user_login_log ADD COLUMN genus CHAR(1), ADD COLUMN birth DATE, ADD COLUMN language INTEGER, ADD COLUMN country INTEGER, ADD COLUMN time_zone INTEGER, ADD COLUMN period_notification INTEGER, ADD COLUMN last_external_notification INTEGER, ADD COLUMN email_failed BOOLEAN,  ADD COLUMN notification_cancel_token VARCHAR(40), ADD COLUMN last_notification_id INTEGER;

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
INSERT INTO user_profile_log(type_log, data_log, id_user_profile, name, picture, dt_register, bio, website, location, token, panoramic_photo, primary_tab, id_user_login, user_profile_type, user_, inactive, suspended)
	VALUES (1, NOW(), new.id, new.name, new.picture, new.dt_register, new.bio, new.website, new.location, new.token, new.panoramic_photo, new.primary_tab, new.id_user_login, new.user_profile_type, new.user_, new.inactive, new.suspended);
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
INSERT INTO user_profile_log(type_log, data_log, id_user_profile, name, picture, dt_register, bio, website, location, token, panoramic_photo, primary_tab, id_user_login, user_profile_type, user_, inactive, suspended)
	VALUES (2, NOW(), new.id, new.name, new.picture, new.dt_register, new.bio, new.website, new.location, new.token, new.panoramic_photo, new.primary_tab, new.id_user_login, new.user_profile_type, new.user_, new.inactive, new.suspended);
	return new;
   END; 
	$BODY$;
CREATE TRIGGER tg_user_profile_update AFTER INSERT ON user_profile FOR EACH ROW EXECUTE PROCEDURE fn_user_profile_update();

DROP TRIGGER tg_user_login_insert ON user_login;
DROP TRIGGER tg_user_login_update ON user_login;
DROP FUNCTION fn_user_login_insert();
DROP FUNCTION fn_user_login_update();

CREATE FUNCTION fn_user_login_insert()
	RETURNS trigger
	LANGUAGE 'plpgsql'
	COST 100
	VOLATILE NOT LEAKPROOF 
AS $BODY$
BEGIN
INSERT INTO user_login_log(type_log, data_log, id_user_login, email, pass, cookie_token, cookie_date, pass_reset_token, pass_reset_date, suspended, email_change_token, email_change_date, email_change_new, genus, birth, language, country, time_zone, period_notification, last_external_notification, email_failed, notification_cancel_token, last_notification_id)
	VALUES (1, NOW(), new.id, new.email, new.pass, new.cookie_token, new.cookie_date, new.pass_reset_token, new.pass_reset_date, new.suspended, new.email_change_token, new.email_change_date, new.email_change_new, new.genus, new.birth, new.language, new.country, new.time_zone, new.period_notification, new.last_external_notification, new.email_failed, new.notification_cancel_token, new.last_notification_id);
	return new;
   END; 
	$BODY$;
CREATE TRIGGER tg_user_login_insert AFTER INSERT ON user_login FOR EACH ROW EXECUTE PROCEDURE fn_user_login_insert();

CREATE FUNCTION fn_user_login_update()
	RETURNS trigger
	LANGUAGE 'plpgsql'
	COST 100
	VOLATILE NOT LEAKPROOF 
AS $BODY$
BEGIN
INSERT INTO user_login_log(type_log, data_log, id_user_login, email, pass, cookie_token, cookie_date, pass_reset_token, pass_reset_date, suspended, email_change_token, email_change_date, email_change_new, genus, birth, language, country, time_zone, period_notification, last_external_notification, email_failed, notification_cancel_token, last_notification_id)
	VALUES (2, NOW(), new.id, new.email, new.pass, new.cookie_token, new.cookie_date, new.pass_reset_token, new.pass_reset_date, new.suspended, new.email_change_token, new.email_change_date, new.email_change_new, new.genus, new.birth, new.language, new.country, new.time_zone, new.period_notification, new.last_external_notification, new.email_failed, new.notification_cancel_token, new.last_notification_id);
	return new;
   END; 
	$BODY$;
CREATE TRIGGER tg_user_login_update AFTER INSERT ON user_login FOR EACH ROW EXECUTE PROCEDURE fn_user_login_update();

grant select on all tables in schema public to "aventurebox";
grant insert on all tables in schema public to "aventurebox";
grant update on all tables in schema public to "aventurebox";
grant delete on all tables in schema public to "aventurebox";
grant all privileges on all sequences in schema public to "aventurebox";


INSERT INTO migration VALUES(31,'Altera as tabelas user_login e user_profile para uso das paginas','2020-06-30', now());
