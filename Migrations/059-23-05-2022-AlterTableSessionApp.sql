/*
 Migration  : 059 Developer  : Giselle Hoekveld
 Data       : 23-05-2022
 Description: Altera tabela session_app e adiciona on delete cascade para chave estrangeira session_app_id_user_fkey 
*/

ALTER TABLE public.session_app DROP CONSTRAINT session_app_id_user_fkey,
ADD CONSTRAINT session_app_id_user_fkey FOREIGN KEY (id_user) REFERENCES public.user_profile(id) ON DELETE CASCADE;

grant select on all tables in schema public to "user-production";
grant insert on all tables in schema public to "user-production";
grant update on all tables in schema public to "user-production";
grant delete on all tables in schema public to "user-production";
grant all privileges on all sequences in schema public to "user-production";

INSERT INTO migration VALUES(59, 'Altera tabela Session App', '2022-5-23', now());