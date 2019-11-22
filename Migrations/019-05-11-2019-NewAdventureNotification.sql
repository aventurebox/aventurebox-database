/*
 Migration  : 019 Developer  : Renan Cavichi
 Data       : 22-11-2019
 Description: New adventure notification
*/

INSERT INTO notification_type(name) VALUES ('new_adventure');

CREATE TABLE user_muted( id_user INTEGER NOT NULL, id_user_muted INTEGER NOT NULL, date TIMESTAMP NOT NULL DEFAULT now(), UNIQUE(id_user, id_user_muted), FOREIGN KEY(id_user) REFERENCES user_login(id), FOREIGN KEY(id_user_muted) REFERENCES user_login(id) );

grant select on all tables in schema public to pg_aventurebox;
grant insert on all tables in schema public to pg_aventurebox;
grant update on all tables in schema public to pg_aventurebox;
grant delete on all tables in schema public to pg_aventurebox;
grant all privileges on all sequences in schema public to pg_aventurebox;

INSERT INTO migration VALUES(19,'Cria sistema para notificações de nova aventura e desativação de notificações no app','2019-11-05', now());