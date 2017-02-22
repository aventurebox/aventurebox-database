/*
 Migration  : 002
 Developer  : Paulo Moura
 Data       : 21-02-2017
 Description: Create Table Refuse Sugestion
*/

CREATE TABLE concact_refuse(
id_user INTEGER NOT NULL,
id_user_refused INTEGER NOT NULL,
date TIMESTAMP NOT NULL,
PRIMARY KEY(id_user, id_user_refused)
);
ALTER TABLE concact_refuse ADD FOREIGN KEY(id_user) REFERENCES user_login(id);
ALTER TABLE concact_refuse ADD FOREIGN KEY(id_user_refused) REFERENCES user_login(id);

grant select on all tables in schema public to pg_aventurebox;
grant insert on all tables in schema public to pg_aventurebox;
grant update on all tables in schema public to pg_aventurebox;
grant delete on all tables in schema public to pg_aventurebox;
grant all privileges on all sequences in schema public to pg_aventurebox;

INSERT INTO migration VALUES(2,'Cria Tabela de Sugestões de Contato Recusadas','2017-02-21', now());