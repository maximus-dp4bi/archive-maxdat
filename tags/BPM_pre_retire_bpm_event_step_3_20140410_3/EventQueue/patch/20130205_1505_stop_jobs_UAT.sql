-- Stop calc job.
execute NYEC_PROCESS_APP.STOP_CALC_DNPACUR_JOB;

-- Stop control job.
execute PROCESS_BPM_QUEUE_JOB_CONTROL.STOP_CONTROL_JOB;

-- Fix incorrect meta-data.
update PROCESS_BPM_QUEUE_JOB
set 
  BSL_ID = 1,
  BDM_ID = 1,
  BATCH_SIZE = 1
where
  BSL_ID  is null
  and BDM_ID is null;
  
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

-- Stop all jobs.  (will take about 10 minutes to run)
execute PROCESS_BPM_QUEUE_JOB_CONTROL.STOP_ALL_JOBS;

execute PROCESS_BPM_QUEUE_JOB_CONTROL.STOP_JOB_BY_ID(7296);
execute PROCESS_BPM_QUEUE_JOB_CONTROL.STOP_JOB_BY_ID(7790);
execute PROCESS_BPM_QUEUE_JOB_CONTROL.STOP_JOB_BY_ID(7889);
execute PROCESS_BPM_QUEUE_JOB_CONTROL.STOP_JOB_BY_ID(8192);

-- Fix stuck processing queue rows.
update BPM_UPDATE_EVENT_QUEUE
set PROCESS_BUEQ_ID = null
where PROCESS_BUEQ_ID is not null;

commit;