/*
 Migration  : 043 Developer  : Alex Souza
 Data       : 18-01-2021
 Description: Aumenta tamanho da coluna origin na tabela ProductEventLog;
*/


ALTER FOREIGN TABLE product_event_log ALTER COLUMN origin TYPE VARCHAR(200);

grant select on all tables in schema public to "aventurebox";
grant insert on all tables in schema public to "aventurebox";
grant update on all tables in schema public to "aventurebox";
grant delete on all tables in schema public to "aventurebox";
grant all privileges on all sequences in schema public to "aventurebox";

INSERT INTO migration VALUES(44, 'Altera tamanho da coluna origin product_event_log', '2021-1-18', now());

--------------- AVENTUREBOX LOG MIGRATION --------------------

ALTER TABLE product_event_log ALTER COLUMN origin TYPE VARCHAR(200);

grant select on all tables in schema public to "aventurebox_ninja";
grant insert on all tables in schema public to "aventurebox_ninja";
grant all privileges on all sequences in schema public to "aventurebox_ninja";
