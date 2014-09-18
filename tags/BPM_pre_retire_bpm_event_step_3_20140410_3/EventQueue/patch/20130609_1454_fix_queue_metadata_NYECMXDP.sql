update PROCESS_BPM_QUEUE_JOB
set 
  ENABLED = 'N',
  STATUS = 'STOPPED', 
  STATUS_DATE = sysdate,
  STOP_REASON_ID = 240,
  END_DATE = sysdate
where 
  PBQJ_ID in (74280,74282,74626,74781)
  and STATUS = 'SLEEPING';
  
commit;