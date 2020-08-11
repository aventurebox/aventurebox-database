/*
 Migration  : 034 Developer  : Alex Souza
 Data       : 11-08-2020
 Description: Alter session_app para adicionar constraints;
*/

ALTER TABLE session_app ADD CONSTRAINT session_app_id_user_id_device_unique UNIQUE(id_user, id_device);

grant select on all tables in schema public to "aventurebox";
grant insert on all tables in schema public to "aventurebox";
grant update on all tables in schema public to "aventurebox";
grant delete on all tables in schema public to "aventurebox";
grant all privileges on all sequences in schema public to "aventurebox";

INSERT INTO migration VALUES(34, 'Altera a tabela session_app adicionando UNIQUE constraint para id_user e id_device','2020-08-11', now());

