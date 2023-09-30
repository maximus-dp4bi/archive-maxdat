

BEGIN
  DBMS_SCHEDULER.CREATE_JOB (
   job_name           =>  'REFRESH_DIGITAL_REPORTING_MATVIEWS',
   job_type           =>  'STORED_PROCEDURE',
   job_action         =>  'REFRESH_DIGITAL_REPORTING_VIEWS',
   start_date         =>  '01-SEP-19 12.00.00 AM',
   repeat_interval    =>  'FREQ=MINUTELY;INTERVAL=30',
   end_date           =>  '30-SEP-25 12.00.00 AM',
   auto_drop          =>   FALSE,
 --  job_class          =>  'batch_update_jobs',
   comments           =>  'To refresh the materialzed views for digital reporting');
END;
/

begin
dbms_scheduler.enable('REFRESH_DIGITAL_REPORTING_MATVIEWS');
end;
/
begin
DBMS_SCHEDULER.SET_ATTRIBUTE('REFRESH_DIGITAL_REPORTING_MATVIEWS','logging_level',DBMS_SCHEDULER.LOGGING_FAILED_RUNS);
end;
/