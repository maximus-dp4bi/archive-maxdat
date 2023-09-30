update BPM_UPDATE_EVENT_QUEUE 
set WROTE_BPM_EVENT_DATE = null
where 
  BSL_ID = 1
  and WROTE_BPM_EVENT_DATE = to_date('2013-10-09 13:07:13','YYYY-MM-DD HH24:MI:SS')
  and OLD_DATA is null;
  
commit;

update BPM_UPDATE_EVENT_QUEUE 
set PROCESS_BUEQ_ID = null
where BSL_ID = 1;
  
commit;