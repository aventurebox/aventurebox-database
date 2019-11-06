/*
 Migration  : 018 Developer  : Renan Cavichi
 Data       : 05-11-2019
 Description: Add Es Modality and Privacity Tables
*/

ALTER TABLE modality ADD name_es VARCHAR(200);
ALTER TABLE modality ADD slug_es VARCHAR(200);

CREATE TABLE adventure_hide(
id_user INTEGER NOT NULL,
id_adventure INTEGER NOT NULL,
date TIMESTAMP NOT NULL DEFAULT now(),
UNIQUE(id_user, id_adventure),
FOREIGN KEY(id_user) REFERENCES user_login(id),
FOREIGN KEY(id_adventure) REFERENCES adventure(id)
);

CREATE TABLE user_blocked(
id_user INTEGER NOT NULL,
id_user_blocked INTEGER NOT NULL,
date TIMESTAMP NOT NULL DEFAULT now(),
UNIQUE(id_user, id_user_blocked),
FOREIGN KEY(id_user) REFERENCES user_login(id),
FOREIGN KEY(id_user_blocked) REFERENCES user_login(id)
);

CREATE TABLE adventure_complaint(
id SERIAL NOT NULL PRIMARY KEY,
id_user INTEGER NOT NULL,
id_adventure INTEGER NOT NULL,
justification text,
date TIMESTAMP NOT NULL DEFAULT now(),
FOREIGN KEY(id_user) REFERENCES user_login(id),
FOREIGN KEY(id_adventure) REFERENCES adventure(id)
);

CREATE TABLE user_complaint(
id_user INTEGER NOT NULL,
id_user_complaint INTEGER NOT NULL,
justification text,
date TIMESTAMP NOT NULL DEFAULT now(),
FOREIGN KEY(id_user) REFERENCES user_login(id),
FOREIGN KEY(id_user_complaint) REFERENCES user_login(id)
);

grant select on all tables in schema public to pg_aventurebox;
grant insert on all tables in schema public to pg_aventurebox;
grant update on all tables in schema public to pg_aventurebox;
grant delete on all tables in schema public to pg_aventurebox;
grant all privileges on all sequences in schema public to pg_aventurebox;

INSERT INTO migration VALUES(18,'Adiciona o idioma espanhol nas modalidades e as tabelas de privacidade','2019-11-05', now());