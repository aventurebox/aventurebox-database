/*
 Migration  : 004
 Developer  : Paulo Moura
 Data       : 27-07-2017
 Description: Create Table session_app
*/

CREATE TABLE session_app(
id SERIAL NOT NULL PRIMARY KEY,
id_user INT NOT NULL,
token TEXT UNIQUE NOT NULL,
user_agent TEXT NOT NULL,
date TIMESTAMP not null default NOW(),
data text
);
ALTER TABLE session_app ADD FOREIGN KEY(id_user) REFERENCES user_login(id);

INSERT INTO migration VALUES(4,'Cria tabela de sessão de usuários','2017-07-27', now());
