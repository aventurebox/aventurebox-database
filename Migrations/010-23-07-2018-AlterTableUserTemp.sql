/*
 Migration  : 010 Developer  : Paulo Moura
 Data       : 23-07-2018
 Description: Alter table user_temp
*/

ALTER TABLE user_temp add language INTEGER DEFAULT 1;

UPDATE user_temp SET dt_register=NOW();

grant select on all tables in schema public to pg_aventurebox;
grant insert on all tables in schema public to pg_aventurebox;
grant update on all tables in schema public to pg_aventurebox;
grant delete on all tables in schema public to pg_aventurebox;
grant all privileges on all sequences in schema public to pg_aventurebox;

INSERT INTO migration VALUES(10,'Altera tabela user_temp','2018-07-23', now());
