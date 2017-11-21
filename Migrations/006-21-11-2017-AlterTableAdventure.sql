/*
 Migration  : 006
 Developer  : Paulo Moura
 Data       : 21-11-2017
 Description: Alter Table adventure add do_not_list
*/

ALTER TABLE adventure ADD do_not_list BOOLEAN DEFAULT FALSE;

grant select on all tables in schema public to pg_aventurebox;
grant insert on all tables in schema public to pg_aventurebox;
grant update on all tables in schema public to pg_aventurebox;
grant delete on all tables in schema public to pg_aventurebox;
grant all privileges on all sequences in schema public to pg_aventurebox;

INSERT INTO migration VALUES(5,'Altera tabela adventure adicionando campo do_not_list','2017-11-11', now());