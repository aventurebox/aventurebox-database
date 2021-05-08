/*
 Migration  : 048 Developer  : Alex Souza
 Data       : 08-05-2021
 Description: Altera as colunas de genero e nascimento do usuário.
*/

ALTER TABLE user_login ALTER COLUMN birth DROP NOT NULL;
ALTER TABLE user_login ALTER COLUMN genus SET DEFAULT 'u'; 
ALTER TABLE user_temp ALTER COLUMN birth DROP NOT NULL;
ALTER TABLE user_temp ALTER COLUMN genus SET DEFAULT 'u';

grant select on all tables in schema public to "aventurebox";
grant insert on all tables in schema public to "aventurebox";
grant update on all tables in schema public to "aventurebox";
grant delete on all tables in schema public to "aventurebox";
grant all privileges on all sequences in schema public to "aventurebox";

INSERT INTO migration VALUES(48, 'Altera colunas genus e birth da tabela user_login', '2021-5-8', now());
