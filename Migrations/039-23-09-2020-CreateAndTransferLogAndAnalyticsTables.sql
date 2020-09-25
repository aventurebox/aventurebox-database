/*
 Migration  : 039 Developer  : Alex Souza
 Data       : 23-09-2020
 Description: Cria e Transfere as tabelas de Logs para banco de dados externo;
 */


------- ANALYTICS DATABSE -------
SELECT 
   pg_terminate_backend(pg_stat_activity.pid)
FROM pg_stat_activity
WHERE
   pg_stat_activity.datname = "aventurebox_log"
AND pid <> pg_backend_pid();

ALTER DATABASE aventurebox_log RENAME TO aventurebox_analytics;

CREATE TABLE action (
	id SERIAL NOT NULL PRIMARY KEY,
	description VARCHAR(500) NOT NULL
);

CREATE TABLE action_record (
	id SERIAL NOT NULL PRIMARY KEY,
	id_action INTEGER NOT NULL,
	date TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY(id_action) REFERENCES action(id)
);
CREATE TABLE ads_log (
	url TEXT NOT NULL,
	date TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
	id_user_content INTEGER,
	origin INTEGER NOT NULL,
	display TEXT NOT NULL,
	action INTEGER DEFAULT 1
);
CREATE TABLE explore_log (
	id_type INTEGER,
	id_user INTEGER,
	search_key TEXT,
	ip TEXT,
	user_agent TEXT,
	date TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);

grant select on all tables in schema public to "aventurebox";
grant insert on all tables in schema public to "aventurebox";
grant all privileges on all sequences in schema public to "aventurebox";

------- LOG DATABSE -------
CREATE DATABASE aventurebox_log;

REVOKE ALL ON DATABASE aventurebox_log FROM "aventurebox";
GRANT CONNECT ON DATABASE aventurebox_log TO "aventurebox";
GRANT SELECT ON ALL TABLES IN SCHEMA public TO "aventurebox";
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO "aventurebox";
GRANT INSERT ON ALL TABLES IN SCHEMA public TO "aventurebox";
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT INSERT ON TABLES TO "aventurebox";

CREATE TABLE adventure_comment_log (
	id SERIAL NOT NULL PRIMARY KEY,
	type_log INTEGER,
	data_log TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
	id_comment INTEGER,
	id_adventure INTEGER,
	id_user INTEGER,
	text TEXT,
	publication TIMESTAMP WITHOUT TIME ZONE
);

CREATE TABLE adventure_featured_log (
	id SERIAL NOT NULL PRIMARY KEY,
	type_log INTEGER,
	data_log TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
	id_adventure INTEGER,
	order_by INTEGER
);

CREATE TABLE adventure_log (
	id SERIAL NOT NULL PRIMARY KEY,
	type_log INTEGER,
	data_log TIMESTAMP WITHOUT TIME ZONE,
	id_adventure INTEGER,
	id_user INTEGER,
	title TEXT,
	title_slug TEXT,
	description TEXT,
	token CHARACTER VARYING(13),
	dt_start DATE,
	dt_end DATE,
	dt_save TIMESTAMP WITHOUT TIME ZONE,
	dt_publication TIMESTAMP WITHOUT TIME ZONE,
	published BOOLEAN,
	rox INTEGER,
	id_item_report INTEGER,
	id_item_photo INTEGER,
	id_item_video INTEGER,
	id_item_tracklog INTEGER,
	id_item_checklist INTEGER,
	views INTEGER,
	picture CHARACTER VARYING(20)
);

CREATE TABLE adventure_rox_log (
	id SERIAL NOT NULL PRIMARY KEY,
	type_log INTEGER,
	data_log TIMESTAMP WITHOUT TIME ZONE,
	id_adventure INTEGER,
	id_user INTEGER,
	DATE TIMESTAMP WITHOUT TIME ZONE
);

CREATE TABLE contact_log (
	id SERIAL NOT NULL PRIMARY KEY,
	type_log INTEGER,
	data_log TIMESTAMP WITHOUT TIME ZONE,
	id_user_follower INTEGER,
	id_user_following INTEGER,
	dt_follow TIMESTAMP WITHOUT TIME ZONE,
	deprecated_dt_accept TIMESTAMP WITHOUT TIME ZONE,
	deprecated_status CHARACTER VARYING(10)
);

CREATE TABLE item_checklist_log (
	id SERIAL NOT NULL PRIMARY KEY,
	type_log INTEGER,
	data_log TIMESTAMP WITHOUT TIME ZONE,
	id_item_checklist INTEGER,
	content TEXT
);

CREATE TABLE item_report_log (
	id SERIAL NOT NULL PRIMARY KEY,
	type_log INTEGER,
	data_log TIMESTAMP WITHOUT TIME ZONE,
	id_item_report INTEGER,
	text TEXT
);

CREATE TABLE notification_log (
	id SERIAL NOT NULL PRIMARY KEY,
	type_log INTEGER,
	data_log TIMESTAMP WITHOUT TIME ZONE,
	id_notification INTEGER,
	id_user_receiver INTEGER,
	id_user_sender INTEGER,
	id_adventure INTEGER,
	fired TIMESTAMP WITHOUT TIME ZONE,
	id_type INTEGER,
	id_post INTEGER
);

CREATE TABLE photo_log (
	id SERIAL NOT NULL PRIMARY KEY,
	type_log INTEGER,
	data_log TIMESTAMP WITHOUT TIME ZONE,
	id_photo INTEGER,
	file CHARACTER VARYING(20),
	id_item_photo INTEGER
);

CREATE TABLE post_comment_log (
	id SERIAL NOT NULL PRIMARY KEY,
	id_comment INTEGER,
	type_log INTEGER,
	id_post INTEGER,
	id_user INTEGER,
	text TEXT,
	publication TIMESTAMP WITHOUT TIME ZONE,
	dt_log TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE post_featured_log (
	id SERIAL NOT NULL PRIMARY KEY,
	type_log INTEGER NOT NULL,
	dt_log TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
	id_post INTEGER NOT NULL,
	order_by INTEGER NOT NULL
);

CREATE TABLE post_item_log (
	id SERIAL NOT NULL PRIMARY KEY,
	id_post INTEGER,
	file CHARACTER VARYING(20),
	type INTEGER,
	type_log INTEGER,
	dt_log TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE post_log (
	id SERIAL NOT NULL PRIMARY KEY,
	id_post INTEGER,
	type_log INTEGER,
	id_user INTEGER,
	title TEXT,
	title_slug TEXT,
	description TEXT,
	token CHARACTER VARYING(13),
	content TEXT,
	dt_publication TIMESTAMP WITHOUT TIME ZONE,
	dt_save TIMESTAMP WITHOUT TIME ZONE,
	published BOOLEAN,
	views INTEGER,
	dt_log TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
	panoramic_photo CHARACTER VARYING(20),
	picture CHARACTER VARYING(20)
);

CREATE TABLE post_rox_log (
	id SERIAL NOT NULL PRIMARY KEY,
	id_post INTEGER,
	id_user INTEGER,
	DATE TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
	type_log INTEGER,
	dt_log TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE product_log (
	id SERIAL NOT NULL PRIMARY KEY,
	type_log INTEGER,
	dt_log TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
	id_product INTEGER,
	image CHARACTER VARYING(200),
	link CHARACTER VARYING(500),
	title CHARACTER VARYING(500),
	description CHARACTER VARYING(500),
	dt_publication TIMESTAMP WITHOUT TIME ZONE,
	gender INTEGER,
	owner_name CHARACTER VARYING(125),
	owner_url CHARACTER VARYING(500),
	id_user INTEGER
);

CREATE TABLE tracklog_log (
	id SERIAL NOT NULL PRIMARY KEY,
	type_log INTEGER,
	data_log TIMESTAMP WITHOUT TIME ZONE,
	id_tracklog INTEGER,
	title TEXT,
	file TEXT,
	id_item_tracklog INTEGER
);

CREATE TABLE user_featured_log (
	id SERIAL NOT NULL PRIMARY KEY,
	type_log INTEGER,
	data_log TIMESTAMP WITHOUT TIME ZONE,
	id_user INTEGER,
	order_by INTEGER
);

CREATE TABLE user_login_log (
	id SERIAL NOT NULL PRIMARY KEY,
	type_log INTEGER,
	data_log TIMESTAMP WITHOUT TIME ZONE,
	id_user_login INTEGER,
	user_ CHARACTER VARYING(40),
	email CHARACTER VARYING(60),
	pass CHARACTER VARYING(40),
	cookie_token CHARACTER VARYING(40),
	cookie_date DATE,
	pass_reset_token CHARACTER VARYING(40),
	pass_reset_date DATE,
	inactive BOOLEAN,
	genus character(1),
	birth DATE,
	language INTEGER,
	country INTEGER,
	time_zone INTEGER,
	period_notification INTEGER,
	email_failed BOOLEAN,
	notification_cancel_token CHARACTER VARYING(40),
	last_notification_id INTEGER,
	suspended BOOLEAN,
	email_change_token CHARACTER VARYING(40),
	email_change_date DATE,
	email_change_new CHARACTER VARYING(60),
	last_external_notification TIMESTAMP WITHOUT TIME ZONE
);

CREATE TABLE user_profile_log (
	id SERIAL NOT NULL PRIMARY KEY,
	type_log INTEGER,
	data_log TIMESTAMP WITHOUT TIME ZONE,
	id_user_profile INTEGER,
	name CHARACTER VARYING(125),
	picture CHARACTER VARYING(20),
	birth DATE,
	genus character(1),
	dt_register TIMESTAMP WITHOUT TIME ZONE,
	bio TEXT,
	website CHARACTER VARYING(100),
	location CHARACTER VARYING(175),
	token CHARACTER VARYING(13),
	language INTEGER,
	country INTEGER,
	time_zone INTEGER,
	id_user_login INTEGER,
	user_ CHARACTER VARYING(40),
	inactive BOOLEAN,
	suspended BOOLEAN,
	type INTEGER,
	panoramic_photo CHARACTER VARYING(20),
	primary_tab INTEGER,
	dt_delete_request TIMESTAMP WITHOUT TIME ZONE
);

CREATE TABLE user_try_login_log (
	id SERIAL NOT NULL PRIMARY KEY,
	type_log INTEGER,
	data_log TIMESTAMP WITHOUT TIME ZONE,
	ip CHARACTER VARYING(16),
	counter INTEGER,
	"time" TIMESTAMP WITHOUT TIME ZONE
);

CREATE TABLE video_log (
	id SERIAL NOT NULL PRIMARY KEY,
	type_log INTEGER,
	data_log TIMESTAMP WITHOUT TIME ZONE,
	id_video INTEGER,
	title TEXT,
	url CHARACTER VARYING(255),
	type INTEGER,
	id_item_video INTEGER
);

grant select on all tables in schema public to "aventurebox";
grant insert on all tables in schema public to "aventurebox";
grant all privileges on all sequences in schema public to "aventurebox";

------- PRINCIPAL DATABSE -------
DROP FOREIGN TABLE product_event_log;
DROP USER MAPPING FOR "aventurebox" SERVER aventurebox_log;
DROP SERVER aventurebox_log;

CREATE SERVER aventurebox_analytics FOREIGN DATA WRAPPER postgres_fdw OPTIONS (host 'host', port '5432', dbname 'aventurebox_analytics');
CREATE SERVER aventurebox_log FOREIGN DATA WRAPPER postgres_fdw OPTIONS (host 'host', port '5432', dbname 'aventurebox_log');

CREATE USER MAPPING FOR "aventurebox" SERVER aventurebox_analytics OPTIONS (user 'aventurebox', password 'pass');
CREATE USER MAPPING FOR "aventurebox" SERVER aventurebox_log OPTIONS (user 'aventurebox', password 'pass');

ALTER TABLE action RENAME TO old_action;
ALTER TABLE action_record RENAME TO old_action_record;
ALTER TABLE ads_log RENAME TO old_ads_log;
ALTER TABLE adventure_comment_log RENAME TO old_adventure_comment_log;
ALTER TABLE adventure_featured_log RENAME TO old_adventure_featured_log;
ALTER TABLE adventure_log RENAME TO old_adventure_log;
ALTER TABLE adventure_rox_log RENAME TO old_adventure_rox_log;
ALTER TABLE contact_log RENAME TO old_contact_log;
ALTER TABLE explore_log RENAME TO old_explore_log;
ALTER TABLE item_checklist_log RENAME TO old_item_checklist_log;
ALTER TABLE item_report_log RENAME TO old_item_report_log;
ALTER TABLE notification_log RENAME TO old_notification_log;
ALTER TABLE photo_log RENAME TO old_photo_log;
ALTER TABLE post_comment_log RENAME TO old_post_comment_log;
ALTER TABLE post_featured_log RENAME TO old_post_featured_log;
ALTER TABLE post_item_log RENAME TO old_post_item_log;
ALTER TABLE post_log RENAME TO old_post_log;
ALTER TABLE post_rox_log RENAME TO old_post_rox_log;
ALTER TABLE product_log RENAME TO old_product_log;
ALTER TABLE tracklog_log RENAME TO old_tracklog_log;
ALTER TABLE user_featured_log RENAME TO old_user_featured_log;
ALTER TABLE user_login_log RENAME TO old_user_login_log;
ALTER TABLE user_profile_log RENAME TO old_user_profile_log;
ALTER TABLE user_try_login_log RENAME TO old_user_try_login_log;
ALTER TABLE video_log RENAME TO old_video_log;

CREATE FOREIGN TABLE product_event_log (
	event INT NOT NULL,
	id_product INT NOT NULL,
	id_user INT,
	dt_action TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
	device VARCHAR(15),
	ip TEXT,
	origin VARCHAR(100),
	url VARCHAR(200)
) SERVER aventurebox_analytics OPTIONS (table_name 'product_event_log');

CREATE FOREIGN TABLE action (
	id INT,
	description VARCHAR(500) NOT NULL
) SERVER aventurebox_analytics OPTIONS (table_name 'action');

CREATE FOREIGN TABLE action_record (
	id_action INTEGER NOT NULL,
	date TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
) SERVER aventurebox_analytics OPTIONS (table_name 'action_record');

CREATE FOREIGN TABLE ads_log (
	url TEXT NOT NULL,
	date TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
	id_user_content INTEGER,
	origin INTEGER NOT NULL,
	display TEXT NOT NULL,
	action INTEGER DEFAULT 1
) SERVER aventurebox_analytics OPTIONS (table_name 'ads_log');

CREATE FOREIGN TABLE explore_log (
	id_type INTEGER,
	id_user INTEGER,
	search_key TEXT,
	ip TEXT,
	user_agent TEXT,
	date TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
) SERVER aventurebox_analytics OPTIONS (table_name 'explore_log');

CREATE FOREIGN TABLE adventure_comment_log (
	type_log INTEGER,
	data_log TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
	id_comment INTEGER,
	id_adventure INTEGER,
	id_user INTEGER,
	text TEXT,
	publication TIMESTAMP WITHOUT TIME ZONE
) SERVER aventurebox_log OPTIONS (table_name 'adventure_comment_log');

CREATE FOREIGN TABLE adventure_featured_log (
	type_log INTEGER,
	data_log TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
	id_adventure INTEGER,
	order_by INTEGER
) SERVER aventurebox_log OPTIONS (table_name 'adventure_featured_log');

CREATE FOREIGN TABLE adventure_log (
	type_log INTEGER,
	data_log TIMESTAMP WITHOUT TIME ZONE,
	id_adventure INTEGER,
	id_user INTEGER,
	title TEXT,
	title_slug TEXT,
	description TEXT,
	token CHARACTER VARYING(13),
	dt_start DATE,
	dt_end DATE,
	dt_save TIMESTAMP WITHOUT TIME ZONE,
	dt_publication TIMESTAMP WITHOUT TIME ZONE,
	published BOOLEAN,
	rox INTEGER,
	id_item_report INTEGER,
	id_item_photo INTEGER,
	id_item_video INTEGER,
	id_item_tracklog INTEGER,
	id_item_checklist INTEGER,
	views INTEGER,
	picture CHARACTER VARYING(20)
) SERVER aventurebox_log OPTIONS (table_name 'adventure_log');

CREATE FOREIGN TABLE adventure_rox_log (
	type_log INTEGER,
	data_log TIMESTAMP WITHOUT TIME ZONE,
	id_adventure INTEGER,
	id_user INTEGER,
	DATE TIMESTAMP WITHOUT TIME ZONE
) SERVER aventurebox_log OPTIONS (table_name 'adventure_rox_log');

CREATE FOREIGN TABLE contact_log (
	type_log INTEGER,
	data_log TIMESTAMP WITHOUT TIME ZONE,
	id_user_follower INTEGER,
	id_user_following INTEGER,
	dt_follow TIMESTAMP WITHOUT TIME ZONE,
	deprecated_dt_accept TIMESTAMP WITHOUT TIME ZONE,
	deprecated_status CHARACTER VARYING(10)
) SERVER aventurebox_log OPTIONS (table_name 'contact_log');

CREATE FOREIGN TABLE item_checklist_log (
	type_log INTEGER,
	data_log TIMESTAMP WITHOUT TIME ZONE,
	id_item_checklist INTEGER,
	content TEXT
) SERVER aventurebox_log OPTIONS (table_name 'item_checklist_log');;

CREATE FOREIGN TABLE item_report_log (
	type_log INTEGER,
	data_log TIMESTAMP WITHOUT TIME ZONE,
	id_item_report INTEGER,
	text TEXT
) SERVER aventurebox_log OPTIONS (table_name 'item_report_log');

CREATE FOREIGN TABLE notification_log (
	type_log INTEGER,
	data_log TIMESTAMP WITHOUT TIME ZONE,
	id_notification INTEGER,
	id_user_receiver INTEGER,
	id_user_sender INTEGER,
	id_adventure INTEGER,
	fired TIMESTAMP WITHOUT TIME ZONE,
	id_type INTEGER,
	id_post INTEGER
) SERVER aventurebox_log OPTIONS (table_name 'notification_log');

CREATE FOREIGN TABLE photo_log (
	type_log INTEGER,
	data_log TIMESTAMP WITHOUT TIME ZONE,
	id_photo INTEGER,
	file CHARACTER VARYING(20),
	id_item_photo INTEGER
) SERVER aventurebox_log OPTIONS (table_name 'photo_log');

CREATE FOREIGN TABLE post_comment_log (
	id_comment INTEGER,
	type_log INTEGER,
	id_post INTEGER,
	id_user INTEGER,
	text TEXT,
	publication TIMESTAMP WITHOUT TIME ZONE,
	dt_log TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP
) SERVER aventurebox_log OPTIONS (table_name 'post_comment_log');;

CREATE FOREIGN TABLE post_featured_log (
	type_log INTEGER NOT NULL,
	dt_log TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
	id_post INTEGER NOT NULL,
	order_by INTEGER NOT NULL
) SERVER aventurebox_log OPTIONS (table_name 'post_featured_log');

CREATE FOREIGN TABLE post_item_log (
	id_post INTEGER,
	file CHARACTER VARYING(20),
	type INTEGER,
	type_log INTEGER,
	dt_log TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP
) SERVER aventurebox_log OPTIONS (table_name 'post_item_log');

CREATE FOREIGN TABLE post_log (
	id_post INTEGER,
	type_log INTEGER,
	id_user INTEGER,
	title TEXT,
	title_slug TEXT,
	description TEXT,
	token CHARACTER VARYING(13),
	content TEXT,
	dt_publication TIMESTAMP WITHOUT TIME ZONE,
	dt_save TIMESTAMP WITHOUT TIME ZONE,
	published BOOLEAN,
	views INTEGER,
	dt_log TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
	panoramic_photo CHARACTER VARYING(20),
	picture CHARACTER VARYING(20)
) SERVER aventurebox_log OPTIONS (table_name 'post_log');

CREATE FOREIGN TABLE post_rox_log (
	id_post INTEGER,
	id_user INTEGER,
	date TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
	type_log INTEGER,
	dt_log TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP
) SERVER aventurebox_log OPTIONS (table_name 'post_rox_log');

CREATE FOREIGN TABLE product_log (
	type_log INTEGER,
	dt_log TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
	id_product INTEGER,
	image CHARACTER VARYING(200),
	link CHARACTER VARYING(500),
	title CHARACTER VARYING(500),
	description CHARACTER VARYING(500),
	dt_publication TIMESTAMP WITHOUT TIME ZONE,
	gender INTEGER,
	owner_name CHARACTER VARYING(125),
	owner_url CHARACTER VARYING(500),
	id_user INTEGER
) SERVER aventurebox_log OPTIONS (table_name 'product_log');

CREATE FOREIGN TABLE tracklog_log (
	type_log INTEGER,
	data_log TIMESTAMP WITHOUT TIME ZONE,
	id_tracklog INTEGER,
	title TEXT,
	file TEXT,
	id_item_tracklog INTEGER
) SERVER aventurebox_log OPTIONS (table_name 'tracklog_log');

CREATE FOREIGN TABLE user_featured_log (
	type_log INTEGER,
	data_log TIMESTAMP WITHOUT TIME ZONE,
	id_user INTEGER,
	order_by INTEGER
) SERVER aventurebox_log OPTIONS (table_name 'user_featured_log');

CREATE FOREIGN TABLE user_login_log (
	type_log INTEGER,
	data_log TIMESTAMP WITHOUT TIME ZONE,
	id_user_login INTEGER,
	user_ CHARACTER VARYING(40),
	email CHARACTER VARYING(60),
	pass CHARACTER VARYING(40),
	cookie_token CHARACTER VARYING(40),
	cookie_date DATE,
	pass_reset_token CHARACTER VARYING(40),
	pass_reset_date DATE,
	inactive BOOLEAN,
	genus character(1),
	birth DATE,
	language INTEGER,
	country INTEGER,
	time_zone INTEGER,
	period_notification INTEGER,
	email_failed BOOLEAN,
	notification_cancel_token CHARACTER VARYING(40),
	last_notification_id INTEGER,
	suspended BOOLEAN,
	email_change_token CHARACTER VARYING(40),
	email_change_date DATE,
	email_change_new CHARACTER VARYING(60),
	last_external_notification TIMESTAMP WITHOUT TIME ZONE
) SERVER aventurebox_log OPTIONS (table_name 'user_login_log');

CREATE FOREIGN TABLE user_profile_log (
	type_log INTEGER,
	data_log TIMESTAMP WITHOUT TIME ZONE,
	id_user_profile INTEGER,
	name CHARACTER VARYING(125),
	picture CHARACTER VARYING(20),
	birth DATE,
	genus character(1),
	dt_register TIMESTAMP WITHOUT TIME ZONE,
	bio TEXT,
	website CHARACTER VARYING(100),
	location CHARACTER VARYING(175),
	token CHARACTER VARYING(13),
	language INTEGER,
	country INTEGER,
	time_zone INTEGER,
	id_user_login INTEGER,
	user_ CHARACTER VARYING(40),
	inactive BOOLEAN,
	suspended BOOLEAN,
	type INTEGER,
	panoramic_photo CHARACTER VARYING(20),
	primary_tab INTEGER,
	dt_delete_request TIMESTAMP WITHOUT TIME ZONE
) SERVER aventurebox_log OPTIONS (table_name 'user_profile_log');

CREATE FOREIGN TABLE user_try_login_log (
	type_log INTEGER,
	data_log TIMESTAMP WITHOUT TIME ZONE,
	ip CHARACTER VARYING(16),
	counter INTEGER,
	"time" TIMESTAMP WITHOUT TIME ZONE
) SERVER aventurebox_log OPTIONS (table_name 'user_try_login_log');

CREATE FOREIGN TABLE video_log (
	type_log INTEGER,
	data_log TIMESTAMP WITHOUT TIME ZONE,
	id_video INTEGER,
	title TEXT,
	url CHARACTER VARYING(255),
	type INTEGER,
	id_item_video INTEGER
) SERVER aventurebox_log OPTIONS (table_name 'video_log');

BEGIN TRANSACTION;

INSERT INTO action SELECT description FROM old_action ORDER BY id ASC;
INSERT INTO action_record SELECT id_action, date FROM old_action_record;
INSERT INTO ads_log SELECT url, date, id_user_content, origin, display, action FROM old_ads_log;
INSERT INTO explore_log SELECT id_type, id_user, search_key, ip, user_agent, date FROM old_explore_log;
INSERT INTO adventure_comment_log SELECT type_log, data_log, id_comment, id_adventure, id_user, text, publication FROM old_adventure_comment_log;
INSERT INTO adventure_featured_log SELECT type_log, data_log, id_adventure, order_by FROM old_adventure_featured_log;
INSERT INTO adventure_log SELECT type_log, data_log, id_adventure, id_user, title, title_slug, description, token, dt_start, dt_end, dt_save, dt_publication, published, rox, id_item_report, id_item_photo, id_item_video, id_item_tracklog, id_item_checklist, views, picture FROM old_adventure_log;
INSERT INTO adventure_rox_log SELECT type_log, data_log, id_adventure, id_user FROM old_adventure_rox_log;
INSERT INTO contact_log SELECT type_log, data_log, id_user_follower, id_user_following, dt_follow, deprecated_dt_accept, deprecated_status FROM old_contact_log;
INSERT INTO item_checklist_log SELECT type_log, data_log, id_item_checklist, content FROM old_item_checklist_log;
INSERT INTO item_report_log SELECT type_log, data_log, id_item_report, text FROM old_item_report_log;
INSERT INTO notification_log SELECT type_log, data_log, id_notification, id_user_receiver, id_user_sender, id_adventure, fired, id_type, id_post FROM old_notification_log;
INSERT INTO photo_log SELECT type_log, data_log, id_photo, file, id_item_photo FROM old_photo_log;
INSERT INTO post_comment_log SELECT id_comment, type_log, id_post, id_user, text, publication, dt_log FROM old_post_comment_log;
INSERT INTO post_featured_log SELECT type_log, dt_log, id_post, order_by FROM old_post_featured_log;
INSERT INTO post_item_log SELECT id_post, file, type, type_log, dt_log FROM old_post_item_log;
INSERT INTO post_log SELECT id_post, type_log, id_user, title, title_slug, description, token, content, dt_publication, dt_save, published, views, dt_log, panoramic_photo, picture FROM old_post_log;
INSERT INTO post_rox_log SELECT id_post, id_user, date, type_log, dt_log FROM old_post_rox_log;
INSERT INTO product_log SELECT type_log, dt_log, id_product, image, link, title, description, dt_publication, gender, owner_name, owner_url, id_user FROM old_product_log;
INSERT INTO tracklog_log SELECT type_log, data_log, id_tracklog, title, file, id_item_tracklog FROM old_tracklog_log;
INSERT INTO user_featured_log SELECT type_log, data_log, id_user, order_by FROM old_user_featured_log;
INSERT INTO user_login_log SELECT type_log, data_log, id_user_login, user_, email, pass, cookie_token, cookie_date, pass_reset_token, pass_reset_date, inactive, genus, birth, language, country, time_zone, period_notification, email_failed, notification_cancel_token, last_notification_id, suspended, email_change_token, email_change_date, email_change_new, last_external_notification FROM old_user_login_log;
INSERT INTO user_profile_log SELECT type_log, data_log, id_user_profile, name, picture, birth, genus, dt_register, bio, website, location, token, language, country, time_zone, id_user_login, user_, inactive, suspended, type, panoramic_photo, primary_tab, dt_delete_request FROM old_user_profile_log;
INSERT INTO user_try_login_log SELECT type_log, data_log, ip, counter, time FROM old_user_try_login_log;
INSERT INTO video_log SELECT type_log, data_log, id_video, title, url, type, id_item_video FROM old_video_log;

END TRANSACTION;

DROP TABLE old_action_record;
DROP TABLE old_action;
DROP TABLE old_ads_log;
DROP TABLE old_adventure_comment_log;
DROP TABLE old_adventure_featured_log;
DROP TABLE old_adventure_log;
DROP TABLE old_adventure_rox_log;
DROP TABLE old_contact_log;
DROP TABLE old_explore_log;
DROP TABLE old_item_checklist_log;
DROP TABLE old_item_report_log;
DROP TABLE old_notification_log;
DROP TABLE old_photo_log;
DROP TABLE old_post_comment_log;
DROP TABLE old_post_featured_log;
DROP TABLE old_post_item_log;
DROP TABLE old_post_log;
DROP TABLE old_post_rox_log;
DROP TABLE old_product_log;
DROP TABLE old_tracklog_log;
DROP TABLE old_user_featured_log;
DROP TABLE old_user_login_log;
DROP TABLE old_user_profile_log;
DROP TABLE old_user_try_login_log;
DROP TABLE old_video_log;

grant select on all tables in schema public to "aventurebox";
grant insert on all tables in schema public to "aventurebox";
grant update on all tables in schema public to "aventurebox";
grant delete on all tables in schema public to "aventurebox";
grant all privileges on all sequences in schema public to "aventurebox";

INSERT INTO migration VALUES(39, 'Cria e transfere as tabelas de logs para banco de dados externo', '2020-09-25', now());


