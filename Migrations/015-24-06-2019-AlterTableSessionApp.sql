/*
 Migration  : 015 Developer  : Paulo Moura
 Data       : 24-06-2019
 Description: Alter Table Session App
*/

ALTER TABLE session_app add id_device VARCHAR(200) NULL;

grant select on all tables in schema public to pg_aventurebox;
grant insert on all tables in schema public to pg_aventurebox;
grant update on all tables in schema public to pg_aventurebox;
grant delete on all tables in schema public to pg_aventurebox;
grant all privileges on all sequences in schema public to pg_aventurebox;

INSERT INTO migration VALUES(15,'Altera tabela session_app','2019-06-24', now());