/*
 Migration  : 052 Developer  : Giselle Hoekveld
 Data       : 06-09-2021
 Description: Create table comment_rox, logs, triggers & alter table comment		  
*/

--------------- AVENTUREBOX LOG --------------------
CREATE TABLE post_comment_rox_log(
	id SERIAL NOT NULL PRIMARY KEY,
	id_post_comment INTEGER,
	id_user INTEGER,
	date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	type_log INTEGER,
	dt_log TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE adventure_comment_rox_log(
	id SERIAL NOT NULL PRIMARY KEY,
	id_adventure_comment INTEGER,
	id_user INTEGER,
	date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	type_log INTEGER,
	dt_log TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

grant select on all tables in schema public to "user-production";
grant insert on all tables in schema public to "user-production";
grant update on all tables in schema public to "user-production";
grant delete on all tables in schema public to "user-production";
grant all privileges on all sequences in schema public to "user-production";
--------------- END AVENTUREBOX LOG --------------------

--------------- AVENTUREBOX --------------------
ALTER TABLE adventure_comment ADD COLUMN id_comment_reply INT DEFAULT null;
ALTER TABLE post_comment ADD COLUMN id_comment_reply INT DEFAULT null;

   -- ADVENTURE COMMENT DELETE
CREATE FUNCTION fn_adventure_reply_delete()
	RETURNS trigger
	LANGUAGE 'plpgsql'
	COST 100
	VOLATILE NOT LEAKPROOF 
AS $BODY$
BEGIN
DELETE FROM adventure_comment  WHERE old.id = id_comment_reply;
   return old;
   END; 
	$BODY$;
CREATE TRIGGER tg_adventure_comment_reply_delete AFTER DELETE ON adventure_comment FOR EACH ROW EXECUTE PROCEDURE fn_adventure_reply_delete();

   -- POST COMMENT DELETE
CREATE FUNCTION fn_post_reply_delete()
	RETURNS trigger
	LANGUAGE 'plpgsql'
	COST 100
	VOLATILE NOT LEAKPROOF 
AS $BODY$
BEGIN
DELETE FROM post_comment  WHERE old.id = id_comment_reply;
   return old;
   END; 
	$BODY$;
CREATE TRIGGER tg_post_comment_reply_delete AFTER DELETE ON post_comment FOR EACH ROW EXECUTE PROCEDURE fn_post_reply_delete();

	-- ADVENTURE COMMENT ROX
CREATE TABLE public.adventure_comment_rox(
id_adventure_comment INT NOT NULL,
id_user INT NOT NULL,
date TIMESTAMP NOT NULL DEFAULT NOW(),
CONSTRAINT adventure_comment_rox_pkey PRIMARY KEY (id_adventure_comment, id_user),
CONSTRAINT adventure_comment_id_adventure_fkey FOREIGN KEY (id_adventure_comment) REFERENCES public.adventure_comment(id) ON DELETE CASCADE,
CONSTRAINT adventure_comment_id_user_fkey FOREIGN KEY (id_user) REFERENCES public.user_profile(id) ON DELETE CASCADE
);

CREATE FOREIGN TABLE adventure_comment_rox_log (
	id_adventure_comment INT,
	id_user INT,
	date TIMESTAMP,
	type_log INT,
	dt_log TIMESTAMP
) SERVER aventurebox_log OPTIONS (table_name 'adventure_comment_rox_log');

	-- POST COMMENT ROX
CREATE TABLE public.post_comment_rox(
id_post_comment INT NOT NULL,
id_user INT NOT NULL,
date TIMESTAMP NOT NULL DEFAULT NOW(),
CONSTRAINT post_comment_rox_pkey PRIMARY KEY (id_post_comment, id_user),
CONSTRAINT post_comment_id_post_fkey FOREIGN KEY (id_post_comment) REFERENCES public.post_comment(id) ON DELETE CASCADE,
CONSTRAINT post_comment_id_user_fkey FOREIGN KEY (id_user) REFERENCES public.user_profile(id) ON DELETE CASCADE
);

CREATE FOREIGN TABLE post_comment_rox_log (
	id_post_comment INT,
	id_user INT,
	date TIMESTAMP,
	type_log INT,
	dt_log TIMESTAMP
) SERVER aventurebox_log OPTIONS (table_name 'post_comment_rox_log');

   -- TRIGGER ADVENTURE COMMENT ROX DELETE
CREATE FUNCTION fn_adventure_comment_rox_delete()
	RETURNS trigger
	LANGUAGE 'plpgsql'
	COST 100
	VOLATILE NOT LEAKPROOF 
AS $BODY$
BEGIN
INSERT INTO adventure_comment_rox_log(type_log,dt_log,id_adventure_comment,id_user,date)
	VALUES (3,NOW(),old.id_adventure_comment,old.id_user,old.date);
	return old;
	END; 
	$BODY$;
CREATE TRIGGER tg_adventure_comment_rox_delete AFTER DELETE ON adventure_comment_rox FOR EACH ROW EXECUTE PROCEDURE fn_adventure_comment_rox_delete();

  -- TRIGGER POST COMMENT ROX DELETE
CREATE FUNCTION fn_post_comment_rox_delete()
	RETURNS trigger
	LANGUAGE 'plpgsql'
	COST 100
	VOLATILE NOT LEAKPROOF 
AS $BODY$
BEGIN
INSERT INTO post_comment_rox_log(type_log,dt_log,id_post_comment,id_user,date)
	VALUES (3,NOW(),old.id_post_comment,old.id_user,old.date);
	return old;
	END; 
	$BODY$;
CREATE TRIGGER tg_post_comment_rox_delete AFTER DELETE ON post_comment_rox FOR EACH ROW EXECUTE PROCEDURE fn_post_comment_rox_delete();

grant select on all tables in schema public to "user-production";
grant insert on all tables in schema public to "user-production";
grant update on all tables in schema public to "user-production";
grant delete on all tables in schema public to "user-production";
grant all privileges on all sequences in schema public to "user-production";

INSERT INTO migration VALUES(53, 'Create table comment_rox, logs, triggers & alter table comment', '2021-09-06', now());