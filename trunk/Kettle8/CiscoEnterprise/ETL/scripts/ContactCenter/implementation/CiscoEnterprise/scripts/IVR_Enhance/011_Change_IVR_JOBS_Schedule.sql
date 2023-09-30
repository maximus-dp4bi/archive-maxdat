alter session set plsql_code_type = native;

BEGIN
 FOR C1 IN (Select schedule_name from user_scheduler_schedules where schedule_name like '%IVR%') LOOP
     DBMS_SCHEDULER.SET_ATTRIBUTE( name => C1.schedule_name,
                                  attribute => 'START_DATE',
                                  value => SYSTIMESTAMP AT TIME ZONE 'US/Eastern');
 END LOOP;
END;
/

alter session set plsql_code_type = interpreted;
