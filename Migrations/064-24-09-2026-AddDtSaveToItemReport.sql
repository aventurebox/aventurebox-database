/*
 Migration  : 064 Developer  : Giselle Hoekveld
 Data       : 24-09-2026
 Description: Adiciona coluna dt_save na tabela item_report e indices para rastreio de edicao
*/

BEGIN;

ALTER TABLE public.item_report 
    ADD COLUMN dt_save TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP;

BEGIN;

-- 1. Atualiza o dt_save do item_report com o dt_save correspondente da adventure
UPDATE public.item_report ir
SET dt_save = adv.dt_save
FROM (
    SELECT id_item_report, MAX(dt_save) AS dt_save
    FROM public.adventure
    WHERE id_item_report IS NOT NULL
    GROUP BY id_item_report
) adv
WHERE ir.id = adv.id_item_report;

-- 2. Limpa o dt_save de item_reports órfãos (sem aventura vinculada)
-- Isso evita que registros sem aventura continuem com o CURRENT_TIMESTAMP da migration
UPDATE public.item_report ir
SET dt_save = NULL
WHERE NOT EXISTS (
    SELECT 1 
    FROM public.adventure a 
    WHERE a.id_item_report = ir.id
);

COMMIT;

CREATE INDEX idx_item_report_dt_save ON public.item_report(dt_save);
CREATE INDEX IF NOT EXISTS idx_post_dt_save ON public.post(dt_save);

INSERT INTO migration VALUES(64, 'Adiciona dt_save em item_report para rastreio de edicao', '2026-9-24', now());

COMMIT;
