/*
 Migration  : 005
 Developer  : Paulo Moura
 Data       : 21-09-2017
 Description: Alter Tables add panoramic_photo
*/

alter table user_profile add panoramic_photo VARCHAR(20) NULL;
alter table adventure add panoramic_photo VARCHAR(20) NULL;

grant select on all tables in schema public to pg_aventurebox;
grant insert on all tables in schema public to pg_aventurebox;
grant update on all tables in schema public to pg_aventurebox;
grant delete on all tables in schema public to pg_aventurebox;
grant all privileges on all sequences in schema public to pg_aventurebox;

INSERT INTO migration VALUES(5,'Altera tabela user_profile e adventure adicionando campo panoramic_photo','2017-09-21', now());


-- Adicionar 10 fotos pranorâmicas default 