/*
 Migration  : 014 Developer  : Paulo Moura
 Data       : 09-04-2019
 Description: Alter Table action and action_record
*/

CREATE TABLE action(
id SERIAL NOT NULL PRIMARY KEY,
description VARCHAR(500) NOT NULL
);
insert into action(description) values('Spot banner sidebar');
insert into action(description) values('Mountain Festival Full Banner');
insert into action(description) values('Gear Tips banner sidebar');

CREATE TABLE action_record(
id SERIAL NOT NULL PRIMARY KEY,
id_action int not null,
date timestamp default current_timestamp,
foreign key(id_action) references action(id)
);

grant select on all tables in schema public to pg_aventurebox;
grant insert on all tables in schema public to pg_aventurebox;
grant update on all tables in schema public to pg_aventurebox;
grant delete on all tables in schema public to pg_aventurebox;
grant all privileges on all sequences in schema public to pg_aventurebox;

INSERT INTO migration VALUES(14,'Cria tabela action e action_record','2019-04-09', now());