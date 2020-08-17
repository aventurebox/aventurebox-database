/*
 Migration  : 035 Developer  : Alex Souza
 Data       : 12-08-2020
 Description: Alter adventure_participant adicionando coluna de aprovacao de participacao;
*/

ALTER TABLE adventure_participant ADD COLUMN approved BOOLEAN NOT NULL DEFAULT TRUE;
ALTER TABLE adventure_participant ALTER COLUMN approved SET DEFAULT FALSE;

INSERT INTO notification_type(id, name) VALUES (11, 'new_post'), (12, 'participant_approved'), (13, 'participant_denied');

-- Altera as notificacoes de participação existentes para o TIPO 12 (Participacao Aprovada);
UPDATE notification SET id_type = 12 WHERE id_type = 8;

grant select on all tables in schema public to "aventurebox";
grant insert on all tables in schema public to "aventurebox";
grant update on all tables in schema public to "aventurebox";
grant delete on all tables in schema public to "aventurebox";
grant all privileges on all sequences in schema public to "aventurebox";

INSERT INTO migration VALUES(35, 'Altera a tabela adventure_participant adicionando coluna de aprovacao de participacao E adicionar registros na tabela notification_type', '2020-08-12', now());

