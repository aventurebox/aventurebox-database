/*
 Migration  : 060 Developer  : Giselle Hoekveld
 Data       : 18-07-2023
 Description: Cria tabela post_tag_profile e insere novos tipos de notificações
*/

CREATE TABLE post_tag_profile(
	id SERIAL NOT NULL PRIMARY KEY,
	id_post INT NOT NULL,
	id_user INT NOT NULL,
	notified BOOLEAN DEFAULT FALSE,
	show_profile BOOLEAN DEFAULT TRUE,
	approved BOOLEAN NOT NULL DEFAULT FALSE,
	FOREIGN KEY (id_post) REFERENCES post(id) ON DELETE CASCADE,
	FOREIGN KEY (id_user) REFERENCES user_profile(id) ON DELETE CASCADE
);

INSERT INTO notification_type(id, name) VALUES (21, 'post_tag_profile');
INSERT INTO notification_type(id, name) VALUES (22, 'comment_on_post_profile_tagged');
INSERT INTO notification_type(id, name) VALUES (23, 'post_tag_profile_approved');
INSERT INTO notification_type(id, name) VALUES (24, 'post_tag_profile_denied');

grant select on all tables in schema public to "user-production";
grant insert on all tables in schema public to "user-production";
grant update on all tables in schema public to "user-production";
grant delete on all tables in schema public to "user-production";
grant all privileges on all sequences in schema public to "user-production";

INSERT INTO migration VALUES(60, 'Cria tabela post_tag_profile e insere novos tipos de notificações', '2023-7-18', now());