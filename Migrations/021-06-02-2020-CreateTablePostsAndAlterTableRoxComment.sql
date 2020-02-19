/*
 Migration  : 021 Developer  : Alex Souza
 Data       : 06-02-2020
 Description: Create table posts, logs & alter tables rox and comments
*/

-- BEGIN CREATE TABLE FROM POST, POST COMMENTS, POST ROX AND LOGS;
CREATE TABLE post(
	id SERIAL NOT NULL PRIMARY KEY,
	id_user INTEGER NOT NULL,
	title TEXT NOT NULL,
	title_slug TEXT NOT NULL,
	description TEXT,
	token VARCHAR(13) NOT NULL,
	content TEXT NOT NULL,
	dt_publication TIMESTAMP,
	dt_save TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	picture VARCHAR(20),
	panoramic_photo VARCHAR(20),
	published BOOLEAN NOT NULL DEFAULT FALSE,
	views INTEGER DEFAULT 0,
	FOREIGN KEY(id_user) REFERENCES user_login(id),
	UNIQUE (token)
);

CREATE TABLE post_log(
	id SERIAL NOT NULL PRIMARY KEY,
	id_post INTEGER,
	type_log INTEGER, 
	id_user INTEGER,
	title TEXT,
	title_slug TEXT,
	description TEXT,
	token VARCHAR(13),
	content TEXT,
	dt_publication TIMESTAMP,
	dt_save TIMESTAMP,
	picture VARCHAR(20),
	panoramic_photo VARCHAR(20),
	published BOOLEAN,
	views INTEGER,
	dt_log TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE post_comment(
	id SERIAL NOT NULL PRIMARY KEY,
	id_post INTEGER NOT NULL,
	id_user INTEGER NOT NULL,
	text TEXT NOT NULL,
	publication TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY(id_user) REFERENCES user_login(id),
	FOREIGN KEY(id_post) REFERENCES post(id)
);

CREATE TABLE post_comment_log(
	id SERIAL NOT NULL PRIMARY KEY,
	id_comment INTEGER,
	type_log INTEGER,
	id_post INTEGER,
	id_user INTEGER,
	text TEXT,
	publication TIMESTAMP,
	dt_log TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE post_rox(
	id_post INTEGER NOT NULL,
	id_user INTEGER NOT NULL,
	date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(id_post, id_user),
	FOREIGN KEY(id_user) REFERENCES user_login(id),
	FOREIGN KEY(id_post) REFERENCES post(id)
);

CREATE TABLE post_rox_log(
	id SERIAL NOT NULL PRIMARY KEY,
	id_post INTEGER,
	id_user INTEGER,
	date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	type_log INTEGER,
	dt_log TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE post_item(
	id SERIAL NOT NULL PRIMARY KEY,
	id_post INTEGER NOT NULL,
	file VARCHAR(20) NOT NULL,
	type INTEGER,
	FOREIGN KEY(id_post) REFERENCES post(id)
);

CREATE TABLE post_item_log(
	id SERIAL NOT NULL PRIMARY KEY,
	id_post INTEGER,
	file VARCHAR(20),
	type INTEGER,
	type_log INTEGER,
	dt_log TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- END CREATE TABLE FROM POST, POST COMMENTS, POST ROX, POST ITEM AND LOGS;

-- BEGIN CREATE TRIGGERS TO LOG POSTS CHANGES;
	-- POST INSERT
CREATE FUNCTION fn_post_insert()
	RETURNS trigger
	LANGUAGE 'plpgsql'
	COST 100
	VOLATILE NOT LEAKPROOF 
AS $BODY$
BEGIN
INSERT INTO post_log(type_log, dt_log, id_post, id_user, title, title_slug, description, content, picture, panoramic_photo, token, dt_publication, dt_save, published, views)
	VALUES (1, NOW(), new.id, new.id_user, new.title, new.title_slug, new.description, new.content, new.picture, new.panoramic_photo, new.token, new.dt_publication, new.dt_save, new.published, new.views);
	return new;
   END; 
	$BODY$;
CREATE TRIGGER tg_post_insert AFTER INSERT ON post FOR EACH ROW EXECUTE PROCEDURE fn_post_insert();

	-- POST UPDATE
CREATE FUNCTION fn_post_update()
	RETURNS trigger
	LANGUAGE 'plpgsql'
	COST 100
	VOLATILE NOT LEAKPROOF 
AS $BODY$
BEGIN
INSERT INTO post_log(type_log, dt_log, id_post, id_user, title, title_slug, description, content, picture, panoramic_photo, token, dt_publication, dt_save, published, views)
	VALUES (2, NOW(), new.id, new.id_user, new.title, new.title_slug, new.description, new.content, new.picture, new.panoramic_photo, new.token, new.dt_publication, new.dt_save, new.published, new.views);
	return new;
	END; 
	$BODY$;
CREATE TRIGGER tg_post_update AFTER UPDATE ON post FOR EACH ROW EXECUTE PROCEDURE fn_post_update();

	-- POST DELETE   
CREATE FUNCTION fn_post_delete()
	RETURNS trigger
	LANGUAGE 'plpgsql'
	COST 100
	VOLATILE NOT LEAKPROOF 
AS $BODY$
BEGIN
INSERT INTO post_log(type_log, dt_log, id_post, id_user, title, title_slug, description, content, picture, panoramic_photo, token, dt_publication, dt_save, published, views)
	VALUES (3, NOW(), old.id, old.id_user, old.title, old.title_slug, old.description, old.content, old.picture, old.panoramic_photo, old.token, old.dt_publication, old.dt_save, old.published, old.views);
	return old;
   END; 
	$BODY$;
CREATE TRIGGER tg_post_delete AFTER DELETE ON post FOR EACH ROW EXECUTE PROCEDURE fn_post_delete();

	-- POST COMMENT DELETE
CREATE FUNCTION fn_post_comment_delete()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF 
AS $BODY$
BEGIN
INSERT INTO post_comment_log(type_log,dt_log,id_comment,id_post,id_user,text,publication)
    VALUES (3,NOW(),old.id,old.id_post,old.id_user,old.text,old.publication);
    return old;
    END; 
    $BODY$;
CREATE TRIGGER tg_post_comment_delete AFTER DELETE ON post_comment FOR EACH ROW EXECUTE PROCEDURE fn_post_comment_delete();

    -- POST ROX DELETE
CREATE FUNCTION fn_post_rox_delete()
	RETURNS trigger
	LANGUAGE 'plpgsql'
	COST 100
	VOLATILE NOT LEAKPROOF 
AS $BODY$
BEGIN
INSERT INTO post_rox_log(type_log,dt_log,id_post,id_user,date)
	VALUES (3,NOW(),old.id_post,old.id_user,old.date);
	return old;
	END; 
	$BODY$;
CREATE TRIGGER tg_post_rox_delete AFTER DELETE ON post_rox FOR EACH ROW EXECUTE PROCEDURE fn_post_rox_delete();

	-- POST ITEM DELETE
CREATE FUNCTION fn_post_item_delete()
	RETURNS trigger
	LANGUAGE 'plpgsql'
	COST 100
	VOLATILE NOT LEAKPROOF 
AS $BODY$
BEGIN
INSERT INTO post_item_log(type_log,dt_log,id_post, file, type)
	VALUES (3,NOW(),old.id_post,old.file,old.type);
	return old;
	END; 
	$BODY$;
CREATE TRIGGER tg_post_item_delete AFTER DELETE ON post_item FOR EACH ROW EXECUTE PROCEDURE fn_post_item_delete();
-- END CREATE TRIGGERS TO LOG POSTS CHANGES;


-- BEGIN ALTER TABLES ROX, COMMENT & NOTIFICATIONS
DROP TRIGGER tg_comment_delete ON comment;
DROP TRIGGER tg_rox_delete ON rox;
DROP TRIGGER tg_notification_delete ON notification;
DROP FUNCTION fn_rox_delete();
DROP FUNCTION fn_comment_delete();
DROP FUNCTION fn_notification_delete();

ALTER TABLE comment RENAME TO adventure_comment;
ALTER TABLE comment_log RENAME TO adventure_comment_log;
ALTER TABLE rox RENAME TO adventure_rox;
ALTER TABLE rox_log RENAME TO adventure_rox_log;
ALTER TABLE notification ADD COLUMN id_post INTEGER DEFAULT NULL;
ALTER TABLE notification ADD CONSTRAINT notification_id_post_fkey FOREIGN KEY(id_post) REFERENCES post(id);
ALTER TABLE notification_log ADD COLUMN id_post INTEGER DEFAULT NULL;

CREATE FUNCTION fn_adventure_comment_delete()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF 
AS $BODY$
BEGIN
INSERT INTO adventure_comment_log(type_log,data_log,id_comment,id_adventure,id_user,text,publication)
    values (3,NOW(),old.id,old.id_adventure,old.id_user,old.text,old.publication);
    return old;
    END; 
    $BODY$;
CREATE TRIGGER tg_adventure_comment_delete AFTER DELETE ON adventure_comment FOR EACH ROW EXECUTE PROCEDURE fn_adventure_comment_delete();

CREATE FUNCTION fn_adventure_rox_delete()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF 
AS $BODY$
BEGIN 
INSERT INTO adventure_rox_log(type_log,data_log,id_adventure,id_user,date)
    values (3,NOW(),old.id_adventure,old.id_user,old.date);
    return old;
    END; 
    $BODY$;
CREATE TRIGGER tg_adventure_rox_delete AFTER DELETE ON adventure_rox FOR EACH ROW EXECUTE PROCEDURE fn_adventure_rox_delete();

CREATE FUNCTION fn_notification_delete()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF 
AS $BODY$
BEGIN 
INSERT INTO notification_log(type_log,data_log,id_notification,id_user_receiver,id_user_sender,id_adventure, id_post, fired,id_type)
    VALUES (3,NOW(),old.id,old.id_user_receiver,old.id_user_sender,old.id_adventure, old.id_post,old.fired,old.id_type);
    return old;
    END; 
    $BODY$;
CREATE TRIGGER tg_notification_delete AFTER DELETE ON notification FOR EACH ROW EXECUTE PROCEDURE fn_notification_delete();

-- END ALTER TABLES ROX E COMMENT


ALTER FUNCTION fn_post_insert() OWNER TO "aventurebox";
ALTER FUNCTION fn_post_delete() OWNER TO "aventurebox";
ALTER FUNCTION fn_post_update() OWNER TO "aventurebox";
ALTER FUNCTION fn_post_comment_delete() OWNER TO "aventurebox";
ALTER FUNCTION fn_post_rox_delete() OWNER TO "aventurebox";
ALTER FUNCTION fn_adventure_comment_delete() OWNER TO "aventurebox";
ALTER FUNCTION fn_adventure_rox_delete() OWNER TO "aventurebox";
ALTER FUNCTION fn_notification_delete() OWNER TO "aventurebox";

grant select on all tables in schema public to "aventurebox";
grant insert on all tables in schema public to "aventurebox";
grant update on all tables in schema public to "aventurebox";
grant delete on all tables in schema public to "aventurebox";
grant all privileges on all sequences in schema public to "aventurebox";


INSERT INTO migration VALUES(21,'Cria tabela de posts e logs & modifica tabela de rox e comentarios','2020-02-06', now());