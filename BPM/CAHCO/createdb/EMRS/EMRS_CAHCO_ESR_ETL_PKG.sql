alter session set plsql_code_type = native;

create or replace package CAHCO_ESR_ETL_PKG as


  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL: svn://svn-staging.maximus.com/dev1d/maxdat/BPM/CAHCO/createdb/EMRS/EMRS_CAHCO_ENROLL_ETL_PKG.sql $';
  SVN_REVISION varchar2(20) := '$Revision: 23484 $';
  SVN_REVISION_DATE varchar2(60) := '$Date: 2018-05-24 19:12:49 -0700 (Thu, 24 May 2018) $';
  SVN_REVISION_AUTHOR varchar2(20) := '$Author: aa24065 $';

  con_pkg    CONSTANT  VARCHAR2(30) := $$PLSQL_UNIT;
  c_abort    CONSTANT  corp_etl_error_log.err_level%TYPE := 'ABORT';
  c_critical CONSTANT  corp_etl_error_log.err_level%TYPE := 'CRITICAL';
  c_log      CONSTANT  corp_etl_error_log.err_level%TYPE := 'LOG';

  PROCEDURE ESR_HOURS_INS;
  PROCEDURE ESR_HOURS_UPD;
  PROCEDURE ESR_TIMEOFF_INS;
  PROCEDURE ESR_TIMEOFF_UPD;
  PROCEDURE ESR_INS_UPD;
     
end;
/


CREATE OR REPLACE PACKAGE BODY CAHCO_ESR_ETL_PKG AS

    v_code corp_etl_error_log.error_codes%TYPE;
    v_desc corp_etl_error_log.error_desc%TYPE;

PROCEDURE ESR_HOURS_INS
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_ins_cnt number;
    v_err_cnt number;

BEGIN

    DELETE FROM Errlog_ESRHours WHERE ora_err_tag$ = 'ESR_HOURS_INS';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'ESR_HOURS_INS','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;

    INSERT /*+ Enable_Parallel_Dml Parallel */
      INTO EMRS_D_ESR_HOURS(esrch_id
          ,esr_id
          ,esr_combined_hours_date
          ,esr_site_code
          ,county_name
          ,hour_type
          ,hours
          ,meetings
          ,floater
          ,training
          ,approved_vacation
          ,unapproved_vacation
          ,approved_sick
          ,unapproved_sick
          ,leave_without_pay
          ,fmla
          ,kin_care
          ,jury_duty
          ,bereavement
          ,late
          ,modified_date
          ,start_date
          ,comments
          ,is_valid
         )
    SELECT esrch_id,
           ESR,
           esr_date,
           SiteCode ,
           County,          
           HourType,
           Hours ,           
           Meetings,
           Floater,
           Training,
           ApprVaca,
           UnApprVaca,
           ApprSick,
           UnApprSick,
           LWOP,
           FMLA,
           KinCare,	
           JuryDuty,
           Berevement,
           Late,
           ModifiedDate,
           StartDate,
           comments,	
           IsValid
    FROM hco_s_esr_combined_hours_stg esr                
     WHERE NOT EXISTS(SELECT 1 FROM emrs_d_esr_hours h WHERE esr.esrch_id = h.esrch_id)
     LOG Errors INTO Errlog_ESRHours ('ESR_HOURS_INS') Reject Limit Unlimited;

    v_ins_cnt := SQL%RowCount;

    UPDATE CORP_ETL_JOB_STATISTICS
       SET Job_end_date = SYSDATE
         , RECORD_COUNT = v_ins_cnt
         , PROCESSED_COUNT = v_ins_cnt
         , RECORD_INSERTED_COUNT = v_ins_cnt
         , JOB_STATUS_CD = 'COMPLETED'
     WHERE JOB_ID =  v_job_id;

    COMMIT;

    INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name,driver_key_number)
    SELECT c_critical, con_pkg, 'CAHCO_ESR_ETL_PKG.ESR_HOURS_INS', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_ESR_HOURS', esrch_id
      FROM Errlog_ESRHours
     WHERE Ora_Err_Tag$ = 'ESR_HOURS_INS';

    v_err_cnt := SQL%RowCount;

    UPDATE CORP_ETL_JOB_STATISTICS
       SET ERROR_COUNT = v_err_cnt
         , RECORD_COUNT = v_ins_cnt + v_err_cnt
         , PROCESSED_COUNT = v_ins_cnt + v_err_cnt
     WHERE JOB_ID =  v_job_id;

    COMMIT;

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, 'CAHCO_ESR_ETL_PKG.ESR_HOURS_INS', 1, v_desc, v_code, 'EMRS_D_ESR_HOURS');

      COMMIT;
END ESR_HOURS_INS;

PROCEDURE ESR_HOURS_UPD
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

    DELETE FROM Errlog_ESRHours WHERE ora_err_tag$ = 'ESR_HOURS_UPD';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'ESR_HOURS_UPD','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;

   MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  EMRS_D_ESR_HOURS s
   USING (SELECT esr.esrch_id,
                 esr.ESR,
                 esr.esr_date,
                 esr.SiteCode ,
                 esr.County,          
                 esr.HourType,
                 esr.Hours ,           
                 esr.Meetings,
                 esr.Floater,
                 esr.Training,
                 esr.ApprVaca,
                 esr.UnApprVaca,
                 esr.ApprSick,
                 esr.UnApprSick,
                 esr.LWOP,
                 esr.FMLA,
                 esr.KinCare,	
                 esr.JuryDuty,
                 esr.Berevement,
                 esr.Late,
                 esr.ModifiedDate,
                 esr.StartDate,
                 esr.comments,	
                 esr.IsValid
          FROM hco_s_esr_combined_hours_stg esr   
          JOIN emrs_d_esr_hours h ON esr.esrch_id = h.esrch_id
          WHERE COALESCE(esr.ESR,'*') != COALESCE(h.esr_id,'*')            
            OR COALESCE(esr.esr_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(h.esr_combined_hours_date, TO_DATE('07/07/7777','mm/dd/yyyy'))    
            OR COALESCE(esr.SiteCode,'*') != COALESCE(h.esr_site_code,'*') 
            OR COALESCE(esr.County,'*') != COALESCE(h.county_name,'*') 
            OR COALESCE(esr.HourType,'*') != COALESCE(h.hour_type,'*') 
            OR COALESCE(esr.Hours,0) != COALESCE(h.hours,0) 
            OR COALESCE(esr.Meetings,0) != COALESCE(h.meetings,0) 
            OR COALESCE(esr.Floater,0) != COALESCE(h.floater,0) 
            OR COALESCE(esr.Training,0) != COALESCE(h.training,0) 
            OR COALESCE(esr.ApprVaca,0) != COALESCE(h.approved_vacation,0) 
            OR COALESCE(esr.UnApprVaca,0) != COALESCE(h.unapproved_vacation,0) 
            OR COALESCE(esr.ApprSick,0) != COALESCE(h.approved_sick,0) 
            OR COALESCE(esr.UnApprSick,0) != COALESCE(h.unapproved_sick,0) 
            OR COALESCE(esr.LWOP,0) != COALESCE(h.leave_without_pay,0) 
            OR COALESCE(esr.FMLA,0) != COALESCE(h.fmla,0) 
            OR COALESCE(esr.KinCare,0) != COALESCE(h.kin_care,0) 
            OR COALESCE(esr.JuryDuty,0) != COALESCE(h.jury_duty,0) 
            OR COALESCE(esr.Berevement,0) != COALESCE(h.bereavement,0) 
            OR COALESCE(esr.Late,0) != COALESCE(h.late,0)             
            OR COALESCE(esr.ModifiedDate, TO_DATE('07/07/7777','mm/dd/yyyy')) !=  COALESCE(h.modified_date, TO_DATE('07/07/7777','mm/dd/yyyy'))   
            OR COALESCE(esr.StartDate, TO_DATE('07/07/7777','mm/dd/yyyy')) !=  COALESCE(h.start_date, TO_DATE('07/07/7777','mm/dd/yyyy')) 
            OR COALESCE(esr.comments,'*') != COALESCE(h.comments,'*') 
            OR COALESCE(esr.IsValid,'*') != COALESCE(h.is_valid,'*') 
          ) st ON (s.esrch_id = st.esrch_id)
    WHEN MATCHED THEN UPDATE
     SET --s.esrch_id = st.esrch_id
          s.esr_id = st.esr
          ,s.esr_combined_hours_date = st.esr_date
          ,s.esr_site_code = st.SiteCode
          ,s.county_name = st.county
          ,s.hour_type = st.HourType
          ,s.hours = st.hours
          ,s.meetings = st.meetings
          ,s.floater = st.floater
          ,s.training = st.training
          ,s.approved_vacation = st.ApprVaca
          ,s.unapproved_vacation = st.UnApprVaca
          ,s.approved_sick = st.ApprSick
          ,s.unapproved_sick = st.UnApprSick
          ,s.leave_without_pay = st.lwop
          ,s.fmla = st.fmla
          ,s.kin_care = st.KinCare
          ,s.jury_duty = st.JuryDuty
          ,s.bereavement = st.Berevement
          ,s.late = st.late
          ,s.modified_date = st.ModifiedDate
          ,s.start_date = st.StartDate
          ,s.comments = st.comments
          ,s.is_valid = st.IsValid
     Log Errors INTO Errlog_ESRHours ('ESR_HOURS_UPD') Reject Limit Unlimited;

    v_upd_cnt := SQL%RowCount;

    UPDATE CORP_ETL_JOB_STATISTICS
       SET Job_end_date = SYSDATE
         , RECORD_COUNT = v_upd_cnt
         , PROCESSED_COUNT = v_upd_cnt
         , RECORD_UPDATED_COUNT = v_upd_cnt
         , JOB_STATUS_CD = 'COMPLETED'
     WHERE JOB_ID =  v_job_id;

    COMMIT;

    INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name,driver_key_number)
    SELECT c_critical, con_pkg, 'CAHCO_ESR_ETL_PKG.ESR_HOURS_UPD', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_ESR_HOURS', esrch_id
      FROM Errlog_ESRHours
     WHERE Ora_Err_Tag$ = 'ESR_HOURS_UPD';

    v_err_cnt := SQL%RowCount;

    UPDATE CORP_ETL_JOB_STATISTICS
       SET ERROR_COUNT = v_err_cnt
         , RECORD_COUNT = v_upd_cnt + v_err_cnt
         , PROCESSED_COUNT = v_upd_cnt + v_err_cnt
     WHERE JOB_ID =  v_job_id;     

    COMMIT;

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, 'CAHCO_ESR_ETL_PKG.ESR_HOURS_UPD', 1, v_desc, v_code, 'EMRS_D_ESR_HOURS');

      COMMIT;
END ESR_HOURS_UPD;

PROCEDURE ESR_TIMEOFF_INS
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_ins_cnt number;
    v_err_cnt number;

BEGIN

    DELETE FROM Errlog_ESRTimeOff WHERE ora_err_tag$ = 'ESR_TIMEOFF_INS';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'ESR_TIMEOFF_INS','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;

    INSERT /*+ Enable_Parallel_Dml Parallel */
      INTO EMRS_D_ESR_TIMEOFF_REQUEST(esrto_id
                  ,esr_id
                  ,timeoff_date
                  ,esr_site_code
                  ,county_name
                  ,timeoff_start_date
                  ,timeoff_end_date
                  ,request_date
                  ,timeoff_request
                  ,timeoff_type
                  ,approved
                  ,denied
                  ,pending
                  ,comments
                  ,modified_by
                  ,shift_covered_by
                  ,note)
    SELECT esrto_id,
            ESR,
            TimeoffDate,
            tor.SiteCode,
            tor.County, 
            tor.StartTime,
            tor.EndTime,
            tor.RequestDate,
            CAST(tor.TimeOffHours AS FLOAT),
            tor.TimeoffType,
            tor.Approved,
            tor.Denied,
            tor.Pending,
            tor.Comments,
            tor.ModifiedBy,
            tor.ShiftCoveredBy, 
            tor.Note
    FROM hco_s_esr_timeoff_request_stg tor                
     WHERE NOT EXISTS(SELECT 1 FROM emrs_d_esr_timeoff_request h WHERE tor.esrto_id = h.esrto_id)
     LOG Errors INTO Errlog_ESRTimeOff ('ESR_TIMEOFF_INS') Reject Limit Unlimited;

    v_ins_cnt := SQL%RowCount;

    UPDATE CORP_ETL_JOB_STATISTICS
       SET Job_end_date = SYSDATE
         , RECORD_COUNT = v_ins_cnt
         , PROCESSED_COUNT = v_ins_cnt
         , RECORD_INSERTED_COUNT = v_ins_cnt
         , JOB_STATUS_CD = 'COMPLETED'
     WHERE JOB_ID =  v_job_id;

    COMMIT;

    INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name,driver_key_number)
    SELECT c_critical, con_pkg, 'CAHCO_ESR_ETL_PKG.ESR_TIMEOFF_INS', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_ESR_TIMEOFF_REQUEST', esrto_id
      FROM Errlog_ESRTimeOff
     WHERE Ora_Err_Tag$ = 'ESR_TIMEOFF_INS';

    v_err_cnt := SQL%RowCount;

    UPDATE CORP_ETL_JOB_STATISTICS
       SET ERROR_COUNT = v_err_cnt
         , RECORD_COUNT = v_ins_cnt + v_err_cnt
         , PROCESSED_COUNT = v_ins_cnt + v_err_cnt
     WHERE JOB_ID =  v_job_id;

    COMMIT;

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, 'CAHCO_ESR_ETL_PKG.ESR_TIMEOFF_INS', 1, v_desc, v_code, 'EMRS_D_ESR_TIMEOFF_REQUEST');

      COMMIT;
END ESR_TIMEOFF_INS;

PROCEDURE ESR_TIMEOFF_UPD
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

    DELETE FROM Errlog_ESRTimeOff WHERE ora_err_tag$ = 'ESR_TIMEOFF_UPD';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'ESR_TIMEOFF_UPD','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;

   MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  EMRS_D_ESR_TIMEOFF_REQUEST s
   USING (SELECT tor.esrto_id,
                  tor.ESR,
                  tor.TimeoffDate,
                  tor.SiteCode,
                  tor.County, 
                  tor.StartTime,
                  tor.EndTime,
                  tor.RequestDate,
                  CAST(tor.TimeOffHours AS FLOAT) TimeOffHours,
                  tor.TimeoffType,
                  tor.Approved,
                  tor.Denied,
                  tor.Pending,
                  tor.Comments,
                  tor.ModifiedBy,
                  tor.ShiftCoveredBy,
                  tor.Note
            FROM hco_s_esr_timeoff_request_stg tor    
          JOIN emrs_d_esr_timeoff_request h ON tor.esrto_id = h.esrto_id
          WHERE COALESCE(tor.ESR,'*') != COALESCE(h.esr_id,'*')            
            OR COALESCE(tor.TimeoffDate, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(h.timeoff_date, TO_DATE('07/07/7777','mm/dd/yyyy'))    
            OR COALESCE(tor.SiteCode,'*') != COALESCE(h.esr_site_code,'*') 
            OR COALESCE(tor.County,'*') != COALESCE(h.county_name,'*') 
            OR COALESCE(tor.StartTime, TO_DATE('07/07/7777','mm/dd/yyyy')) !=  COALESCE(h.timeoff_start_date, TO_DATE('07/07/7777','mm/dd/yyyy')) 
            OR COALESCE(tor.EndTime, TO_DATE('07/07/7777','mm/dd/yyyy')) !=  COALESCE(h.timeoff_end_date, TO_DATE('07/07/7777','mm/dd/yyyy')) 
            OR COALESCE(tor.RequestDate, TO_DATE('07/07/7777','mm/dd/yyyy')) !=  COALESCE(h.request_date, TO_DATE('07/07/7777','mm/dd/yyyy')) 
            OR COALESCE(CAST(tor.TimeOffHours AS FLOAT),0) != COALESCE(h.timeoff_request,0) 
            OR COALESCE(tor.TimeoffType,'*') != COALESCE(h.timeoff_type,'*') 
            OR COALESCE(tor.Approved,'*') != COALESCE(h.approved,'*') 
            OR COALESCE(tor.Denied,'*') != COALESCE(h.denied,'*')                   
            OR COALESCE(tor.Pending,'*') != COALESCE(h.pending,'*')       
            OR COALESCE(tor.Comments,'*') != COALESCE(h.comments,'*') 
            OR COALESCE(tor.ModifiedBy,'*') != COALESCE(h.modified_by,'*') 
            OR COALESCE(tor.ShiftCoveredBy,'*') != COALESCE(h.shift_covered_by,'*')             
               OR COALESCE(tor.Note,'*') != COALESCE(h.note,'*')             
          ) st ON (s.esrto_id = st.esrto_id)
    WHEN MATCHED THEN UPDATE
     SET --s.esrto_id = st.esrto_id          
          s.esr_id = st.esr
          ,s.timeoff_date = st.TimeoffDate
          ,s.esr_site_code = st.SiteCode
          ,s.county_name = st.county
          ,s.timeoff_start_date = st.StartTime
          ,s.timeoff_end_date = st.EndTime
          ,s.request_date = st.RequestDate          
          ,s.timeoff_request = st.TimeOffHours
          ,s.timeoff_type = st.TimeoffType
          ,s.approved = st.Approved
          ,s.denied = st.Denied
          ,s.pending = st.Pending          
          ,s.comments = st.comments
          ,s.modified_by = st.ModifiedBy
          ,s.shift_covered_by = st.ShiftCoveredBy
          ,s.note = st.Note
     Log Errors INTO Errlog_ESRTimeOff ('ESR_TIMEOFF_UPD') Reject Limit Unlimited;

    v_upd_cnt := SQL%RowCount;

    UPDATE CORP_ETL_JOB_STATISTICS
       SET Job_end_date = SYSDATE
         , RECORD_COUNT = v_upd_cnt
         , PROCESSED_COUNT = v_upd_cnt
         , RECORD_UPDATED_COUNT = v_upd_cnt
         , JOB_STATUS_CD = 'COMPLETED'
     WHERE JOB_ID =  v_job_id;

    COMMIT;

    INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name,driver_key_number)
    SELECT c_critical, con_pkg, 'CAHCO_ESR_ETL_PKG.ESR_TIMEOFF_UPD', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_ESR_TIMEOFF_REQUEST', esrto_id
      FROM Errlog_ESRTimeOff
     WHERE Ora_Err_Tag$ = 'ESR_TIMEOFF_UPD';

    v_err_cnt := SQL%RowCount;

    UPDATE CORP_ETL_JOB_STATISTICS
       SET ERROR_COUNT = v_err_cnt
         , RECORD_COUNT = v_upd_cnt + v_err_cnt
         , PROCESSED_COUNT = v_upd_cnt + v_err_cnt
     WHERE JOB_ID =  v_job_id;     

    COMMIT;

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, 'CAHCO_ESR_ETL_PKG.ESR_TIMEOFF_UPD', 1, v_desc, v_code, 'EMRS_D_ESR_TIMEOFF_REQUEST');

      COMMIT;
END ESR_TIMEOFF_UPD;

PROCEDURE ESR_INS_UPD
IS    
  BEGIN
    ESR_HOURS_INS;
    ESR_HOURS_UPD;
    ESR_TIMEOFF_INS;
    ESR_TIMEOFF_UPD;
  END;
END;
/


grant execute on CAHCO_ESR_ETL_PKG to MAXDAT_READ_ONLY;

alter session set plsql_code_type = interpreted;