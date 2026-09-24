/*
 Migration  : 062 Developer  : Renan Cavichi
 Data       : 24-09-2026
 Description: Remove triggers dependentes das foreign tables de log
*/

BEGIN;

-- Remove os triggers que apenas escrevem nas foreign tables de log.
DROP TRIGGER IF EXISTS tg_adventure_insert ON public.adventure;
DROP TRIGGER IF EXISTS tg_adventure_update ON public.adventure;
DROP TRIGGER IF EXISTS tg_adventure_comment_delete ON public.adventure_comment;
DROP TRIGGER IF EXISTS tg_adventure_comment_update ON public.adventure_comment;
DROP TRIGGER IF EXISTS tg_adventure_comment_mention_delete ON public.adventure_comment_mention;
DROP TRIGGER IF EXISTS tg_adventure_comment_rox_delete ON public.adventure_comment_rox;
DROP TRIGGER IF EXISTS tg_adventure_featured_delete ON public.adventure_featured;
DROP TRIGGER IF EXISTS tg_adventure_featured_insert ON public.adventure_featured;
DROP TRIGGER IF EXISTS tg_adventure_featured_update ON public.adventure_featured;
DROP TRIGGER IF EXISTS tg_adventure_rox_delete ON public.adventure_rox;
DROP TRIGGER IF EXISTS tg_advertising ON public.advertising;
DROP TRIGGER IF EXISTS tg_contact_delete ON public.contact;
DROP TRIGGER IF EXISTS tg_contact_insert ON public.contact;
DROP TRIGGER IF EXISTS tg_item_checklist_delete ON public.item_checklist;
DROP TRIGGER IF EXISTS tg_item_checklist_insert ON public.item_checklist;
DROP TRIGGER IF EXISTS tg_item_checklist_update ON public.item_checklist;
DROP TRIGGER IF EXISTS tg_item_report_delete ON public.item_report;
DROP TRIGGER IF EXISTS tg_item_report_insert ON public.item_report;
DROP TRIGGER IF EXISTS tg_item_report_update ON public.item_report;
DROP TRIGGER IF EXISTS tg_notification_delete ON public.notification;
DROP TRIGGER IF EXISTS tg_photo_delete ON public.photo;
DROP TRIGGER IF EXISTS tg_photo_insert ON public.photo;
DROP TRIGGER IF EXISTS tg_photo_update ON public.photo;
DROP TRIGGER IF EXISTS tg_post_delete ON public.post;
DROP TRIGGER IF EXISTS tg_post_insert ON public.post;
DROP TRIGGER IF EXISTS tg_post_update ON public.post;
DROP TRIGGER IF EXISTS tg_post_comment_delete ON public.post_comment;
DROP TRIGGER IF EXISTS tg_post_comment_update ON public.post_comment;
DROP TRIGGER IF EXISTS tg_post_comment_mention_delete ON public.post_comment_mention;
DROP TRIGGER IF EXISTS tg_post_comment_rox_delete ON public.post_comment_rox;
DROP TRIGGER IF EXISTS tg_post_featured_delete ON public.post_featured;
DROP TRIGGER IF EXISTS tg_post_item_delete ON public.post_item;
DROP TRIGGER IF EXISTS tg_post_rox_delete ON public.post_rox;
DROP TRIGGER IF EXISTS tg_post_tag_profile_delete ON public.post_tag_profile;
DROP TRIGGER IF EXISTS tg_post_tag_profile_update ON public.post_tag_profile;
DROP TRIGGER IF EXISTS tg_product_delete ON public.product;
DROP TRIGGER IF EXISTS tg_product_insert ON public.product;
DROP TRIGGER IF EXISTS tg_product_update ON public.product;
DROP TRIGGER IF EXISTS tg_session_app_log ON public.session_app;
DROP TRIGGER IF EXISTS tg_tracklog_delete ON public.tracklog;
DROP TRIGGER IF EXISTS tg_tracklog_insert ON public.tracklog;
DROP TRIGGER IF EXISTS tg_tracklog_update ON public.tracklog;
DROP TRIGGER IF EXISTS tg_user_featured_delete ON public.user_featured;
DROP TRIGGER IF EXISTS tg_user_featured_insert ON public.user_featured;
DROP TRIGGER IF EXISTS tg_user_featured_update ON public.user_featured;
DROP TRIGGER IF EXISTS tg_user_login_insert ON public.user_login;
DROP TRIGGER IF EXISTS tg_user_login_update ON public.user_login;
DROP TRIGGER IF EXISTS tg_user_page_admin_log ON public.user_page_admin;
DROP TRIGGER IF EXISTS tg_user_profile_delete ON public.user_profile;
DROP TRIGGER IF EXISTS tg_user_profile_insert ON public.user_profile;
DROP TRIGGER IF EXISTS tg_user_profile_update ON public.user_profile;
DROP TRIGGER IF EXISTS tg_user_profile_module_delete ON public.user_profile_module;
DROP TRIGGER IF EXISTS tg_user_profile_module_insert ON public.user_profile_module;
DROP TRIGGER IF EXISTS tg_user_profile_module_update ON public.user_profile_module;
DROP TRIGGER IF EXISTS tg_user_try_login_delete ON public.user_try_login;
DROP TRIGGER IF EXISTS tg_user_try_login_update ON public.user_try_login;
DROP TRIGGER IF EXISTS tg_video_delete ON public.video;
DROP TRIGGER IF EXISTS tg_video_insert ON public.video;
DROP TRIGGER IF EXISTS tg_video_update ON public.video;

-- Remove as funcoes que existiam apenas para gravar nas foreign tables de log.
DROP FUNCTION IF EXISTS public.fn_adventure_insert();
DROP FUNCTION IF EXISTS public.fn_adventure_update();
DROP FUNCTION IF EXISTS public.fn_adventure_comment_delete();
DROP FUNCTION IF EXISTS public.fn_adventure_comment_update();
DROP FUNCTION IF EXISTS public.fn_adventure_comment_mention_delete();
DROP FUNCTION IF EXISTS public.fn_adventure_comment_rox_delete();
DROP FUNCTION IF EXISTS public.fn_adventure_featured_delete();
DROP FUNCTION IF EXISTS public.fn_adventure_featured_insert();
DROP FUNCTION IF EXISTS public.fn_adventure_featured_update();
DROP FUNCTION IF EXISTS public.fn_adventure_rox_delete();
DROP FUNCTION IF EXISTS public.fn_advertising_trigger();
DROP FUNCTION IF EXISTS public.fn_contact_delete();
DROP FUNCTION IF EXISTS public.fn_contact_insert();
DROP FUNCTION IF EXISTS public.fn_item_checklist_delete();
DROP FUNCTION IF EXISTS public.fn_item_checklist_insert();
DROP FUNCTION IF EXISTS public.fn_item_checklist_update();
DROP FUNCTION IF EXISTS public.fn_item_report_delete();
DROP FUNCTION IF EXISTS public.fn_item_report_insert();
DROP FUNCTION IF EXISTS public.fn_item_report_update();
DROP FUNCTION IF EXISTS public.fn_notification_delete();
DROP FUNCTION IF EXISTS public.fn_photo_delete();
DROP FUNCTION IF EXISTS public.fn_photo_insert();
DROP FUNCTION IF EXISTS public.fn_photo_update();
DROP FUNCTION IF EXISTS public.fn_post_delete();
DROP FUNCTION IF EXISTS public.fn_post_insert();
DROP FUNCTION IF EXISTS public.fn_post_update();
DROP FUNCTION IF EXISTS public.fn_post_comment_delete();
DROP FUNCTION IF EXISTS public.fn_post_comment_update();
DROP FUNCTION IF EXISTS public.fn_post_comment_mention_delete();
DROP FUNCTION IF EXISTS public.fn_post_comment_rox_delete();
DROP FUNCTION IF EXISTS public.fn_post_featured_delete();
DROP FUNCTION IF EXISTS public.fn_post_item_delete();
DROP FUNCTION IF EXISTS public.fn_post_rox_delete();
DROP FUNCTION IF EXISTS public.fn_post_tag_profile_delete();
DROP FUNCTION IF EXISTS public.fn_post_tag_profile_update();
DROP FUNCTION IF EXISTS public.fn_product_delete();
DROP FUNCTION IF EXISTS public.fn_product_insert();
DROP FUNCTION IF EXISTS public.fn_product_update();
DROP FUNCTION IF EXISTS public.fn_session_app_trigger_log();
DROP FUNCTION IF EXISTS public.fn_tracklog_delete();
DROP FUNCTION IF EXISTS public.fn_tracklog_insert();
DROP FUNCTION IF EXISTS public.fn_tracklog_update();
DROP FUNCTION IF EXISTS public.fn_user_featured_delete();
DROP FUNCTION IF EXISTS public.fn_user_featured_insert();
DROP FUNCTION IF EXISTS public.fn_user_featured_update();
DROP FUNCTION IF EXISTS public.fn_user_login_insert();
DROP FUNCTION IF EXISTS public.fn_user_login_update();
DROP FUNCTION IF EXISTS public.fn_user_page_admin_trigger_log();
DROP FUNCTION IF EXISTS public.fn_user_profile_delete();
DROP FUNCTION IF EXISTS public.fn_user_profile_insert();
DROP FUNCTION IF EXISTS public.fn_user_profile_update();
DROP FUNCTION IF EXISTS public.fn_user_profile_module_delete();
DROP FUNCTION IF EXISTS public.fn_user_profile_module_insert();
DROP FUNCTION IF EXISTS public.fn_user_profile_module_update();
DROP FUNCTION IF EXISTS public.fn_user_try_login_delete();
DROP FUNCTION IF EXISTS public.fn_user_try_login_update();
DROP FUNCTION IF EXISTS public.fn_video_delete();
DROP FUNCTION IF EXISTS public.fn_video_insert();
DROP FUNCTION IF EXISTS public.fn_video_update();

-- Mantem apenas a regra de limpeza dos itens associados a aventuras.
CREATE OR REPLACE FUNCTION public.fn_adventure_delete()
RETURNS trigger
LANGUAGE plpgsql
AS $function$
BEGIN
    DELETE FROM public.item_report WHERE id = OLD.id_item_report;
    DELETE FROM public.item_photo WHERE id = OLD.id_item_photo;
    DELETE FROM public.item_video WHERE id = OLD.id_item_video;
    DELETE FROM public.item_tracklog WHERE id = OLD.id_item_tracklog;
    DELETE FROM public.item_checklist WHERE id = OLD.id_item_checklist;
    RETURN OLD;
END;
$function$;

INSERT INTO migration VALUES(62, 'Remove triggers dependentes das foreign tables de log', '2026-9-24', now());

COMMIT;
