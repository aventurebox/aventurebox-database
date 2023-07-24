/*
 Migration  : 060 Developer  : Giselle Hoekveld
 Data       : 18-07-2023
 Description: Cria tabela post_tag e insere novos tipos de notificações
*/

CREATE TABLE post_tag(
	id SERIAL NOT NULL PRIMARY KEY,
	id_post INT NOT NULL,
	id_user INT NOT NULL,
	notified BOOLEAN DEFAULT FALSE,
	show_profile BOOLEAN DEFAULT TRUE,
	approved BOOLEAN NOT NULL DEFAULT FALSE,
	FOREIGN KEY (id_post) REFERENCES post(id) ON DELETE CASCADE,
	FOREIGN KEY (id_user) REFERENCES user_profile(id) ON DELETE CASCADE
);

INSERT INTO notification_type(id, name) VALUES (21, 'tag');
INSERT INTO notification_type(id, name) VALUES (22, 'comment_on_tagged_publication');
INSERT INTO notification_type(id, name) VALUES (23, 'tag_approved');
INSERT INTO notification_type(id, name) VALUES (24, 'tag_denied');

grant select on all tables in schema public to "user-production";
grant insert on all tables in schema public to "user-production";
grant update on all tables in schema public to "user-production";
grant delete on all tables in schema public to "user-production";
grant all privileges on all sequences in schema public to "user-production";

INSERT INTO migration VALUES(60, 'Cria tabela post_tag e insere novos tipos de notificações', '2023-7-18', now());