-- Stop control job.
execute PROCESS_BPM_QUEUE_JOB_CONTROL.STOP_CONTROL_JOB;

-- Stop jobs with incorrect meta-data.
update PROCESS_BPM_QUEUE_JOB
set 
  BSL_ID = 1,
  BDM_ID = 1,
  BATCH_SIZE = 1
where
  BSL_ID  is null
  and BDM_ID is null;
  
commit;

-- (will take about 4 minutes to run)
execute PROCESS_BPM_QUEUE_JOB_CONTROL.STOP_JOB_BY_ID(7513);
execute PROCESS_BPM_QUEUE_JOB_CONTROL.STOP_JOB_BY_ID(7912);
execute PROCESS_BPM_QUEUE_JOB_CONTROL.STOP_JOB_BY_ID(8253);
execute PROCESS_BPM_QUEUE_JOB_CONTROL.STOP_JOB_BY_ID(8555);
execute PROCESS_BPM_QUEUE_JOB_CONTROL.STOP_JOB_BY_ID(8851);
execute PROCESS_BPM_QUEUE_JOB_CONTROL.STOP_JOB_BY_ID(9277);
execute PROCESS_BPM_QUEUE_JOB_CONTROL.STOP_JOB_BY_ID(9406);

-- Stop all jobs.  (will take about 30 minutes to run)
execute PROCESS_BPM_QUEUE_JOB_CONTROL.STOP_ALL_JOBS;

-- Cleanup duplicate instances.
delete from BPM_INSTANCE_ATTRIBUTE
where BI_ID in (1137764,1139005,1139688,1139687);

commit;

delete from BPM_UPDATE_EVENT 
where BI_ID in (1137764,1139005,1139688,1139687);

commit;

delete from BPM_INSTANCE 
where 
  BI_ID in (1137764,1139005,1139688,1139687)
  and IDENTIFIER in (349834,349854,349855,349856)
  and BEM_ID = 2 
  and BIL_ID = 3;
  
commit;

-- Fix BIL_ID;
update BPM_INSTANCE
set BIL_ID = 2
where BEM_ID = 2 and BIL_ID != 2;

commit;

-- Fix stuck processing queue rows.
update BPM_UPDATE_EVENT_QUEUE
set PROCESS_BUEQ_ID = null
where PROCESS_BUEQ_ID is not null;

commit;
