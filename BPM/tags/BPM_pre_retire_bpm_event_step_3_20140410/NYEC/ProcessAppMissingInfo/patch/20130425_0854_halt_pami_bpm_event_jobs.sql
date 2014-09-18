update PROCESS_BPM_QUEUE_JOB_CONFIG
set ENABLED = 'N'
where 
  BSL_ID = 4
  and BDM_ID = 1;
  
commit;