create or replace force view d_process_bpm_queue_job_sv as
select
  PBQJ_ID,
  JOB_NAME,
  BSL_ID,
  BDM_ID,
  BATCH_SIZE,
  START_DATE,
  END_DATE,
  STATUS,
  STATUS_DATE,
  ENABLED,
  START_REASON_ID,
  STOP_REASON_ID
from PROCESS_BPM_QUEUE_JOB
with read only;
grant select, insert, update on D_PROCESS_BPM_QUEUE_JOB_SV to MAXDAT_MITRAN_OLTP_SIU;
grant select, insert, update, delete on D_PROCESS_BPM_QUEUE_JOB_SV to MAXDAT_MITRAN_OLTP_SIUD;
grant select on D_PROCESS_BPM_QUEUE_JOB_SV to MAXDAT_MITRAN_READ_ONLY;


