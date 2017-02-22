/*
 Migration  : 001
 Developer  : Renan Cavichi
 Data       : 17-01-2017
 Description: Create Migration Table
*/

-- ----------------------------
--  Table structure for migration
-- ----------------------------
DROP TABLE IF EXISTS "public"."migration";
CREATE TABLE "public"."migration" (
	"id" int4 NOT NULL,
	"description" text NOT NULL COLLATE "default",
	"created_at" date NOT NULL,
	"inserted_at" timestamp(6) NOT NULL
)
WITH (OIDS=FALSE);

-- ----------------------------
--  Primary key structure for table migration
-- ----------------------------
ALTER TABLE "public"."migration" ADD PRIMARY KEY ("id") NOT DEFERRABLE INITIALLY IMMEDIATE;

INSERT INTO migration VALUES(1,'Cria Tabela de Migrations','2017-01-17', now());