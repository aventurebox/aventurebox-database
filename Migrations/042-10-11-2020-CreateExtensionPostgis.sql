/*
 Migration  : 042 Developer  : Alex Souza
 Data       : 13-11-2020
 Description: Cria a extensao para uso do PostGIS e Logs Explorar no Mapa;
*/

CREATE EXTENSION postgis;

CREATE FOREIGN TABLE explore_map_text_log (
	id_user INT,
	dt_event TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
	device VARCHAR(15),
	ip TEXT,
	search TEXT
) SERVER aventurebox_analytics OPTIONS (table_name 'explore_map_text_log');

CREATE FOREIGN TABLE explore_map_bounds_log (
	id_user INT,
	dt_event TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
	device VARCHAR(15),
	ip TEXT,
	bounds BOX
) SERVER aventurebox_analytics OPTIONS (table_name 'explore_map_bounds_log');

CREATE FOREIGN TABLE explore_map_adventure_log (
	id_user INT,
	id_adventure INT,
	dt_event TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
	device VARCHAR(15),
	ip TEXT,
	location POINT
) SERVER aventurebox_analytics OPTIONS (table_name 'explore_map_adventure_log');

grant select on all tables in schema public to "aventurebox";
grant insert on all tables in schema public to "aventurebox";
grant update on all tables in schema public to "aventurebox";
grant delete on all tables in schema public to "aventurebox";
grant all privileges on all sequences in schema public to "aventurebox";

INSERT INTO migration VALUES(42, 'Cria a extensao para uso do PostGIS e Logs Explorar no Mapa', '2020-11-13', now());

--------------- AVENTUREBOX ANALYTICS MIGRATION --------------------

CREATE TABLE explore_map_text_log (
	id BIGSERIAL NOT NULL PRIMARY KEY,
	id_user INT,
	dt_event TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
	device VARCHAR(15),
	ip TEXT,
	search TEXT
);
CREATE TABLE explore_map_bounds_log (
	id BIGSERIAL NOT NULL PRIMARY KEY,
	id_user INT,
	dt_event TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
	device VARCHAR(15),
	ip TEXT,
	bounds BOX
);
CREATE TABLE explore_map_adventure_log (
	id BIGSERIAL NOT NULL PRIMARY KEY,
	id_user INT,
	id_adventure INT,
	dt_event TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
	device VARCHAR(15),
	ip TEXT,
	location POINT
);

grant select on all tables in schema public to "aventurebox";
grant insert on all tables in schema public to "aventurebox";
grant all privileges on all sequences in schema public to "aventurebox";
