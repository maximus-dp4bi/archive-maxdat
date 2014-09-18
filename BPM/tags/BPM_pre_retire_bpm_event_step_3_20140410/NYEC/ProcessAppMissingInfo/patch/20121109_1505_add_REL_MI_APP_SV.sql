create or replace view REL_MI_APP_SV
as
select 
  dnpamicur.NYEC_PAMI_BI_ID as nyec_pami_bi_id,
  dnpacur.NYEC_PA_BI_ID as nyec_pa_bi_id
from 
  D_NYEC_PAMI_CURRENT dnpamicur, 
  D_NYEC_PA_CURRENT dnpacur
where dnpamicur."Application ID" = dnpacur."Application ID"
with read only;