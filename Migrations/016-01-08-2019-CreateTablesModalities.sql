/*
 Migration  : 016 Developer  : Paulo Moura
 Data       : 01-08-2019
 Description: Create tables modalities
*/

CREATE TABLE modality(
id SERIAL NOT NULL PRIMARY KEY,
"name_pt-br" VARCHAR(200) NOT NULL,
"slug_pt-br" VARCHAR(200) NOT NULL,
"name_en-us" VARCHAR(200) NOT NULL,
"slug_en-us" VARCHAR(200) NOT NULL
);

INSERT INTO modality("name_pt-br", "slug_pt-br", "name_en-us", "slug_en-us") VALUES
('Trekking','trekking','Trekking','trekking'),
('Hiking','hiking','Hiking','hiking'),
('Montanhismo','montanhismo','Mountaineering','mountaineering'),
('Mountain Bike','mountain-bike','Mountain Bike','mountain-bike'),
('Surfe','surfe','Surf','surf'),
('Mergulho','mergulho','Diving','diving'),
('Escalada','escalada','Climb','climb'),
('Snowboard','snowboard','Snowboarding','snowboarding');

CREATE TABLE adventure_modality(
id SERIAL NOT NULL PRIMARY KEY,
id_adventure INTEGER NOT NULL,
id_modality INTEGER NOT NULL,
FOREIGN KEY(id_adventure) REFERENCES adventure(id),
FOREIGN KEY(id_modality) REFERENCES modality(id),
UNIQUE (id_adventure, id_modality)
);

-- NINJA
grant select on all tables in schema public to pg_aventurebox;
grant insert on all tables in schema public to pg_aventurebox;
grant update on all tables in schema public to pg_aventurebox;
grant delete on all tables in schema public to pg_aventurebox;
grant all privileges on all sequences in schema public to pg_aventurebox;

-- PRODUCTION
grant select on all tables in schema public to "user-production";
grant insert on all tables in schema public to "user-production";
grant update on all tables in schema public to "user-production";
grant delete on all tables in schema public to "user-production";
grant all privileges on all sequences in schema public to "user-production";

INSERT INTO migration VALUES(16,'Cria tabelas de modalidades','2019-08-01', now());