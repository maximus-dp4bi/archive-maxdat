create or replace force view d_bpm_source_lkup_sv as
select 
  BSL_ID,
  name,
  BSTL_ID
from BPM_SOURCE_LKUP
with read only;
grant select, insert, update on D_BPM_SOURCE_LKUP_SV to MAXDAT_MITRAN_OLTP_SIU;
grant select, insert, update, delete on D_BPM_SOURCE_LKUP_SV to MAXDAT_MITRAN_OLTP_SIUD;
grant select on D_BPM_SOURCE_LKUP_SV to MAXDAT_MITRAN_READ_ONLY;


