execute dbms_job.remove(21);
execute dbms_job.remove(22);
execute dbms_job.remove(81);

BEGIN
  DBMS_SCHEDULER.CREATE_JOB (
   job_name           =>  'MAINTAIN_D_DATES',
   job_type           =>  'STORED_PROCEDURE',
   job_action         =>  'MAINTAIN_BPM_D_DATES',
   start_date         =>  '01-AUG-19 12.00.00 AM',
   repeat_interval    =>  'FREQ=DAILY;BYHOUR=0;BYMINUTE=0;BYSECOND=0',
   end_date           =>  '01-AUG-35 12.00.00 AM',
   auto_drop          =>   FALSE,
 --  job_class          =>  'batch_update_jobs',
   comments           =>  'To refresh the d_dates table');
END;
/

begin
dbms_scheduler.enable('MAINTAIN_D_DATES');
end;
/

begin
DBMS_SCHEDULER.SET_ATTRIBUTE('MAINTAIN_D_DATES','logging_level',DBMS_SCHEDULER.LOGGING_RUNS);
end;
/

BEGIN
  DBMS_SCHEDULER.CREATE_JOB (
   job_name           =>  'REFRESH_DATES_VIEWS',
   job_type           =>  'STORED_PROCEDURE',
   job_action         =>  'REFRESH_D_DATES_VIEWS',
   start_date         =>  '01-AUG-19 12.00.00 AM',
   repeat_interval    =>  'FREQ=DAILY;BYHOUR=0;BYMINUTE=5;BYSECOND=0',
   end_date           =>  '01-AUG-35 12.00.00 AM',
   auto_drop          =>   FALSE,
 --  job_class          =>  'batch_update_jobs',
   comments           =>  'To refresh the d_dates materialized views');
END;
/

begin
dbms_scheduler.enable('REFRESH_DATES_VIEWS');
end;
/
begin
DBMS_SCHEDULER.SET_ATTRIBUTE('REFRESH_DATES_VIEWS','logging_level',DBMS_SCHEDULER.LOGGING_RUNS);
end;
/

BEGIN
  DBMS_SCHEDULER.CREATE_JOB (
   job_name           =>  'UPDATE_CLIENT_ELIGIBILITY',
   job_type           =>  'STORED_PROCEDURE',
   job_action         =>  'UPDATE_D_CLIENT_ELIGIBILITY',
   start_date         =>  '01-AUG-19 12.00.00 AM',
   repeat_interval    =>  'FREQ=DAILY;BYHOUR=6;BYMINUTE=30;BYSECOND=0',
   end_date           =>  '01-AUG-35 12.00.00 AM',
   auto_drop          =>   FALSE,
 --  job_class          =>  'batch_update_jobs',
   comments           =>  'To load the d_client_eligibility table');
END;
/

begin
dbms_scheduler.enable('UPDATE_CLIENT_ELIGIBILITY');
end;
/
begin
DBMS_SCHEDULER.SET_ATTRIBUTE('UPDATE_CLIENT_ELIGIBILITY','logging_level',DBMS_SCHEDULER.LOGGING_RUNS);
end;
/