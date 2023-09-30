BEGIN
  DBMS_SCHEDULER.DROP_JOB ('REFRESH_PL_TABLES');
END;
/

BEGIN
  DBMS_SCHEDULER.CREATE_JOB (
   job_name           =>  'REFRESH_PL_TABLES',
   job_type           =>  'STORED_PROCEDURE',
   job_action         =>  'REFRESH_DATA_PKG.REFRESH_PL_TABLE',
   start_date         =>  '29-SEP-20 12.00.00 AM',
   repeat_interval    =>  'FREQ=DAILY;BYHOUR=0;BYMINUTE=55;BYSECOND=0',
   end_date           =>  '01-AUG-25 12.00.00 AM',
   auto_drop          =>   FALSE,
 --  job_class          =>  'batch_update_jobs',
   comments           =>  'To refresh the dates in the PL table');
END;
/

begin
dbms_scheduler.enable('REFRESH_PL_TABLES');
end;
/

begin
DBMS_SCHEDULER.SET_ATTRIBUTE('REFRESH_PL_TABLES','logging_level',DBMS_SCHEDULER.LOGGING_RUNS);
end;
/