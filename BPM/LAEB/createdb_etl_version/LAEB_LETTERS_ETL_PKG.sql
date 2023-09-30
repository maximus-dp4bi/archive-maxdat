alter session set plsql_code_type = native;

create or replace package LAEB_LETTERS_ETL_PKG as


  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL: svn://svn-staging.maximus.com/dev1d/maxdat/BPM/LAEB/createdb_etl_version/EMRS/EMRS_LAEB_ELIG_ETL_PKG.sql $';
  SVN_REVISION varchar2(20) := '$Revision: 25551 $';
  SVN_REVISION_DATE varchar2(60) := '$Date: 2018-11-10 18:55:32 -0800 (Sat, 10 Nov 2018) $';
  SVN_REVISION_AUTHOR varchar2(20) := '$Author: aa24065 $';

  con_pkg    CONSTANT  VARCHAR2(30) := $$PLSQL_UNIT;
  c_abort    CONSTANT  corp_etl_error_log.err_level%TYPE := 'ABORT';
  c_critical CONSTANT  corp_etl_error_log.err_level%TYPE := 'CRITICAL';
  c_log      CONSTANT  corp_etl_error_log.err_level%TYPE := 'LOG';

  PROCEDURE LETTER_REQUEST_INS;
  PROCEDURE LETTER_REQUEST_UPD;
  
  PROCEDURE LETTER_REQUEST_LINK_INS;
  PROCEDURE LETTER_REQUEST_LINK_UPD;
  

    
end;
/

CREATE OR REPLACE PACKAGE BODY LAEB_LETTERS_ETL_PKG AS

    v_code corp_etl_error_log.error_codes%TYPE;
    v_desc corp_etl_error_log.error_desc%TYPE;

PROCEDURE LETTER_REQUEST_INS
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_ins_cnt number;
    v_err_cnt number;

BEGIN

    DELETE FROM Errlog_Letter WHERE ora_err_tag$ = 'LETTER_REQUEST_INS';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'LETTER_REQUEST_INS','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;

    INSERT /*+ Enable_Parallel_Dml Parallel */
      INTO D_LETTER_REQUEST 
          ( letter_request_id,
            case_id,
            lmdef_id,
            requested_on,
            request_type,
            produced_by,
            language_cd,
            driver_type,
            status_cd,
            rep_lmreq_id,
            sent_on,
            created_by,
            create_ts,
            updated_by,
            update_ts,
            printed_on,
            staff_id_printed_by,
            note_refid,
            return_date,
            return_reason_cd,   
            parent_lmreq_id,
            reprint_parent_lmreq_id,
            lmact_cd,
            ldis_cd,    
            authorized_lmreq_id,
            error_codes,
            nmbr_requested,
            program_type_cd,
            material_request_id,
            mailing_address_id,
            response_due_date,
            mailed_date,
            reject_reason_cd,
            status_err_src,
            letter_out_generation_num,
            portal_view_ind,
            is_digital_ind)
    SELECT lmreq_id,
            case_id,
            lmdef_id,
            requested_on,
            request_type,
            produced_by,
            language_cd,
            driver_type,
            status_cd,
            rep_lmreq_id,
            sent_on,
            created_by,
            create_ts,
            updated_by,
            update_ts,
            printed_on,
            staff_id_printed_by,
            note_refid,
            return_date,
            return_reason_cd,   
            parent_lmreq_id,
            reprint_parent_lmreq_id,
            lmact_cd,
            ldis_cd,    
            authorized_lmreq_id,
            error_codes,
            nmbr_requested,
            program_type_cd,
            material_request_id,
            mailing_address_id,
            response_due_date,
            mailed_date,
            reject_reason_cd,
            status_err_src,
            letter_out_generation_num,
            portal_view_ind,
            is_digital_ind         
    FROM s_letter_request_stg e     
    WHERE NOT EXISTS(SELECT 1 FROM d_letter_request ce WHERE e.lmreq_id = ce.letter_request_id)
     LOG Errors INTO Errlog_Letter ('LETTER_REQUEST_INS') Reject Limit Unlimited;

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
    SELECT c_critical, con_pkg, 'LAEB_LETTERS_ETL_PKG.LETTER_REQUEST_INS', 1, Ora_Err_Mesg$, ora_err_number$, 'D_LETTER_REQUEST', LETTER_REQUEST_ID
      FROM Errlog_Letter
     WHERE Ora_Err_Tag$ = 'LETTER_REQUEST_INS';

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
      VALUES( c_critical, con_pkg, 'LAEB_LETTERS_ETL_PKG.LETTER_REQUEST_INS', 1, v_desc, v_code, 'D_LETTER_REQUEST');

      COMMIT;
END LETTER_REQUEST_INS;

PROCEDURE LETTER_REQUEST_UPD
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

    DELETE FROM Errlog_Letter WHERE ora_err_tag$ = 'LETTER_REQUEST_UPD';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'LETTER_REQUEST_UPD','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;

   MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  D_LETTER_REQUEST e
   USING (SELECT tmp.*
          FROM (SELECT lmreq_id letter_request_id,
                  case_id,
                  lmdef_id,
                  requested_on,
                  request_type,
                  produced_by,
                  language_cd,
                  driver_type,
                  status_cd,
                  rep_lmreq_id,
                  sent_on,
                  created_by,
                  create_ts,
                  updated_by,
                  update_ts,
                  printed_on,
                  staff_id_printed_by,
                  note_refid,
                  return_date,
                  return_reason_cd,   
                  parent_lmreq_id,
                  reprint_parent_lmreq_id,
                  lmact_cd,
                  ldis_cd,    
                  authorized_lmreq_id,
                  error_codes,
                  nmbr_requested,
                  program_type_cd,
                  material_request_id,
                  mailing_address_id,
                  response_due_date,
                  mailed_date,
                  reject_reason_cd,
                  status_err_src,
                  letter_out_generation_num,
                  portal_view_ind,
                  is_digital_ind         
                FROM s_letter_request_stg e                 
              ) tmp
          JOIN d_letter_request t ON tmp.letter_request_id = t.letter_request_id
          WHERE COALESCE(t.case_id,0) != COALESCE(tmp.case_id,0)            
            OR COALESCE(t.lmdef_id,0) != COALESCE(tmp.lmdef_id,0)            
            OR COALESCE(t.requested_on, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.requested_on, TO_DATE('07/07/7777','mm/dd/yyyy'))          
            OR COALESCE(t.request_type,'*') != COALESCE(tmp.request_type,'*')
            OR COALESCE(t.produced_by,'*') != COALESCE(tmp.produced_by,'*')
            OR COALESCE(t.language_cd,'*') != COALESCE(tmp.language_cd,'*')
            OR COALESCE(t.driver_type,'*') != COALESCE(tmp.driver_type,'*')
            OR COALESCE(t.status_cd,'*') != COALESCE(tmp.status_cd,'*')
            OR COALESCE(t.rep_lmreq_id,0) != COALESCE(tmp.rep_lmreq_id,0) 
            OR COALESCE(t.sent_on, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.sent_on, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.created_by,'*') != COALESCE(tmp.created_by,'*')
            OR COALESCE(t.create_ts, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.create_ts, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.updated_by,'*') != COALESCE(tmp.updated_by,'*')
            OR COALESCE(t.update_ts, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.update_ts, TO_DATE('07/07/7777','mm/dd/yyyy'))            
            OR COALESCE(t.printed_on, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.printed_on, TO_DATE('07/07/7777','mm/dd/yyyy'))                        
            OR COALESCE(t.staff_id_printed_by,0) != COALESCE(tmp.staff_id_printed_by,0) 
            OR COALESCE(t.note_refid,0) != COALESCE(tmp.note_refid,0) 
            OR COALESCE(t.return_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.return_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.return_reason_cd,'*') != COALESCE(tmp.return_reason_cd,'*')
            OR COALESCE(t.parent_lmreq_id,0) != COALESCE(tmp.parent_lmreq_id,0) 
            OR COALESCE(t.reprint_parent_lmreq_id,0) != COALESCE(tmp.reprint_parent_lmreq_id,0) 
            OR COALESCE(t.lmact_cd,'*') != COALESCE(tmp.lmact_cd,'*')                       
            OR COALESCE(t.ldis_cd,'*') != COALESCE(tmp.ldis_cd,'*') 
            OR COALESCE(t.authorized_lmreq_id,0) != COALESCE(tmp.authorized_lmreq_id,0) 
            OR COALESCE(t.error_codes,'*') != COALESCE(tmp.error_codes,'*') 
            OR COALESCE(t.nmbr_requested,0) != COALESCE(tmp.nmbr_requested,0)             
            OR COALESCE(t.program_type_cd,'*') != COALESCE(tmp.program_type_cd,'*') 
            OR COALESCE(t.material_request_id,0) != COALESCE(tmp.material_request_id,0) 
            OR COALESCE(t.mailing_address_id,0) != COALESCE(tmp.mailing_address_id,0)
            OR COALESCE(t.response_due_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.response_due_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.mailed_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.mailed_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.reject_reason_cd,'*') != COALESCE(tmp.reject_reason_cd,'*') 
            OR COALESCE(t.status_err_src,'*') != COALESCE(tmp.status_err_src,'*') 
            OR COALESCE(t.letter_out_generation_num,0) != COALESCE(tmp.letter_out_generation_num,0) 
            OR COALESCE(t.portal_view_ind,0) != COALESCE(tmp.portal_view_ind,0)            
            OR COALESCE(t.is_digital_ind,0) != COALESCE(tmp.is_digital_ind,0)                     
          ) ce ON (e.letter_request_id = ce.letter_request_id)
    WHEN MATCHED THEN UPDATE
     SET e.case_id = ce.case_id
         ,e.lmdef_id = ce.lmdef_id
         ,e.requested_on = ce.requested_on
         ,e.request_type = ce.request_type
         ,e.produced_by = ce.produced_by
         ,e.language_cd = ce.language_cd
         ,e.driver_type = ce.driver_type
         ,e.status_cd = ce.status_cd
         ,e.rep_lmreq_id = ce.rep_lmreq_id
         ,e.sent_on = ce.sent_on
         ,e.created_by = ce.created_by
         ,e.create_ts = ce.create_ts
         ,e.updated_by = ce.updated_by
         ,e.update_ts = ce.update_ts
         ,e.printed_on = ce.printed_on
         ,e.staff_id_printed_by = ce.staff_id_printed_by
         ,e.note_refid = ce.note_refid
         ,e.return_date = ce.return_date
         ,e.return_reason_cd = ce.return_reason_cd
         ,e.parent_lmreq_id = ce.parent_lmreq_id
         ,e.reprint_parent_lmreq_id = ce.reprint_parent_lmreq_id
         ,e.lmact_cd = ce.lmact_cd
         ,e.ldis_cd = ce.ldis_cd
         ,e.authorized_lmreq_id = ce.authorized_lmreq_id
         ,e.error_codes = ce.error_codes
         ,e.nmbr_requested = ce.nmbr_requested
         ,e.program_type_cd = ce.program_type_cd
         ,e.material_request_id = ce.material_request_id
         ,e.mailing_address_id = ce.mailing_address_id
         ,e.response_due_date = ce.response_due_date
         ,e.mailed_date = ce.mailed_date
         ,e.reject_reason_cd = ce.reject_reason_cd
         ,e.status_err_src = ce.status_err_src
         ,e.letter_out_generation_num = ce.letter_out_generation_num
         ,e.portal_view_ind = ce.portal_view_ind
         ,e.is_digital_ind =  ce.is_digital_ind
     Log Errors INTO Errlog_Letter ('LETTER_REQUEST_UPD') Reject Limit Unlimited;

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
    SELECT c_critical, con_pkg, 'LAEB_LETTERS_ETL_PKG.LETTER_REQUEST_UPD', 1, Ora_Err_Mesg$, ora_err_number$, 'D_LETTER_REQUEST', LETTER_REQUEST_ID
      FROM Errlog_Letter
     WHERE Ora_Err_Tag$ = 'LETTER_REQUEST_UPD';

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
      VALUES( c_critical, con_pkg, 'LAEB_LETTERS_ETL_PKG.LETTER_REQUEST_UPD', 1, v_desc, v_code, 'D_LETTER_REQUEST');

      COMMIT;
END LETTER_REQUEST_UPD;

PROCEDURE LETTER_REQUEST_LINK_INS
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_ins_cnt number;
    v_err_cnt number;

BEGIN

    DELETE FROM Errlog_LtrLink WHERE ora_err_tag$ = 'LETTER_REQUEST_LINK_INS';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'LETTER_REQUEST_LINK_INS','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;

    INSERT /*+ Enable_Parallel_Dml Parallel */
      INTO D_LETTER_REQUEST_LINK 
          (lmlink_id,
            letter_request_id,
            reference_type,
            reference_id,
            created_by,
            create_ts,
            updated_by,    
            update_ts,
            additional_reference_type,
            additional_reference_id,
            client_id,
            client_enroll_status_id)
    SELECT
          lmlink_id,
            letter_request_id,
            reference_type,
            reference_id,
            created_by,
            create_ts,
            updated_by,    
            update_ts,
            additional_reference_type,
            additional_reference_id,
            client_id,
            client_enroll_status_id      
    FROM s_letter_link_stg e     
    WHERE NOT EXISTS(SELECT 1 FROM d_letter_request_link ce WHERE e.lmlink_id = ce.lmlink_id)
     LOG Errors INTO Errlog_LtrLink ('LETTER_REQUEST_LINK_INS') Reject Limit Unlimited;

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
    SELECT c_critical, con_pkg, 'LAEB_LETTERS_ETL_PKG.LETTER_REQUEST_LINK_INS', 1, Ora_Err_Mesg$, ora_err_number$, 'D_LETTER_REQUEST_LINK', LMLINK_ID
      FROM Errlog_LtrLink
     WHERE Ora_Err_Tag$ = 'LETTER_REQUEST_LINK_INS';

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
      VALUES( c_critical, con_pkg, 'LAEB_LETTERS_ETL_PKG.LETTER_REQUEST_LINK_INS', 1, v_desc, v_code, 'D_LETTER_REQUEST_LINK');

      COMMIT;
END LETTER_REQUEST_LINK_INS;

PROCEDURE LETTER_REQUEST_LINK_UPD
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

    DELETE FROM Errlog_LtrLink WHERE ora_err_tag$ = 'LETTER_REQUEST_LINK_UPD';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'LETTER_REQUEST_LINK_UPD','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;

   MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  D_LETTER_REQUEST_LINK e
   USING (SELECT tmp.*
          FROM (SELECT lmlink_id,
                  letter_request_id,
                  reference_type,
                  reference_id,
                  created_by,
                  create_ts,
                  updated_by,    
                  update_ts,
                  additional_reference_type,
                  additional_reference_id,
                  client_id,
                  client_enroll_status_id  
                FROM s_letter_link_stg e                
              ) tmp
          JOIN d_letter_request_link t ON tmp.lmlink_id = t.lmlink_id
          WHERE COALESCE(t.letter_request_id,0) != COALESCE(tmp.letter_request_id,0) 
            OR COALESCE(t.reference_type,'*') != COALESCE(tmp.reference_type,'*')          
            OR COALESCE(t.reference_id,0) != COALESCE(tmp.reference_id,0) 
            OR COALESCE(t.create_ts, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.create_ts, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.created_by,'*') != COALESCE(tmp.created_by,'*')
            OR COALESCE(t.update_ts, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.update_ts, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.updated_by,'*') != COALESCE(tmp.updated_by,'*')
            OR COALESCE(t.additional_reference_type,'*') != COALESCE(tmp.additional_reference_type,'*')          
            OR COALESCE(t.additional_reference_id,0) != COALESCE(tmp.additional_reference_id,0) 
            OR COALESCE(t.client_id,0) != COALESCE(tmp.client_id,0) 
            OR COALESCE(t.client_enroll_status_id,0) != COALESCE(tmp.client_enroll_status_id,0)                        
          ) ce ON (e.lmlink_id = ce.lmlink_id)
    WHEN MATCHED THEN UPDATE
     SET e.letter_request_id = ce.letter_request_id
        ,e.reference_type = ce.reference_type
        ,e.reference_id = ce.reference_id
        ,e.create_ts = ce.create_ts
        ,e.created_by = ce.created_by
        ,e.update_ts = ce.update_ts
        ,e.updated_by = ce.updated_by
        ,e.additional_reference_type = ce.additional_reference_type
        ,e.additional_reference_id = ce.additional_reference_id
        ,e.client_id = ce.client_id
        ,e.client_enroll_status_id = ce.client_enroll_status_id              
     Log Errors INTO Errlog_LtrLink ('LETTER_REQUEST_LINK_UPD') Reject Limit Unlimited;

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
    SELECT c_critical, con_pkg, 'LAEB_LETTERS_ETL_PKG.LETTER_REQUEST_LINK_UPD', 1, Ora_Err_Mesg$, ora_err_number$, 'D_LETTER_REQUEST_LINK', LMLINK_ID
      FROM Errlog_LtrLink
     WHERE Ora_Err_Tag$ = 'LETTER_REQUEST_LINK_UPD';

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
      VALUES( c_critical, con_pkg, 'LAEB_LETTERS_ETL_PKG.LETTER_REQUEST_LINK_UPD', 1, v_desc, v_code, 'D_LETTER_REQUEST_LINK');

      COMMIT;
END LETTER_REQUEST_LINK_UPD;


END;
/

grant execute on LAEB_LETTERS_ETL_PKG to MAXDAT_LAEB_READ_ONLY;

alter session set plsql_code_type = interpreted;