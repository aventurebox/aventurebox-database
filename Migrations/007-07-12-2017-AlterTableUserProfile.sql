/*
 Migration  : 007
 Developer  : Paulo Moura
 Data       : 07-12-2017
 Description: Alter Table user_profile add notification_cancel_token
*/

ALTER TABLE user_profile ADD notification_cancel_token VARCHAR(40);

grant select on all tables in schema public to pg_aventurebox;
grant insert on all tables in schema public to pg_aventurebox;
grant update on all tables in schema public to pg_aventurebox;
grant delete on all tables in schema public to pg_aventurebox;
grant all privileges on all sequences in schema public to pg_aventurebox;

INSERT INTO migration VALUES(7,'Altera tabela user_profile adicionando notification_cancel_token','2017-12-07', now());