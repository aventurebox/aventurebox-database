/*
 Migration  : 037 Developer  : Alex Souza
 Data       : 31-08-2020
 Description: Alter table product adicionando colunas do perfil do usuario;
*/

ALTER TABLE product ADD COLUMN owner_name VARCHAR(125);
ALTER TABLE product ADD COLUMN owner_link VARCHAR(500);
ALTER TABLE product ADD COLUMN id_user INT;

ALTER TABLE product ADD CONSTRAINT product_id_user_fkey FOREIGN KEY (id_user) REFERENCES user_profile (id) ON DELETE CASCADE;

grant select on all tables in schema public to "aventurebox";
grant insert on all tables in schema public to "aventurebox";
grant update on all tables in schema public to "aventurebox";
grant delete on all tables in schema public to "aventurebox";
grant all privileges on all sequences in schema public to "aventurebox";

INSERT INTO migration VALUES(37, 'Altera a tabela product adicionando colunas do perfil do usuario', '2020-08-31', now());

