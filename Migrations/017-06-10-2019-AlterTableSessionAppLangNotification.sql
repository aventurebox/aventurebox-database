/*
 Migration  : 017 Developer  : Renan Cavichi
 Data       : 06-10-2019
 Description: Alter Table Session App Lang Notification
*/

ALTER TABLE session_app ADD COLUMN lang VARCHAR (5) NOT NULL DEFAULT 'en-us';

grant select on all tables in schema public to pg_aventurebox;
grant insert on all tables in schema public to pg_aventurebox;
grant update on all tables in schema public to pg_aventurebox;
grant delete on all tables in schema public to pg_aventurebox;
grant all privileges on all sequences in schema public to pg_aventurebox;

INSERT INTO migration VALUES(17,'Altera tabela session_app para incluir idioma de notificação','2019-10-06', now());