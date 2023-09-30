alter session set plsql_code_type = native;

BEGIN
    DBMS_SCHEDULER.disable(name=>'CREATE_DAILY_IVR_JOBS');
END;
/

BEGIN
dbms_scheduler.create_schedule('ivr_enhance_sch_1', repeat_interval =>
  'FREQ=DAILY; BYHOUR=07; BYMINUTE=00; BYSECOND=00; ');
dbms_scheduler.create_schedule('ivr_enhance_sch_2', repeat_interval =>
  'FREQ=DAILY; BYHOUR=08; BYMINUTE=30; BYSECOND=00;');
END;
/ 

begin
   DBMS_SCHEDULER.create_schedule ('IVR_JOBS_SCH', repeat_interval =>'ivr_enhance_sch_1, ivr_enhance_sch_2');
END;
/

BEGIN
  dbms_scheduler.set_attribute (
    name      => 'cc_ivr_daily_schedule',
    attribute => 'repeat_interval',
    value     => 'IVR_JOBS_SCH');
end;
/

BEGIN
    DBMS_SCHEDULER.enable(name=>'CREATE_DAILY_IVR_JOBS');
END;
/

alter session set plsql_code_type = interpreted;
