alter session set plsql_code_type = native;

create or replace package CAHCO_MAILING_ETL_PKG as


  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL$';
  SVN_REVISION varchar2(20) := '$Revision$';
  SVN_REVISION_DATE varchar2(60) := '$Date$';
  SVN_REVISION_AUTHOR varchar2(20) := '$Author$';

  con_pkg    CONSTANT  VARCHAR2(30) := $$PLSQL_UNIT;
  c_abort    CONSTANT  corp_etl_error_log.err_level%TYPE := 'ABORT';
  c_critical CONSTANT  corp_etl_error_log.err_level%TYPE := 'CRITICAL';
  c_log      CONSTANT  corp_etl_error_log.err_level%TYPE := 'LOG';

  PROCEDURE MAILING_INS;
  PROCEDURE LETTER_MAILING_INDICATOR_UPD;
  PROCEDURE PACKET_MAILING_INDICATOR_UPD;
  
  PROCEDURE LETTER_MAILING_INS;
  PROCEDURE LETTER_MAILING_UPD;
  
  PROCEDURE PACKET_MAILING_INS;
  PROCEDURE PACKET_MAILING_UPD;
  
  PROCEDURE LETTER_DETAIL_INS;
  PROCEDURE LETTER_DETAIL_UPD;
  
  PROCEDURE LETTER_MAILING_BADADDR_UPD;
  PROCEDURE PACKET_MAILING_BADADDR_UPD;
      
end;
/


CREATE OR REPLACE PACKAGE BODY CAHCO_MAILING_ETL_PKG AS

    v_code corp_etl_error_log.error_codes%TYPE;
    v_desc corp_etl_error_log.error_desc%TYPE;

PROCEDURE MAILING_INS
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_ins_cnt number;
    v_err_cnt number;

BEGIN

    DELETE FROM Errlog_Mailing WHERE ora_err_tag$ = 'MAILING_INS';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'MAILING_INS','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;

    INSERT /*+ Enable_Parallel_Dml Parallel */
      INTO HCO_D_MAILING (mail_id
          ,custom_mailing_indicator
          ,record_date              
          )
    SELECT  mail_id
          ,custom_mailing_indicator
          ,record_date                            
    FROM hco_s_mailing_stg s                
     WHERE NOT EXISTS(SELECT 1 FROM hco_d_mailing m WHERE m.mail_id = s.mail_id)
     LOG Errors INTO Errlog_Form ('MAILING_INS') Reject Limit Unlimited;

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
    SELECT c_critical, con_pkg, 'CAHCO_MAILING_ETL_PKG.MAILING_INS', 1, Ora_Err_Mesg$, ora_err_number$, 'HCO_D_MAILING', MAIL_ID
      FROM Errlog_Mailing
     WHERE Ora_Err_Tag$ = 'MAILING_INS';

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
      VALUES( c_critical, con_pkg, 'CAHCO_MAILING_ETL_PKG.MAILING_INS', 1, v_desc, v_code, 'HCO_D_MAILING');

      COMMIT;
END MAILING_INS;

PROCEDURE LETTER_MAILING_INDICATOR_UPD
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_Letter_Mailing WHERE ora_err_tag$ = 'LETTER_MAILING_INDICATOR_UPD';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'LETTER_MAILING_INDICATOR_UPD','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

   MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  HCO_S_LETTER_MAILING_STG s
   USING (SELECT m.custom_mailing_indicator,
                t.dim_letter_mailing_id
          FROM hco_d_mailing m
          JOIN hco_s_letter_mailing_stg t ON m.mail_id = t.dcin
          WHERE  COALESCE(t.custom_mailing_indicator,'*') != COALESCE(m.custom_mailing_indicator,'*')            
          ) st ON (s.dim_letter_mailing_id = st.dim_letter_mailing_id)
    WHEN MATCHED THEN UPDATE
     SET s.custom_mailing_indicator = st.custom_mailing_indicator
     Log Errors INTO Errlog_Letter_Mailing ('LETTER_MAILING_INDICATOR_UPD') Reject Limit Unlimited;

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
    SELECT c_critical, con_pkg, 'CAHCO_MAILING_ETL_PKG.LETTER_MAILING_INDICATOR_UPD', 1, Ora_Err_Mesg$, ora_err_number$, 'HCO_S_LETTER_MAILING_STG', DIM_LETTER_MAILING_ID
    FROM Errlog_Letter_Mailing
    WHERE Ora_Err_Tag$ = 'LETTER_MAILING_INDICATOR_UPD';

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
      VALUES( c_critical, con_pkg, 'CAHCO_MAILING_ETL_PKG.LETTER_MAILING_INDICATOR_UPD', 1, v_desc, v_code, 'HCO_S_LETTER_MAILING_STG');

      COMMIT;
END LETTER_MAILING_INDICATOR_UPD;

PROCEDURE PACKET_MAILING_INDICATOR_UPD
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_Packet_Mailing WHERE ora_err_tag$ = 'PACKET_MAILING_INDICATOR_UPD';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'PACKET_MAILING_INDICATOR_UPD','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

   MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  HCO_S_PACKET_MAILING_STG s
   USING (SELECT m.custom_mailing_indicator,
                t.dim_packet_mailing_id
          FROM hco_d_mailing m
          JOIN hco_s_packet_mailing_stg t ON m.mail_id = t.dcin
          WHERE  COALESCE(t.custom_mailing_indicator,'*') != COALESCE(m.custom_mailing_indicator,'*')            
          ) st ON (s.dim_packet_mailing_id = st.dim_packet_mailing_id)
    WHEN MATCHED THEN UPDATE
     SET s.custom_mailing_indicator = st.custom_mailing_indicator
     Log Errors INTO Errlog_Packet_Mailing ('PACKET_MAILING_INDICATOR_UPD') Reject Limit Unlimited;

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
    SELECT c_critical, con_pkg, 'CAHCO_MAILING_ETL_PKG.PACKET_MAILING_INDICATOR_UPD', 1, Ora_Err_Mesg$, ora_err_number$, 'HCO_S_PACKET_MAILING_STG', DIM_PACKET_MAILING_ID
    FROM Errlog_Packet_Mailing
    WHERE Ora_Err_Tag$ = 'PACKET_MAILING_INDICATOR_UPD';

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
      VALUES( c_critical, con_pkg, 'CAHCO_MAILING_ETL_PKG.PACKET_MAILING_INDICATOR_UPD', 1, v_desc, v_code, 'HCO_S_PACKET_MAILING_STG');

      COMMIT;
END PACKET_MAILING_INDICATOR_UPD;

PROCEDURE LETTER_MAILING_INS
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_ins_cnt number;
    v_err_cnt number;

BEGIN

    DELETE FROM Errlog_Letter_Mailing WHERE ora_err_tag$ = 'LETTER_MAILING_INS';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'LETTER_MAILING_INS','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;
 
    INSERT /*+ Enable_Parallel_Dml Parallel */
      INTO HCO_D_LETTER_MAILING (dim_letter_mailing_id,
                       vendor_received_date,
                       county_code,
                       custom_mailing_indicator,
                       letter_type_id,
                       letter_type_code,
                       job_id,
                       case_id,
                       dcin,
                       date_requested,
                       date_mailed,
                       language_id,
                       valid_flag,
                       mail_status,
                       sub_type,
                       bad_address_transaction_type,
                       bad_address_record_date,
                       bad_address_flag,
                       modified_date,
                       modified_name,
                       record_date,
                       record_name
                       )
     SELECT dim_letter_mailing_id,
            vendor_received_date,
            county_code,
            custom_mailing_indicator,
            letter_type_id,
            letter_type_code,
            job_id,
            case_id,
            dcin,
            date_requested,
            date_mailed,
            language_id,
            valid_flag,
            mail_status,
            sub_type,
            bad_address_transaction_type,
            bad_address_record_date,
            bad_address_flag,
            modified_date,
            modified_by modified_name,
            modified_date record_date,
            modified_by record_name         
     FROM hco_s_letter_mailing_stg s
     WHERE NOT EXISTS(SELECT 1 FROM hco_d_letter_mailing m WHERE s.dim_letter_mailing_id = m.dim_letter_mailing_id)
     LOG Errors INTO Errlog_Letter_Mailing ('LETTER_MAILING_INS') Reject Limit Unlimited;

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
    SELECT c_critical, con_pkg, 'CAHCO_MAILING_ETL_PKG.LETTER_MAILING_INS', 1, Ora_Err_Mesg$, ora_err_number$, 'HCO_D_LETTER_MAILING', DIM_LETTER_MAILING_ID
      FROM Errlog_Letter_Mailing
     WHERE Ora_Err_Tag$ = 'LETTER_MAILING_INS';

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
      VALUES( c_critical, con_pkg, 'CAHCO_MAILING_ETL_PKG.LETTER_MAILING_INS', 1, v_desc, v_code, 'HCO_D_LETTER_MAILING');

      COMMIT;
END LETTER_MAILING_INS;


PROCEDURE LETTER_MAILING_BADADDR_UPD
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_Letter_Mailing WHERE ora_err_tag$ = 'LETTER_MAILING_BADADDR_UPD';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'LETTER_MAILING_BADADDR_UPD','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

   MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  HCO_D_LETTER_MAILING s
    USING (SELECT lm.dp_letter_mail_id, tmp.bad_address_transaction_type,tmp.bad_address_record_date,tmp.bad_address_flag
           FROM hco_d_letter_mailing lm
            JOIN(
              SELECT ba.TransactionType bad_address_transaction_type,
                      ba.RecordCreateDate bad_address_record_date,
                      ba.DeIdentificationCIN,
                      CASE WHEN ba.DeIdentificationCIN is not null THEN 'Y' ELSE 'N' END bad_address_flag,
                      ROW_NUMBER() OVER(PARTITION BY DeIdentificationCIN ORDER BY DimBadAddressId) prn
               FROM hco_s_bad_address_stg ba) tmp ON lm.dcin = tmp.DeIdentificationCIN
            WHERE prn = 1
            AND (COALESCE(lm.bad_address_transaction_type,'*') != COALESCE(tmp.bad_address_transaction_type,'*')           
            OR COALESCE(lm.bad_address_record_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.bad_address_record_date, TO_DATE('07/07/7777','mm/dd/yyyy'))            
            OR COALESCE(lm.bad_address_flag,'*') != COALESCE(tmp.bad_address_flag,'*') )            
          ) st ON (s.dp_letter_mail_id = st.dp_letter_mail_id)
    WHEN MATCHED THEN UPDATE
     SET s.bad_address_transaction_type = st.bad_address_transaction_type
        ,s.bad_address_record_date = st.bad_address_record_date
        ,s.bad_address_flag = st.bad_address_flag        
     Log Errors INTO Errlog_Letter_Mailing ('LETTER_MAILING_BADADDR_UPD') Reject Limit Unlimited;

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
    SELECT c_critical, con_pkg, 'CAHCO_MAILING_ETL_PKG.LETTER_MAILING_BADADDR_UPD', 1, Ora_Err_Mesg$, ora_err_number$, 'HCO_D_LETTER_MAILING', DIM_LETTER_MAILING_ID
    FROM Errlog_Letter_Mailing
    WHERE Ora_Err_Tag$ = 'LETTER_MAILING_BADADDR_UPD';

    v_err_cnt := SQL%RowCount;

    UPDATE CORP_ETL_JOB_STATISTICS
       SET ERROR_COUNT = v_err_cnt
         , RECORD_COUNT = record_count + v_err_cnt
         , PROCESSED_COUNT = processed_count + v_err_cnt
     WHERE JOB_ID =  v_job_id;
     
    COMMIT;

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, 'CAHCO_MAILING_ETL_PKG.LETTER_MAILING_BADADDR_UPD', 1, v_desc, v_code, 'HCO_D_LETTER_MAILING');

      COMMIT;
END LETTER_MAILING_BADADDR_UPD;

PROCEDURE LETTER_MAILING_UPD
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_Letter_Mailing WHERE ora_err_tag$ = 'LETTER_MAILING_UPD';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'LETTER_MAILING_UPD','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

   MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  HCO_D_LETTER_MAILING s
   USING (SELECT tmp.dim_letter_mailing_id,
            tmp.vendor_received_date,
            tmp.county_code,
            tmp.custom_mailing_indicator,
            tmp.letter_type_id,
            tmp.letter_type_code,
            tmp.job_id,
            tmp.case_id,
            tmp.dcin,
            tmp.date_requested,
            tmp.date_mailed,
            tmp.language_id,
            tmp.valid_flag,
            tmp.mail_status,
            tmp.sub_type,
            tmp.bad_address_transaction_type,
            tmp.bad_address_record_date,
            tmp.bad_address_flag,
            tmp.modified_date,
            tmp.modified_by modified_name,
            t.dp_letter_mail_id
        FROM hco_s_letter_mailing_stg tmp
          JOIN hco_d_letter_mailing t ON tmp.dim_letter_mailing_id = t.dim_letter_mailing_id
        WHERE  COALESCE(t.vendor_received_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.vendor_received_date, TO_DATE('07/07/7777','mm/dd/yyyy'))          
            OR COALESCE(t.county_code,'*') != COALESCE(tmp.county_code,'*')
            OR COALESCE(t.custom_mailing_indicator,'*') != COALESCE(tmp.custom_mailing_indicator,'*')            
            OR COALESCE(t.letter_type_id,0) != COALESCE(tmp.letter_type_id,0)
            OR COALESCE(t.letter_type_code,'*') != COALESCE(tmp.letter_type_code,'*')            
            OR COALESCE(t.job_id,'*') != COALESCE(tmp.job_id,'*')
            OR COALESCE(t.case_id,'*') != COALESCE(tmp.case_id,'*')
            OR COALESCE(t.dcin,'*') != COALESCE(tmp.dcin,'*')
            OR COALESCE(t.date_requested, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.date_requested, TO_DATE('07/07/7777','mm/dd/yyyy'))            
            OR COALESCE(t.date_mailed, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.date_mailed, TO_DATE('07/07/7777','mm/dd/yyyy'))            
            OR COALESCE(t.language_id,'*') != COALESCE(tmp.language_id,'*')           
            OR COALESCE(t.valid_flag,'*') != COALESCE(tmp.valid_flag,'*')           
            OR COALESCE(t.mail_status,'*') != COALESCE(tmp.mail_status,'*')           
            OR COALESCE(t.sub_type,'*') != COALESCE(tmp.sub_type,'*')           
            OR COALESCE(t.bad_address_transaction_type,'*') != COALESCE(tmp.bad_address_transaction_type,'*')           
            OR COALESCE(t.bad_address_record_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.bad_address_record_date, TO_DATE('07/07/7777','mm/dd/yyyy'))            
            OR COALESCE(t.bad_address_flag,'*') != COALESCE(tmp.bad_address_flag,'*')           
            OR COALESCE(t.modified_name,'*') != COALESCE(tmp.modified_by,'*')           
            OR COALESCE(t.modified_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.modified_date, TO_DATE('07/07/7777','mm/dd/yyyy'))    
          ) st ON (s.dp_letter_mail_id = st.dp_letter_mail_id)
    WHEN MATCHED THEN UPDATE
     SET s.vendor_received_date = st.vendor_received_date
        ,s.county_code = st.county_code
        ,s.custom_mailing_indicator = st.custom_mailing_indicator
        ,s.letter_type_id = st.letter_type_id
        ,s.letter_type_code = st.letter_type_code
        ,s.job_id = st.job_id
        ,s.case_id = st.case_id
        ,s.dcin = st.dcin
        ,s.date_requested = st.date_requested
        ,s.date_mailed = st.date_mailed
        ,s.language_id = st.language_id
        ,s.valid_flag = st.valid_flag 
        ,s.mail_status = st.mail_status
        ,s.sub_type = st.sub_type
        ,s.bad_address_transaction_type = st.bad_address_transaction_type
        ,s.bad_address_record_date = st.bad_address_record_date
        ,s.bad_address_flag = st.bad_address_flag
        ,s.modified_name = st.modified_name
        ,s.modified_date = st.modified_date
     Log Errors INTO Errlog_Letter_Mailing ('LETTER_MAILING_UPD') Reject Limit Unlimited;

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
    SELECT c_critical, con_pkg, 'CAHCO_MAILING_ETL_PKG.LETTER_MAILING_UPD', 1, Ora_Err_Mesg$, ora_err_number$, 'HCO_D_LETTER_MAILING', DIM_LETTER_MAILING_ID
    FROM Errlog_Letter_Mailing
    WHERE Ora_Err_Tag$ = 'LETTER_MAILING_UPD';

    v_err_cnt := SQL%RowCount;

    UPDATE CORP_ETL_JOB_STATISTICS
       SET ERROR_COUNT = v_err_cnt
         , RECORD_COUNT = record_count + v_err_cnt
         , PROCESSED_COUNT = processed_count + v_err_cnt
     WHERE JOB_ID =  v_job_id;
     
    COMMIT;
    
    LETTER_MAILING_BADADDR_UPD;

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, 'CAHCO_MAILING_ETL_PKG.LETTER_MAILING_UPD', 1, v_desc, v_code, 'HCO_D_LETTER_MAILING');

      COMMIT;
END LETTER_MAILING_UPD;

PROCEDURE PACKET_MAILING_INS
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_ins_cnt number;
    v_err_cnt number;

BEGIN

    DELETE FROM Errlog_Packet_Mailing WHERE ora_err_tag$ = 'PACKET_MAILING_INS';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'PACKET_MAILING_INS','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;
 
    INSERT /*+ Enable_Parallel_Dml Parallel */
      INTO HCO_D_PACKET_MAILING (dim_packet_mailing_id,
                                 vendor_received_date,
                                 county_code,
                                 custom_mailing_indicator,
                                 job_id,
                                 dcin,
                                 date_requested,
                                 date_mailed,
                                 ship_by_date,
                                 language_id,
                                 packet_type,
                                 packet_subtype,
                                 booklet_type1,
                                 booklet_type2,
                                 ppd,
                                 packets_requested,
                                 case_id,
                                 mail_status,                              
                                 valid_flag,
                                 bad_address_transaction_type,
                                 bad_address_record_date,
                                 bad_address_flag,
                                 modified_date,
                                 modified_name,
                                 record_date,
                                 record_name )
     SELECT dim_packet_mailing_id,
            vendor_received_date,
            county_code,
            custom_mailing_indicator,
            job_id,
            dcin,
            date_requested,
            date_mailed,
            ship_by_date,
            language_id,
            packet_type,
            packet_subtype,
            booklet_type1,
            booklet_type2,
            ppd,
            packets_requested,
            case_id,
            mail_status,                              
            valid_flag,
            bad_address_transaction_type,
            bad_address_record_date,
            bad_address_flag,
            modified_date,
            modified_by,                                 
            modified_date record_date,
            modified_by record_name         
     FROM hco_s_packet_mailing_stg s
     WHERE NOT EXISTS(SELECT 1 FROM hco_d_packet_mailing m WHERE s.dim_packet_mailing_id = m.dim_packet_mailing_id)
     LOG Errors INTO Errlog_Packet_Mailing ('PACKET_MAILING_INS') Reject Limit Unlimited;

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
    SELECT c_critical, con_pkg, 'CAHCO_MAILING_ETL_PKG.PACKET_MAILING_INS', 1, Ora_Err_Mesg$, ora_err_number$, 'HCO_D_PACKET_MAILING', DIM_PACKET_MAILING_ID
      FROM Errlog_Packet_Mailing
     WHERE Ora_Err_Tag$ = 'PACKET_MAILING_INS';

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
      VALUES( c_critical, con_pkg, 'CAHCO_MAILING_ETL_PKG.PACKET_MAILING_INS', 1, v_desc, v_code, 'HCO_D_PACKET_MAILING');

      COMMIT;
END PACKET_MAILING_INS;

PROCEDURE PACKET_MAILING_BADADDR_UPD
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_Packet_Mailing WHERE ora_err_tag$ = 'PACKET_MAILING_BADADDR_UPD';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'PACKET_MAILING_BADADDR_UPD','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

   MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  HCO_D_PACKET_MAILING s
    USING (SELECT lm.dp_packet_mail_id, tmp.bad_address_transaction_type,tmp.bad_address_record_date,tmp.bad_address_flag
           FROM hco_d_packet_mailing lm
            JOIN(
              SELECT ba.TransactionType bad_address_transaction_type,
                      ba.RecordCreateDate bad_address_record_date,
                      ba.DeIdentificationCIN,
                      CASE WHEN ba.DeIdentificationCIN is not null THEN 'Y' ELSE 'N' END bad_address_flag,
                      ROW_NUMBER() OVER(PARTITION BY DeIdentificationCIN ORDER BY DimBadAddressId) prn
               FROM hco_s_bad_address_stg ba) tmp ON lm.dcin = tmp.DeIdentificationCIN
            WHERE prn = 1
            AND (COALESCE(lm.bad_address_transaction_type,'*') != COALESCE(tmp.bad_address_transaction_type,'*')           
            OR COALESCE(lm.bad_address_record_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.bad_address_record_date, TO_DATE('07/07/7777','mm/dd/yyyy'))            
            OR COALESCE(lm.bad_address_flag,'*') != COALESCE(tmp.bad_address_flag,'*') )            
          ) st ON (s.dp_packet_mail_id = st.dp_packet_mail_id)
    WHEN MATCHED THEN UPDATE
     SET s.bad_address_transaction_type = st.bad_address_transaction_type
        ,s.bad_address_record_date = st.bad_address_record_date
        ,s.bad_address_flag = st.bad_address_flag        
     Log Errors INTO Errlog_Packet_Mailing ('PACKET_MAILING_BADADDR_UPD') Reject Limit Unlimited;

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
    SELECT c_critical, con_pkg, 'CAHCO_MAILING_ETL_PKG.PACKET_MAILING_BADADDR_UPD', 1, Ora_Err_Mesg$, ora_err_number$, 'HCO_D_PACKET_MAILING', DIM_PACKET_MAILING_ID
    FROM Errlog_Packet_Mailing
    WHERE Ora_Err_Tag$ = 'PACKET_MAILING_BADADDR_UPD';

    v_err_cnt := SQL%RowCount;

    UPDATE CORP_ETL_JOB_STATISTICS
       SET ERROR_COUNT = v_err_cnt
         , RECORD_COUNT = record_count + v_err_cnt
         , PROCESSED_COUNT = processed_count + v_err_cnt
     WHERE JOB_ID =  v_job_id;
     
    COMMIT;

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, 'CAHCO_MAILING_ETL_PKG.PACKET_MAILING_BADADDR_UPD', 1, v_desc, v_code, 'HCO_D_PACKET_MAILING');

      COMMIT;
END PACKET_MAILING_BADADDR_UPD;

PROCEDURE PACKET_MAILING_UPD
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_Packet_Mailing WHERE ora_err_tag$ = 'PACKET_MAILING_UPD';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'PACKET_MAILING_UPD','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

   MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  HCO_D_PACKET_MAILING s
   USING (SELECT tmp.dim_packet_mailing_id,
            tmp.vendor_received_date,
            tmp.county_code,
            tmp.custom_mailing_indicator,           
            tmp.job_id,            
            tmp.dcin,
            tmp.date_requested,
            tmp.date_mailed,
            tmp.ship_by_date,
            tmp.language_id,
            tmp.packet_type,
            tmp.packet_subtype,
            tmp.booklet_type1,
            tmp.booklet_type2,
            tmp.ppd,
            tmp.packets_requested,
            tmp.case_id,            
            tmp.mail_status,
            tmp.valid_flag,            
            tmp.bad_address_transaction_type,
            tmp.bad_address_record_date,
            tmp.bad_address_flag,
            tmp.modified_date,
            tmp.modified_by modified_name,
            t.dp_packet_mail_id
        FROM hco_s_packet_mailing_stg tmp
          JOIN hco_d_packet_mailing t ON tmp.dim_packet_mailing_id = t.dim_packet_mailing_id
        WHERE  COALESCE(t.vendor_received_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.vendor_received_date, TO_DATE('07/07/7777','mm/dd/yyyy'))          
            OR COALESCE(t.county_code,'*') != COALESCE(tmp.county_code,'*')
            OR COALESCE(t.custom_mailing_indicator,'*') != COALESCE(tmp.custom_mailing_indicator,'*')                        
            OR COALESCE(t.job_id,'*') != COALESCE(tmp.job_id,'*')            
            OR COALESCE(t.dcin,'*') != COALESCE(tmp.dcin,'*')            
            OR COALESCE(t.date_requested, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.date_requested, TO_DATE('07/07/7777','mm/dd/yyyy'))            
            OR COALESCE(t.date_mailed, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.date_mailed, TO_DATE('07/07/7777','mm/dd/yyyy'))            
            OR COALESCE(t.ship_by_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.ship_by_date, TO_DATE('07/07/7777','mm/dd/yyyy'))            
            OR COALESCE(t.language_id,'*') != COALESCE(tmp.language_id,'*')           
            OR COALESCE(t.packet_type,'*') != COALESCE(tmp.packet_type,'*')           
            OR COALESCE(t.packet_subtype,'*') != COALESCE(tmp.packet_subtype,'*')           
            OR COALESCE(t.booklet_type1,'*') != COALESCE(tmp.booklet_type1,'*')           
            OR COALESCE(t.booklet_type2,'*') != COALESCE(tmp.booklet_type2,'*')           
            OR COALESCE(t.ppd,'*') != COALESCE(tmp.ppd,'*')           
            OR COALESCE(t.packets_requested,0) != COALESCE(tmp.packets_requested,0)           
            OR COALESCE(t.case_id,'*') != COALESCE(tmp.case_id,'*')
            OR COALESCE(t.mail_status,'*') != COALESCE(tmp.mail_status,'*')           
            OR COALESCE(t.valid_flag,'*') != COALESCE(tmp.valid_flag,'*')           
            OR COALESCE(t.bad_address_transaction_type,'*') != COALESCE(tmp.bad_address_transaction_type,'*')           
            OR COALESCE(t.bad_address_record_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.bad_address_record_date, TO_DATE('07/07/7777','mm/dd/yyyy'))            
            OR COALESCE(t.bad_address_flag,'*') != COALESCE(tmp.bad_address_flag,'*')           
            OR COALESCE(t.modified_name,'*') != COALESCE(tmp.modified_by,'*')           
            OR COALESCE(t.modified_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.modified_date, TO_DATE('07/07/7777','mm/dd/yyyy'))    
          ) st ON (s.dp_packet_mail_id = st.dp_packet_mail_id)
    WHEN MATCHED THEN UPDATE
     SET s.vendor_received_date = st.vendor_received_date
        ,s.county_code = st.county_code
        ,s.custom_mailing_indicator = st.custom_mailing_indicator        
        ,s.job_id = st.job_id
        ,s.dcin = st.dcin
        ,s.date_requested = st.date_requested
        ,s.date_mailed = st.date_mailed
        ,s.ship_by_date = st.ship_by_date
        ,s.language_id = st.language_id
        ,s.packet_type = st.packet_type
        ,s.packet_subtype = st.packet_subtype
        ,s.booklet_type1 = st.booklet_type1
        ,s.booklet_type2 = st.booklet_type2
        ,s.ppd = st.ppd
        ,s.packets_requested = st.packets_requested
        ,s.case_id = st.case_id
        ,s.mail_status = st.mail_status
        ,s.valid_flag = st.valid_flag                 
        ,s.bad_address_transaction_type = st.bad_address_transaction_type
        ,s.bad_address_record_date = st.bad_address_record_date
        ,s.bad_address_flag = st.bad_address_flag
        ,s.modified_name = st.modified_name
        ,s.modified_date = st.modified_date
     Log Errors INTO Errlog_Packet_Mailing ('PACKET_MAILING_UPD') Reject Limit Unlimited;

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
    SELECT c_critical, con_pkg, 'CAHCO_MAILING_ETL_PKG.PACKET_MAILING_UPD', 1, Ora_Err_Mesg$, ora_err_number$, 'HCO_D_PACKET_MAILING', DIM_PACKET_MAILING_ID
    FROM Errlog_Packet_Mailing
    WHERE Ora_Err_Tag$ = 'PACKET_MAILING_UPD';

    v_err_cnt := SQL%RowCount;

    UPDATE CORP_ETL_JOB_STATISTICS
       SET ERROR_COUNT = v_err_cnt
         , RECORD_COUNT = record_count + v_err_cnt
         , PROCESSED_COUNT = processed_count + v_err_cnt
     WHERE JOB_ID =  v_job_id;
     
    COMMIT;
    
    PACKET_MAILING_BADADDR_UPD;

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, 'CAHCO_MAILING_ETL_PKG.PACKET_MAILING_UPD', 1, v_desc, v_code, 'HCO_D_PACKET_MAILING');

      COMMIT;
END PACKET_MAILING_UPD;

PROCEDURE LETTER_DETAIL_INS
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_ins_cnt number;
    v_err_cnt number;

BEGIN

    DELETE FROM Errlog_Letter_Detail WHERE ora_err_tag$ = 'LETTER_DETAIL_INS';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'LETTER_DETAIL_INS','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;
 
    INSERT /*+ Enable_Parallel_Dml Parallel */
      INTO HCO_D_LETTER_DETAIL (dim_mail_detail_id,
                       dcin,
                       cin,
                       letter_status,
                       plan_type,
                       enrollment_id,
                       exemption_id,
                       client_number,
                       record_date,
                       record_name,
                       modified_date,
                       modified_name,
                       spd_status,
                       maximus_status
                       )
     SELECT DimMailDetailsID
            ,DeIdentificationCIN
            ,CIN
            ,LetterStatus
            ,PlanType
            ,EnrollmentId
            ,ExemptionID
            ,BeneficiaryID
            ,RecordCreateDate
            ,RecordCreateName
            ,DateLastModified
            ,NameLastModified
            ,SpdStatus
            ,MaximusStatus
     FROM hco_s_letter_detail_stg s
     WHERE NOT EXISTS(SELECT 1 FROM hco_d_letter_detail m WHERE s.DimMailDetailsID = m.dim_mail_detail_id)
     LOG Errors INTO Errlog_Letter_Detail ('LETTER_DETAIL_INS') Reject Limit Unlimited;

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
    SELECT c_critical, con_pkg, 'CAHCO_MAILING_ETL_PKG.LETTER_DETAIL_INS', 1, Ora_Err_Mesg$, ora_err_number$, 'HCO_D_LETTER_DETAIL', DIM_MAIL_DETAIL_ID
      FROM Errlog_Letter_Detail
     WHERE Ora_Err_Tag$ = 'LETTER_DETAIL_INS';

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
      VALUES( c_critical, con_pkg, 'CAHCO_MAILING_ETL_PKG.LETTER_DETAIL_INS', 1, v_desc, v_code, 'HCO_D_LETTER_DETAIL');

      COMMIT;
END LETTER_DETAIL_INS;

PROCEDURE LETTER_DETAIL_UPD
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_Letter_Detail WHERE ora_err_tag$ = 'LETTER_DETAIL_UPD';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'LETTER_DETAIL_UPD','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

   MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  HCO_D_LETTER_DETAIL s
   USING (SELECT tmp.DimMailDetailsID
            ,tmp.DeIdentificationCIN
            ,tmp.CIN
            ,tmp.LetterStatus
            ,tmp.PlanType
            ,tmp.EnrollmentId
            ,tmp.ExemptionID
            ,tmp.BeneficiaryID
            ,tmp.RecordCreateDate
            ,tmp.RecordCreateName
            ,tmp.DateLastModified
            ,tmp.NameLastModified 
            ,tmp.SpdStatus
            ,tmp.MaximusStatus
            ,t.dim_mail_detail_id
     FROM hco_s_letter_detail_stg tmp     
          JOIN hco_d_letter_detail t ON tmp.DimMailDetailsID = t.dim_mail_detail_id
        WHERE COALESCE(t.dcin,'*') != COALESCE(tmp.DeIdentificationCIN,'*')      
         OR COALESCE(t.cin,'*') != COALESCE(tmp.cin,'*')
         OR COALESCE(t.letter_status,'*') != COALESCE(tmp.LetterStatus,'*')
         OR COALESCE(t.plan_type,'*') != COALESCE(tmp.PlanType,'*')
         OR COALESCE(t.spd_status,'*') != COALESCE(tmp.SpdStatus,'*')
         OR COALESCE(t.maximus_status,'*') != COALESCE(tmp.MaximusStatus,'*')
         OR COALESCE(t.enrollment_id,0) != COALESCE(tmp.EnrollmentId,0)
         OR COALESCE(t.exemption_id,0) != COALESCE(tmp.ExemptionID,0)
         OR COALESCE(t.client_number,0) != COALESCE(tmp.BeneficiaryID,0)        
         OR COALESCE(t.record_name,'*') != COALESCE(tmp.RecordCreateName,'*')           
         OR COALESCE(t.record_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.RecordCreateDate, TO_DATE('07/07/7777','mm/dd/yyyy'))    
         OR COALESCE(t.modified_name,'*') != COALESCE(tmp.NameLastModified,'*')           
         OR COALESCE(t.modified_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.DateLastModified, TO_DATE('07/07/7777','mm/dd/yyyy'))    
          ) st ON (s.dim_mail_detail_id = st.dim_mail_detail_id)
    WHEN MATCHED THEN UPDATE
     SET s.dcin = st.DeIdentificationCIN
         ,s.cin = st.cin
         ,s.letter_status = st.LetterStatus
         ,s.plan_type = st.PlanType
         ,s.enrollment_id = st.EnrollmentId
         ,s.exemption_id = st.ExemptionID
         ,s.client_number = st.BeneficiaryID
         ,s.record_name = st.RecordCreateName
         ,s.record_date = st.RecordCreateDate
         ,s.modified_name = st.NameLastModified
         ,s.modified_date = st.DateLastModified
         ,s.spd_status = st.SpdStatus
         ,s.maximus_status = st.MaximusStatus
     Log Errors INTO Errlog_Letter_Detail ('LETTER_DETAIL_UPD') Reject Limit Unlimited;

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
    SELECT c_critical, con_pkg, 'CAHCO_MAILING_ETL_PKG.LETTER_DETAIL_UPD', 1, Ora_Err_Mesg$, ora_err_number$, 'HCO_D_LETTER_DETAIL', DIM_MAIL_DETAIL_ID
    FROM Errlog_Letter_Detail
    WHERE Ora_Err_Tag$ = 'LETTER_DETAIL_UPD';

    v_err_cnt := SQL%RowCount;

    UPDATE CORP_ETL_JOB_STATISTICS
       SET ERROR_COUNT = v_err_cnt
         , RECORD_COUNT = record_count + v_err_cnt
         , PROCESSED_COUNT = processed_count + v_err_cnt
     WHERE JOB_ID =  v_job_id;
     
    COMMIT;

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, 'CAHCO_MAILING_ETL_PKG.LETTER_DETAIL_UPD', 1, v_desc, v_code, 'HCO_D_LETTER_DETAIL');

      COMMIT;
END LETTER_DETAIL_UPD;


END;
/


grant execute on CAHCO_MAILING_ETL_PKG to MAXDAT_READ_ONLY;

alter session set plsql_code_type = interpreted;