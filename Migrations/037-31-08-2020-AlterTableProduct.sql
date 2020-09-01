/*
 Migration  : 037 Developer  : Alex Souza
 Data       : 31-08-2020
 Description: Alter table product adicionando colunas do perfil do usuario e cria log de produtos;
*/

ALTER TABLE product ADD COLUMN owner_name VARCHAR(125);
ALTER TABLE product ADD COLUMN owner_url VARCHAR(500);
ALTER TABLE product ADD COLUMN id_user INT;

ALTER TABLE product ADD CONSTRAINT product_id_user_fkey FOREIGN KEY (id_user) REFERENCES user_profile (id) ON DELETE CASCADE;

CREATE TABLE product_log(
	id SERIAL NOT NULL PRIMARY KEY,
	type_log INT,
	dt_log TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	id_product INT NOT NULL,
	image VARCHAR(200),
	link VARCHAR(500),
	title VARCHAR(500),
	description VARCHAR(500),
	dt_publication TIMESTAMP,
	gender INTEGER,
	owner_name VARCHAR(125),
	owner_url VARCHAR(500),
	id_user INT
);

CREATE FUNCTION fn_product_insert()
	RETURNS trigger
	LANGUAGE 'plpgsql'
	COST 100
	VOLATILE NOT LEAKPROOF 
AS $BODY$
BEGIN
INSERT INTO product_log(type_log, dt_log, id_product, image, link, title, description, dt_publication, gender, owner_name, owner_url, id_user)
	VALUES (1, NOW(), new.id, new.image, new.link, new.title, new.description, new.dt_publication, new.gender, new.owner_name, new.owner_url, new.id_user);
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
INSERT INTO product_log(type_log, dt_log, id_product, image, link, title, description, dt_publication, gender, owner_name, owner_url, id_user)
	VALUES (2, NOW(), new.id, new.image, new.link, new.title, new.description, new.dt_publication, new.gender, new.owner_name, new.owner_url, new.id_user);
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
INSERT INTO product_log(type_log, dt_log, id_product, image, link, title, description, dt_publication, gender, owner_name, owner_url, id_user)
	VALUES (3, NOW(), old.id, old.image, old.link, old.title, old.description, old.dt_publication, old.gender, old.owner_name, old.owner_url, old.id_user);
	return old;
   END; 
	$BODY$;
CREATE TRIGGER tg_product_delete AFTER DELETE ON product FOR EACH ROW EXECUTE PROCEDURE fn_product_delete();


grant select on all tables in schema public to "aventurebox";
grant insert on all tables in schema public to "aventurebox";
grant update on all tables in schema public to "aventurebox";
grant delete on all tables in schema public to "aventurebox";
grant all privileges on all sequences in schema public to "aventurebox";

INSERT INTO migration VALUES(37, 'Altera a tabela product adicionando colunas do perfil do usuario e cria log dos produtos', '2020-08-31', now());

