/*
 Migration  : 030 Developer  : Alex Souza
 Data       : 15-06-2020
 Description: Alter table contact and log;
*/

-- ALTER TABLES TO NEW COLUMN NAMES;
ALTER TABLE contact RENAME COLUMN id_user_inviter TO id_user_follower;
ALTER TABLE contact RENAME COLUMN id_user_guest TO id_user_following;
ALTER TABLE contact RENAME COLUMN dt_inviter TO dt_follow;
ALTER TABLE contact RENAME COLUMN dt_accept TO deprecated_dt_accept;
ALTER TABLE contact RENAME COLUMN status TO deprecated_status;

ALTER TABLE contact_log RENAME COLUMN id_user_inviter TO id_user_follower;
ALTER TABLE contact_log RENAME COLUMN id_user_guest TO id_user_following;
ALTER TABLE contact_log RENAME COLUMN dt_inviter TO dt_follow;
ALTER TABLE contact_log RENAME COLUMN dt_accept TO deprecated_dt_accept;
ALTER TABLE contact_log RENAME COLUMN status TO deprecated_status;

ALTER TABLE contact ALTER COLUMN deprecated_status DROP NOT NULL;

-- RECREATE LOG TRIGGERS
DROP TRIGGER tg_contact_insert ON contact;
DROP TRIGGER tg_contact_delete ON contact;
DROP TRIGGER tg_contact_update ON contact;
DROP FUNCTION fn_contact_insert();
DROP FUNCTION fn_contact_delete();
DROP FUNCTION fn_contact_update();

CREATE FUNCTION fn_contact_insert()
	RETURNS trigger
	LANGUAGE 'plpgsql'
	COST 100
	VOLATILE NOT LEAKPROOF 
AS $BODY$
BEGIN
INSERT INTO contact_log(type_log, data_log, id_user_following, id_user_follower, dt_follow)
	VALUES (1, NOW(), new.id_user_following, new.id_user_follower, new.dt_follow);
	return new;
   END; 
	$BODY$;
CREATE TRIGGER tg_contact_insert AFTER INSERT ON contact FOR EACH ROW EXECUTE PROCEDURE fn_contact_insert();


CREATE FUNCTION fn_contact_delete()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF 
AS $BODY$
BEGIN
INSERT INTO contact_log(type_log,data_log,id_user_following,id_user_follower, dt_follow)
    VALUES (3,NOW(),old.id_user_following,old.id_user_follower,old.dt_follow);
    return old;
    END; 
    $BODY$;
CREATE TRIGGER tg_contact_delete AFTER DELETE ON contact FOR EACH ROW EXECUTE PROCEDURE fn_contact_delete();

-- INSERT INTO TABLE NEW ROWS TO MUTUAL CONTACTS TO FOLLOW
BEGIN TRANSACTION;
INSERT INTO contact(id_user_follower, id_user_following, dt_follow, deprecated_dt_accept, deprecated_status) SELECT id_user_following, id_user_follower, dt_follow, deprecated_dt_accept, deprecated_status FROM contact WHERE deprecated_status = 'done';
END TRANSACTION;


ALTER FUNCTION fn_contact_insert() OWNER TO "aventurebox";
ALTER FUNCTION fn_contact_delete() OWNER TO "aventurebox";

grant select on all tables in schema public to "aventurebox";
grant insert on all tables in schema public to "aventurebox";
grant update on all tables in schema public to "aventurebox";
grant delete on all tables in schema public to "aventurebox";
grant all privileges on all sequences in schema public to "aventurebox";


INSERT INTO migration VALUES(30,'Altera a tabela de contatos (seguidores)','2020-06-15', now());
