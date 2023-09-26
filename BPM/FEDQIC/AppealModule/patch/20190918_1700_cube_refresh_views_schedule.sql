BEGIN
  DBMS_SCHEDULER.CREATE_JOB (
   job_name           =>  'REFRESH_APPEAL_CUBE_MVIEWS',
   job_type           =>  'STORED_PROCEDURE',
   job_action         =>  'REFRESH_APPEAL_CUBE_MATERIAL_VIEWS',
   start_date         =>  '15-SEP-19 12.05.00 AM',
   repeat_interval    =>  'FREQ=DAILY;INTERVAL=01',
   end_date           =>  '30-SEP-25 12.00.00 AM',
   auto_drop          =>   FALSE,
   comments           =>  'To refresh the materialzed views for fedqic appeal cubes');
END;
/

commit;

begin
dbms_scheduler.enable('REFRESH_APPEAL_CUBE_MVIEWS');
end;
/

commit;

begin
DBMS_SCHEDULER.SET_ATTRIBUTE('REFRESH_APPEAL_CUBE_MVIEWS','logging_level',DBMS_SCHEDULER.LOGGING_FAILED_RUNS);
end;
/

commit;    