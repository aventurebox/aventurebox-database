/*
 Migration  : 013 Developer  : Paulo Moura
 Data       : 07-03-2019
 Description: Alter Table user_profile
*/

alter table user_profile add last_notification_id int;

grant select on all tables in schema public to pg_aventurebox;
grant insert on all tables in schema public to pg_aventurebox;
grant update on all tables in schema public to pg_aventurebox;
grant delete on all tables in schema public to pg_aventurebox;
grant all privileges on all sequences in schema public to pg_aventurebox;

INSERT INTO migration VALUES(13,'Altera tabela user_profile','2019-03-07', now());