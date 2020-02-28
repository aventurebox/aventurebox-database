/*
 Migration  : 022 Developer  : Alex Souza
 Data       : 28-02-2020
 Description: Create table post modalities
*/

CREATE TABLE post_modality(
id SERIAL NOT NULL PRIMARY KEY,
id_post INTEGER NOT NULL,
id_modality INTEGER NOT NULL,
FOREIGN KEY(id_post) REFERENCES post(id),
FOREIGN KEY(id_modality) REFERENCES modality(id),
UNIQUE (id_post, id_modality)
);


grant select on all tables in schema public to "aventurebox";
grant insert on all tables in schema public to "aventurebox";
grant update on all tables in schema public to "aventurebox";
grant delete on all tables in schema public to "aventurebox";
grant all privileges on all sequences in schema public to "aventurebox";
	

INSERT INTO migration VALUES(22,'Cria tabela de modalidades do post','2020-02-28', now());