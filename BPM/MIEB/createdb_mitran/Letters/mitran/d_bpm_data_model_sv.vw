create or replace force view d_bpm_data_model_sv as
select 
  BDM_ID,
  CODE,
  name
from BPM_DATA_MODEL
with read only;
grant select, insert, update on D_BPM_DATA_MODEL_SV to MAXDAT_MITRAN_OLTP_SIU;
grant select, insert, update, delete on D_BPM_DATA_MODEL_SV to MAXDAT_MITRAN_OLTP_SIUD;
grant select on D_BPM_DATA_MODEL_SV to MAXDAT_MITRAN_READ_ONLY;


