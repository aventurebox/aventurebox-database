/*
 Migration  : 064 Developer  : Giselle Hoekveld
 Data       : 24-09-2026
 Description: Adiciona coluna dt_save na tabela item_report e indices para rastreio de edicao
*/

BEGIN;

ALTER TABLE public.item_report 
    ADD COLUMN dt_save TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP;

CREATE INDEX idx_item_report_dt_save ON public.item_report(dt_save);
CREATE INDEX IF NOT EXISTS idx_post_dt_save ON public.post(dt_save);

INSERT INTO migration VALUES(64, 'Adiciona dt_save em item_report para rastreio de edicao', '2026-9-24', now());

COMMIT;
