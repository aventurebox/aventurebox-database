/*
 Migration  : 049 Developer  : Renan Cavichi
 Data       : 24-06-2021
 Description: Cria View Para Posts Sugeridos da Home;
*/

CREATE TABLE post_suggestion (
	id_post INT NOT NULL,
	dt_add TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
	UNIQUE(id_post),
	FOREIGN KEY(id_post) REFERENCES post(id) ON DELETE CASCADE
);

CREATE MATERIALIZED VIEW post_suggestion_view AS
WITH 
top_rox AS (
	SELECT 
	p.id, p.id_user, p.title, p.title_slug, p.description, p.token, 
	p.content, p.dt_publication, p.panoramic_photo,
	up.id AS user_id, up.user_, up.name, up.picture picture_u, up.token AS token_user 
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

ALTER MATERIALIZED VIEW post_suggestion_view OWNER TO "user-production";

grant select on all tables in schema public to "user-production";
grant insert on all tables in schema public to "user-production";
grant update on all tables in schema public to "user-production";
grant delete on all tables in schema public to "user-production";
grant all privileges on all sequences in schema public to "user-production";

INSERT INTO migration VALUES(49, 'Cria View Para Posts Sugeridos', '2021-6-24', now());