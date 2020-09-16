/*
 Migration  : 038 Developer  : Alex Souza
 Data       : 15-09-2020
 Description: Cria extensão e tabelas para log de dados em banco de dados externos;
*/

CREATE EXTENSION postgres_fdw;

CREATE SERVER aventurebox_log FOREIGN DATA WRAPPER postgres_fdw OPTIONS (host '206.189.201.202', port '25060', dbname 'database_log');

CREATE USER MAPPING FOR "aventurebox" SERVER aventurebox_log OPTIONS (user 'aventurebox_ninja', password 'senha');

CREATE FOREIGN TABLE product_event_log (
	event INT NOT NULL,
	id_product INT NOT NULL,
	id_user INT,
	dt_action TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
	device VARCHAR(15),
	ip TEXT,
	origin VARCHAR(100),
	url VARCHAR(200)
) SERVER aventurebox_log OPTIONS (table_name 'product_event_log');

grant select on all tables in schema public to "aventurebox";
grant insert on all tables in schema public to "aventurebox";
grant update on all tables in schema public to "aventurebox";
grant delete on all tables in schema public to "aventurebox";
grant all privileges on all sequences in schema public to "aventurebox";

INSERT INTO migration VALUES(38, 'Cria extensão e tabelas para log de dados em banco de dados externos', '2020-09-15', now());

--------------- AVENTUREBOX LOGS MIGRATION --------------------

CREATE TABLE product_event_log (
	id BIGSERIAL NOT NULL PRIMARY KEY,
	event INT NOT NULL,
	id_product INT NOT NULL,
	id_user INT,
	dt_action TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
	device VARCHAR(15),
	ip TEXT,
	origin VARCHAR(100),
	url VARCHAR(200)
);
grant select on all tables in schema public to "aventurebox_ninja";
grant insert on all tables in schema public to "aventurebox_ninja";
grant all privileges on all sequences in schema public to "aventurebox_ninja";

