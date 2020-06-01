/*
 Migration  : 029 Developer  : Alex Souza
 Data       : 01-06-2020
 Description: Create Ads Log Table
*/

CREATE TABLE ads_log(
url TEXT NOT NULL,
date TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
id_user_content INTEGER,
origin INTEGER NOT NULL,
display TEXT NOT NULL
);


grant select on all tables in schema public to "aventurebox";
grant insert on all tables in schema public to "aventurebox";
grant update on all tables in schema public to "aventurebox";
grant delete on all tables in schema public to "aventurebox";
grant all privileges on all sequences in schema public to "aventurebox";

INSERT INTO migration VALUES(29, 'Adiciona a tabelas de log dos anuncios', '2020-06-01', now());