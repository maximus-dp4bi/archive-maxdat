alter session set plsql_code_type = native;

BEGIN
    DBMS_SCHEDULER.disable(name=>'CREATE_DAILY_MI_JOBS');
    DBMS_SCHEDULER.disable(name=>'CREATE_LOAD_EYR_FILES_REQ');
    DBMS_SCHEDULER.disable(name=>'MATCH_CON');
END;
/

CREATE OR REPLACE PACKAGE MI_UTIL_PKG AS
       PROCEDURE CREATE_DAILY_MI_JOBS;
       PROCEDURE CREATE_DAILY_EYR_JOB;
       procedure PROC_CREATE_SCHEDULER_JOB;
END;
/

CREATE OR REPLACE PACKAGE BODY MI_UTIL_PKG AS

PROCEDURE CREATE_DAILY_MI_JOBS IS
  P_MAX_JOB_ID                 NUMBER;
    V_CODE VARCHAR2(30);
    V_ERROR VARCHAR2(200);
BEGIN
  BEGIN
     SELECT NVL(MAX(JOB_ID),0) INTO P_MAX_JOB_ID FROM ETL_INIT_MIHC_CON;
  EXCEPTION WHEN OTHERS THEN
    P_MAX_JOB_ID := 21009;
  END;

  insert into mi_job_ctrl(job_name, Job_Param_1, Job_Param_2) values ('LOAD_ETL_INIT_MIHC_CON', P_MAX_JOB_ID, '9999999999');
  insert into mi_job_ctrl(job_name) values ('LOAD_LETTER_REQUEST_DATA');
  COMMIT;
  EXCEPTION WHEN OTHERS THEN
      V_CODE := SQLCODE;
      V_ERROR := SUBSTR(SQLERRM,1,200);
      MI_LETTERS_PKG.INS_ERROR_LOG(p_job_name=>'CREATE_DAILY_MI_JOBS',P_ERROR_MSG=> V_ERROR, P_ERROR_CODE =>V_CODE
                      , P_TABLE_NAME=>NULL, P_TABLE_ID=> NULL);
      COMMIT;
END;

PROCEDURE CREATE_DAILY_EYR_JOB IS
V_CODE VARCHAR2(30);
    V_ERROR VARCHAR2(200);
BEGIN
  insert into mi_job_ctrl(job_name, Job_Param_1) values ('LOAD_EYR_FILES', '.*\.csv');
COMMIT;
  EXCEPTION WHEN OTHERS THEN
      V_CODE := SQLCODE;
      V_ERROR := SUBSTR(SQLERRM,1,200);
      MI_LETTERS_PKG.INS_ERROR_LOG(p_job_name=>'CREATE_LOAD_EYR_FILES_REQ',P_ERROR_MSG=> V_ERROR, P_ERROR_CODE =>V_CODE
                      , P_TABLE_NAME=>NULL, P_TABLE_ID=> NULL);
      COMMIT;
END;

procedure PROC_CREATE_SCHEDULER_JOB
as
BEGIN

  dbms_scheduler.create_schedule('MI_LOAD_LETTERS_1', repeat_interval =>
    'FREQ=DAILY; BYHOUR=05; BYMINUTE=00; BYSECOND=00; ');
  dbms_scheduler.create_schedule('MI_LOAD_LETTERS_2', repeat_interval =>
    'FREQ=DAILY; BYHOUR=07; BYMINUTE=00; BYSECOND=00;');
  dbms_scheduler.create_schedule('MI_LOAD_LETTERS_3', repeat_interval =>
    'FREQ=DAILY; BYHOUR=15; BYMINUTE=00; BYSECOND=00;');

   DBMS_SCHEDULER.create_schedule ('MI_LOAD_LETTERS', repeat_interval =>'MI_LOAD_LETTERS_1, MI_LOAD_LETTERS_2, MI_LOAD_LETTERS_3');

  dbms_scheduler.create_schedule('MI_LOAD_EYR_1', repeat_interval =>
    'FREQ=DAILY; BYHOUR=04; BYMINUTE=30; BYSECOND=00; ');
  dbms_scheduler.create_schedule('MI_LOAD_EYR_2', repeat_interval =>
    'FREQ=DAILY; BYHOUR=06; BYMINUTE=30; BYSECOND=00;');
  dbms_scheduler.create_schedule('MI_LOAD_EYR_3', repeat_interval =>
    'FREQ=DAILY; BYHOUR=14; BYMINUTE=30; BYSECOND=00;');

   DBMS_SCHEDULER.create_schedule ('MI_LOAD_EYR', repeat_interval =>'MI_LOAD_EYR_1, MI_LOAD_EYR_2, MI_LOAD_EYR_3');

  dbms_scheduler.create_schedule('MI_LOAD_MATCH_CON_1', repeat_interval =>
    'FREQ=DAILY; BYHOUR=05; BYMINUTE=45; BYSECOND=00; ');
  dbms_scheduler.create_schedule('MI_LOAD_MATCH_CON_2', repeat_interval =>
    'FREQ=DAILY; BYHOUR=07; BYMINUTE=45; BYSECOND=00;');
  dbms_scheduler.create_schedule('MI_LOAD_MATCH_CON_3', repeat_interval =>
    'FREQ=DAILY; BYHOUR=15; BYMINUTE=45; BYSECOND=00;');

   DBMS_SCHEDULER.create_schedule ('MI_LOAD_MATCH_CON', repeat_interval =>'MI_LOAD_MATCH_CON_1, MI_LOAD_MATCH_CON_2, MI_LOAD_MATCH_CON_3');

  BEGIN
   FOR C1 IN (Select schedule_name from user_scheduler_schedules where schedule_name like '%MI_LOAD%') LOOP
       DBMS_SCHEDULER.SET_ATTRIBUTE( name => C1.schedule_name,
                                    attribute => 'START_DATE',
                                    value => SYSTIMESTAMP AT TIME ZONE 'US/Eastern');
   END LOOP;
  END;

    DBMS_SCHEDULER.CREATE_JOB (
      job_name   => 'CREATE_DAILY_MI_JOBS',
      job_type   => 'STORED_PROCEDURE',
      job_action => 'MI_UTIL_PKG.CREATE_DAILY_MI_JOBS',
      schedule_name => 'MI_LOAD_LETTERS');

    DBMS_SCHEDULER.CREATE_JOB (
      job_name   => 'CREATE_LOAD_EYR_FILES_REQ',
      job_type   => 'STORED_PROCEDURE',
      job_action => 'MI_UTIL_PKG.CREATE_DAILY_EYR_JOB',
      schedule_name => 'MI_LOAD_EYR');

    DBMS_SCHEDULER.CREATE_JOB (
      job_name   => 'MATCH_CON',
      job_type   => 'STORED_PROCEDURE',
      job_action => 'MI_LETTERS_PKG.PROC_MATCH_CON_LETTER',
      schedule_name => 'MI_LOAD_MATCH_CON');


    DBMS_SCHEDULER.SET_ATTRIBUTE(
          name => 'CREATE_DAILY_MI_JOBS',
          attribute => 'RESTARTABLE',
      value => TRUE);
    DBMS_SCHEDULER.SET_ATTRIBUTE(
          name => 'CREATE_LOAD_EYR_FILES_REQ',
          attribute => 'RESTARTABLE',
      value => TRUE);
    DBMS_SCHEDULER.SET_ATTRIBUTE(
          name => 'MATCH_CON',
          attribute => 'RESTARTABLE',
      value => TRUE);

    DBMS_SCHEDULER.ENABLE(name=>'CREATE_DAILY_MI_JOBS');
    DBMS_SCHEDULER.ENABLE(name=>'CREATE_LOAD_EYR_FILES_REQ');
    DBMS_SCHEDULER.ENABLE(name=>'MATCH_CON');

end;

END;
/

BEGIN
    DBMS_SCHEDULER.ENABLE(name=>'CREATE_DAILY_MI_JOBS');
    DBMS_SCHEDULER.ENABLE(name=>'CREATE_LOAD_EYR_FILES_REQ');
    DBMS_SCHEDULER.ENABLE(name=>'MATCH_CON');
END;
/

alter session set plsql_code_type = interpreted;


grant execute on MI_UTIL_PKG to MAXDAT_MIEB_PFP_E;
grant execute on MI_UTIL_PKG to MAXDAT_MIEB_OLTP_SIUD;
grant MAXDAT_MIEB_PFP_E to sr18956;

