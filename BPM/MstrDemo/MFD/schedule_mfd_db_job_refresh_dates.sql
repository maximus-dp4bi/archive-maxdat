BEGIN
  DBMS_SCHEDULER.DROP_JOB ('REFRESH_MFD_TABLES');
END;  
/
BEGIN
  DBMS_SCHEDULER.CREATE_JOB (
   job_name           =>  'REFRESH_MFD_TABLES',
   job_type           =>  'STORED_PROCEDURE',
   job_action         =>  'REFRESH_DATA_PKG.REFRESH_MFD_TABLE',
   start_date         =>  '01-JUL-20 12.00.00 AM',
   repeat_interval    =>  'FREQ=DAILY;BYHOUR=0;BYMINUTE=40;BYSECOND=0',
   end_date           =>  '01-AUG-25 12.00.00 AM',
   auto_drop          =>   FALSE,
 --  job_class          =>  'batch_update_jobs',
   comments           =>  'To refresh the dates in the MFD table');
END;
/

begin
dbms_scheduler.enable('REFRESH_MFD_TABLES');
end;
/

begin
DBMS_SCHEDULER.SET_ATTRIBUTE('REFRESH_MFD_TABLES','logging_level',DBMS_SCHEDULER.LOGGING_RUNS);
end;
/