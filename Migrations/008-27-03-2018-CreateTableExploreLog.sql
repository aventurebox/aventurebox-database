/*
 Migration  : 008
 Developer  : Paulo Moura
 Data       : 27-03-2018
 Description: Create table explore_log
*/

CREATE TABLE explore_log(
id_type INTEGER,
id_user INTEGER,
search_key TEXT,
ip TEXT,
user_agent TEXT,
date TIMESTAMP
);

grant select on all tables in schema public to pg_aventurebox;
grant insert on all tables in schema public to pg_aventurebox;
grant update on all tables in schema public to pg_aventurebox;
grant delete on all tables in schema public to pg_aventurebox;
grant all privileges on all sequences in schema public to pg_aventurebox;

INSERT INTO migration VALUES(8,'Cria tabela explore_log','2018-03-27', now());
