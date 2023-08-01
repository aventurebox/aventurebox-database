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

DROP MATERIALIZED VIEW IF EXISTS post_suggestion_view;

CREATE MATERIALIZED VIEW post_suggestion_view AS
WITH 
top_rox AS (
	SELECT 
	p.id, p.id_user, p.title, p.title_slug, p.description, p.token, 
	p.content, p.dt_publication, p.panoramic_photo,
	up.id AS user_id, up.user_, up.name, up.picture picture_u, up.token AS token_user, up.verified AS verified_u
	FROM post p
	INNER JOIN user_profile up ON p.id_user = up.id
	WHERE p.published = TRUE
	AND up.inactive = FALSE
	AND up.suspended = FALSE
	AND p.do_not_list = FALSE
	ORDER BY (
		SELECT COUNT(rox.id_user) FROM post_rox AS rox 
		JOIN user_profile ups ON ups.id = rox.id_user 
		WHERE rox.id_post = p.id AND ups.inactive = FALSE AND ups.suspended = FALSE
	) DESC
),
suggestions AS (
	SELECT * FROM top_rox
	WHERE id IN (SELECT id_post FROM post_suggestion)
),
rox_month AS (
	SELECT * FROM top_rox
	WHERE (dt_publication + interval '3 month' > NOW())
	AND id NOT IN (SELECT id FROM suggestions)
	LIMIT 500 * 0.15
),
rox_year AS (
	SELECT * FROM top_rox
	WHERE (dt_publication + interval '1 year' > NOW())
	AND id NOT IN (SELECT * FROM (SELECT id FROM suggestions UNION ALL SELECT id FROM rox_month) t1)
	LIMIT 500 * 0.25
),
rox_platform AS (
	SELECT * FROM top_rox
	WHERE id NOT IN (SELECT * FROM (SELECT id FROM suggestions UNION ALL SELECT id FROM rox_month UNION ALL SELECT id FROM rox_year) t2)
	LIMIT 500 * 0.6
)
SELECT * FROM (
	SELECT * FROM rox_month UNION ALL
	SELECT * FROM rox_year UNION ALL
	SELECT * FROM rox_platform UNION ALL
	SELECT * FROM suggestions
) posts;
CREATE UNIQUE INDEX ON post_suggestion_view (id);

DROP MATERIALIZED VIEW IF EXISTS adventure_suggestion_view;

CREATE MATERIALIZED VIEW adventure_suggestion_view AS
WITH 
top_rox AS (
	SELECT 
	a.id, a.id_user, a.title, a.title_slug, a.description, a.token, 
	a.dt_start, a.dt_end, a.dt_publication, a.id_item_report, a.id_item_photo,
	a.id_item_video, a.id_item_tracklog, a.id_item_checklist, a.panoramic_photo, a.picture, 
	a.location[0] lat, a.location[1] lng, 
	up.id AS user_id, up.user_, up.name, up.picture picture_u, up.token AS token_user, up.verified AS verified_u
	FROM adventure a
	INNER JOIN user_profile up ON a.id_user = up.id
	WHERE a.published = TRUE
	AND up.inactive = FALSE
	AND up.suspended = FALSE
	AND a.do_not_list = FALSE
	ORDER BY (
		SELECT COUNT(rox.id_user) FROM adventure_rox AS rox 
		JOIN user_profile ups ON ups.id = rox.id_user 
		WHERE rox.id_adventure = a.id AND ups.inactive = FALSE
	) DESC
),
suggestions AS (
	SELECT * FROM top_rox
	WHERE id IN (SELECT id_adventure FROM adventure_suggestion)
),
rox_month AS (
	SELECT * FROM top_rox
	WHERE (dt_publication + interval '3 month' > NOW())
	AND id NOT IN (SELECT id FROM suggestions)
	LIMIT 500 * 0.15
),
rox_year AS (
	SELECT * FROM top_rox
	WHERE (dt_publication + interval '1 year' > NOW())
	AND id NOT IN (SELECT * FROM (SELECT id FROM suggestions UNION ALL SELECT id FROM rox_month) t1)
	LIMIT 500 * 0.25
),
rox_platform AS (
	SELECT * FROM top_rox
	WHERE id NOT IN (SELECT * FROM (SELECT id FROM suggestions UNION ALL SELECT id FROM rox_month UNION ALL SELECT id FROM rox_year) t2)
	LIMIT 500 * 0.6
)
SELECT * FROM (
	SELECT * FROM rox_month UNION ALL
	SELECT * FROM rox_year UNION ALL
	SELECT * FROM rox_platform UNION ALL
	SELECT * FROM suggestions
) adventures;
CREATE UNIQUE INDEX ON adventure_suggestion_view (id);

ALTER MATERIALIZED VIEW explore_users_view OWNER TO "user-production";
ALTER MATERIALIZED VIEW user_suggestion_view OWNER TO "user-production";
ALTER MATERIALIZED VIEW adventure_suggestion_view OWNER TO "user-production";
ALTER MATERIALIZED VIEW post_suggestion_view OWNER TO "user-production";

grant select on all tables in schema public to "user-production";
grant insert on all tables in schema public to "user-production";
grant update on all tables in schema public to "user-production";
grant delete on all tables in schema public to "user-production";
grant all privileges on all sequences in schema public to "user-production";

INSERT INTO migration VALUES(61, 'Altera tabela user_profile adicionando coluna verified', '2023-7-28', now());