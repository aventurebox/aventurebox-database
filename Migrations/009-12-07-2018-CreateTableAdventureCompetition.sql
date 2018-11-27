/*
 Migration  : 009
 Developer  : Paulo Moura
 Data       : 12-07-2018
 Description: Create table adventure_competition
*/

CREATE TABLE adventure_competition(
id_adventure int not null,
id_user int not null,
date timestamp default CURRENT_TIMESTAMP,
type Integer DEFAULT 1 NOT NULL
);

alter table adventure_competition add unique(id_adventure);

grant select on all tables in schema public to pg_aventurebox;
grant insert on all tables in schema public to pg_aventurebox;
grant update on all tables in schema public to pg_aventurebox;
grant delete on all tables in schema public to pg_aventurebox;
grant all privileges on all sequences in schema public to pg_aventurebox;

INSERT INTO migration VALUES(9,'Cria tabela adventure_competition','2018-07-12', now());
