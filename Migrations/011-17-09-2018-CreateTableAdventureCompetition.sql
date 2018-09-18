/*
 Migration  : 011 Developer  : Paulo Moura
 Data       : 17-09-2018
 Description: CreateTableCompetition
*/

BEGIN;

-- CREATE TABLE "adventure_competition" ------------------------
CREATE TABLE "public"."adventure_competition" ( 
	"id_adventure" Integer NOT NULL,
	"id_user" Integer NOT NULL,
	"date" Timestamp Without Time Zone DEFAULT now(),
	"type" Integer DEFAULT 1 NOT NULL,
	CONSTRAINT "adventure_competition_id_adventure_key" UNIQUE( "id_adventure" ) );
 ;
-- -------------------------------------------------------------

COMMIT;

BEGIN;

-- CREATE LINK "adventure_competition_id_user_fkey" ------------
ALTER TABLE "public"."adventure_competition"
	ADD CONSTRAINT "adventure_competition_id_user_fkey" FOREIGN KEY ( "id_user" )
	REFERENCES "public"."user_login" ( "id" ) MATCH SIMPLE
	ON DELETE No Action
	ON UPDATE No Action;
-- -------------------------------------------------------------

COMMIT;

BEGIN;

-- CREATE LINK "adventure_competition_id_adventure_fkey" -------
ALTER TABLE "public"."adventure_competition"
	ADD CONSTRAINT "adventure_competition_id_adventure_fkey" FOREIGN KEY ( "id_adventure" )
	REFERENCES "public"."adventure" ( "id" ) MATCH SIMPLE
	ON DELETE No Action
	ON UPDATE No Action;
-- -------------------------------------------------------------

COMMIT;


grant select on all tables in schema public to pg_aventurebox;
grant insert on all tables in schema public to pg_aventurebox;
grant update on all tables in schema public to pg_aventurebox;
grant delete on all tables in schema public to pg_aventurebox;
grant all privileges on all sequences in schema public to pg_aventurebox;

INSERT INTO migration VALUES(11,'Cria tabela adventure_competition','2018-09-17', now());
