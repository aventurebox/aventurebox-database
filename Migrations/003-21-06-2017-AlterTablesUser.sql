/*
 Migration  : 003
 Developer  : Paulo Moura
 Data       : 21-06-2017
 Description: Alter Table's user_temp, user_login, user_login_log
*/

ALTER TABLE user_temp ALTER COLUMN user_ TYPE character varying(40);
ALTER TABLE user_login ALTER COLUMN user_ TYPE character varying(40);
ALTER TABLE user_login_log ALTER COLUMN user_ TYPE character varying(40);

INSERT INTO migration VALUES(3,'Altera tamanho da coluna user_ das tabelas user_temp, user_login, user_login_log','2017-06-21', now());
