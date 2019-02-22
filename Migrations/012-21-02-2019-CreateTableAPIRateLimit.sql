/*
 Migration  : 012 Developer  : Paulo Moura
 Data       : 21-02-2019
 Description: Create Table api_rate_limit
*/

CREATE TABLE api_rate_limit(
id SERIAL NOT NULL PRIMARY KEY,
id_user INTEGER null,
ip text NOT NULL,
uri text NOT NULL,
data timestamp without time zone NOT NULL DEFAULT current_timestamp
);

grant select on all tables in schema public to pg_aventurebox;
grant insert on all tables in schema public to pg_aventurebox;
grant update on all tables in schema public to pg_aventurebox;
grant delete on all tables in schema public to pg_aventurebox;
grant all privileges on all sequences in schema public to pg_aventurebox;

INSERT INTO migration VALUES(12,'Cria tabela api_rate_limit','2019-02-21', now());