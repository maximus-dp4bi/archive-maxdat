update BPM_UPDATE_EVENT_QUEUE
set PROCESS_BUEQ_ID = null 
where BSL_ID = 1;

commit;

update BPM_UPDATE_EVENT_QUEUE
set WROTE_BPM_EVENT_DATE = sysdate
where 
  BSL_ID = 1
  and OLD_DATA is null;

commit;

