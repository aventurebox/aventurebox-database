/*
 Migration  : 051 Developer  : Renan Cavichi
 Data       : 27-07-2021
 Description: Altera tabela produtos com a chave estrangeira após add os módules;
*/

ALTER TABLE product ALTER COLUMN id_user_profile_module SET NOT NULL;
ALTER TABLE product ADD FOREIGN KEY(id_user_profile_module) REFERENCES user_profile_module(id) ON DELETE CASCADE;

grant select on all tables in schema public to "user-production";
grant insert on all tables in schema public to "user-production";
grant update on all tables in schema public to "user-production";
grant delete on all tables in schema public to "user-production";
grant all privileges on all sequences in schema public to "user-production";

INSERT INTO migration VALUES(51, 'Altera tabela produtos com a chave estrangeira após add os módules', '2021-7-27', now());