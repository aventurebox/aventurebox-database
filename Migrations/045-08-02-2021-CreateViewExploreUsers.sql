/*
 Migration  : 045 Developer  : Alex Souza
 Data       : 08-02-2021
 Description: Cria View para o explorar usuarios;
*/


CREATE MATERIALIZED VIEW explore_users_view AS
SELECT user_profile.id, user_profile.user_, user_profile.name, user_profile.picture, user_profile.token,
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

ALTER MATERIALIZED VIEW explore_users_view OWNER TO "aventurebox";

grant select on all tables in schema public to "aventurebox";
grant insert on all tables in schema public to "aventurebox";
grant update on all tables in schema public to "aventurebox";
grant delete on all tables in schema public to "aventurebox";
grant all privileges on all sequences in schema public to "aventurebox";

INSERT INTO migration VALUES(45, 'Cria View Para Explorar Usuarios', '2021-2-8', now());