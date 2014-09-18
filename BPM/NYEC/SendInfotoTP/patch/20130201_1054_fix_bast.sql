delete from BPM_ATTRIBUTE_STAGING_TABLE where BSL_ID = 8;

commit;

-- Stop jobs with incorrect meta-data.
update PROCESS_BPM_QUEUE_JOB
set 
  STATUS = 'STOPPED',
  END_DATE = sysdate,
  STATUS_DATE = sysdate
where
  STATUS = 'STARTED';
  
commit;

-- Stop 'STARTED' jobs.
execute PROCESS_BPM_QUEUE_JOB_CONTROL.STOP_JOB_BY_ID(10810);
execute PROCESS_BPM_QUEUE_JOB_CONTROL.STOP_JOB_BY_ID(11391);