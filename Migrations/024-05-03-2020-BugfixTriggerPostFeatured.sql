/*
 Migration  : 023 Developer  : Alex Souza
 Data       : 05-03-2020
 Description: Bugfix trigger post featured;
*/

DROP TRIGGER tg_post_featured_delete ON post_featured;
DROP FUNCTION fn_post_featured_delete();

CREATE FUNCTION fn_post_featured_delete()
	RETURNS trigger
	LANGUAGE 'plpgsql'
	COST 100
	VOLATILE NOT LEAKPROOF 
AS $BODY$
BEGIN
INSERT INTO post_featured_log(type_log, dt_log, id_post, order_by)
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
	

INSERT INTO migration VALUES(24,'Bugfix trigger post featured','2020-03-20', now());