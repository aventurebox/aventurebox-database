/*
 Migration  : 040 Developer  : Alex Souza
 Data       : 05-10-2020
 Description: Cria tabela de ads/banners e log de eventos;
*/

CREATE TABLE advertising (
	id SERIAL NOT NULL PRIMARY KEY,
	campaign_name VARCHAR(30) NOT NULL,
	image_desktop_sidebar TEXT,
	image_desktop_parallax TEXT,
	image_desktop_parallax_background TEXT,
	image_mobile TEXT,
	image_app TEXT,
	location TEXT NOT NULL,
	dt_start TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
	dt_end TIMESTAMP WITHOUT TIME ZONE,
	url TEXT NOT NULL,
	alt VARCHAR(200),
	not_list BOOLEAN DEFAULT FALSE,
	id_user INT,
	language VARCHAR(5),
	UNIQUE(campaign_name, language),
	FOREIGN KEY(id_user) REFERENCES user_profile(id)
);

CREATE FUNCTION fn_advertising_trigger() 
	RETURNS trigger
AS $BODY$
    BEGIN
        IF (TG_OP = 'DELETE') THEN
            INSERT INTO advertising_log(id_advertising, type_log, dt_log, campaign_name, image_desktop_sidebar, image_desktop_parallax, image_desktop_parallax_background, image_mobile, image_app, location, dt_start, dt_end, url, alt, not_list, id_user, language)
            VALUES (old.id, 3, NOW(), old.campaign_name, old.image_desktop_sidebar, old.image_desktop_parallax, old.image_desktop_parallax_background, old.image_mobile, old.image_app, old.location, old.dt_start, old.dt_end, old.url, old.alt, old.not_list, old.id_user, old.language);
            RETURN old;
        ELSIF (TG_OP = 'UPDATE') THEN
            INSERT INTO advertising_log(id_advertising, type_log, dt_log, campaign_name, image_desktop_sidebar, image_desktop_parallax, image_desktop_parallax_background, image_mobile, image_app, location, dt_start, dt_end, url, alt, not_list, id_user, language)
            VALUES (new.id, 2, NOW(), new.campaign_name, new.image_desktop_sidebar, new.image_desktop_parallax, new.image_desktop_parallax_background, new.image_mobile, new.image_app, new.location, new.dt_start, new.dt_end, new.url, new.alt, new.not_list, new.id_user, new.language);
            RETURN new;
        ELSIF (TG_OP = 'INSERT') THEN
            INSERT INTO advertising_log(id_advertising, type_log, dt_log, campaign_name, image_desktop_sidebar, image_desktop_parallax, image_desktop_parallax_background, image_mobile, image_app, location, dt_start, dt_end, url, alt, not_list, id_user, language)
            VALUES (new.id, 1, NOW(), new.campaign_name, new.image_desktop_sidebar, new.image_desktop_parallax, new.image_desktop_parallax_background, new.image_mobile, new.image_app, new.location, new.dt_start, new.dt_end, new.url, new.alt, new.not_list, new.id_user, new.language);
            RETURN new;
        END IF;
        RETURN NULL;
    END;
$BODY$ LANGUAGE plpgsql COST 100 VOLATILE NOT LEAKPROOF;

CREATE TRIGGER tg_advertising AFTER INSERT OR UPDATE OR DELETE ON advertising FOR EACH ROW EXECUTE PROCEDURE fn_advertising_trigger();

CREATE FOREIGN TABLE advertising_log (
	type_log INT,
	dt_log TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	id_advertising INT NOT NULL,
	campaign_name VARCHAR(30) NOT NULL,
	image_desktop_sidebar TEXT,
	image_desktop_parallax TEXT,
	image_desktop_parallax_background TEXT,
	image_mobile TEXT,
	image_app TEXT,
	location TEXT NOT NULL,
	dt_start TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
	dt_end TIMESTAMP WITHOUT TIME ZONE,
	url TEXT NOT NULL,
	alt VARCHAR(200),
	not_list BOOLEAN DEFAULT FALSE,
	id_user INT,
	language VARCHAR(5)
) SERVER aventurebox_log OPTIONS (table_name 'advertising_log');

CREATE FOREIGN TABLE advertising_event_log (
	event INT NOT NULL,
	id_advertising INT NOT NULL,
	id_user INT,
	dt_event TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
	device VARCHAR(15),
	ip TEXT,
	origin VARCHAR(100),
	location VARCHAR(100),
	url VARCHAR(200)
) SERVER aventurebox_analytics OPTIONS (table_name 'advertising_event_log');

INSERT INTO advertising(campaign_name, image_desktop_sidebar, location, url, alt, language) VALUES ('spot-brasil-apoio', 'https://aventurebox.com/ui/img/banner-spot-x-aventurebox.jpg', 'explore', 'https://www.findmespot.com/pt-br/products-services/spot-x?utm_source=AventureBox&utm_medium=Display&utm_campaign=Generic2020', 'Spot Brasil', 'pt-br');

INSERT INTO advertising (campaign_name, image_mobile, location, url, alt, language) VALUES ('aventurebox-app-ios', 'https://aventurebox.com/ui/img/apple-app-aventurebox-banner-mob-pt-br.jpg', 'explore', 'itms-apps://apps.apple.com/app/aventurebox/id1479232795', 'Download App AventureBox Apple Store', 'pt-br');
INSERT INTO advertising (campaign_name, image_mobile, location, url, alt, language) VALUES ('aventurebox-app-ios', 'https://aventurebox.com/ui/img/apple-app-aventurebox-banner-mob-en-us.jpg', 'explore', 'itms-apps://apps.apple.com/app/aventurebox/id1479232795', 'Download App AventureBox Apple Store', 'en-us');
INSERT INTO advertising (campaign_name, image_mobile, location, url, alt, language) VALUES ('aventurebox-app-ios', 'https://aventurebox.com/ui/img/apple-app-aventurebox-banner-mob-es.jpg', 'explore', 'itms-apps://apps.apple.com/app/aventurebox/id1479232795', 'Download App AventureBox Apple Store', 'es');

INSERT INTO advertising (campaign_name, image_mobile, location, url, alt, language) VALUES ('aventurebox-app-android', 'https://aventurebox.com/ui/img/android-app-aventurebox-banner-mob-pt-br.jpg', 'explore', 'https://play.google.com/store/apps/details?id=com.aventurebox', 'Download App AventureBox Play Store', 'pt-br');
INSERT INTO advertising (campaign_name, image_mobile, location, url, alt, language) VALUES ('aventurebox-app-android', 'https://aventurebox.com/ui/img/android-app-aventurebox-banner-mob-en-us.jpg', 'explore', 'https://play.google.com/store/apps/details?id=com.aventurebox', 'Download App AventureBox Play Store', 'en-us');
INSERT INTO advertising (campaign_name, image_mobile, location, url, alt, language) VALUES ('aventurebox-app-android', 'https://aventurebox.com/ui/img/android-app-aventurebox-banner-mob-es.jpg', 'explore', 'https://play.google.com/store/apps/details?id=com.aventurebox', 'Download App AventureBox Play Store', 'es');


grant select on all tables in schema public to "aventurebox";
grant insert on all tables in schema public to "aventurebox";
grant update on all tables in schema public to "aventurebox";
grant delete on all tables in schema public to "aventurebox";
grant all privileges on all sequences in schema public to "aventurebox";

INSERT INTO migration VALUES(40, 'Cria tabela de ads/banners e de log', '2020-10-05', now());

--------------- AVENTUREBOX ANALYTICS MIGRATION --------------------

CREATE TABLE advertising_event_log (
	id BIGSERIAL NOT NULL PRIMARY KEY,
	event INT NOT NULL,
	id_advertising INT NOT NULL,
	id_user INT,
	dt_event TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
	device VARCHAR(15),
	ip TEXT,
	origin VARCHAR(100),
	location VARCHAR(100),
	url VARCHAR(200)
);
grant select on all tables in schema public to "aventurebox";
grant insert on all tables in schema public to "aventurebox";
grant all privileges on all sequences in schema public to "aventurebox";

--------------- AVENTUREBOX LOGS MIGRATION --------------------

CREATE TABLE advertising_log (
	id SERIAL NOT NULL PRIMARY KEY,
	type_log INT,
	dt_log TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	id_advertising INT NOT NULL,
	campaign_name VARCHAR(30) NOT NULL,
	image_desktop_sidebar TEXT,
	image_desktop_parallax TEXT,
	image_desktop_parallax_background TEXT,
	image_mobile TEXT,
	image_app TEXT,
	location TEXT NOT NULL,
	dt_start TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
	dt_end TIMESTAMP WITHOUT TIME ZONE,
	url TEXT NOT NULL,
	alt VARCHAR(200),
	not_list BOOLEAN DEFAULT FALSE,
	id_user INT,
	language VARCHAR(5)
);

grant select on all tables in schema public to "aventurebox";
grant insert on all tables in schema public to "aventurebox";
grant all privileges on all sequences in schema public to "aventurebox";

