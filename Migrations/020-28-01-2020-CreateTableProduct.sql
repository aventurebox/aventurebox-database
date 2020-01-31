/*
 Migration  : 020 Developer  : Alex Souza
 Data       : 28-01-2020
 Description: Create table products
*/

CREATE TABLE product(
id SERIAL NOT NULL PRIMARY KEY,
image VARCHAR(200) NOT NULL,
link VARCHAR(500) NOT NULL,
title VARCHAR(500) NOT NULL,
description VARCHAR(500),
dt_publication TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
gender INTEGER DEFAULT 0 NOT NULL
);

CREATE TABLE product_modality(
id SERIAL NOT NULL PRIMARY KEY,
id_product INTEGER NOT NULL,
id_modality INTEGER NOT NULL,
FOREIGN KEY(id_product) REFERENCES product(id),
FOREIGN KEY(id_modality) REFERENCES modality(id),
UNIQUE (id_product, id_modality)
);

-- NINJA
grant select on all tables in schema public to "user-ninja";
grant insert on all tables in schema public to "user-ninja";
grant update on all tables in schema public to "user-ninja";
grant delete on all tables in schema public to "user-ninja";
grant all privileges on all sequences in schema public to "user-ninja";

-- PRODUCTION
-- grant select on all tables in schema public to "user-production";
-- grant insert on all tables in schema public to "user-production";
-- grant update on all tables in schema public to "user-production";
-- grant delete on all tables in schema public to "user-production";
-- grant all privileges on all sequences in schema public to "user-production";

INSERT INTO migration VALUES(20,'Cria tabela de produtos','2020-01-28', now());