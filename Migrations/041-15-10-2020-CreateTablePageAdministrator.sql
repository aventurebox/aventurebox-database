/*
 Migration  : 041 Developer  : Alex Souza
 Data       : 15-10-2020
 Description: Cria tabela de administradores das paginas;
*/

CREATE TABLE user_page_admin (
	id SERIAL NOT NULL PRIMARY KEY,
	id_user_page INT NOT NULL,
	id_user_admin INT NOT NULL,
	dt_request TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
	dt_accept TIMESTAMP WITHOUT TIME ZONE,
	UNIQUE(id_user_page, id_user_admin),
	FOREIGN KEY(id_user_page) REFERENCES user_profile(id) ON DELETE CASCADE,
	FOREIGN KEY(id_user_admin) REFERENCES user_login(id) ON DELETE CASCADE
);

CREATE FUNCTION fn_user_page_admin_trigger_log() 
	RETURNS trigger
AS $BODY$
    BEGIN
        IF (TG_OP = 'DELETE') THEN
            INSERT INTO user_page_admin_log(id_user_page_admin, type_log, dt_log, id_user_page, id_user_admin, dt_request, dt_accept)
            VALUES (old.id, 3, NOW(), old.id_user_page, old.id_user_admin, old.dt_request, old.dt_accept);
            RETURN old;
        ELSIF (TG_OP = 'UPDATE') THEN
            INSERT INTO user_page_admin_log(id_user_page_admin, type_log, dt_log, id_user_page, id_user_admin, dt_request, dt_accept)
            VALUES (new.id, 2, NOW(), new.id_user_page, new.id_user_admin, new.dt_request, new.dt_accept);
            RETURN new;
        ELSIF (TG_OP = 'INSERT') THEN
            INSERT INTO user_page_admin_log(id_user_page_admin, type_log, dt_log, id_user_page, id_user_admin, dt_request, dt_accept)
            VALUES (new.id, 1, NOW(), new.id_user_page, new.id_user_admin, new.dt_request, new.dt_accept);
            RETURN new;
        END IF;
        RETURN NULL;
    END;
$BODY$ LANGUAGE plpgsql COST 100 VOLATILE NOT LEAKPROOF;

CREATE FUNCTION fn_user_page_admin_trigger_constraint()
	RETURNS trigger
AS $BODY$
	BEGIN
		IF (SELECT type FROM user_profile WHERE id = new.id_user_page) = 1
		THEN
			RAISE EXCEPTION 'fn_user_page_admin_exception - only pages can have administrators';
		END IF;
		RETURN new;
	END;
$BODY$ LANGUAGE plpgsql COST 100 VOLATILE NOT LEAKPROOF;

CREATE TRIGGER tg_user_page_admin_log AFTER INSERT OR UPDATE OR DELETE ON user_page_admin FOR EACH ROW EXECUTE PROCEDURE fn_user_page_admin_trigger_log();
CREATE TRIGGER tg_user_page_admin_constraint BEFORE INSERT ON user_page_admin FOR EACH ROW EXECUTE PROCEDURE fn_user_page_admin_trigger_constraint();

CREATE FOREIGN TABLE user_page_admin_log (
	type_log INT,
	dt_log TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	id_user_page_admin INT NOT NULL,
	id_user_page INT NOT NULL,
	id_user_admin INT NOT NULL,
	dt_request TIMESTAMP WITHOUT TIME ZONE,
	dt_accept TIMESTAMP WITHOUT TIME ZONE
) SERVER aventurebox_log OPTIONS (table_name 'user_page_admin_log');


ALTER TABLE session_app ADD COLUMN id_user_login INT NOT NULL DEFAULT 0;
ALTER TABLE session_app ALTER COLUMN id_user_login DROP DEFAULT;
BEGIN TRANSACTION;
UPDATE session_app SET id_user_login = q.id_user_login FROM (SELECT id, id_user_login FROM user_profile) AS q WHERE session_app.id_user = q.id;
END TRANSACTION;
ALTER TABLE session_app ADD FOREIGN KEY(id_user_login) REFERENCES user_login(id) ON DELETE CASCADE;

CREATE FOREIGN TABLE session_app_log (
	type_log INT,
	dt_log TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	id_user INT NOT NULL,
	token TEXT NOT NULL,
	user_agent TEXT,
	date TIMESTAMP,
	data TEXT,
	id_device VARCHAR(200),
	lang VARCHAR(5),
	id_user_login INT
) SERVER aventurebox_log OPTIONS (table_name 'session_app_log');

CREATE FUNCTION fn_session_app_trigger_log() 
	RETURNS trigger
AS $BODY$
    BEGIN
        IF (TG_OP = 'DELETE') THEN
            INSERT INTO session_app_log(type_log, dt_log, id_user, token, user_agent, date, data, id_device, lang, id_user_login)
            VALUES (3, NOW(), old.id_user, old.token, old.user_agent, old.date, old.data, old.id_device, old.lang, old.id_user_login);
            RETURN old;
        ELSIF (TG_OP = 'UPDATE') THEN
            INSERT INTO session_app_log(type_log, dt_log, id_user, token, user_agent, date, data, id_device, lang, id_user_login)
            VALUES (2, NOW(), new.id_user, new.token, new.user_agent, new.date, new.data, new.id_device, new.lang, new.id_user_login);
            RETURN new;
        ELSIF (TG_OP = 'INSERT') THEN
            INSERT INTO session_app_log(type_log, dt_log, id_user, token, user_agent, date, data, id_device, lang, id_user_login)
            VALUES (1, NOW(), new.id_user, new.token, new.user_agent, new.date, new.data, new.id_device, new.lang, new.id_user_login);
            RETURN new;
        END IF;
        RETURN NULL;
    END;
$BODY$ LANGUAGE plpgsql COST 100 VOLATILE NOT LEAKPROOF;
CREATE TRIGGER tg_session_app_log AFTER INSERT OR UPDATE OR DELETE ON session_app FOR EACH ROW EXECUTE PROCEDURE fn_session_app_trigger_log();

INSERT INTO notification_type(id, name) VALUES (14, 'page_admin_add');
INSERT INTO notification_type(id, name) VALUES (15, 'page_admin_accepted');
INSERT INTO notification_type(id, name) VALUES (16, 'page_admin_denied');

grant select on all tables in schema public to "aventurebox";
grant insert on all tables in schema public to "aventurebox";
grant update on all tables in schema public to "aventurebox";
grant delete on all tables in schema public to "aventurebox";
grant all privileges on all sequences in schema public to "aventurebox";

INSERT INTO migration VALUES(41, 'Cria tabela de administradores das paginas e log', '2020-10-15', now());

--------------- AVENTUREBOX ANALYTICS MIGRATION --------------------

CREATE TABLE user_page_admin_log (
	id BIGSERIAL NOT NULL PRIMARY KEY,
	type_log INT,
	dt_log TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	id_user_page_admin INT NOT NULL,
	id_user_page INT NOT NULL,
	id_user_admin INT NOT NULL,
	dt_request TIMESTAMP WITHOUT TIME ZONE,
	dt_accept TIMESTAMP WITHOUT TIME ZONE
);

CREATE TABLE session_app_log (
	id BIGSERIAL NOT NULL PRIMARY KEY,
	type_log INT,
	dt_log TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	id_user INT NOT NULL,
	token TEXT NOT NULL,
	user_agent TEXT,
	date TIMESTAMP,
	data TEXT,
	id_device VARCHAR(200),
	lang VARCHAR(5),
	id_user_login INT
);

grant select on all tables in schema public to "aventurebox";
grant insert on all tables in schema public to "aventurebox";
grant all privileges on all sequences in schema public to "aventurebox";

