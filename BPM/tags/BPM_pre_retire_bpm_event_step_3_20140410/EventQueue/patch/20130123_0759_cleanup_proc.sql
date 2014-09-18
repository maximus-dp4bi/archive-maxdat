update PROCESS_BPM_QUEUE_JOB
set
  STATUS = 'STOPPED',
  STOP_REASON_ID = 203,
  END_DATE = sysdate,
  STATUS_DATE = sysdate
where 
  STATUS != 'STOPPED';

commit;
