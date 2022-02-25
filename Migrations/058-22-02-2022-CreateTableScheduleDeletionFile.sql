/*
 Migration  : 058 Developer  : Giselle Hoekveld
 Data       : 22-02-2022
 Description: Cria Tabela Schedule Deletion File
*/

CREATE TABLE schedule_deletion_file(
	id SERIAL NOT NULL PRIMARY KEY,
	id_profile INT NOT NULL,
	path VARCHAR(500) NOT NULL,
	date_schedule TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	date_deletion TIMESTAMP DEFAULT NULL
);

grant select on all tables in schema public to "user-production";
grant insert on all tables in schema public to "user-production";
grant update on all tables in schema public to "user-production";
grant delete on all tables in schema public to "user-production";
grant all privileges on all sequences in schema public to "user-production";

INSERT INTO migration VALUES(58, 'Cria Tabela Schedule Deletion File', '2022-2-22', now());