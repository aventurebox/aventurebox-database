/*
 Migration  : 055 Developer  : Giselle Hoekveld Silva
 Data       : 05-10-2021
 Description: Cria tabela, triggers e logs de menções para os comentários;
*/

--------------- AVENTUREBOX LOG --------------------
CREATE TABLE adventure_comment_mention_log(
	id SERIAL NOT NULL PRIMARY KEY,
	id_adventure_comment INTEGER,
	id_user INTEGER,
	date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	type_log INTEGER,
	dt_log TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE post_comment_mention_log(
	id SERIAL NOT NULL PRIMARY KEY,
	id_post_comment INTEGER,
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
CREATE TABLE public.adventure_comment_mention (
id_adventure_comment INT NOT NULL,
id_user INT NOT NULL,
date TIMESTAMP NOT NULL DEFAULT NOW(),
CONSTRAINT adventure_comment_mention_pkey PRIMARY KEY (id_adventure_comment, id_user),
CONSTRAINT adventure_comment_mention_comment_id_fkey FOREIGN KEY (id_adventure_comment) REFERENCES public.adventure_comment(id) ON DELETE CASCADE,
CONSTRAINT adventure_comment_mention_id_user_fkey FOREIGN KEY (id_user) REFERENCES public.user_profile(id) ON DELETE CASCADE
);

CREATE TABLE public.post_comment_mention (
id_post_comment INT NOT NULL,
id_user INT NOT NULL,
date TIMESTAMP NOT NULL DEFAULT NOW(),
CONSTRAINT post_comment_mention_pkey PRIMARY KEY (id_post_comment, id_user),
CONSTRAINT post_comment_mention_comment_id_fkey FOREIGN KEY (id_post_comment) REFERENCES public.post_comment(id) ON DELETE CASCADE,
CONSTRAINT post_comment_mention_id_user_fkey FOREIGN KEY (id_user) REFERENCES public.user_profile(id) ON DELETE CASCADE
);

--------------- FOREIGN TABLES 
CREATE FOREIGN TABLE adventure_comment_mention_log (
	id_adventure_comment INT,
	id_user INT,
	date TIMESTAMP,
	type_log INT,
	dt_log TIMESTAMP
) SERVER aventurebox_log OPTIONS (table_name 'adventure_comment_mention_log');

CREATE FOREIGN TABLE post_comment_mention_log (
	id_post_comment INT,
	id_user INT,
	date TIMESTAMP,
	type_log INT,
	dt_log TIMESTAMP
) SERVER aventurebox_log OPTIONS (table_name 'post_comment_mention_log');

--------------- TRIGGERS
CREATE FUNCTION fn_adventure_comment_mention_delete()
	RETURNS trigger
	LANGUAGE 'plpgsql'
	COST 100
	VOLATILE NOT LEAKPROOF 
AS $BODY$
BEGIN
INSERT INTO adventure_comment_mention_log(type_log,dt_log,id_adventure_comment,id_user,date)
	VALUES (3,NOW(),old.id_adventure_comment,old.id_user,old.date);
	return old;
	END; 
	$BODY$;
CREATE TRIGGER tg_adventure_comment_mention_delete AFTER DELETE ON adventure_comment_mention FOR EACH ROW EXECUTE PROCEDURE fn_adventure_comment_mention_delete();

CREATE FUNCTION fn_post_comment_mention_delete()
	RETURNS trigger
	LANGUAGE 'plpgsql'
	COST 100
	VOLATILE NOT LEAKPROOF 
AS $BODY$
BEGIN
INSERT INTO post_comment_mention_log(type_log,dt_log,id_post_comment,id_user,date)
	VALUES (3,NOW(),old.id_post_comment,old.id_user,old.date);
	return old;
	END; 
	$BODY$;
CREATE TRIGGER tg_post_comment_mention_delete AFTER DELETE ON post_comment_mention FOR EACH ROW EXECUTE PROCEDURE fn_post_comment_mention_delete();

grant select on all tables in schema public to "user-production";
grant insert on all tables in schema public to "user-production";
grant update on all tables in schema public to "user-production";
grant delete on all tables in schema public to "user-production";
grant all privileges on all sequences in schema public to "user-production";

INSERT INTO migration VALUES(55, 'Cria tabela, triggers e logs de menções para os comentários', '2021-10-05', now());
--------------- END AVENTUREBOX --------------------