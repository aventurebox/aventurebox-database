/*
 Migration  : 063 Developer  : Giselle Hoekveld
 Data       : 24-09-2026
 Description: Remove foreign tables, user mappings, foreign servers e extensao postgres_fdw
*/

BEGIN;

-- ============================================================================
-- 1. REMOVE AS TABELAS ESTRANGEIRAS (FOREIGN TABLES)
-- ============================================================================

-- Foreign tables do servidor aventurebox_analytics
DROP FOREIGN TABLE IF EXISTS public.product_event_log CASCADE;
DROP FOREIGN TABLE IF EXISTS public.action CASCADE;
DROP FOREIGN TABLE IF EXISTS public.action_record CASCADE;
DROP FOREIGN TABLE IF EXISTS public.ads_log CASCADE;
DROP FOREIGN TABLE IF EXISTS public.explore_log CASCADE;
DROP FOREIGN TABLE IF EXISTS public.advertising_event_log CASCADE;
DROP FOREIGN TABLE IF EXISTS public.explore_map_text_log CASCADE;
DROP FOREIGN TABLE IF EXISTS public.explore_map_bounds_log CASCADE;
DROP FOREIGN TABLE IF EXISTS public.explore_map_adventure_log CASCADE;

-- Foreign tables do servidor aventurebox_log
DROP FOREIGN TABLE IF EXISTS public.advertising_log CASCADE;
DROP FOREIGN TABLE IF EXISTS public.adventure_comment_log CASCADE;
DROP FOREIGN TABLE IF EXISTS public.adventure_featured_log CASCADE;
DROP FOREIGN TABLE IF EXISTS public.adventure_log CASCADE;
DROP FOREIGN TABLE IF EXISTS public.adventure_rox_log CASCADE;
DROP FOREIGN TABLE IF EXISTS public.contact_log CASCADE;
DROP FOREIGN TABLE IF EXISTS public.item_checklist_log CASCADE;
DROP FOREIGN TABLE IF EXISTS public.item_report_log CASCADE;
DROP FOREIGN TABLE IF EXISTS public.notification_log CASCADE;
DROP FOREIGN TABLE IF EXISTS public.photo_log CASCADE;
DROP FOREIGN TABLE IF EXISTS public.post_comment_log CASCADE;
DROP FOREIGN TABLE IF EXISTS public.post_featured_log CASCADE;
DROP FOREIGN TABLE IF EXISTS public.post_item_log CASCADE;
DROP FOREIGN TABLE IF EXISTS public.post_log CASCADE;
DROP FOREIGN TABLE IF EXISTS public.post_rox_log CASCADE;
DROP FOREIGN TABLE IF EXISTS public.product_log CASCADE;
DROP FOREIGN TABLE IF EXISTS public.tracklog_log CASCADE;
DROP FOREIGN TABLE IF EXISTS public.user_featured_log CASCADE;
DROP FOREIGN TABLE IF EXISTS public.user_login_log CASCADE;
DROP FOREIGN TABLE IF EXISTS public.user_profile_log CASCADE;
DROP FOREIGN TABLE IF EXISTS public.user_try_login_log CASCADE;
DROP FOREIGN TABLE IF EXISTS public.video_log CASCADE;
DROP FOREIGN TABLE IF EXISTS public.user_page_admin_log CASCADE;
DROP FOREIGN TABLE IF EXISTS public.session_app_log CASCADE;
DROP FOREIGN TABLE IF EXISTS public.adventure_comment_rox_log CASCADE;
DROP FOREIGN TABLE IF EXISTS public.post_comment_rox_log CASCADE;
DROP FOREIGN TABLE IF EXISTS public.user_profile_module_log CASCADE;
DROP FOREIGN TABLE IF EXISTS public.adventure_comment_mention_log CASCADE;
DROP FOREIGN TABLE IF EXISTS public.post_comment_mention_log CASCADE;
DROP FOREIGN TABLE IF EXISTS public.post_tag_profile_log CASCADE;

-- ============================================================================
-- 2. REMOVE OS MAPEAMENTOS DE USUÁRIO (USER MAPPINGS)
-- ============================================================================
DROP USER MAPPING IF EXISTS FOR "aventurebox" SERVER aventurebox_log;
DROP USER MAPPING IF EXISTS FOR "aventurebox" SERVER aventurebox_analytics;
DROP USER MAPPING IF EXISTS FOR "user-production" SERVER aventurebox_log;
DROP USER MAPPING IF EXISTS FOR "user-production" SERVER aventurebox_analytics;
DROP USER MAPPING IF EXISTS FOR "postgres" SERVER aventurebox_log;
DROP USER MAPPING IF EXISTS FOR "postgres" SERVER aventurebox_analytics;
DROP USER MAPPING IF EXISTS FOR CURRENT_USER SERVER aventurebox_log;
DROP USER MAPPING IF EXISTS FOR CURRENT_USER SERVER aventurebox_analytics;

-- ============================================================================
-- 3. REMOVE OS SERVIDORES ESTRANGEIROS (FOREIGN SERVERS)
-- ============================================================================
DROP SERVER IF EXISTS aventurebox_log CASCADE;
DROP SERVER IF EXISTS aventurebox_analytics CASCADE;

-- ============================================================================
-- 4. REMOVE A EXTENSÃO POSTGRES_FDW
-- ============================================================================
DROP EXTENSION IF EXISTS postgres_fdw CASCADE;

-- ============================================================================
-- 5. REGISTRO DA MIGRATION
-- ============================================================================
INSERT INTO migration VALUES(63, 'Remove foreign tables, user mappings, servers e extensao postgres_fdw', '2026-9-24', now());

COMMIT;
