/*
 Migration  : 047 Developer  : Alex Souza
 Data       : 11-03-2021
 Description: Cria Colunas, Views e Tabelas para o Onboarding do usuario;
*/

-- CRIA TABELA E VIEW DE LISTA DE USUARIOS RECOMENDADOS NO ONBOARDING
CREATE TABLE user_suggestion (
	id_user INT NOT NULL,
	first BOOLEAN NOT NULL DEFAULT FALSE,
	dt_add TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
	UNIQUE(id_user),
	FOREIGN KEY (id_user) REFERENCES user_profile(id) ON DELETE CASCADE
);

CREATE FUNCTION fn_user_suggestion()
	RETURNS trigger
AS $BODY$
BEGIN
	REFRESH MATERIALIZED VIEW user_suggestion_view;
	return new;
	END; 
	$BODY$ LANGUAGE plpgsql COST 100 VOLATILE NOT LEAKPROOF;

CREATE TRIGGER tg_user_suggestion AFTER UPDATE OR INSERT OR DELETE ON user_suggestion FOR EACH ROW EXECUTE PROCEDURE fn_user_suggestion();


CREATE MATERIALIZED VIEW user_suggestion_view AS
SELECT id, name, picture, token, user_,
(
	SELECT COUNT(id) FROM adventure 
	WHERE id_user = up.id AND published = TRUE AND do_not_list = FALSE
) as count_adventure,
(
	SELECT COUNT(id) FROM post 
	WHERE id_user = up.id AND published = TRUE AND do_not_list = FALSE
) as count_post
FROM user_profile up 
INNER JOIN user_suggestion us ON up.id = us.id_user
ORDER BY us.first DESC, random();

CREATE UNIQUE INDEX ON user_suggestion_view(id);

ALTER MATERIALIZED VIEW user_suggestion_view OWNER TO "aventurebox";


-- CRIA COLUNA PARA SALVAR O ONBOARDING DO USUARIO
ALTER TABLE user_profile ADD COLUMN onboarding INT DEFAULT 1;
UPDATE user_profile SET onboarding = null;

grant select on all tables in schema public to "aventurebox";
grant insert on all tables in schema public to "aventurebox";
grant update on all tables in schema public to "aventurebox";
grant delete on all tables in schema public to "aventurebox";
grant all privileges on all sequences in schema public to "aventurebox";

INSERT INTO migration VALUES(47, 'Cria Colunas, Views e Tabelas para o Onboarding', '2021-3-11', now());




