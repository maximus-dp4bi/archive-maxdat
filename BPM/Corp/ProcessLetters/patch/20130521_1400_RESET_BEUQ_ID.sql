update BPM_UPDATE_EVENT_QUEUE
set PROCESS_BUEQ_ID = null
where 
  BSL_ID = 12
  and PROCESS_BUEQ_ID is not null;

commit;


create index BUEQ_LX3 on BPM_UPDATE_EVENT_QUEUE (IDENTIFIER) local online tablespace MAXDAT_INDX parallel compute statistics;