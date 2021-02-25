/*
 Migration  : 046 Developer  : Alex Souza
 Data       : 25-02-2021
 Description: Cria View Para Aventuras Sugeridas da Home;
*/

CREATE TABLE adventure_suggestion (
	id SERIAL NOT NULL PRIMARY KEY,
	id_adventure INT NOT NULL,
	dt_add TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
	UNIQUE(id, id_adventure),
	FOREIGN KEY(id_adventure) REFERENCES adventure(id) ON DELETE CASCADE
);

CREATE MATERIALIZED VIEW adventure_suggestion_view AS
WITH 
top_rox AS (
	SELECT 
	a.id, a.id_user, a.title, a.title_slug, a.description, a.token, 
	a.dt_start, a.dt_end, a.dt_publication, a.id_item_report, a.id_item_photo,
	a.id_item_video, a.id_item_tracklog, a.id_item_checklist, a.panoramic_photo, a.picture, 
	a.location[0] lat, a.location[1] lng, 
	up.id AS user_id, up.user_, up.name, up.picture picture_u, up.token AS token_user 
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

ALTER MATERIALIZED VIEW adventure_suggestion_view OWNER TO "aventurebox"

grant select on all tables in schema public to "aventurebox";
grant insert on all tables in schema public to "aventurebox";
grant update on all tables in schema public to "aventurebox";
grant delete on all tables in schema public to "aventurebox";
grant all privileges on all sequences in schema public to "aventurebox";

INSERT INTO migration VALUES(46, 'Cria View Para Aventuras Sugeridas', '2021-2-25', now());