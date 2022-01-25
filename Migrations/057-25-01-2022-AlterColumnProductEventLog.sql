/*
 Migration  : 057 Developer  : Giselle Hoekveld
 Data       : 25-01-2022
 Description: Aumenta tamanho da coluna url na tabela ProductEventLog;
*/


ALTER FOREIGN TABLE product_event_log ALTER COLUMN url TYPE VARCHAR(500);

grant select on all tables in schema public to "user-production";
grant insert on all tables in schema public to "user-production";
grant update on all tables in schema public to "user-production";
grant delete on all tables in schema public to "user-production";
grant all privileges on all sequences in schema public to "user-production";

INSERT INTO migration VALUES(57, 'Altera tamanho da coluna url product_event_log', '2022-1-25', now());

--------------- AVENTUREBOX ANALYTICS MIGRATION --------------------

ALTER TABLE product_event_log ALTER COLUMN url TYPE VARCHAR(500);

grant select on all tables in schema public to "user-production";
grant insert on all tables in schema public to "user-production";
grant update on all tables in schema public to "user-production";
grant delete on all tables in schema public to "user-production";
grant all privileges on all sequences in schema public to "user-production";
