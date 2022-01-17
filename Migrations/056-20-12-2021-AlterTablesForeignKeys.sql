/*
 Migration  : 056 Developer  : Giselle Hoekveld Silva
 Data       : 20-12-2021
 Description: Altera tabelas na chave estrangeira com on delete cascade;
*/

------------------------------------- ADVENTURE -------------------------------------
ALTER TABLE public.adventure DROP CONSTRAINT adventure_id_item_checklist_fkey,
ADD CONSTRAINT adventure_id_item_checklist_fkey FOREIGN KEY (id_item_checklist) REFERENCES public.item_checklist(id) ON DELETE CASCADE;
ALTER TABLE public.adventure DROP CONSTRAINT adventure_id_item_photo_fkey,
ADD CONSTRAINT adventure_id_item_photo_fkey FOREIGN KEY (id_item_photo) REFERENCES public.item_photo(id) ON DELETE CASCADE;
ALTER TABLE public.adventure DROP CONSTRAINT adventure_id_item_report_fkey,
ADD CONSTRAINT adventure_id_item_report_fkey FOREIGN KEY (id_item_report) REFERENCES public.item_report(id) ON DELETE CASCADE;
ALTER TABLE public.adventure DROP CONSTRAINT adventure_id_item_tracklog_fkey,
ADD CONSTRAINT adventure_id_item_tracklog_fkey FOREIGN KEY (id_item_tracklog) REFERENCES public.item_tracklog(id) ON DELETE CASCADE;
ALTER TABLE public.adventure DROP CONSTRAINT adventure_id_item_video_fkey,
ADD CONSTRAINT adventure_id_item_video_fkey FOREIGN KEY (id_item_video) REFERENCES public.item_video(id) ON DELETE CASCADE;
ALTER TABLE public.adventure DROP CONSTRAINT adventure_id_user_fkey,
ADD CONSTRAINT adventure_id_user_fkey FOREIGN KEY (id_user) REFERENCES public.user_profile(id) ON DELETE CASCADE;

ALTER TABLE public.adventure_comment DROP CONSTRAINT adventure_comment_id_user_fkey,
ADD CONSTRAINT adventure_comment_id_user_fkey FOREIGN KEY (id_user) REFERENCES public.user_profile(id) ON DELETE CASCADE;
ALTER TABLE public.adventure_comment DROP CONSTRAINT comment_id_adventure_fkey,
ADD CONSTRAINT comment_id_adventure_fkey FOREIGN KEY (id_adventure) REFERENCES public.adventure(id) ON DELETE CASCADE;

ALTER TABLE public.adventure_competition DROP CONSTRAINT adventure_competition_id_user_fkey,
ADD CONSTRAINT adventure_competition_id_user_fkey FOREIGN KEY (id_user) REFERENCES public.user_profile(id) ON DELETE CASCADE;

ALTER TABLE public.adventure_complaint DROP CONSTRAINT adventure_complaint_id_adventure_fkey,
ADD CONSTRAINT adventure_complaint_id_adventure_fkey FOREIGN KEY (id_adventure) REFERENCES public.adventure(id) ON DELETE CASCADE;
ALTER TABLE public.adventure_complaint DROP CONSTRAINT adventure_complaint_id_user_fkey,
ADD CONSTRAINT adventure_complaint_id_user_fkey FOREIGN KEY (id_user) REFERENCES public.user_profile(id) ON DELETE CASCADE;

ALTER TABLE public.adventure_hide DROP CONSTRAINT adventure_hide_id_adventure_fkey,
ADD CONSTRAINT adventure_hide_id_adventure_fkey FOREIGN KEY (id_adventure) REFERENCES public.adventure(id) ON DELETE CASCADE;
ALTER TABLE public.adventure_hide DROP CONSTRAINT adventure_hide_id_user_fkey,
ADD CONSTRAINT adventure_hide_id_user_fkey FOREIGN KEY (id_user) REFERENCES public.user_profile(id) ON DELETE CASCADE;

ALTER TABLE public.adventure_modality DROP CONSTRAINT adventure_modality_id_adventure_fkey,
ADD CONSTRAINT adventure_modality_id_adventure_fkey FOREIGN KEY (id_adventure) REFERENCES public.adventure(id) ON DELETE CASCADE;
ALTER TABLE public.adventure_modality DROP CONSTRAINT adventure_modality_id_modality_fkey,
ADD CONSTRAINT adventure_modality_id_modality_fkey FOREIGN KEY (id_modality) REFERENCES public.modality(id) ON DELETE CASCADE;

ALTER TABLE public.adventure_participant DROP CONSTRAINT adventure_participant_id_adventure_fkey,
ADD CONSTRAINT adventure_participant_id_adventure_fkey FOREIGN KEY (id_adventure) REFERENCES public.adventure(id) ON DELETE CASCADE;
ALTER TABLE public.adventure_participant DROP CONSTRAINT adventure_participant_id_user_fkey,
ADD CONSTRAINT adventure_participant_id_user_fkey FOREIGN KEY (id_user) REFERENCES public.user_profile(id) ON DELETE CASCADE;

ALTER TABLE public.adventure_rox DROP CONSTRAINT rox_id_adventure_fkey,
ADD CONSTRAINT rox_id_adventure_fkey FOREIGN KEY (id_adventure) REFERENCES public.adventure(id) ON DELETE CASCADE;
ALTER TABLE public.adventure_rox DROP CONSTRAINT rox_id_user_fkey,
ADD CONSTRAINT rox_id_user_fkey FOREIGN KEY (id_user) REFERENCES public.user_profile(id) ON DELETE CASCADE;

ALTER TABLE public.item_report_photo DROP CONSTRAINT item_report_photo_id_item_report_fkey,
ADD CONSTRAINT item_report_photo_id_item_report_fkey FOREIGN KEY (id_item_report) REFERENCES public.item_report(id) ON DELETE CASCADE;

ALTER TABLE public.notification DROP CONSTRAINT notification_id_adventure_fkey,
ADD CONSTRAINT notification_id_adventure_fkey FOREIGN KEY (id_adventure) REFERENCES public.adventure(id) ON DELETE CASCADE;
ALTER TABLE public.notification DROP CONSTRAINT notification_id_post_fkey,
ADD CONSTRAINT notification_id_post_fkey FOREIGN KEY (id_post) REFERENCES public.post(id) ON DELETE CASCADE;
ALTER TABLE public.notification DROP CONSTRAINT notification_id_type_fkey,
ADD CONSTRAINT notification_id_type_fkey FOREIGN KEY (id_type) REFERENCES public.notification_type(id) ON DELETE CASCADE;
ALTER TABLE public.notification DROP CONSTRAINT notification_id_user_receiver_fkey,
ADD CONSTRAINT notification_id_user_receiver_fkey FOREIGN KEY (id_user_receiver) REFERENCES public.user_profile(id) ON DELETE CASCADE;
ALTER TABLE public.notification DROP CONSTRAINT notification_id_user_sender_fkey,
ADD CONSTRAINT notification_id_user_sender_fkey FOREIGN KEY (id_user_sender) REFERENCES public.user_profile(id) ON DELETE CASCADE;

ALTER TABLE public.photo DROP CONSTRAINT photo_id_item_photo_fkey,
ADD CONSTRAINT photo_id_item_photo_fkey FOREIGN KEY (id_item_photo) REFERENCES public.item_photo(id) ON DELETE CASCADE;

ALTER TABLE public.tracklog DROP CONSTRAINT tracklog_id_item_tracklog_fkey,
ADD CONSTRAINT tracklog_id_item_tracklog_fkey FOREIGN KEY (id_item_tracklog) REFERENCES public.item_tracklog(id) ON DELETE CASCADE;

ALTER TABLE public.video DROP CONSTRAINT video_id_item_video_fkey,
ADD CONSTRAINT video_id_item_video_fkey FOREIGN KEY (id_item_video) REFERENCES public.item_video(id) ON DELETE CASCADE;

------------------------------------- POST -------------------------------------
ALTER TABLE public.post DROP CONSTRAINT post_id_user_fkey,
ADD CONSTRAINT post_id_user_fkey FOREIGN KEY (id_user) REFERENCES public.user_profile(id) ON DELETE CASCADE;

ALTER TABLE public.post_comment DROP CONSTRAINT post_comment_id_post_fkey,
ADD CONSTRAINT post_comment_id_post_fkey FOREIGN KEY (id_post) REFERENCES public.post(id) ON DELETE CASCADE;
ALTER TABLE public.post_comment DROP CONSTRAINT post_comment_id_user_fkey,
ADD CONSTRAINT post_comment_id_user_fkey FOREIGN KEY (id_user) REFERENCES public.user_profile(id) ON DELETE CASCADE;

ALTER TABLE public.post_complaint DROP CONSTRAINT post_complaint_id_post_fkey,
ADD CONSTRAINT post_complaint_id_post_fkey FOREIGN KEY (id_post) REFERENCES public.post(id) ON DELETE CASCADE;
ALTER TABLE public.post_complaint DROP CONSTRAINT post_complaint_id_user_fkey,
ADD CONSTRAINT post_complaint_id_user_fkey FOREIGN KEY (id_user) REFERENCES public.user_profile(id) ON DELETE CASCADE;

ALTER TABLE public.post_featured DROP CONSTRAINT post_featured_id_post_fkey,
ADD CONSTRAINT post_featured_id_post_fkey FOREIGN KEY (id_post) REFERENCES public.post(id) ON DELETE CASCADE;

ALTER TABLE public.post_hide DROP CONSTRAINT post_hide_id_post_fkey,
ADD CONSTRAINT post_hide_id_post_fkey FOREIGN KEY (id_post) REFERENCES public.post(id) ON DELETE CASCADE;
ALTER TABLE public.post_hide DROP CONSTRAINT post_hide_id_user_fkey,
ADD CONSTRAINT post_hide_id_user_fkey FOREIGN KEY (id_user) REFERENCES public.user_profile(id) ON DELETE CASCADE;

ALTER TABLE public.post_item DROP CONSTRAINT post_item_id_post_fkey,
ADD CONSTRAINT post_item_id_post_fkey FOREIGN KEY (id_post) REFERENCES public.post(id) ON DELETE CASCADE;

ALTER TABLE public.post_modality DROP CONSTRAINT post_modality_id_modality_fkey,
ADD CONSTRAINT post_modality_id_modality_fkey FOREIGN KEY (id_modality) REFERENCES public.modality(id) ON DELETE CASCADE;
ALTER TABLE public.post_modality DROP CONSTRAINT post_modality_id_post_fkey,
ADD CONSTRAINT post_modality_id_post_fkey FOREIGN KEY (id_post) REFERENCES public.post(id) ON DELETE CASCADE;

ALTER TABLE public.post_rox DROP CONSTRAINT post_rox_id_post_fkey,
ADD CONSTRAINT post_rox_id_post_fkey FOREIGN KEY (id_post) REFERENCES public.post(id) ON DELETE CASCADE;
ALTER TABLE public.post_rox DROP CONSTRAINT post_rox_id_user_fkey,
ADD CONSTRAINT post_rox_id_user_fkey FOREIGN KEY (id_user) REFERENCES public.user_profile(id) ON DELETE CASCADE;


------------------------------------- PRODUCT -------------------------------------
ALTER TABLE public.product_modality DROP CONSTRAINT product_modality_id_modality_fkey,
ADD CONSTRAINT product_modality_id_modality_fkey FOREIGN KEY (id_modality) REFERENCES public.modality(id) ON DELETE CASCADE;
ALTER TABLE public.product_modality DROP CONSTRAINT product_modality_id_product_fkey,
ADD CONSTRAINT product_modality_id_product_fkey FOREIGN KEY (id_product) REFERENCES public.product(id) ON DELETE CASCADE;


------------------------------------- USER PROFILE -------------------------------------
ALTER TABLE public.user_profile DROP CONSTRAINT user_profile_id_user_login_fkey,
ADD CONSTRAINT user_profile_id_user_login_fkey FOREIGN KEY (id_user_login) REFERENCES public.user_login(id) ON DELETE CASCADE;

ALTER TABLE public.advertising DROP CONSTRAINT advertising_id_user_fkey,
ADD CONSTRAINT advertising_id_user_fkey FOREIGN KEY (id_user) REFERENCES public.user_profile(id) ON DELETE CASCADE;

ALTER TABLE public.concact_refuse DROP CONSTRAINT concact_refuse_id_user_fkey,
ADD CONSTRAINT concact_refuse_id_user_fkey FOREIGN KEY (id_user) REFERENCES public.user_profile(id) ON DELETE CASCADE;
ALTER TABLE public.concact_refuse DROP CONSTRAINT concact_refuse_id_user_refused_fkey,
ADD CONSTRAINT concact_refuse_id_user_refused_fkey FOREIGN KEY (id_user_refused) REFERENCES public.user_profile(id) ON DELETE CASCADE;

ALTER TABLE public.contact DROP CONSTRAINT contact_id_user_follower_fkey,
ADD CONSTRAINT contact_id_user_follower_fkey FOREIGN KEY (id_user_follower) REFERENCES public.user_profile(id) ON DELETE CASCADE;
ALTER TABLE public.contact DROP CONSTRAINT contact_id_user_following_fkey,
ADD CONSTRAINT contact_id_user_following_fkey FOREIGN KEY (id_user_following) REFERENCES public.user_profile(id) ON DELETE CASCADE;

ALTER TABLE public.email_invite DROP CONSTRAINT email_invite_id_user_fkey,
ADD CONSTRAINT email_invite_id_user_fkey FOREIGN KEY (id_user) REFERENCES public.user_profile(id) ON DELETE CASCADE;

ALTER TABLE public.thing_rox DROP CONSTRAINT thing_rox_id_thing_fkey,
ADD CONSTRAINT thing_rox_id_thing_fkey FOREIGN KEY (id_thing) REFERENCES public.thing(id) ON DELETE CASCADE;
ALTER TABLE public.thing_rox DROP CONSTRAINT thing_rox_id_user_fkey,
ADD CONSTRAINT thing_rox_id_user_fkey FOREIGN KEY (id_user) REFERENCES public.user_profile(id) ON DELETE CASCADE;

ALTER TABLE public.user_blocked DROP CONSTRAINT user_blocked_id_user_blocked_fkey,
ADD CONSTRAINT user_blocked_id_user_blocked_fkey FOREIGN KEY (id_user_blocked) REFERENCES public.user_profile(id) ON DELETE CASCADE;
ALTER TABLE public.user_blocked DROP CONSTRAINT user_blocked_id_user_fkey,
ADD CONSTRAINT user_blocked_id_user_fkey FOREIGN KEY (id_user) REFERENCES public.user_profile(id) ON DELETE CASCADE;

ALTER TABLE public.user_complaint DROP CONSTRAINT user_complaint_id_user_complaint_fkey,
ADD CONSTRAINT user_complaint_id_user_complaint_fkey FOREIGN KEY (id_user_complaint) REFERENCES public.user_profile(id) ON DELETE CASCADE;
ALTER TABLE public.user_complaint DROP CONSTRAINT user_complaint_id_user_fkey,
ADD CONSTRAINT user_complaint_id_user_fkey FOREIGN KEY (id_user) REFERENCES public.user_profile(id) ON DELETE CASCADE;

ALTER TABLE public.user_featured DROP CONSTRAINT user_featured_id_user_fkey,
ADD CONSTRAINT user_featured_id_user_fkey FOREIGN KEY (id_user) REFERENCES public.user_profile(id) ON DELETE CASCADE;

ALTER TABLE public.user_muted DROP CONSTRAINT user_muted_id_user_fkey,
ADD CONSTRAINT user_muted_id_user_fkey FOREIGN KEY (id_user) REFERENCES public.user_profile(id) ON DELETE CASCADE;
ALTER TABLE public.user_muted DROP CONSTRAINT user_muted_id_user_muted_fkey,
ADD CONSTRAINT user_muted_id_user_muted_fkey FOREIGN KEY (id_user_muted) REFERENCES public.user_profile(id) ON DELETE CASCADE;

------------------------------------- TRIGGER -------------------------------------
DROP TRIGGER tg_adventure_delete ON adventure;
DROP FUNCTION fn_adventure_delete();

CREATE FUNCTION fn_adventure_delete()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF 
AS $BODY$
BEGIN
INSERT INTO adventure_log(type_log,data_log,id_adventure,id_user,title,title_slug,description,token,dt_start,dt_end,dt_save,dt_publication,published,rox,id_item_report,id_item_photo,id_item_video,id_item_tracklog,id_item_checklist,views,picture)
    VALUES (3,NOW(),old.id,old.id_user,old.title,old.title_slug,old.description,old.token,old.dt_start,old.dt_end,old.dt_save,old.dt_publication,old.published,old.rox,old.id_item_report,old.id_item_photo,old.id_item_video,old.id_item_tracklog,old.id_item_checklist,old.views,old.picture);
DELETE FROM item_report WHERE item_report.id = old.id_item_report;
DELETE FROM item_photo WHERE item_photo.id = old.id_item_photo;
DELETE FROM item_video WHERE item_video.id = old.id_item_video;
DELETE FROM item_tracklog WHERE item_tracklog.id = old.id_item_tracklog;
DELETE FROM item_checklist WHERE item_checklist.id = old.id_item_checklist;
RETURN old;
END; 
$BODY$;
CREATE TRIGGER tg_adventure_delete AFTER DELETE ON adventure FOR EACH ROW EXECUTE PROCEDURE fn_adventure_delete();

grant select on all tables in schema public to "user-production";
grant insert on all tables in schema public to "user-production";
grant update on all tables in schema public to "user-production";
grant delete on all tables in schema public to "user-production";
grant all privileges on all sequences in schema public to "user-production";

INSERT INTO migration VALUES(56, 'Altera tabelas na chave estrangeira com on delete cascade', '2021-12-20', now());