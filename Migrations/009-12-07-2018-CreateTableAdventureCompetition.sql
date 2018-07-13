/*
 Migration  : 009
 Developer  : Paulo Moura
 Data       : 12-07-2018
 Description: Create table adventure_competition
*/

CREATE TABLE adventure_competition(
id_adventure int not null,
id_user int not null,
date timestamp default CURRENT_TIMESTAMP 
);
alter table adventure_competition add foreign key(id_adventure) references adventure(id);
alter table adventure_competition add foreign key(id_user) references user_login(id);
alter table adventure_competition add unique(id_adventure);

INSERT INTO migration VALUES(9,'Cria tabela adventure_competition','2018-07-12', now());
