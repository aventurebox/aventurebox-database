/*
 Migration  : 061 Developer  : Giselle Hoekveld
 Data       : 28-07-2023
 Description: Altera tabela user_profile adicionando coluna verified
*/

ALTER TABLE user_profile ADD COLUMN verified BOOLEAN NOT NULL DEFAULT FALSE;

DROP MATERIALIZED VIEW IF EXISTS explore_users_view;

CREATE MATERIALIZED VIEW explore_users_view AS
SELECT user_profile.id, user_profile.user_, user_profile.name, user_profile.picture, user_profile.token, user_profile.verified,
(SELECT 
	(SELECT COUNT(adventure.id) 
		FROM adventure, adventure_rox 
		WHERE adventure.id_user = user_profile.id 
		AND adventure_rox.id_adventure = adventure.id) + 
	(SELECT COUNT(post.id) 
		FROM post, post_rox 
		WHERE post.id_user = user_profile.id 
		AND post_rox.id_post = post.id)) rox_count
FROM user_profile 
WHERE user_profile.dt_register <= NOW()
AND user_profile.inactive = FALSE
AND user_profile.suspended = FALSE
ORDER BY rox_count DESC, user_profile.id DESC;
CREATE UNIQUE INDEX ON explore_users_view (id);

DROP MATERIALIZED VIEW IF EXISTS user_suggestion_view;

CREATE MATERIALIZED VIEW user_suggestion_view AS
SELECT id, name, picture, token, user_, verified,
(
	SELECT COUNT(id) FROM adventure 
	WHERE id_user = up.id AND published = TRUE AND do_not_list = FALSE
) as count_adventure,
(
	SELECT COUNT(id) FROM post 
	WHERE id_user = up.id AND published = TRUE AND do_not_list = FALSE
) as count_post
FROM user_profile up 
INNER JOIN user_suggestion us ON up.id = us.id_user
ORDER BY us.first DESC, random();
CREATE UNIQUE INDEX ON user_suggestion_view(id);

grant select on all tables in schema public to "user-production";
grant insert on all tables in schema public to "user-production";
grant update on all tables in schema public to "user-production";
grant delete on all tables in schema public to "user-production";
grant all privileges on all sequences in schema public to "user-production";

INSERT INTO migration VALUES(61, 'Altera tabela user_profile adicionando coluna verified', '2023-7-28', now());