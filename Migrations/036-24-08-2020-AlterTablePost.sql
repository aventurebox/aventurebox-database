/*
 Migration  : 036 Developer  : Alex Souza
 Data       : 24-08-2020
 Description: Alter table post adicionando coluna do_not_list;
*/

ALTER TABLE post ADD COLUMN do_not_list BOOLEAN DEFAULT FALSE;

grant select on all tables in schema public to "aventurebox";
grant insert on all tables in schema public to "aventurebox";
grant update on all tables in schema public to "aventurebox";
grant delete on all tables in schema public to "aventurebox";
grant all privileges on all sequences in schema public to "aventurebox";

INSERT INTO migration VALUES(36, 'Altera a tabela post adicionando coluna do_not_list', '2020-08-24', now());

