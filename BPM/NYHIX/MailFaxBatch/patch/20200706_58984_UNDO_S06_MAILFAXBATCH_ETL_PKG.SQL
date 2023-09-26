create or replace package MAILFAXBATCH_ETL_PKG as


  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL: svn://svn-staging.maximus.com/dev1d/maxdat/BPM/CAHCO/createdb/EMRS/EMRS_CAHCO_ENROLL_ETL_PKG.sql $';
  SVN_REVISION varchar2(20) := '$Revision: 25551 $';
  SVN_REVISION_DATE varchar2(60) := '$Date: 2018-11-10 18:55:32 -0800 (Sat, 10 Nov 2018) $';
  SVN_REVISION_AUTHOR varchar2(20) := '$Author: aa24065 $';

  con_pkg    CONSTANT  VARCHAR2(30) := $$PLSQL_UNIT;
  c_abort    CONSTANT  corp_etl_error_log.err_level%TYPE := 'ABORT';
  c_critical CONSTANT  corp_etl_error_log.err_level%TYPE := 'CRITICAL';
  c_log      CONSTANT  corp_etl_error_log.err_level%TYPE := 'LOG';

  PROCEDURE MFB_BATCH_INS;
  PROCEDURE MFB_BATCH_EVENTS_INS;
  PROCEDURE MFB_FORM_INS;
  PROCEDURE MFB_ENVELOPE_INS;
  PROCEDURE MFB_DOCUMENT_INS;
  PROCEDURE MFB_WIP_INS;
end;
/

SHOW ERRORS

create or replace PACKAGE BODY MAILFAXBATCH_ETL_PKG AS

    v_code corp_etl_error_log.error_codes%TYPE;
    v_desc corp_etl_error_log.error_desc%TYPE;

PROCEDURE MFB_BATCH_INS
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_ins_cnt number;
    v_err_cnt number;

BEGIN

    DELETE FROM Errlog_MFB WHERE ora_err_tag$ = 'MFB_BATCH_INS';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'MFB_BATCH_INS','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;

    INSERT /*+ Enable_Parallel_Dml Parallel */
    INTO CORP_ETL_MFB_BATCH_WIP (cemfbb_id	,
      batch_guid	,
      batch_id	,
      batch_name	,
      creation_station_id	,
      creation_user_name	,
      creation_user_id	,
      batch_class	,
      batch_class_des	,
      batch_type	,
      create_dt	,
      complete_dt	,
      instance_status	,
      instance_status_dt	,
      batch_page_count	,
      batch_doc_count	,
      batch_envelope_count	,
      cancel_dt	,
      cancel_by	,
      cancel_reason	,
      cancel_method	,
      asf_scan_batch	,
      assd_scan_batch	,
      ased_scan_batch	,
      aspb_scan_batch	,
      asf_perform_qc	,
      assd_perform_qc	,
      ased_perform_qc	,
      aspb_perform_qc	,
      kofax_qc_reason	,
      asf_classification	,
      assd_classification	,
      ased_classification	,
      classification_dt	,
      asf_recognition	,
      assd_recognition	,
      ased_recognition	,
      recognition_dt	,
      asf_validate_data	,
      assd_validate_data	,
      ased_validate_data	,
      aspb_validate_data	,
      validation_dt	,
      asf_create_pdf	,
      assd_create_pdf	,
      ased_create_pdf	,
      asf_populate_reports	,
      assd_populate_reports	,
      ased_populate_reports	,
      asf_release_dms	,
      assd_release_dms	,
      ased_release_dms	,
      batch_priority	,
      batch_deleted	,
      pages_scanned_flag	,
      docs_created_flag	,
      docs_deleted_flag	,
      pages_replaced_flag	,
      pages_deleted_flag	,
      stg_done_date	,
      stg_extract_date	,
      stg_last_update_date	,
      stg_processed_date	,
      updated	,
      batch_complete_dt	,
      current_batch_module_id	,
      gwf_qc_required	,
      current_step	,
      source_server	,
      batch_description	,
      reprocessed_flag	,
      cejs_job_id	,
      aspb_validate_data_user_id	)
    SELECT cemfbb_id	,
      batch_guid	,
      batch_id	,
      batch_name	,
      creation_station_id	,
      creation_user_name	,
      creation_user_id	,
      batch_class	,
      batch_class_des	,
      batch_type	,
      create_dt	,
      complete_dt	,
      instance_status	,
      instance_status_dt	,
      batch_page_count	,
      batch_doc_count	,
      batch_envelope_count	,
      cancel_dt	,
      cancel_by	,
      cancel_reason	,
      cancel_method	,
      asf_scan_batch	,
      assd_scan_batch	,
      ased_scan_batch	,
      aspb_scan_batch	,
      asf_perform_qc	,
      assd_perform_qc	,
      ased_perform_qc	,
      aspb_perform_qc	,
      kofax_qc_reason	,
      asf_classification	,
      assd_classification	,
      ased_classification	,
      classification_dt	,
      asf_recognition	,
      assd_recognition	,
      ased_recognition	,
      recognition_dt	,
      asf_validate_data	,
      assd_validate_data	,
      ased_validate_data	,
      aspb_validate_data	,
      validation_dt	,
      asf_create_pdf	,
      assd_create_pdf	,
      ased_create_pdf	,
      asf_populate_reports	,
      assd_populate_reports	,
      ased_populate_reports	,
      asf_release_dms	,
      assd_release_dms	,
      ased_release_dms	,
      batch_priority	,
      batch_deleted	,
      pages_scanned_flag	,
      docs_created_flag	,
      docs_deleted_flag	,
      pages_replaced_flag	,
      pages_deleted_flag	,
      stg_done_date	,
      stg_extract_date	,
      stg_last_update_date	,
      stg_processed_date	,
      null	,
      batch_complete_dt	,
      current_batch_module_id	,
      gwf_qc_required	,
      current_step	,
      source_server	,
      batch_description	,
      reprocessed_flag	,
      cejs_job_id	,
      aspb_validate_data_user_id
    FROM CORP_ETL_MFB_BATCH WHERE COMPLETE_DT IS NULL
    LOG Errors INTO Errlog_MFB ('MFB_BATCH_INS') Reject Limit Unlimited;

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
    SELECT c_critical, con_pkg, 'MAILFAXBATCH_ETL_PKG.MFB_BATCH_INS', 1, Ora_Err_Mesg$, ora_err_number$, 'CORP_ETL_MFB_BATCH_WIP', CEMFBB_ID
      FROM Errlog_MFB
     WHERE Ora_Err_Tag$ = 'MFB_BATCH_INS';

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
      VALUES( c_critical, con_pkg, 'MAILFAXBATCH_ETL_PKG.MFB_BATCH_INS', 1, v_desc, v_code, 'CORP_ETL_MFB_BATCH_WIP');

      COMMIT;
END MFB_BATCH_INS;

PROCEDURE MFB_BATCH_EVENTS_INS
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_ins_cnt number;
    v_err_cnt number;

BEGIN

    DELETE FROM Errlog_MFBE WHERE ora_err_tag$ = 'MFB_BATCH_EVENTS_INS';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'MFB_BATCH_EVENTS_INS','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;

    INSERT /*+ Enable_Parallel_Dml Parallel */
    INTO CORP_ETL_MFB_BATCH_EVENTS_WIP (cemfbbe_id	,
        batch_module_id	,
        batch_guid	,
        module_launch_id	,
        module_unique_id	,
        module_name	,
        module_close_id	,
        module_close_name	,
        module_start_dt	,
        module_end_dt	,
        batch_status	,
        user_name	,
        station_id	,
        site_name	,
        site_id	,
        batch_deleted	,
        doc_pages	,
        pages_scanned	,
        pages_deleted	,
        docs_created	,
        docs_deleted	,
        pages_replaced	,
        stg_extract_date	,
        stg_last_update_date	,
        stg_processed_date	,
        updated	,
        source_server	,
        error_text	,
        user_id		)
    SELECT cemfbbe_id	,
        batch_module_id	,
        batch_guid	,
        module_launch_id	,
        module_unique_id	,
        module_name	,
        module_close_id	,
        module_close_name	,
        module_start_dt	,
        module_end_dt	,
        batch_status	,
        user_name	,
        station_id	,
        site_name	,
        site_id	,
        batch_deleted	,
        doc_pages	,
        pages_scanned	,
        pages_deleted	,
        docs_created	,
        docs_deleted	,
        pages_replaced	,
        stg_extract_date	,
        stg_last_update_date	,
        stg_processed_date	,
        null	,
        source_server	,
        error_text	,
        user_id
    FROM CORP_ETL_MFB_BATCH_EVENTS Z WHERE EXISTS(SELECT 1 FROM CORP_ETL_MFB_BATCH B WHERE B.BATCH_GUID=Z.BATCH_GUID AND COMPLETE_DT IS NULL)
    LOG Errors INTO Errlog_MFBE ('MFB_BATCH_EVENTS_INS') Reject Limit Unlimited;

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
    SELECT c_critical, con_pkg, 'MAILFAXBATCH_ETL_PKG.MFB_BATCH_EVENTS_INS', 1, Ora_Err_Mesg$, ora_err_number$, 'CORP_ETL_MFB_BATCH_EVENTS_WIP', CEMFBBE_ID
      FROM Errlog_MFBE
     WHERE Ora_Err_Tag$ = 'MFB_BATCH_EVENTS_INS';

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
      VALUES( c_critical, con_pkg, 'MAILFAXBATCH_ETL_PKG.MFB_BATCH_EVENTS_INS', 1, v_desc, v_code, 'CORP_ETL_MFB_BATCH_EVENTS_WIP');

      COMMIT;
END MFB_BATCH_EVENTS_INS;


PROCEDURE MFB_FORM_INS
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_ins_cnt number;
    v_err_cnt number;

BEGIN

    DELETE FROM Errlog_MFBF WHERE ora_err_tag$ = 'MFB_FORM_INS';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'MFB_FORM_INS','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;

    INSERT /*+ Enable_Parallel_Dml Parallel */
    INTO CORP_ETL_MFB_FORM_WIP (cemfbf_id	,
        batch_guid	,
        form_type_entry_id	,
        batch_module_id	,
        type_name	,
        doc_class_name	,
        doc_count	,
        rejected_docs	,
        pages	,
        rejected_pages	,
        completed_docs	,
        completed_pages	,
        stg_extract_date	,
        stg_last_update_date	,
        stg_processed_date	,
        updated	,
        source_server		)
    SELECT cemfbf_id	,
        batch_guid	,
        form_type_entry_id	,
        batch_module_id	,
        type_name	,
        doc_class_name	,
        doc_count	,
        rejected_docs	,
        pages	,
        rejected_pages	,
        completed_docs	,
        completed_pages	,
        stg_extract_date	,
        stg_last_update_date	,
        stg_processed_date	,
        null	,
        source_server
    FROM CORP_ETL_MFB_FORM Z WHERE EXISTS(SELECT 1 FROM CORP_ETL_MFB_BATCH B WHERE B.BATCH_GUID=Z.BATCH_GUID AND COMPLETE_DT IS NULL)
    LOG Errors INTO Errlog_MFBF ('MFB_FORM_INS') Reject Limit Unlimited;

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
    SELECT c_critical, con_pkg, 'MAILFAXBATCH_ETL_PKG.MFB_FORM_INS', 1, Ora_Err_Mesg$, ora_err_number$, 'CORP_ETL_MFB_FORM_WIP', CEMFBF_ID
      FROM Errlog_MFBF
     WHERE Ora_Err_Tag$ = 'MFB_FORM_INS';

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
      VALUES( c_critical, con_pkg, 'MAILFAXBATCH_ETL_PKG.MFB_FORM_INS', 1, v_desc, v_code, 'CORP_ETL_MFB_FORM_WIP');

      COMMIT;
END MFB_FORM_INS;

PROCEDURE MFB_ENVELOPE_INS
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_ins_cnt number;
    v_err_cnt number;

BEGIN

    DELETE FROM Errlog_MFBEN WHERE ora_err_tag$ = 'MFB_ENVELOPE_INS';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'MFB_ENVELOPE_INS','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;

    INSERT /*+ Enable_Parallel_Dml Parallel */
    INTO CORP_ETL_MFB_ENVELOPE_WIP (cemfbe_id	,
        batch_guid	,
        ecn	,
        env_receipt_date	,
        env_creation_date	,
        env_doc_count	,
        env_page_count	,
        stg_extract_date	,
        stg_last_update_date	,
        stg_processed_date	,
        updated	)
    SELECT cemfbe_id	,
        batch_guid	,
        ecn	,
        env_receipt_date	,
        env_creation_date	,
        env_doc_count	,
        env_page_count	,
        stg_extract_date	,
        stg_last_update_date	,
        stg_processed_date	,
        null
    FROM CORP_ETL_MFB_ENVELOPE Z WHERE EXISTS(SELECT 1 FROM CORP_ETL_MFB_BATCH B WHERE B.BATCH_GUID=Z.BATCH_GUID AND COMPLETE_DT IS NULL)
    LOG Errors INTO Errlog_MFBEN ('MFB_ENVELOPE_INS') Reject Limit Unlimited;

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
    SELECT c_critical, con_pkg, 'MAILFAXBATCH_ETL_PKG.MFB_ENVELOPE_INS', 1, Ora_Err_Mesg$, ora_err_number$, 'CORP_ETL_MFB_ENVELOPE_WIP', CEMFBE_ID
      FROM Errlog_MFBEN
     WHERE Ora_Err_Tag$ = 'MFB_ENVELOPE_INS';

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
      VALUES( c_critical, con_pkg, 'MAILFAXBATCH_ETL_PKG.MFB_ENVELOPE_INS', 1, v_desc, v_code, 'CORP_ETL_MFB_ENVELOPE_WIP');

      COMMIT;
END MFB_ENVELOPE_INS;


PROCEDURE MFB_DOCUMENT_INS
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_ins_cnt number;
    v_err_cnt number;

BEGIN

    DELETE FROM Errlog_MFBD WHERE ora_err_tag$ = 'MFB_DOCUMENT_INS';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'MFB_DOCUMENT_INS','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;

    INSERT /*+ Enable_Parallel_Dml Parallel */
    INTO CORP_ETL_MFB_DOCUMENT_WIP (cemfbd_id	,
        batch_guid	,
        ecn	,
        doc_id	,
        dcn	,
        doc_order_number	,
        type_name	,
        doc_class	,
        doc_receipt_dt	,
        doc_creation_dt	,
        doc_page_count	,
        classified_doc	,
        deleted	,
        confidence	,
        confident	,
        stg_extract_date	,
        stg_last_update_date	,
        stg_processed_date	,
        updated		)
    SELECT cemfbd_id	,
        batch_guid	,
        ecn	,
        doc_id	,
        dcn	,
        doc_order_number	,
        type_name	,
        doc_class	,
        doc_receipt_dt	,
        doc_creation_dt	,
        doc_page_count	,
        classified_doc	,
        deleted	,
        confidence	,
        confident	,
        stg_extract_date	,
        stg_last_update_date	,
        stg_processed_date	,
        null
    FROM CORP_ETL_MFB_DOCUMENT Z WHERE EXISTS(SELECT 1 FROM CORP_ETL_MFB_BATCH B WHERE B.BATCH_GUID=Z.BATCH_GUID AND COMPLETE_DT IS NULL)
    LOG Errors INTO Errlog_MFBD ('MFB_DOCUMENT_INS') Reject Limit Unlimited;

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
    SELECT c_critical, con_pkg, 'MAILFAXBATCH_ETL_PKG.MFB_DOCUMENT_INS', 1, Ora_Err_Mesg$, ora_err_number$, 'CORP_ETL_MFB_DOCUMENT_WIP', CEMFBD_ID
      FROM Errlog_MFBD
     WHERE Ora_Err_Tag$ = 'MFB_DOCUMENT_INS';

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
      VALUES( c_critical, con_pkg, 'MAILFAXBATCH_ETL_PKG.MFB_DOCUMENT_INS', 1, v_desc, v_code, 'CORP_ETL_MFB_DOCUMENT_WIP');

      COMMIT;
END MFB_DOCUMENT_INS;



PROCEDURE MFB_WIP_INS
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_ins_cnt number;
    v_err_cnt number;

BEGIN
  MFB_BATCH_INS;
  MFB_BATCH_EVENTS_INS;
  MFB_FORM_INS;
  MFB_ENVELOPE_INS;
  MFB_DOCUMENT_INS;
END MFB_WIP_INS;

END;
/

SHOW ERRORS