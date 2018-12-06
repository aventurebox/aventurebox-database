/*
 Migration  : 011 Developer  : Paulo Moura
 Data       : 01-11-2018
 Description: AlterTableTracklog
*/

alter table tracklog add distance decimal(20,2);
alter table tracklog add total_time text;
alter table tracklog add elevation_gain decimal(20,2);
alter table tracklog add elevation_loss decimal(20,2);
alter table tracklog add distances text;
alter table tracklog add elevations text;
alter table tracklog add consolidated boolean default false;

grant select on all tables in schema public to pg_aventurebox;
grant insert on all tables in schema public to pg_aventurebox;
grant update on all tables in schema public to pg_aventurebox;
grant delete on all tables in schema public to pg_aventurebox;
grant all privileges on all sequences in schema public to pg_aventurebox;

INSERT INTO migration VALUES(11,'Altera tabela tracklog','2018-11-01', now());
