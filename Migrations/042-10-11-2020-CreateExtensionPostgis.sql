/*
 Migration  : 042 Developer  : Alex Souza
 Data       : 13-11-2020
 Description: Cria a extensao para uso do PostGIS;
*/

CREATE EXTENSION postgis;

INSERT INTO migration VALUES(42, 'Cria a extensao para uso do PostGIS', '2020-11-13', now());