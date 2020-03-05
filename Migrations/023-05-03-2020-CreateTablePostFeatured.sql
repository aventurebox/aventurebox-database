/*
 Migration  : 023 Developer  : Alex Souza
 Data       : 05-03-2020
 Description: Create table post featured
*/

CREATE TABLE post_featured(
	id_post INTEGER NOT NULL PRIMARY KEY,
	order_by INTEGER NOT NULL,
	FOREIGN KEY(id_post) REFERENCES post(id),
	UNIQUE (order_by)
);

CREATE TABLE post_featured_log(
	id SERIAL NOT NULL PRIMARY KEY,
	type_log INTEGER NOT NULL,
	dt_log TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	id_post INTEGER NOT NULL,
	order_by INTEGER NOT NULL
);

CREATE FUNCTION fn_post_featured_delete()
	RETURNS trigger
	LANGUAGE 'plpgsql'
	COST 100
	VOLATILE NOT LEAKPROOF 
AS $BODY$
BEGIN
INSERT INTO post_log(type_log, dt_log, id_post, order_by)
	VALUES (3, NOW(), old.id, old.order_by);
	return old;
   END; 
	$BODY$;
CREATE TRIGGER tg_post_featured_delete AFTER DELETE ON post_featured FOR EACH ROW EXECUTE PROCEDURE fn_post_featured_delete();


grant select on all tables in schema public to "aventurebox";
grant insert on all tables in schema public to "aventurebox";
grant update on all tables in schema public to "aventurebox";
grant delete on all tables in schema public to "aventurebox";
grant all privileges on all sequences in schema public to "aventurebox";
	

INSERT INTO migration VALUES(23,'Cria tabela de destaques do post','2020-03-05', now());