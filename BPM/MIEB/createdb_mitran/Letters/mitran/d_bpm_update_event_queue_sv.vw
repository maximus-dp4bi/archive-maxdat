create or replace force view d_bpm_update_event_queue_sv as
select "BUEQ_ID","BSL_ID","BIL_ID","IDENTIFIER","EVENT_DATE","QUEUE_DATE","PROCESS_BUEQ_ID","WROTE_BPM_SEMANTIC_DATE","DATA_VERSION","OLD_DATA","NEW_DATA","CEJS_JOB_ID"
from BPM_UPDATE_EVENT_QUEUE
with read only;
grant select, insert, update on D_BPM_UPDATE_EVENT_QUEUE_SV to MAXDAT_MITRAN_OLTP_SIU;
grant select, insert, update, delete on D_BPM_UPDATE_EVENT_QUEUE_SV to MAXDAT_MITRAN_OLTP_SIUD;
grant select on D_BPM_UPDATE_EVENT_QUEUE_SV to MAXDAT_MITRAN_READ_ONLY;


