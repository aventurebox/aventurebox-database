/*
 Migration  : 052 Developer  : Giselle Hoekveld
 Data       : 16-08-2021
 Description: Altera tabela e triggers (drop/create) em product_log e cria tabela e triggers user_profile_module_log; 
*/

--------------- AVENTUREBOX LOG --------------------
ALTER TABLE product_log ADD COLUMN situation VARCHAR(40);
ALTER TABLE product_log ADD COLUMN id_user_profile_module INT;
ALTER TABLE product_log ADD COLUMN picture VARCHAR(100);

CREATE TABLE user_profile_module_log(
	id SERIAL NOT NULL PRIMARY KEY,
    id_user_profile_module INT,
	type_log INT,
	dt_log TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	id_user_profile INT,
	id_module INT,
	situation VARCHAR(40), 
	num_items INT, 
	activation_date TIMESTAMP,
	deactivation_date TIMESTAMP 
);

grant select on all tables in schema public to "user-production";
grant insert on all tables in schema public to "user-production";
grant update on all tables in schema public to "user-production";
grant delete on all tables in schema public to "user-production";
grant all privileges on all sequences in schema public to "user-production";
--------------- END AVENTUREBOX LOG --------------------

--------------- AVENTUREBOX --------------------

ALTER TABLE product_log ADD COLUMN situation VARCHAR(40);
ALTER TABLE product_log ADD COLUMN id_user_profile_module INT;
ALTER TABLE product_log ADD COLUMN picture VARCHAR(100);

DROP TRIGGER tg_product_insert ON product;
DROP TRIGGER tg_product_update ON product;
DROP TRIGGER tg_product_delete ON product;
DROP FUNCTION fn_product_insert();
DROP FUNCTION fn_product_update();
DROP FUNCTION fn_product_delete();

CREATE FUNCTION fn_product_insert()
	RETURNS trigger
	LANGUAGE 'plpgsql'
	COST 100
	VOLATILE NOT LEAKPROOF 
AS $BODY$
BEGIN
INSERT INTO product_log(type_log, dt_log, id_product, image, link, title, description, dt_publication, gender, owner_name, owner_url, id_user, situation, id_user_profile_module, picture)
	VALUES (1, NOW(), new.id, new.image, new.link, new.title, new.description, new.dt_publication, new.gender, new.owner_name, new.owner_url, new.id_user, new.situation, new.id_user_profile_module, new.picture);
	return new;
   END; 
	$BODY$;
CREATE TRIGGER tg_product_insert AFTER INSERT ON product FOR EACH ROW EXECUTE PROCEDURE fn_product_insert();

CREATE FUNCTION fn_product_update()
	RETURNS trigger
	LANGUAGE 'plpgsql'
	COST 100
	VOLATILE NOT LEAKPROOF 
AS $BODY$
BEGIN
INSERT INTO product_log(type_log, dt_log, id_product, image, link, title, description, dt_publication, gender, owner_name, owner_url, id_user, situation, id_user_profile_module, picture)
	VALUES (2, NOW(), new.id, new.image, new.link, new.title, new.description, new.dt_publication, new.gender, new.owner_name, new.owner_url, new.id_user, new.situation, new.id_user_profile_module, new.picture);
	return new;
	END; 
	$BODY$;
CREATE TRIGGER tg_product_update AFTER UPDATE ON product FOR EACH ROW EXECUTE PROCEDURE fn_product_update();

CREATE FUNCTION fn_product_delete()
	RETURNS trigger
	LANGUAGE 'plpgsql'
	COST 100
	VOLATILE NOT LEAKPROOF 
AS $BODY$
BEGIN
INSERT INTO product_log(type_log, dt_log, id_product, image, link, title, description, dt_publication, gender, owner_name, owner_url, id_user, situation, id_user_profile_module, picture)
	VALUES (3, NOW(), old.id, old.image, old.link, old.title, old.description, old.dt_publication, old.gender, old.owner_name, old.owner_url, old.id_user, old.situation, old.id_user_profile_module, old.picture);
	return old;
   END; 
	$BODY$;
CREATE TRIGGER tg_product_delete AFTER DELETE ON product FOR EACH ROW EXECUTE PROCEDURE fn_product_delete();

CREATE FOREIGN TABLE user_profile_module_log (
	type_log INT,
	dt_log TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_user_profile_module INT,
	id_user_profile INT,
	id_module INT,
	situation VARCHAR(40), 
	num_items INT, 
	activation_date TIMESTAMP,
	deactivation_date TIMESTAMP
) SERVER aventurebox_log OPTIONS (table_name 'user_profile_module_log');

CREATE FUNCTION fn_user_profile_module_insert()
	RETURNS trigger
	LANGUAGE 'plpgsql'
	COST 100
	VOLATILE NOT LEAKPROOF 
AS $BODY$
BEGIN
INSERT INTO user_profile_module_log(type_log, dt_log, id_user_profile_module, id_user_profile, id_module, situation, num_items, activation_date, deactivation_date)
	VALUES (1, NOW(), new.id, new.id_user_profile, new.id_module, new.situation, new.num_items, new.activation_date, new.deactivation_date);
	return new;
   END; 
	$BODY$;
CREATE TRIGGER tg_user_profile_module_insert AFTER INSERT ON user_profile_module FOR EACH ROW EXECUTE PROCEDURE fn_user_profile_module_insert();

CREATE FUNCTION fn_user_profile_module_update()
	RETURNS trigger
	LANGUAGE 'plpgsql'
	COST 100
	VOLATILE NOT LEAKPROOF 
AS $BODY$
BEGIN
INSERT INTO user_profile_module_log(type_log, dt_log, id_user_profile_module, id_user_profile, id_module, situation, num_items, activation_date, deactivation_date)
	VALUES (2, NOW(), new.id, new.id_user_profile, new.id_module, new.situation, new.num_items, new.activation_date, new.deactivation_date);
	return new;
	END; 
	$BODY$;
CREATE TRIGGER tg_user_profile_module_update AFTER UPDATE ON user_profile_module FOR EACH ROW EXECUTE PROCEDURE fn_user_profile_module_update();

CREATE FUNCTION fn_user_profile_module_delete()
	RETURNS trigger
	LANGUAGE 'plpgsql'
	COST 100
	VOLATILE NOT LEAKPROOF 
AS $BODY$
BEGIN
INSERT INTO user_profile_module_log(type_log, dt_log, id_user_profile_module, id_user_profile, id_module, situation, num_items, activation_date, deactivation_date)
	VALUES (3, NOW(), old.id, old.id_user_profile, old.id_module, old.situation, old.num_items, old.activation_date, old.deactivation_date);
	return old;
   END; 
	$BODY$;
CREATE TRIGGER tg_user_profile_module_delete AFTER DELETE ON user_profile_module FOR EACH ROW EXECUTE PROCEDURE fn_user_profile_module_delete();

grant select on all tables in schema public to "user-production";
grant insert on all tables in schema public to "user-production";
grant update on all tables in schema public to "user-production";
grant delete on all tables in schema public to "user-production";
grant all privileges on all sequences in schema public to "user-production";

INSERT INTO migration VALUES(52, 'Altera tabela e triggers em product_log e cria tabela e triggers user_profile_module_log', '2021-8-16', now());