/*
 Migration  : 025 Developer  : Alex Souza
 Data       : 30-03-2020
 Description: Create Post Privacy Tables
*/

CREATE TABLE post_hide(
id_user INTEGER NOT NULL,
id_post INTEGER NOT NULL,
date TIMESTAMP NOT NULL DEFAULT now(),
UNIQUE(id_user, id_post),
FOREIGN KEY(id_user) REFERENCES user_login(id),
FOREIGN KEY(id_post) REFERENCES post(id)
);


CREATE TABLE post_complaint(
id SERIAL NOT NULL PRIMARY KEY,
id_user INTEGER NOT NULL,
id_post INTEGER NOT NULL,
justification text,
date TIMESTAMP NOT NULL DEFAULT now(),
FOREIGN KEY(id_user) REFERENCES user_login(id),
FOREIGN KEY(id_post) REFERENCES post(id)
);

grant select on all tables in schema public to "aventurebox";
grant insert on all tables in schema public to "aventurebox";
grant update on all tables in schema public to "aventurebox";
grant delete on all tables in schema public to "aventurebox";
grant all privileges on all sequences in schema public to "aventurebox";

INSERT INTO migration VALUES(25, 'Adiciona as tabelas de privacidade para as matérias', '2020-03-30', now());