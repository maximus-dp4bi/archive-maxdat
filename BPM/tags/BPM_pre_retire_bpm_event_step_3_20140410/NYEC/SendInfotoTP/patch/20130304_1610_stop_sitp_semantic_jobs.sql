-- Stop NYEC Send Info to TP semantic jobs.
update PROCESS_BPM_QUEUE_JOB_CONFIG 
set ENABLED = 'N' 
where BSL_ID = 8 
  and BDM_ID = 2;
  
commit;
  
execute PROCESS_BPM_QUEUE_JOB_CONTROL.ADJUST_NUM_OF_JOBS(8,2);
