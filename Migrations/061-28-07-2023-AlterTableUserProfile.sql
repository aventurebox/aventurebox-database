/*
 Migration  : 061 Developer  : Giselle Hoekveld
 Data       : 28-07-2023
 Description: Altera tabela user_profile adicionando coluna verified
*/

ALTER TABLE user_profile ADD COLUMN verified BOOLEAN NOT NULL DEFAULT FALSE;

grant select on all tables in schema public to "user-production";
grant insert on all tables in schema public to "user-production";
grant update on all tables in schema public to "user-production";
grant delete on all tables in schema public to "user-production";
grant all privileges on all sequences in schema public to "user-production";

INSERT INTO migration VALUES(61, 'Altera tabela user_profile adicionando coluna verified', '2023-7-28', now());