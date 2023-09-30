alter session set plsql_code_type = native;


BEGIN
    DBMS_SCHEDULER.DISABLE(name=>'CREATE_DAILY_IVR_JOBS');
END;
/

CREATE OR REPLACE PACKAGE CISCO_ENTERPRISE_CC.IVR_UTIL_PKG AS
FUNCTION IS_AFTER_HOURS(P_PROJECT_ID IN NUMBER, P_PROGRAM_ID IN NUMBER, P_DATE IN DATE,P_WEEKEND_AH IN VARCHAR2, P_HOLIDAY_AH IN VARCHAR2, P_BUSS_START_TIME IN VARCHAR2, P_BUSS_END_TIME IN VARCHAR2, P_BUSS_TZ IN VARCHAR2) RETURN DATE;
PROCEDURE INSERT_IVR_JOB_CTRL(P_JOB_NAME VARCHAR2, P_APP_NAME IN VARCHAR2,  P_START_DATE_NUM IN NUMBER, P_END_DATE_NUM IN NUMBER, P_JOB_PARAM_1 IN VARCHAR2 DEFAULT NULL);
PROCEDURE CREATE_DAILY_IVR_JOBS(P_JOB_NAME IN VARCHAR2);
PROCEDURE CREATE_DAILY_IVR_JOBS;
procedure PROC_CREATE_SCHEDULER_JOB;
END;
/

CREATE OR REPLACE PACKAGE BODY CISCO_ENTERPRISE_CC.IVR_UTIL_PKG AS

FUNCTION IS_AFTER_HOURS(P_PROJECT_ID IN NUMBER, P_PROGRAM_ID IN NUMBER, P_DATE IN DATE,P_WEEKEND_AH IN VARCHAR2, P_HOLIDAY_AH IN VARCHAR2, P_BUSS_START_TIME IN VARCHAR2, P_BUSS_END_TIME IN VARCHAR2, P_BUSS_TZ IN VARCHAR2) RETURN DATE
  IS
  V_ERR VARCHAR2(2000);
BEGIN

  IF UPPER(TRIM(P_WEEKEND_AH)) IN ('Y','YES') THEN
    IF TO_NUMBER(TO_CHAR(P_DATE,'D')) < 2 OR   TO_NUMBER(TO_CHAR(P_DATE,'D')) > 6 THEN
       RETURN P_DATE;
    END IF;
  END IF;

  IF UPPER(TRIM(P_HOLIDAY_AH)) IN ('Y','YES') THEN
    DECLARE
    V_CNT NUMBER := 0;
    BEGIN
      SELECT COUNT(1) INTO V_CNT FROM CC_C_IVR_HOLIDAYS IH WHERE IH.D_PROJECT_ID = P_PROJECT_ID AND IH.D_PROGRAM_ID = P_PROGRAM_ID AND IH.HOLIDAY_DATE = TRUNC(P_DATE);
      IF V_CNT > 0 THEN
        RETURN P_DATE;
      END IF;
    EXCEPTION WHEN NO_DATA_FOUND THEN NULL;
    END;
  END IF;

  IF to_char(cast(from_tz(cast(P_DATE as timestamp), 'US/Eastern') at time zone (P_BUSS_TZ) as Date),'hh24:mi') < P_BUSS_START_TIME
     OR  to_char(cast(from_tz(cast(P_DATE as timestamp), 'US/Eastern') at time zone (P_BUSS_TZ) as Date),'hh24:mi') > P_BUSS_END_TIME
     THEN
       RETURN P_DATE;
  END IF;

  RETURN(TO_DATE('7/7/7777','MM/DD/YYYY'));

      exception
      when others then
           V_ERR := 'PROJECT:' || P_PROJECT_ID || ' DATE:' || P_DATE || ' ' || SQLCODE || ';' || SUBSTR(SQLERRM,1,100);
           insert into cc_l_error ( MESSAGE , ERROR_DATE, JOB_NAME , TRANSFORM_NAME)
           values (V_ERR, SYSDATE, 'IVR_UTIL_PKG', 'IS_AFTER_HOURS');
           RETURN(TO_DATE('7/7/7777','MM/DD/YYYY'));
END;

PROCEDURE INSERT_IVR_JOB_CTRL(P_JOB_NAME VARCHAR2, P_APP_NAME IN VARCHAR2,  P_START_DATE_NUM IN NUMBER, P_END_DATE_NUM IN NUMBER, P_JOB_PARAM_1 IN VARCHAR2 DEFAULT NULL) IS
  V_COUNT NUMBER(10) := 0;
  V_ERR VARCHAR2(2000);

  BEGIN
        BEGIN
              BEGIN
                  SELECT COUNT(1)
                  INTO V_COUNT
                  FROM CC_A_IVR_JOB_CTRL IJC
                  WHERE IJC.JOB_NAME = P_JOB_NAME
                  AND IJC.APP_NAME_PARAM = P_APP_NAME
                  AND IJC.START_DATE_PARAM_NUM = P_START_DATE_NUM
                  AND IJC.STATUS IN ('PEND','WORK');
              EXCEPTION WHEN NO_DATA_FOUND THEN
                V_COUNT := 0;
              END;
              IF V_COUNT = 0 THEN
                INSERT INTO   CC_A_IVR_JOB_CTRL(JOB_NAME, APP_NAME_PARAM, START_DATE_PARAM_NUM, END_DATE_PARAM_NUM, JOB_PARAM_1) VALUES (P_JOB_NAME, P_APP_NAME, P_START_DATE_NUM, P_END_DATE_NUM, P_JOB_PARAM_1);
              ELSE
                 V_ERR := 'JOB:' || P_JOB_NAME || ' DATE:' || P_START_DATE_NUM || ' PEND/WORK job exists';
                 insert into cc_l_error ( MESSAGE , ERROR_DATE, JOB_NAME , TRANSFORM_NAME)
                 values (V_ERR, SYSDATE, 'IVR_UTIL_PKG', 'INSERT_IVR_JOB_CTRL');
              END IF;
        EXCEPTION WHEN OTHERS THEN
               V_ERR := 'JOB:' || P_JOB_NAME || ' DATE:' || P_START_DATE_NUM || ' ' || SQLCODE || ';' || SUBSTR(SQLERRM,1,100);
               insert into cc_l_error ( MESSAGE , ERROR_DATE, JOB_NAME , TRANSFORM_NAME)
               values (V_ERR, SYSDATE, 'IVR_UTIL_PKG', 'INSERT_IVR_JOB_CTRL');
        END;
 COMMIT;
 END;

PROCEDURE CREATE_DAILY_IVR_JOBS(P_JOB_NAME IN VARCHAR2)
  IS

CURSOR CUR_CCVP_STG IS
                    SELECT DISTINCT value APP_NAME, LEAST(NVL(trunc(IC.START_DATE), TRUNC(SYSDATE-8))+1, trunc(SYSDATE-3)) START_DATE
                    FROM CC_A_LIST_LKUP CAL
                    left join (select icC.appname APP_NAME, max(ICC.CALLSTARTDATE) START_DATE FROM CC_S_IVR_CISCOCVP ICC GROUP BY ICC.APPNAME) IC ON IC.APP_NAME = CAL.VALUE
                    WHERE name = 'IVR_Enhance_CISCOCVP'
                    and list_type = 'APP_NAME_TO_LOAD'
                    AND TRUNC(SYSDATE) BETWEEN CAL.START_DATE AND CAL.END_DATE
            ;

CURSOR CUR_INST (P_SOURCE IN VARCHAR2) IS
        SELECT IVR_APPNAME APP_NAME, TRUNC(LAST_LOAD_DATE)  START_DATE
        FROM cc_c_ivr_ctrls IVC
        LEFT JOIN (SELECT IVS.APPLICATION_NAME APP_NAME, min(TRUNC(CALL_DATE)) LAST_LOAD_DATE FROM CC_S_IVR_RESPONSE IVS
        WHERE 1=1 
        AND IVR_RESPONSE_ID >= (SELECT MIN(ivm.IVR_RESPONSE_ID) FROM CC_S_IVR_RESPONSE IVm
        WHERE TRUNC(ivm.CALL_dATE) >= TRUNC(SYSDATE -5))
        AND TRUNC(CALL_dATE) >= TRUNC(SYSDATE -5)
        AND  NOT EXISTS (
                    SELECT IRP.SOURCE_TABLE_ID
                    FROM CC_F_IVR_PERFORMANCE_INSTANCE IRP 
                    WHERE SOURCE_TABLE_NAME = 'CC_S_IVR_RESPONSE'
                    AND SOURCE_TABLE_ID = IVS.IVR_RESPONSE_ID
                    AND IVR_CALL_DATE >= TRUNC(SYSDATE -5)
                    AND IRP.IVR_APPLICATION_NAME = IVS.APPLICATION_NAME
                    )
        GROUP BY IVS.APPLICATION_NAME ) IV ON IV.APP_NAME = IVC.IVR_APPNAME         
        WHERE ivc.ctrl_type = 'LOAD'
        and ivc.ctrl_name = 'INSTANCE_LOAD'
        and ivc.ivr_source = P_SOURCE
        AND LAST_LOAD_DATE IS NOT NULL
        and ivc.effective_dt <= sysdate
        and ivc.end_dt >= sysdate;

/*        SELECT IVR_APPNAME APP_NAME, NVL(TRUNC(IR.START_dATE), TRUNC(SYSDATE-8))+1 START_DATE
        FROM cc_c_ivr_ctrls IVC
        LEFT JOIN (select iRR.Ivr_Application_Name APP_NAME, max(IRR.IVR_CALL_DATE) START_DATE FROM CC_F_IVR_PERFORMANCE_INSTANCE IRR GROUP BY IRR.Ivr_Application_Name) IR ON IR.APP_NAME = IVC.IVR_APPNAME
        WHERE ivc.ctrl_type = 'LOAD'
        and ivc.ctrl_name = 'INSTANCE_LOAD'
        and ivc.ivr_source = P_SOURCE
        and ivc.effective_dt <= sysdate
        and ivc.end_dt >= sysdate
           ;
*/
CURSOR CUR_INST_CVP (P_SOURCE IN VARCHAR2) IS
        SELECT IVR_APPNAME APP_NAME, LEAST(NVL(trunc(IR.START_DATE), TRUNC(SYSDATE-8))+1, trunc(SYSDATE-3)) START_DATE
        FROM cc_c_ivr_ctrls IVC
        LEFT JOIN (select iRR.Ivr_Application_Name APP_NAME, max(IRR.IVR_CALL_DATE) START_DATE FROM CC_F_IVR_PERFORMANCE_INSTANCE IRR GROUP BY IRR.Ivr_Application_Name) IR ON IR.APP_NAME = IVC.IVR_APPNAME
        WHERE ivc.ctrl_type = 'LOAD'
        and ivc.ctrl_name = 'INSTANCE_LOAD'
        and ivc.ivr_source = P_SOURCE
        and ivc.effective_dt <= sysdate
        and ivc.end_dt >= sysdate
           ;

BEGIN

CASE
  WHEN P_JOB_NAME IN ('LOAD_CCVP_STG')
  THEN
         FOR C1 IN CUR_CCVP_STG
         LOOP
             IF C1.START_DATE < TRUNC(SYSDATE) THEN
               INSERT_IVR_JOB_CTRL(P_JOB_NAME, C1.APP_NAME, TO_NUMBER(TO_CHAR(C1.START_dATE,'YYYYMMDD')),TO_NUMBER(TO_CHAR(SYSDATE-1,'YYYYMMDD')));
             END IF;
         END LOOP;
  WHEN P_JOB_NAME IN ('LOAD_CISCOCVP','LOAD_CCVP_INST')  THEN
         FOR C1 IN CUR_INST_CVP('CISCO_CVP')
         LOOP
             IF C1.START_DATE < TRUNC(SYSDATE) THEN
               INSERT_IVR_JOB_CTRL(P_JOB_NAME, C1.APP_NAME, TO_NUMBER(TO_CHAR(C1.START_dATE,'YYYYMMDD')),TO_NUMBER(TO_CHAR(SYSDATE-1,'YYYYMMDD')));
             END IF;
         END LOOP;
  WHEN P_JOB_NAME IN ('LOAD_VERINTCSI', 'LOAD_VCSI_INST')  THEN
         FOR C1 IN CUR_INST('VERINT_CSI')
         LOOP
             IF C1.START_DATE < TRUNC(SYSDATE) THEN
               INSERT_IVR_JOB_CTRL(P_JOB_NAME, C1.APP_NAME, TO_NUMBER(TO_CHAR(C1.START_dATE,'YYYYMMDD')),TO_NUMBER(TO_CHAR(SYSDATE-1,'YYYYMMDD')));
             END IF;
         END LOOP;
  WHEN P_JOB_NAME IN ('LOAD_ALL_VCSI') THEN
            INSERT_IVR_JOB_CTRL('LOAD_ALL_VCSI', NULL, NULL, NULL, NULL);
     WHEN P_JOB_NAME = 'RECALC_CLASS' THEN
           INSERT_IVR_JOB_CTRL('RECALC_CLASS', NULL, NULL, NULL, 'MISSING');
     WHEN P_JOB_NAME = 'RECALC_CLS_ALL' THEN
           INSERT_IVR_JOB_CTRL('RECALC_CLS_ALL', NULL, NULL, NULL, 'ALL');
     WHEN P_JOB_NAME = 'RECALC_CLS_NEW' THEN
           INSERT_IVR_JOB_CTRL('RECALC_CLS_NEW', NULL, NULL, NULL, 'NEW');
     ELSE
       NULL;
END CASE;


END;


PROCEDURE CREATE_DAILY_IVR_JOBS
  IS
  v_err varchar2(200);
BEGIN
FOR CJOB IN (SELECT JOB_NAME, DAILY_RUN_SCRIPT FROM CC_A_IVR_JOB WHERE DAILY_RUN_ENABLED = 'Y' AND ENABLED = 'Y' AND DAILY_RUN_sCRIPT IS NOT NULL)
  LOOP
        BEGIN
               EXECUTE IMMEDIATE CJOB.DAILY_RUN_SCRIPT USING CJOB.JOB_NAME;
        exception
        when others then
             V_ERR := 'CREATE:' || CJOB.JOB_NAME || ' ' ||SQLCODE || ';' || SUBSTR(SQLERRM,1,100);
             insert into cc_l_error ( MESSAGE , ERROR_DATE, JOB_NAME , TRANSFORM_NAME)
             values (V_ERR, SYSDATE, 'IVR_CALC_PKG', 'CREATE_DAILY_IVR_JOBS');
        END;

  END LOOP;
  commit;
END;

procedure PROC_CREATE_SCHEDULER_JOB
  as 
  v_schedule_name varchar2(50) := 'cc_ivr_daily_schedule';
  v_package_name varchar2(50) := 'IVR_UTIL_PKG';
  v_procedure_name varchar2(61) := 'CREATE_DAILY_IVR_JOBS';
  v_job_type varchar2(50) := 'STORED_PROCEDURE';
  v_err varchar2(300); 
  begin

  DBMS_SCHEDULER.CREATE_SCHEDULE (
    schedule_name     => v_schedule_name,
    start_date        => systimestamp,
    repeat_interval   => 'freq=daily; byhour=7; byminute=0; bysecond=0;',
    comments          => 'Every day');
    
    DBMS_SCHEDULER.CREATE_JOB (
            job_name   => v_procedure_name,
            job_type   => v_job_type,
            job_action => v_package_name ||'.' || v_procedure_name,
            schedule_name => v_schedule_name);
            
    DBMS_SCHEDULER.ENABLE(name=>v_procedure_name);
    
     DBMS_SCHEDULER.SET_ATTRIBUTE(
            name => v_procedure_name,
            attribute => 'RESTARTABLE',
        value => TRUE);
      
 
  exception
        when others then
         V_ERR := 'Schedule IVR daily load; ' || SQLCODE || ';' || SUBSTR(SQLERRM,1,100);
        insert into cc_l_error ( MESSAGE , ERROR_DATE, JOB_NAME , TRANSFORM_NAME) 
          values (V_ERR, SYSDATE, 'IVR_CALC_PKG', 'PROC_CREATE_SCHEDULER_JOB');
          
          COMMIT;
          
  end;

END;
/

BEGIN
    DBMS_SCHEDULER.enABLE(name=>'CREATE_DAILY_IVR_JOBS');
END;
/

alter session set plsql_code_type = interpreted;
