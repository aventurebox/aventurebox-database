/*
 Migration  : 028 Developer  : Alex Souza
 Data       : 22-05-2020
 Description: Alter Table api_rate_limit incluir notification_timestamp
*/

ALTER TABLE api_rate_limit ADD COLUMN notification_timestamp TIMESTAMP WITHOUT TIME ZONE NULL;

grant select on all tables in schema public to aventurebox;
grant insert on all tables in schema public to aventurebox;
grant update on all tables in schema public to aventurebox;
grant delete on all tables in schema public to aventurebox;
grant all privileges on all sequences in schema public to aventurebox;

INSERT INTO migration VALUES(28,'Altera tabela api_rate_limit para incluir a data de notificao por e-mail','2020-05-22', now());