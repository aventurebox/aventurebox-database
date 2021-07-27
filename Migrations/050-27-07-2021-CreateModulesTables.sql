/*
 Migration  : 050 Developer  : Renan Cavichi
 Data       : 27-07-2021
 Description: Cria esquema de tabelas para módulos do dashboard;
*/

/* situation: published, draft, paused */
CREATE TABLE modules (
id SERIAL NOT NULL PRIMARY KEY,
slug VARCHAR(40) NOT NULL,
situation VARCHAR(40) NOT NULL,  
creation_date TIMESTAMP NOT NULL DEFAULT now()
);

/* situation: active, paused, pending, deactivated */
CREATE TABLE user_profile_module (
id SERIAL NOT NULL PRIMARY KEY,
id_user_profile INT NOT NULL,
id_module INT NOT NULL,
situation VARCHAR(40) NOT NULL, 
num_items INT NOT NULL DEFAULT 1, 
activation_date TIMESTAMP NOT NULL DEFAULT now(),
deactivation_date TIMESTAMP DEFAULT NULL,
FOREIGN KEY(id_user_profile) REFERENCES user_profile(id) ON DELETE CASCADE,
FOREIGN KEY(id_module) REFERENCES modules(id) ON DELETE CASCADE
);

ALTER TABLE product ADD COLUMN situation VARCHAR(40) NOT NULL DEFAULT 'pending';
ALTER TABLE product ADD COLUMN id_user_profile_module INT;
ALTER TABLE product ADD COLUMN picture VARCHAR(20);

grant select on all tables in schema public to "user-production";
grant insert on all tables in schema public to "user-production";
grant update on all tables in schema public to "user-production";
grant delete on all tables in schema public to "user-production";
grant all privileges on all sequences in schema public to "user-production";

INSERT INTO migration VALUES(50, 'Cria esquema de tabelas para módulos do dashboard', '2021-7-27', now());