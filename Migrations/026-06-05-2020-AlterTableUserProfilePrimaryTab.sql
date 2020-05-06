/*
 Migration  : 026 Developer  : Alex Souza
 Data       : 06-05-2020
 Description: Alter Table User Profile Primary Tab
*/

ALTER TABLE user_profile ADD COLUMN primary_tab INT;

grant select on all tables in schema public to aventurebox;
grant insert on all tables in schema public to aventurebox;
grant update on all tables in schema public to aventurebox;
grant delete on all tables in schema public to aventurebox;
grant all privileges on all sequences in schema public to aventurebox;

INSERT INTO migration VALUES(26,'Altera tabela user_profile para incluir qual a aba de preferencia do usuario (1 - Aventuras | 2 - Materias)','2020-05-06', now());