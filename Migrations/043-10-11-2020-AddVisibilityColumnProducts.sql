/*
 Migration  : 043 Developer  : Alex Souza
 Data       : 11-01-2021
 Description: Adiciona coluna de visibilidade nos produtos;
*/


ALTER TABLE product ADD COLUMN not_list BOOLEAN DEFAULT FALSE;

ALTER FOREIGN TABLE product_log ADD COLUMN not_list BOOLEAN;

DROP TRIGGER tg_product_update ON product;
DROP FUNCTION fn_product_update();

CREATE FUNCTION fn_product_update()
	RETURNS trigger
AS $BODY$
BEGIN
INSERT INTO product_log(type_log, dt_log, id_product, image, link, title, description, dt_publication, gender, owner_name, owner_url, id_user, not_list)
	VALUES (2, NOW(), new.id, new.image, new.link, new.title, new.description, new.dt_publication, new.gender, new.owner_name, new.owner_url, new.id_user, new.not_list);
	return new;
	END; 
	$BODY$ LANGUAGE plpgsql COST 100 VOLATILE NOT LEAKPROOF;

CREATE TRIGGER tg_product_update AFTER UPDATE ON product FOR EACH ROW EXECUTE PROCEDURE fn_product_update();

grant select on all tables in schema public to "aventurebox";
grant insert on all tables in schema public to "aventurebox";
grant update on all tables in schema public to "aventurebox";
grant delete on all tables in schema public to "aventurebox";
grant all privileges on all sequences in schema public to "aventurebox";

INSERT INTO migration VALUES(43, 'Adiciona coluna de visibilidade nos produtos', '2021-1-11', now());

--------------- AVENTUREBOX LOG MIGRATION --------------------

ALTER TABLE product_log ADD COLUMN not_list BOOLEAN;

grant select on all tables in schema public to "aventurebox_ninja";
grant insert on all tables in schema public to "aventurebox_ninja";
grant all privileges on all sequences in schema public to "aventurebox_ninja";
