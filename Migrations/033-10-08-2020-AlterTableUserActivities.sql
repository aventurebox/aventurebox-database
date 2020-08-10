/*
 Migration  : 033 Developer  : Alex Souza
 Data       : 10-08-2020
 Description: Alter user_activities adicionar constraint;
*/

DELETE FROM user_activities;

ALTER TABLE user_activities ADD CONSTRAINT user_activities_id_user_fkey FOREIGN KEY (id_user) REFERENCES user_profile (id) ON DELETE CASCADE;
ALTER TABLE user_activities ADD CONSTRAINT user_activities_id_type_id_user_unique UNIQUE(id_user, type_activities);

grant select on all tables in schema public to "aventurebox";
grant insert on all tables in schema public to "aventurebox";
grant update on all tables in schema public to "aventurebox";
grant delete on all tables in schema public to "aventurebox";
grant all privileges on all sequences in schema public to "aventurebox";

INSERT INTO migration VALUES(33, 'Altera a tabela user_activities adicionando constraints de chave estrangeira e unique','2020-08-10', now());

