CREATE OR REPLACE VIEW REL_TASK_APP_SV AS 
select
   dmwcur.MW_BI_ID as mw_bi_id,
   dnpacur.NYEC_PA_BI_ID as nyec_pa_bi_id
from
   D_MW_CURRENT dmwcur,
   D_NYEC_PA_CURRENT dnpacur
where
   dmwcur."Source Reference ID" = dnpacur."Application ID"
   and dmwcur."Source Reference Type" = 'Application ID' 
WITH READ ONLY;

commit;