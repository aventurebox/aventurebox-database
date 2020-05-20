/*
 Migration  : 027 Developer  : Alex Souza
 Data       : 20-05-2020
 Description: Alter table api_rate_limit;
*/

DROP TABLE IF EXISTS api_rate_limit;

CREATE TABLE api_rate_limit(
	id_user INTEGER NULL,
	ip TEXT NOT NULL,
	uri TEXT NOT NULL,
	data TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
	action INTEGER NOT NULL DEFAULT 0
);

grant select on all tables in schema public to aventurebox;
grant insert on all tables in schema public to aventurebox;
grant update on all tables in schema public to aventurebox;
grant delete on all tables in schema public to aventurebox;
grant all privileges on all sequences in schema public to aventurebox;

INSERT INTO migration VALUES(27,'Altera a tabela api_rate_limit','2020-05-20', now());