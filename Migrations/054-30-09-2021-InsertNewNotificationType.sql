/*
 Migration  : 054 Developer  : Giselle Hoekveld Silva
 Data       : 01-10-2021
 Description: Insere novos valores na tabela notification_type
*/

INSERT INTO notification_type(id, name) VALUES (17, 'reply'), (18, 'rox_comment'), (19, 'rox_reply');

grant select on all tables in schema public to "user-production";
grant insert on all tables in schema public to "user-production";
grant update on all tables in schema public to "user-production";
grant delete on all tables in schema public to "user-production";
grant all privileges on all sequences in schema public to "user-production";

INSERT INTO migration VALUES(54, 'Insere novos valores na tabela notification_type', '2021-10-01', now());

