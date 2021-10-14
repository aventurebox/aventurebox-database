/*
 Migration  : 055 Developer  : Giselle Hoekveld Silva
 Data       : 05-10-2021
 Description: Cria tabela e Triggers de menções para os comentários;
*/

CREATE TABLE public.adventure_comment_mention (
id_adventure_comment INT NOT NULL,
id_user INT NOT NULL,
CONSTRAINT adventure_comment_mention_pkey PRIMARY KEY (id_adventure_comment, id_user),
CONSTRAINT adventure_comment_mention_comment_id_fkey FOREIGN KEY (id_adventure_comment) REFERENCES public.adventure_comment(id) ON DELETE CASCADE,
CONSTRAINT adventure_comment_mention_id_user_fkey FOREIGN KEY (id_user) REFERENCES public.user_profile(id) ON DELETE CASCADE
);

CREATE TABLE public.post_comment_mention (
id_post_comment INT NOT NULL,
id_user INT NOT NULL,
CONSTRAINT post_comment_mention_pkey PRIMARY KEY (id_post_comment, id_user),
CONSTRAINT post_comment_mention_comment_id_fkey FOREIGN KEY (id_post_comment) REFERENCES public.post_comment(id) ON DELETE CASCADE,
CONSTRAINT post_comment_mention_id_user_fkey FOREIGN KEY (id_user) REFERENCES public.user_profile(id) ON DELETE CASCADE
);

grant select on all tables in schema public to "user-production";
grant insert on all tables in schema public to "user-production";
grant update on all tables in schema public to "user-production";
grant delete on all tables in schema public to "user-production";
grant all privileges on all sequences in schema public to "user-production";

INSERT INTO migration VALUES(55, 'Cria tabela e Triggers de menções para os comentários', '2021-10-05', now());