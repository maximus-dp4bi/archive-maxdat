alter session set plsql_code_type = native;

create or replace package EMRS_LAEB_CASE_CLIENT_ETL_PKG as


  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL: svn://svn-staging.maximus.com/dev1d/maxdat/BPM/CAHCO/createdb/EMRS/EMRS_CAHCO_ETL_PKG.sql $';
  SVN_REVISION varchar2(20) := '$Revision: 25758 $';
  SVN_REVISION_DATE varchar2(60) := '$Date: 2018-12-14 16:08:28 -0800 (Fri, 14 Dec 2018) $';
  SVN_REVISION_AUTHOR varchar2(20) := '$Author: fm18957 $';

  con_pkg       CONSTANT VARCHAR2(30) := $$PLSQL_UNIT;
  c_abort       CONSTANT corp_etl_error_log.err_level%TYPE := 'ABORT';
  c_critical    CONSTANT corp_etl_error_log.err_level%TYPE := 'CRITICAL';
  c_log         CONSTANT corp_etl_error_log.err_level%TYPE := 'LOG';
  c_one_sec     CONSTANT DECIMAL(10,5) := 1/(24*60*60); 
  c_time_format CONSTANT VARCHAR2(6) := 'HH24MI';

  PROCEDURE ADDRESS_INS;
  PROCEDURE ADDRESS_UPD;

  PROCEDURE PHONE_INS;
  PROCEDURE PHONE_UPD;

  PROCEDURE ALERT_INS;
  PROCEDURE ALERT_UPD;

  PROCEDURE CASE_INS;
  PROCEDURE CASE_UPD;

  PROCEDURE CLIENT_INS;
  PROCEDURE CLIENT_UPD;

  PROCEDURE CASE_CLIENT_INS;
  PROCEDURE CASE_CLIENT_UPD;
  
  PROCEDURE CLIENT_SUPPLEMENTARY_INFO_INS;
  PROCEDURE CLIENT_SUPPLEMENTARY_INFO_UPD;  
  
  PROCEDURE EMAIL_ADDRESS_INS;
  PROCEDURE EMAIL_ADDRESS_UPD;

END;
/

create or replace PACKAGE BODY        EMRS_LAEB_CASE_CLIENT_ETL_PKG AS

    v_code corp_etl_error_log.error_codes%TYPE;
    v_desc corp_etl_error_log.error_desc%TYPE;

PROCEDURE ADDRESS_INS
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_ins_cnt number;
    v_err_cnt number;
    to_process number := 0;
    Run_Multiple varchar2(1) := 'N';
BEGIN

    DELETE FROM Errlog_Address WHERE ora_err_tag$ = 'ADDRESS_INS';

    Maxdat_Statistics.TABLE_STATS('EMRS_S_ADDRESS_STG');

    SELECT COUNT(1) INTO to_process FROM EMRS_S_ADDRESS_STG;

    SELECT CASE WHEN to_process > NVL(Value,1000000)
                THEN 'Y' ELSE 'N' END INTO Run_Multiple
      FROM CORP_ETL_CONTROL WHERE NAME = 'EMRS_REC_THRESHOLD';

    IF Run_Multiple = 'N' THEN

        INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
        VALUES (SEQ_JOB_ID.Nextval, 'ADDRESS_INS','STARTED',SYSDATE)
        RETURNING JOB_ID INTO v_job_id;

        COMMIT;

        INSERT /*+ Enable_Parallel_Dml Parallel */
          INTO Emrs_D_Address   
                          (  
                              ADDR_ID
                            , ADDR_STREET_1
                            , ADDR_STREET_2
                            , ADDR_CITY
                            , ADDR_STATE_CD
                            , ADDR_ZIP
                            , ADDR_ZIP_FOUR
                            , ADDR_TYPE_CD
                            , ADDR_BEGIN_DATE
                            , ADDR_END_DATE
                            , ADDR_COUNTRY
                            , CLIENT_ID
                            , ADDR_ATTN
                            , ADDR_HOUSE_CODE
                            , ADDR_BAR_CODE
                            , ADDR_ORIGIN_CD
                            , ADDR_STAFF_ID
                            , ADDR_CTLK_ID
                            , ADDR_DOLK_ID
                            , ADDR_PROV_ID
                            , ADDR_PAYC_ID
                            , ADDR_VERIFIED
                            , ADDR_VERIFIED_DATE
                            , ADVY_ID
                            , ADDR_BAD_DATE
                            , ADDR_BAD_DATE_SATISFIED
                            , CASE_ID
                            , START_NDT
                            , END_NDT
                            , COMPARABLE_KEY
                            , RECORD_NAME
                            , RECORD_DATE
                            , RECORD_TIME
                            , MODIFIED_NAME
                            , MODIFIED_DATE
                            , MODIFIED_TIME
                        )
        SELECT                                              
                              ADDR_ID
                            , ADDR_STREET_1
                            , ADDR_STREET_2
                            , ADDR_CITY
                            , ADDR_STATE_CD
                            , ADDR_ZIP
                            , ADDR_ZIP_FOUR
                            , ADDR_TYPE_CD
                            , ADDR_BEGIN_DATE
                            , ADDR_END_DATE
                            , ADDR_COUNTRY
                            , CLNT_CLIENT_ID
                            , ADDR_ATTN
                            , ADDR_HOUSE_CODE
                            , ADDR_BAR_CODE
                            , ADDR_ORIGIN_CD
                            , ADDR_STAFF_ID
                            , ADDR_CTLK_ID
                            , ADDR_DOLK_ID
                            , ADDR_PROV_ID
                            , ADDR_PAYC_ID
                            , ADDR_VERIFIED
                            , ADDR_VERIFIED_DATE
                            , ADVY_ID
                            , ADDR_BAD_DATE
                            , ADDR_BAD_DATE_SATISFIED
                            , ADDR_CASE_ID
                            , START_NDT
                            , END_NDT
                            , COMPARABLE_KEY
                            , CREATED_BY
                            , CREATION_DATE
                            , TO_CHAR(CREATION_DATE, c_time_format)
                            , LAST_UPDATED_BY
                            , LAST_UPDATE_DATE
                            , TO_CHAR(LAST_UPDATE_DATE, c_time_format)                                                            
          FROM emrs_s_address_stg s
         WHERE NOT EXISTS (SELECT 1 FROM emrs_d_address C WHERE C.addr_id = S.addr_id)
           Log Errors INTO Errlog_Address ('ADDRESS_INS') Reject Limit Unlimited;

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
        SELECT c_critical, con_pkg, con_pkg || '.ADDRESS_INS', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_ADDRESS', ADDR_ID
          FROM Errlog_Address
         WHERE Ora_Err_Tag$ = 'ADDRESS_INS';

        v_err_cnt := SQL%RowCount;

        UPDATE CORP_ETL_JOB_STATISTICS
           SET ERROR_COUNT = v_err_cnt
             , RECORD_COUNT = v_ins_cnt + v_err_cnt
             , PROCESSED_COUNT = v_ins_cnt + v_err_cnt
         WHERE JOB_ID =  v_job_id;

        COMMIT;

    ELSE

       FOR IDX In 0..9
       LOOP

            Maxdat_Statistics.TABLE_STATS('EMRS_D_ADDRESS');

            INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
            VALUES (SEQ_JOB_ID.Nextval, 'ADDRESS_INS THREAD'||IDX,'STARTED',SYSDATE)
            RETURNING JOB_ID INTO v_job_id;

            COMMIT;

            INSERT /*+ Enable_Parallel_Dml Parallel */
              INTO Emrs_D_Address   
                              (  
                                  ADDR_ID
                                , ADDR_STREET_1
                                , ADDR_STREET_2
                                , ADDR_CITY
                                , ADDR_STATE_CD
                                , ADDR_ZIP
                                , ADDR_ZIP_FOUR
                                , ADDR_TYPE_CD
                                , ADDR_BEGIN_DATE
                                , ADDR_END_DATE
                                , ADDR_COUNTRY
                                , CLIENT_ID
                                , ADDR_ATTN
                                , ADDR_HOUSE_CODE
                                , ADDR_BAR_CODE
                                , ADDR_ORIGIN_CD
                                , ADDR_STAFF_ID
                                , ADDR_CTLK_ID
                                , ADDR_DOLK_ID
                                , ADDR_PROV_ID
                                , ADDR_PAYC_ID
                                , ADDR_VERIFIED
                                , ADDR_VERIFIED_DATE
                                , ADVY_ID
                                , ADDR_BAD_DATE
                                , ADDR_BAD_DATE_SATISFIED
                                , CASE_ID
                                , START_NDT
                                , END_NDT
                                , COMPARABLE_KEY
                                , RECORD_NAME
                                , RECORD_DATE
                                , RECORD_TIME
                                , MODIFIED_NAME
                                , MODIFIED_DATE
                                , MODIFIED_TIME
                            )
            SELECT                                              
                                  ADDR_ID
                                , ADDR_STREET_1
                                , ADDR_STREET_2
                                , ADDR_CITY
                                , ADDR_STATE_CD
                                , ADDR_ZIP
                                , ADDR_ZIP_FOUR
                                , ADDR_TYPE_CD
                                , ADDR_BEGIN_DATE
                                , ADDR_END_DATE
                                , ADDR_COUNTRY
                                , CLNT_CLIENT_ID
                                , ADDR_ATTN
                                , ADDR_HOUSE_CODE
                                , ADDR_BAR_CODE
                                , ADDR_ORIGIN_CD
                                , ADDR_STAFF_ID
                                , ADDR_CTLK_ID
                                , ADDR_DOLK_ID
                                , ADDR_PROV_ID
                                , ADDR_PAYC_ID
                                , ADDR_VERIFIED
                                , ADDR_VERIFIED_DATE
                                , ADVY_ID
                                , ADDR_BAD_DATE
                                , ADDR_BAD_DATE_SATISFIED
                                , ADDR_CASE_ID
                                , START_NDT
                                , END_NDT
                                , COMPARABLE_KEY
                                , CREATED_BY
                                , CREATION_DATE
                                , TO_CHAR(CREATION_DATE, c_time_format)
                                , LAST_UPDATED_BY
                                , LAST_UPDATE_DATE
                                , TO_CHAR(LAST_UPDATE_DATE, c_time_format)                                                            
              FROM emrs_s_address_stg s
             WHERE SUBSTR(S.ADDR_ID,-1) = IDX
               AND NOT EXISTS (SELECT 1 FROM emrs_d_address C WHERE C.addr_id = S.addr_id)
               Log Errors INTO Errlog_Address ('ADDRESS_INS') Reject Limit Unlimited;

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
            SELECT c_critical, con_pkg, con_pkg || '.ADDRESS_INS', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_ADDRESS', ADDR_ID
              FROM Errlog_Address
             WHERE Ora_Err_Tag$ = 'ADDRESS_INS';

            v_err_cnt := SQL%RowCount;

            UPDATE CORP_ETL_JOB_STATISTICS
               SET ERROR_COUNT = v_err_cnt
                 , RECORD_COUNT = v_ins_cnt + v_err_cnt
                 , PROCESSED_COUNT = v_ins_cnt + v_err_cnt
             WHERE JOB_ID =  v_job_id;

            DELETE FROM Errlog_Address WHERE ora_err_tag$ = 'ADDRESS_INS';

            COMMIT;

       END LOOP;

    END IF;

    Maxdat_Statistics.TABLE_STATS('EMRS_D_ADDRESS');

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, con_pkg || '.ADDRESS_INS', 1, v_desc, v_code, 'EMRS_D_ADDRESS');

      COMMIT;

END ADDRESS_INS;

PROCEDURE ADDRESS_UPD
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
    to_process number := 0;
    Run_Multiple varchar2(1) := 'N';
BEGIN

    DELETE FROM Errlog_Address WHERE ora_err_tag$ = 'ADDRESS_UPD';

    Maxdat_Statistics.TABLE_STATS('EMRS_S_ADDRESS_STG');

    SELECT COUNT(1) INTO to_process FROM EMRS_S_ADDRESS_STG;

    SELECT CASE WHEN to_process > NVL(Value,1000000)
                THEN 'Y' ELSE 'N' END INTO Run_Multiple
      FROM CORP_ETL_CONTROL WHERE NAME = 'EMRS_REC_THRESHOLD';

    IF Run_Multiple = 'N' THEN

       INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
       VALUES (SEQ_JOB_ID.Nextval, 'ADDRESS_UPD','STARTED',SYSDATE)
       RETURNING JOB_ID INTO v_job_id;

       COMMIT;

       Maxdat_Statistics.TABLE_STATS('EMRS_D_ADDRESS');

       MERGE /*+ Enable_Parallel_Dml Parallel */
        INTO  EMRS_D_ADDRESS D
       USING ( 
                SELECT                
                          s.ADDR_ID
                        , s.ADDR_STREET_1
                        , s.ADDR_STREET_2
                        , s.ADDR_CITY
                        , s.ADDR_STATE_CD
                        , s.ADDR_ZIP
                        , s.ADDR_ZIP_FOUR
                        , s.ADDR_TYPE_CD
                        , s.ADDR_BEGIN_DATE
                        , s.ADDR_END_DATE
                        , s.ADDR_COUNTRY
                        , s.CLNT_CLIENT_ID
                        , s.ADDR_ATTN
                        , s.ADDR_HOUSE_CODE
                        , s.ADDR_BAR_CODE
                        , s.ADDR_ORIGIN_CD
                        , s.ADDR_STAFF_ID
                        , s.ADDR_CTLK_ID
                        , s.ADDR_DOLK_ID
                        , s.ADDR_PROV_ID
                        , s.ADDR_PAYC_ID
                        , s.ADDR_VERIFIED
                        , s.ADDR_VERIFIED_DATE
                        , s.ADVY_ID
                        , s.ADDR_BAD_DATE
                        , s.ADDR_BAD_DATE_SATISFIED
                        , s.ADDR_CASE_ID
                        , s.START_NDT
                        , s.END_NDT
                        , s.COMPARABLE_KEY
                        , s.CREATED_BY                                  AS  RECORD_NAME
                        , s.CREATION_DATE                               AS  RECORD_DATE
                        , TO_CHAR(s.CREATION_DATE, c_time_format)       AS  RECORD_TIME
                        , s.LAST_UPDATED_BY                             AS  MODIFIED_NAME
                        , s.LAST_UPDATE_DATE                            AS  MODIFIED_DATE
                        , TO_CHAR(s.LAST_UPDATE_DATE, c_time_format)    AS  MODIFIED_TIME
                 FROM EMRS_D_ADDRESS D, EMRS_S_ADDRESS_STG S
                WHERE D.ADDR_ID = S.ADDR_ID
              ) C ON (D.ADDR_ID = C.ADDR_ID)
        WHEN MATCHED THEN UPDATE
         SET                                        
                          d.ADDR_STREET_1                           =   c.ADDR_STREET_1
                        , d.ADDR_STREET_2                           =   c.ADDR_STREET_2
                        , d.ADDR_CITY                               =   c.ADDR_CITY
                        , d.ADDR_STATE_CD                           =   c.ADDR_STATE_CD
                        , d.ADDR_ZIP                                =   c.ADDR_ZIP
                        , d.ADDR_ZIP_FOUR                           =   c.ADDR_ZIP_FOUR
                        , d.ADDR_TYPE_CD                            =   c.ADDR_TYPE_CD
                        , d.ADDR_BEGIN_DATE                         =   c.ADDR_BEGIN_DATE
                        , d.ADDR_END_DATE                           =   c.ADDR_END_DATE
                        , d.ADDR_COUNTRY                            =   c.ADDR_COUNTRY
                        , d.CLIENT_ID                               =   c.CLNT_CLIENT_ID
                        , d.ADDR_ATTN                               =   c.ADDR_ATTN
                        , d.ADDR_HOUSE_CODE                         =   c.ADDR_HOUSE_CODE
                        , d.ADDR_BAR_CODE                           =   c.ADDR_BAR_CODE
                        , d.ADDR_ORIGIN_CD                          =   c.ADDR_ORIGIN_CD
                        , d.ADDR_STAFF_ID                           =   c.ADDR_STAFF_ID
                        , d.ADDR_CTLK_ID                            =   c.ADDR_CTLK_ID
                        , d.ADDR_DOLK_ID                            =   c.ADDR_DOLK_ID
                        , d.ADDR_PROV_ID                            =   c.ADDR_PROV_ID
                        , d.ADDR_PAYC_ID                            =   c.ADDR_PAYC_ID
                        , d.ADDR_VERIFIED                           =   c.ADDR_VERIFIED
                        , d.ADDR_VERIFIED_DATE                      =   c.ADDR_VERIFIED_DATE
                        , d.ADVY_ID                                 =   c.ADVY_ID
                        , d.ADDR_BAD_DATE                           =   c.ADDR_BAD_DATE
                        , d.ADDR_BAD_DATE_SATISFIED                 =   c.ADDR_BAD_DATE_SATISFIED
                        , d.CASE_ID                                 =   c.ADDR_CASE_ID
                        , d.START_NDT                               =   c.START_NDT
                        , d.END_NDT                                 =   c.END_NDT
                        , d.COMPARABLE_KEY                          =   c.COMPARABLE_KEY
                        , d.RECORD_NAME                             =   c.RECORD_NAME
                        , d.RECORD_DATE                             =   c.RECORD_DATE
                        , d.RECORD_TIME                             =   c.RECORD_TIME
                        , d.MODIFIED_NAME                           =   c.MODIFIED_NAME
                        , d.MODIFIED_DATE                           =   c.MODIFIED_DATE
                        , d.MODIFIED_TIME                           =   c.MODIFIED_TIME
         Log Errors INTO Errlog_Address ('ADDRESS_UPD') Reject Limit Unlimited;

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
        SELECT c_critical, con_pkg, con_pkg || '.ADDRESS_UPD', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_ADDRESS', ADDR_ID
          FROM Errlog_Address
         WHERE Ora_Err_Tag$ = 'ADDRESS_UPD';

        v_err_cnt := SQL%RowCount;

        UPDATE CORP_ETL_JOB_STATISTICS
           SET ERROR_COUNT = v_err_cnt
             , RECORD_COUNT = v_upd_cnt + v_err_cnt
             , PROCESSED_COUNT = v_upd_cnt + v_err_cnt
         WHERE JOB_ID =  v_job_id;

        COMMIT;

    ELSE

       FOR IDX In 0..9
       LOOP
           Maxdat_Statistics.TABLE_STATS('EMRS_D_ADDRESS');

           INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
           VALUES (SEQ_JOB_ID.Nextval, 'ADDRESS_UPD THREAD'||IDX,'STARTED',SYSDATE)
           RETURNING JOB_ID INTO v_job_id;

           COMMIT;

           MERGE /*+ Enable_Parallel_Dml Parallel */
            INTO  EMRS_D_ADDRESS D
           USING ( 
                    SELECT                
                              s.ADDR_ID
                            , s.ADDR_STREET_1
                            , s.ADDR_STREET_2
                            , s.ADDR_CITY
                            , s.ADDR_STATE_CD
                            , s.ADDR_ZIP
                            , s.ADDR_ZIP_FOUR
                            , s.ADDR_TYPE_CD
                            , s.ADDR_BEGIN_DATE
                            , s.ADDR_END_DATE
                            , s.ADDR_COUNTRY
                            , s.CLNT_CLIENT_ID
                            , s.ADDR_ATTN
                            , s.ADDR_HOUSE_CODE
                            , s.ADDR_BAR_CODE
                            , s.ADDR_ORIGIN_CD
                            , s.ADDR_STAFF_ID
                            , s.ADDR_CTLK_ID
                            , s.ADDR_DOLK_ID
                            , s.ADDR_PROV_ID
                            , s.ADDR_PAYC_ID
                            , s.ADDR_VERIFIED
                            , s.ADDR_VERIFIED_DATE
                            , s.ADVY_ID
                            , s.ADDR_BAD_DATE
                            , s.ADDR_BAD_DATE_SATISFIED
                            , s.ADDR_CASE_ID
                            , s.START_NDT
                            , s.END_NDT
                            , s.COMPARABLE_KEY
                            , s.CREATED_BY                                  AS  RECORD_NAME
                            , s.CREATION_DATE                               AS  RECORD_DATE
                            , TO_CHAR(s.CREATION_DATE, c_time_format)       AS  RECORD_TIME
                            , s.LAST_UPDATED_BY                             AS  MODIFIED_NAME
                            , s.LAST_UPDATE_DATE                            AS  MODIFIED_DATE
                            , TO_CHAR(s.LAST_UPDATE_DATE, c_time_format)    AS  MODIFIED_TIME
                     FROM EMRS_D_ADDRESS D, EMRS_S_ADDRESS_STG S
                    WHERE D.ADDR_ID = S.ADDR_ID
                      AND SUBSTR(S.ADDR_ID,-1) = IDX                    
                  ) C ON (D.ADDR_ID = C.ADDR_ID)
            WHEN MATCHED THEN UPDATE
             SET                                        
                              d.ADDR_STREET_1                           =   c.ADDR_STREET_1
                            , d.ADDR_STREET_2                           =   c.ADDR_STREET_2
                            , d.ADDR_CITY                               =   c.ADDR_CITY
                            , d.ADDR_STATE_CD                           =   c.ADDR_STATE_CD
                            , d.ADDR_ZIP                                =   c.ADDR_ZIP
                            , d.ADDR_ZIP_FOUR                           =   c.ADDR_ZIP_FOUR
                            , d.ADDR_TYPE_CD                            =   c.ADDR_TYPE_CD
                            , d.ADDR_BEGIN_DATE                         =   c.ADDR_BEGIN_DATE
                            , d.ADDR_END_DATE                           =   c.ADDR_END_DATE
                            , d.ADDR_COUNTRY                            =   c.ADDR_COUNTRY
                            , d.CLIENT_ID                               =   c.CLNT_CLIENT_ID
                            , d.ADDR_ATTN                               =   c.ADDR_ATTN
                            , d.ADDR_HOUSE_CODE                         =   c.ADDR_HOUSE_CODE
                            , d.ADDR_BAR_CODE                           =   c.ADDR_BAR_CODE
                            , d.ADDR_ORIGIN_CD                          =   c.ADDR_ORIGIN_CD
                            , d.ADDR_STAFF_ID                           =   c.ADDR_STAFF_ID
                            , d.ADDR_CTLK_ID                            =   c.ADDR_CTLK_ID
                            , d.ADDR_DOLK_ID                            =   c.ADDR_DOLK_ID
                            , d.ADDR_PROV_ID                            =   c.ADDR_PROV_ID
                            , d.ADDR_PAYC_ID                            =   c.ADDR_PAYC_ID
                            , d.ADDR_VERIFIED                           =   c.ADDR_VERIFIED
                            , d.ADDR_VERIFIED_DATE                      =   c.ADDR_VERIFIED_DATE
                            , d.ADVY_ID                                 =   c.ADVY_ID
                            , d.ADDR_BAD_DATE                           =   c.ADDR_BAD_DATE
                            , d.ADDR_BAD_DATE_SATISFIED                 =   c.ADDR_BAD_DATE_SATISFIED
                            , d.CASE_ID                                 =   c.ADDR_CASE_ID
                            , d.START_NDT                               =   c.START_NDT
                            , d.END_NDT                                 =   c.END_NDT
                            , d.COMPARABLE_KEY                          =   c.COMPARABLE_KEY
                            , d.RECORD_NAME                             =   c.RECORD_NAME
                            , d.RECORD_DATE                             =   c.RECORD_DATE
                            , d.RECORD_TIME                             =   c.RECORD_TIME
                            , d.MODIFIED_NAME                           =   c.MODIFIED_NAME
                            , d.MODIFIED_DATE                           =   c.MODIFIED_DATE
                            , d.MODIFIED_TIME                           =   c.MODIFIED_TIME
             Log Errors INTO Errlog_Address ('ADDRESS_UPD') Reject Limit Unlimited;

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
            SELECT c_critical, con_pkg, con_pkg || '.ADDRESS_UPD', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_ADDRESS', ADDR_ID
              FROM Errlog_Address
             WHERE Ora_Err_Tag$ = 'ADDRESS_UPD';

            v_err_cnt := SQL%RowCount;

            UPDATE CORP_ETL_JOB_STATISTICS
               SET ERROR_COUNT = v_err_cnt
                 , RECORD_COUNT = v_upd_cnt + v_err_cnt
                 , PROCESSED_COUNT = v_upd_cnt + v_err_cnt
             WHERE JOB_ID =  v_job_id;

            DELETE FROM Errlog_Address WHERE ora_err_tag$ = 'ADDRESS_UPD';

            COMMIT;

       END LOOP;

    END IF;

    Maxdat_Statistics.TABLE_STATS('EMRS_D_ADDRESS');

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, con_pkg || '.ADDRESS_UPD', 1, v_desc, v_code, 'EMRS_D_ADDRESS');

      COMMIT;

END ADDRESS_UPD;

PROCEDURE PHONE_INS
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_ins_cnt number;
    v_err_cnt number;
    to_process number := 0;
    Run_Multiple varchar2(1) := 'N';
BEGIN

    DELETE FROM Errlog_Phone WHERE ora_err_tag$ = 'PHONE_INS';

    Maxdat_Statistics.TABLE_STATS('EMRS_S_PHONE_STG');

    SELECT COUNT(1) INTO to_process FROM EMRS_S_PHONE_STG;

    SELECT CASE WHEN to_process > NVL(Value,1000000)
                THEN 'Y' ELSE 'N' END INTO Run_Multiple
      FROM CORP_ETL_CONTROL WHERE NAME = 'EMRS_REC_THRESHOLD';

    IF Run_Multiple = 'N' THEN

        INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
        VALUES (SEQ_JOB_ID.Nextval, 'PHONE_INS','STARTED',SYSDATE)
        RETURNING JOB_ID INTO v_job_id;

        COMMIT;

        INSERT /*+ Enable_Parallel_Dml Parallel */
          INTO Emrs_D_Phone (  
                              PHONE_ID
                            , PHON_BEGIN_DATE
                            , PHON_TYPE_CD
                            , PHON_END_DATE
                            , CLIENT_ID
                            , PHON_AREA_CODE
                            , PHON_PHONE_NUMBER
                            , PHON_EXT
                            , PHON_PROV_ID
                            , PHON_CNTT_ID
                            , PHON_DOLK_ID
                            , CASE_ID
                            , START_NDT
                            , END_NDT
                            , PHON_CARRIER_INFO
                            , SMS_ENABLED_IND
                            , PHON_BAD_DATE
                            , PHON_BAD_DATE_SATISFIED
                            , CONTACT_METHOD_FAX_IND
                            , COMPARABLE_KEY                            
                            , RECORD_NAME
                            , RECORD_DATE
                            , RECORD_TIME
                            , MODIFIED_NAME
                            , MODIFIED_DATE
                            , MODIFIED_TIME
                        )
        SELECT                                              
                              PHON_ID
                            , PHON_BEGIN_DATE
                            , PHON_TYPE_CD
                            , PHON_END_DATE
                            , CLNT_CLIENT_ID
                            , PHON_AREA_CODE
                            , PHON_PHONE_NUMBER
                            , PHON_EXT
                            , PHON_PROV_ID
                            , PHON_CNTT_ID
                            , PHON_DOLK_ID
                            , PHON_CASE_ID
                            , START_NDT
                            , END_NDT
                            , PHON_CARRIER_INFO
                            , SMS_ENABLED_IND
                            , PHON_BAD_DATE
                            , PHON_BAD_DATE_SATISFIED
                            , CONTACT_METHOD_FAX_IND
                            , COMPARABLE_KEY                            
                            , CREATED_BY
                            , CREATION_DATE
                            , TO_CHAR(CREATION_DATE, c_time_format)
                            , LAST_UPDATED_BY
                            , LAST_UPDATE_DATE
                            , TO_CHAR(LAST_UPDATE_DATE, c_time_format)                                                            
          FROM emrs_s_phone_stg s
         WHERE NOT EXISTS (SELECT 1 FROM emrs_d_phone C WHERE C.phone_id = S.phon_id)
           Log Errors INTO Errlog_Phone ('PHONE_INS') Reject Limit Unlimited;

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
        SELECT c_critical, con_pkg, con_pkg || '.PHONE_INS', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_PHONE', PHONE_ID
          FROM Errlog_Phone
         WHERE Ora_Err_Tag$ = 'PHONE_INS';

        v_err_cnt := SQL%RowCount;

        UPDATE CORP_ETL_JOB_STATISTICS
           SET ERROR_COUNT = v_err_cnt
             , RECORD_COUNT = v_ins_cnt + v_err_cnt
             , PROCESSED_COUNT = v_ins_cnt + v_err_cnt
         WHERE JOB_ID =  v_job_id;

        COMMIT;

    ELSE

       FOR IDX In 0..9
       LOOP

            Maxdat_Statistics.TABLE_STATS('EMRS_D_PHONE');

            INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
            VALUES (SEQ_JOB_ID.Nextval, 'PHONE_INS THREAD'||IDX,'STARTED',SYSDATE)
            RETURNING JOB_ID INTO v_job_id;

            COMMIT;

            INSERT /*+ Enable_Parallel_Dml Parallel */
              INTO Emrs_D_Phone (  
                                  PHONE_ID
                                , PHON_BEGIN_DATE
                                , PHON_TYPE_CD
                                , PHON_END_DATE
                                , CLIENT_ID
                                , PHON_AREA_CODE
                                , PHON_PHONE_NUMBER
                                , PHON_EXT
                                , PHON_PROV_ID
                                , PHON_CNTT_ID
                                , PHON_DOLK_ID
                                , CASE_ID
                                , START_NDT
                                , END_NDT
                                , PHON_CARRIER_INFO
                                , SMS_ENABLED_IND
                                , PHON_BAD_DATE
                                , PHON_BAD_DATE_SATISFIED
                                , CONTACT_METHOD_FAX_IND
                                , COMPARABLE_KEY                            
                                , RECORD_NAME
                                , RECORD_DATE
                                , RECORD_TIME
                                , MODIFIED_NAME
                                , MODIFIED_DATE
                                , MODIFIED_TIME
                            )
            SELECT                                              
                                  PHON_ID
                                , PHON_BEGIN_DATE
                                , PHON_TYPE_CD
                                , PHON_END_DATE
                                , CLNT_CLIENT_ID
                                , PHON_AREA_CODE
                                , PHON_PHONE_NUMBER
                                , PHON_EXT
                                , PHON_PROV_ID
                                , PHON_CNTT_ID
                                , PHON_DOLK_ID
                                , PHON_CASE_ID
                                , START_NDT
                                , END_NDT
                                , PHON_CARRIER_INFO
                                , SMS_ENABLED_IND
                                , PHON_BAD_DATE
                                , PHON_BAD_DATE_SATISFIED
                                , CONTACT_METHOD_FAX_IND
                                , COMPARABLE_KEY                            
                                , CREATED_BY
                                , CREATION_DATE
                                , TO_CHAR(CREATION_DATE, c_time_format)
                                , LAST_UPDATED_BY
                                , LAST_UPDATE_DATE
                                , TO_CHAR(LAST_UPDATE_DATE, c_time_format)                                                            
              FROM emrs_s_phone_stg s
             WHERE SUBSTR(S.PHON_ID,-1) = IDX
               AND NOT EXISTS (SELECT 1 FROM emrs_d_phone C WHERE C.phone_id = S.phon_id)
               Log Errors INTO Errlog_Phone ('PHONE_INS') Reject Limit Unlimited;

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
            SELECT c_critical, con_pkg, con_pkg || '.PHONE_INS', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_PHONE', PHONE_ID
              FROM Errlog_Phone
             WHERE Ora_Err_Tag$ = 'PHONE_INS';

            v_err_cnt := SQL%RowCount;

            UPDATE CORP_ETL_JOB_STATISTICS
               SET ERROR_COUNT = v_err_cnt
                 , RECORD_COUNT = v_ins_cnt + v_err_cnt
                 , PROCESSED_COUNT = v_ins_cnt + v_err_cnt
             WHERE JOB_ID =  v_job_id;

            DELETE FROM Errlog_Phone WHERE ora_err_tag$ = 'PHONE_INS';

            COMMIT;

       END LOOP;

    END IF;

    Maxdat_Statistics.TABLE_STATS('EMRS_D_PHONE');

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, con_pkg || '.PHONE_INS', 1, v_desc, v_code, 'EMRS_D_PHONE');

      COMMIT;
END PHONE_INS;

PROCEDURE PHONE_UPD
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
    to_process number := 0;
    Run_Multiple varchar2(1) := 'N';
BEGIN

    DELETE FROM Errlog_Phone WHERE ora_err_tag$ = 'PHONE_UPD';

    Maxdat_Statistics.TABLE_STATS('EMRS_S_PHONE_STG');

    SELECT COUNT(1) INTO to_process FROM EMRS_S_PHONE_STG;

    SELECT CASE WHEN to_process > NVL(Value,1000000)
                THEN 'Y' ELSE 'N' END INTO Run_Multiple
      FROM CORP_ETL_CONTROL WHERE NAME = 'EMRS_REC_THRESHOLD';

    IF Run_Multiple = 'N' THEN

       INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
       VALUES (SEQ_JOB_ID.Nextval, 'PHONE_UPD','STARTED',SYSDATE)
       RETURNING JOB_ID INTO v_job_id;

       COMMIT;

       Maxdat_Statistics.TABLE_STATS('EMRS_D_PHONE');

       MERGE /*+ Enable_Parallel_Dml Parallel */
        INTO  EMRS_D_PHONE D
       USING ( 
                SELECT                
                          s.PHON_ID
                        , s.PHON_BEGIN_DATE
                        , s.PHON_TYPE_CD
                        , s.PHON_END_DATE
                        , s.CLNT_CLIENT_ID
                        , s.PHON_AREA_CODE
                        , s.PHON_PHONE_NUMBER
                        , s.PHON_EXT
                        , s.PHON_PROV_ID
                        , s.PHON_CNTT_ID
                        , s.PHON_DOLK_ID
                        , s.PHON_CASE_ID
                        , s.START_NDT
                        , s.END_NDT
                        , s.PHON_CARRIER_INFO
                        , s.SMS_ENABLED_IND
                        , s.PHON_BAD_DATE
                        , s.PHON_BAD_DATE_SATISFIED
                        , s.CONTACT_METHOD_FAX_IND
                        , s.COMPARABLE_KEY                            
                        , s.CREATED_BY                                  AS  RECORD_NAME
                        , s.CREATION_DATE                               AS  RECORD_DATE
                        , TO_CHAR(s.CREATION_DATE, c_time_format)       AS  RECORD_TIME
                        , s.LAST_UPDATED_BY                             AS  MODIFIED_NAME
                        , s.LAST_UPDATE_DATE                            AS  MODIFIED_DATE
                        , TO_CHAR(s.LAST_UPDATE_DATE, c_time_format)    AS  MODIFIED_TIME
                 FROM EMRS_D_PHONE D, EMRS_S_PHONE_STG S
                WHERE D.PHONE_ID = S.PHON_ID
              ) C ON (D.PHONE_ID = C.PHON_ID)
        WHEN MATCHED THEN UPDATE
         SET              d.PHON_BEGIN_DATE                         =   c.PHON_BEGIN_DATE
                        , d.PHON_TYPE_CD                            =   c.PHON_TYPE_CD
                        , d.PHON_END_DATE                           =   c.PHON_END_DATE
                        , d.CLIENT_ID                               =   c.CLNT_CLIENT_ID
                        , d.PHON_AREA_CODE                          =   c.PHON_AREA_CODE
                        , d.PHON_PHONE_NUMBER                       =   c.PHON_PHONE_NUMBER
                        , d.PHON_EXT                                =   c.PHON_EXT
                        , d.PHON_PROV_ID                            =   c.PHON_PROV_ID
                        , d.PHON_CNTT_ID                            =   c.PHON_CNTT_ID
                        , d.PHON_DOLK_ID                            =   c.PHON_DOLK_ID
                        , d.CASE_ID                                 =   c.PHON_CASE_ID
                        , d.START_NDT                               =   c.START_NDT
                        , d.END_NDT                                 =   c.END_NDT
                        , d.PHON_CARRIER_INFO                       =   c.PHON_CARRIER_INFO
                        , d.SMS_ENABLED_IND                         =   c.SMS_ENABLED_IND
                        , d.PHON_BAD_DATE                           =   c.PHON_BAD_DATE
                        , d.PHON_BAD_DATE_SATISFIED                 =   c.PHON_BAD_DATE_SATISFIED
                        , d.CONTACT_METHOD_FAX_IND                  =   c.CONTACT_METHOD_FAX_IND
                        , d.COMPARABLE_KEY                          =   c.COMPARABLE_KEY                            
                        , d.RECORD_NAME                             =   c.RECORD_NAME
                        , d.RECORD_DATE                             =   c.RECORD_DATE
                        , d.RECORD_TIME                             =   c.RECORD_TIME
                        , d.MODIFIED_NAME                           =   c.MODIFIED_NAME
                        , d.MODIFIED_DATE                           =   c.MODIFIED_DATE
                        , d.MODIFIED_TIME                           =   c.MODIFIED_TIME
         Log Errors INTO Errlog_Phone ('PHONE_UPD') Reject Limit Unlimited;

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
        SELECT c_critical, con_pkg, con_pkg || '.PHONE_UPD', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_PHONE', PHONE_ID
          FROM Errlog_Phone
         WHERE Ora_Err_Tag$ = 'PHONE_UPD';

        v_err_cnt := SQL%RowCount;

        UPDATE CORP_ETL_JOB_STATISTICS
           SET ERROR_COUNT = v_err_cnt
             , RECORD_COUNT = v_upd_cnt + v_err_cnt
             , PROCESSED_COUNT = v_upd_cnt + v_err_cnt
         WHERE JOB_ID =  v_job_id;

        COMMIT;

    ELSE

       FOR IDX In 0..9
       LOOP
           Maxdat_Statistics.TABLE_STATS('EMRS_D_PHONE');

           INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
           VALUES (SEQ_JOB_ID.Nextval, 'PHONE_UPD THREAD'||IDX,'STARTED',SYSDATE)
           RETURNING JOB_ID INTO v_job_id;

           COMMIT;

           MERGE /*+ Enable_Parallel_Dml Parallel */
            INTO  EMRS_D_PHONE D
           USING ( 
                    SELECT                
                              s.PHON_ID
                            , s.PHON_BEGIN_DATE
                            , s.PHON_TYPE_CD
                            , s.PHON_END_DATE
                            , s.CLNT_CLIENT_ID
                            , s.PHON_AREA_CODE
                            , s.PHON_PHONE_NUMBER
                            , s.PHON_EXT
                            , s.PHON_PROV_ID
                            , s.PHON_CNTT_ID
                            , s.PHON_DOLK_ID
                            , s.PHON_CASE_ID
                            , s.START_NDT
                            , s.END_NDT
                            , s.PHON_CARRIER_INFO
                            , s.SMS_ENABLED_IND
                            , s.PHON_BAD_DATE
                            , s.PHON_BAD_DATE_SATISFIED
                            , s.CONTACT_METHOD_FAX_IND
                            , s.COMPARABLE_KEY                            
                            , s.CREATED_BY                                  AS  RECORD_NAME
                            , s.CREATION_DATE                               AS  RECORD_DATE
                            , TO_CHAR(s.CREATION_DATE, c_time_format)       AS  RECORD_TIME
                            , s.LAST_UPDATED_BY                             AS  MODIFIED_NAME
                            , s.LAST_UPDATE_DATE                            AS  MODIFIED_DATE
                            , TO_CHAR(s.LAST_UPDATE_DATE, c_time_format)    AS  MODIFIED_TIME
                     FROM EMRS_D_PHONE D, EMRS_S_PHONE_STG S
                    WHERE D.PHONE_ID = S.PHON_ID
                      AND SUBSTR(S.PHON_ID,-1) = IDX
                  ) C ON (D.PHONE_ID = C.PHON_ID)
            WHEN MATCHED THEN UPDATE
             SET              d.PHON_BEGIN_DATE                         =   c.PHON_BEGIN_DATE
                            , d.PHON_TYPE_CD                            =   c.PHON_TYPE_CD
                            , d.PHON_END_DATE                           =   c.PHON_END_DATE
                            , d.CLIENT_ID                               =   c.CLNT_CLIENT_ID
                            , d.PHON_AREA_CODE                          =   c.PHON_AREA_CODE
                            , d.PHON_PHONE_NUMBER                       =   c.PHON_PHONE_NUMBER
                            , d.PHON_EXT                                =   c.PHON_EXT
                            , d.PHON_PROV_ID                            =   c.PHON_PROV_ID
                            , d.PHON_CNTT_ID                            =   c.PHON_CNTT_ID
                            , d.PHON_DOLK_ID                            =   c.PHON_DOLK_ID
                            , d.CASE_ID                                 =   c.PHON_CASE_ID
                            , d.START_NDT                               =   c.START_NDT
                            , d.END_NDT                                 =   c.END_NDT
                            , d.PHON_CARRIER_INFO                       =   c.PHON_CARRIER_INFO
                            , d.SMS_ENABLED_IND                         =   c.SMS_ENABLED_IND
                            , d.PHON_BAD_DATE                           =   c.PHON_BAD_DATE
                            , d.PHON_BAD_DATE_SATISFIED                 =   c.PHON_BAD_DATE_SATISFIED
                            , d.CONTACT_METHOD_FAX_IND                  =   c.CONTACT_METHOD_FAX_IND
                            , d.COMPARABLE_KEY                          =   c.COMPARABLE_KEY                            
                            , d.RECORD_NAME                             =   c.RECORD_NAME
                            , d.RECORD_DATE                             =   c.RECORD_DATE
                            , d.RECORD_TIME                             =   c.RECORD_TIME
                            , d.MODIFIED_NAME                           =   c.MODIFIED_NAME
                            , d.MODIFIED_DATE                           =   c.MODIFIED_DATE
                            , d.MODIFIED_TIME                           =   c.MODIFIED_TIME
             Log Errors INTO Errlog_Phone ('PHONE_UPD') Reject Limit Unlimited;

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
            SELECT c_critical, con_pkg, con_pkg || '.PHONE_UPD', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_PHONE', PHONE_ID
              FROM Errlog_Phone
             WHERE Ora_Err_Tag$ = 'PHONE_UPD';

            v_err_cnt := SQL%RowCount;

            UPDATE CORP_ETL_JOB_STATISTICS
               SET ERROR_COUNT = v_err_cnt
                 , RECORD_COUNT = v_upd_cnt + v_err_cnt
                 , PROCESSED_COUNT = v_upd_cnt + v_err_cnt
             WHERE JOB_ID =  v_job_id;

            DELETE FROM Errlog_Phone WHERE ora_err_tag$ = 'PHONE_UPD';

            COMMIT;

       END LOOP;

    END IF;

    Maxdat_Statistics.TABLE_STATS('EMRS_D_PHONE');

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, con_pkg || '.PHONE_UPD', 1, v_desc, v_code, 'EMRS_D_PHONE');

      COMMIT;

END PHONE_UPD;

PROCEDURE ALERT_INS
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_ins_cnt number;
    v_err_cnt number;
    to_process number := 0;
    Run_Multiple varchar2(1) := 'N';
BEGIN

    DELETE FROM Errlog_Alert WHERE ora_err_tag$ = 'ALERT_INS';

    Maxdat_Statistics.TABLE_STATS('EMRS_S_ALERT_STG');

    SELECT COUNT(1) INTO to_process FROM EMRS_S_ALERT_STG;

    SELECT CASE WHEN to_process > NVL(Value,1000000)
                THEN 'Y' ELSE 'N' END INTO Run_Multiple
      FROM CORP_ETL_CONTROL WHERE NAME = 'EMRS_REC_THRESHOLD';

    IF Run_Multiple = 'N' THEN

        INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
        VALUES (SEQ_JOB_ID.Nextval, 'ALERT_INS','STARTED',SYSDATE)
        RETURNING JOB_ID INTO v_job_id;

        COMMIT;

        INSERT /*+ Enable_Parallel_Dml Parallel */
          INTO Emrs_D_Alert (  
                              ALERT_ID
                            , CASE_ID
                            , CLIENT_ID
                            , MESSAGE
                            , START_DATE
                            , END_DATE
                            , VOID_IND
                            , SYSTEM_ALERT_IND
                            , REF_TYPE
                            , REF_ID
                            , LOCK_ID
                            , RECORD_COUNT
                            , ALERT_HANDLER
                            , RECORD_NAME
                            , RECORD_DATE
                            , RECORD_TIME
                            , MODIFIED_NAME
                            , MODIFIED_DATE
                            , MODIFIED_TIME
                        )
        SELECT                ALERT_ID
                            , CASE_ID
                            , CLIENT_ID
                            , MESSAGE
                            , START_DATE
                            , END_DATE
                            , VOID_IND
                            , SYSTEM_ALERT_IND
                            , REF_TYPE
                            , REF_ID
                            , LOCK_ID
                            , RECORD_COUNT
                            , ALERT_HANDLER
                            , CREATED_BY
                            , CREATE_TS
                            , TO_CHAR(CREATE_TS, c_time_format)
                            , UPDATED_BY
                            , UPDATE_TS
                            , TO_CHAR(UPDATE_TS, c_time_format)                                                            
          FROM emrs_s_alert_stg s
         WHERE NOT EXISTS (SELECT 1 FROM emrs_d_alert C WHERE C.alert_id = S.alert_id)
           Log Errors INTO Errlog_Alert ('ALERT_INS') Reject Limit Unlimited;

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
        SELECT c_critical, con_pkg, con_pkg || '.ALERT_INS', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_ALERT', ALERT_ID
          FROM Errlog_Alert
         WHERE Ora_Err_Tag$ = 'ALERT_INS';

        v_err_cnt := SQL%RowCount;

        UPDATE CORP_ETL_JOB_STATISTICS
           SET ERROR_COUNT = v_err_cnt
             , RECORD_COUNT = v_ins_cnt + v_err_cnt
             , PROCESSED_COUNT = v_ins_cnt + v_err_cnt
         WHERE JOB_ID =  v_job_id;

        COMMIT;

    ELSE

       FOR IDX In 0..9
       LOOP

            Maxdat_Statistics.TABLE_STATS('EMRS_D_ALERT');

            INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
            VALUES (SEQ_JOB_ID.Nextval, 'ALERT_INS THREAD'||IDX,'STARTED',SYSDATE)
            RETURNING JOB_ID INTO v_job_id;

            COMMIT;

            INSERT /*+ Enable_Parallel_Dml Parallel */
              INTO Emrs_D_Alert (  
                                  ALERT_ID
                                , CASE_ID
                                , CLIENT_ID
                                , MESSAGE
                                , START_DATE
                                , END_DATE
                                , VOID_IND
                                , SYSTEM_ALERT_IND
                                , REF_TYPE
                                , REF_ID
                                , LOCK_ID
                                , RECORD_COUNT
                                , ALERT_HANDLER
                                , RECORD_NAME
                                , RECORD_DATE
                                , RECORD_TIME
                                , MODIFIED_NAME
                                , MODIFIED_DATE
                                , MODIFIED_TIME
                            )
            SELECT                ALERT_ID
                                , CASE_ID
                                , CLIENT_ID
                                , MESSAGE
                                , START_DATE
                                , END_DATE
                                , VOID_IND
                                , SYSTEM_ALERT_IND
                                , REF_TYPE
                                , REF_ID
                                , LOCK_ID
                                , RECORD_COUNT
                                , ALERT_HANDLER
                                , CREATED_BY
                                , CREATE_TS
                                , TO_CHAR(CREATE_TS, c_time_format)
                                , UPDATED_BY
                                , UPDATE_TS
                                , TO_CHAR(UPDATE_TS, c_time_format)                                                            
              FROM emrs_s_alert_stg s
             WHERE SUBSTR(S.ALERT_ID,-1) = IDX
               AND NOT EXISTS (SELECT 1 FROM emrs_d_alert C WHERE C.alert_id = S.alert_id)
               Log Errors INTO Errlog_Alert ('ALERT_INS') Reject Limit Unlimited;

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
            SELECT c_critical, con_pkg, con_pkg || '.ALERT_INS', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_ALERT', ALERT_ID
              FROM Errlog_Alert
             WHERE Ora_Err_Tag$ = 'ALERT_INS';

            v_err_cnt := SQL%RowCount;

            UPDATE CORP_ETL_JOB_STATISTICS
               SET ERROR_COUNT = v_err_cnt
                 , RECORD_COUNT = v_ins_cnt + v_err_cnt
                 , PROCESSED_COUNT = v_ins_cnt + v_err_cnt
             WHERE JOB_ID =  v_job_id;

            DELETE FROM Errlog_Alert WHERE ora_err_tag$ = 'ALERT_INS';

            COMMIT;

       END LOOP;

    END IF;

    Maxdat_Statistics.TABLE_STATS('EMRS_D_ALERT');

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, con_pkg || '.ALERT_INS', 1, v_desc, v_code, 'EMRS_D_ALERT');

      COMMIT;
END ALERT_INS;

PROCEDURE ALERT_UPD
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
    to_process number := 0;
    Run_Multiple varchar2(1) := 'N';
BEGIN

    DELETE FROM Errlog_Alert WHERE ora_err_tag$ = 'ALERT_UPD';

    Maxdat_Statistics.TABLE_STATS('EMRS_S_ALERT_STG');

    SELECT COUNT(1) INTO to_process FROM EMRS_S_ALERT_STG;

    SELECT CASE WHEN to_process > NVL(Value,1000000)
                THEN 'Y' ELSE 'N' END INTO Run_Multiple
      FROM CORP_ETL_CONTROL WHERE NAME = 'EMRS_REC_THRESHOLD';

    IF Run_Multiple = 'N' THEN

       INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
       VALUES (SEQ_JOB_ID.Nextval, 'ALERT_UPD','STARTED',SYSDATE)
       RETURNING JOB_ID INTO v_job_id;

       COMMIT;

       Maxdat_Statistics.TABLE_STATS('EMRS_D_ALERT');

       MERGE /*+ Enable_Parallel_Dml Parallel */
        INTO  EMRS_D_ALERT D
       USING ( 
                SELECT                
                              s.ALERT_ID
                            , s.CASE_ID
                            , s.CLIENT_ID
                            , s.MESSAGE
                            , s.START_DATE
                            , s.END_DATE
                            , s.VOID_IND
                            , s.SYSTEM_ALERT_IND
                            , s.REF_TYPE
                            , s.REF_ID
                            , s.LOCK_ID
                            , s.RECORD_COUNT
                            , s.ALERT_HANDLER
                            , s.CREATED_BY                              AS  RECORD_NAME
                            , s.CREATE_TS                               AS  RECORD_DATE
                            , TO_CHAR(s.CREATE_TS, c_time_format)       AS  RECORD_TIME
                            , s.UPDATED_BY                              AS  MODIFIED_NAME
                            , s.UPDATE_TS                               AS  MODIFIED_DATE
                            , TO_CHAR(s.UPDATE_TS, c_time_format)       AS  MODIFIED_TIME                                                               
                 FROM EMRS_D_ALERT D, EMRS_S_ALERT_STG S
                WHERE D.ALERT_ID = S.ALERT_ID
              ) C ON (D.ALERT_ID = C.ALERT_ID)
        WHEN MATCHED THEN UPDATE
         SET              
                          d.CASE_ID                                 =   c.CASE_ID
                        , d.CLIENT_ID                               =   c.CLIENT_ID
                        , d.MESSAGE                                 =   c.MESSAGE
                        , d.START_DATE                              =   c.START_DATE
                        , d.END_DATE                                =   c.END_DATE
                        , d.VOID_IND                                =   c.VOID_IND
                        , d.SYSTEM_ALERT_IND                        =   c.SYSTEM_ALERT_IND
                        , d.REF_TYPE                                =   c.REF_TYPE 
                        , d.REF_ID                                  =   c.REF_ID                                 
                        , d.LOCK_ID                                 =   c.LOCK_ID
                        , d.RECORD_COUNT                            =   c.RECORD_COUNT
                        , d.ALERT_HANDLER                           =   c.ALERT_HANDLER
                        , d.RECORD_NAME                             =   c.RECORD_NAME
                        , d.RECORD_DATE                             =   c.RECORD_DATE
                        , d.RECORD_TIME                             =   c.RECORD_TIME
                        , d.MODIFIED_NAME                           =   c.MODIFIED_NAME
                        , d.MODIFIED_DATE                           =   c.MODIFIED_DATE
                        , d.MODIFIED_TIME                           =   c.MODIFIED_TIME
         Log Errors INTO Errlog_Alert ('ALERT_UPD') Reject Limit Unlimited;

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
        SELECT c_critical, con_pkg, con_pkg || '.ALERT_UPD', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_ALERT', ALERT_ID
          FROM Errlog_Alert
         WHERE Ora_Err_Tag$ = 'ALERT_UPD';

        v_err_cnt := SQL%RowCount;

        UPDATE CORP_ETL_JOB_STATISTICS
           SET ERROR_COUNT = v_err_cnt
             , RECORD_COUNT = v_upd_cnt + v_err_cnt
             , PROCESSED_COUNT = v_upd_cnt + v_err_cnt
         WHERE JOB_ID =  v_job_id;

        COMMIT;

    ELSE

       FOR IDX In 0..9
       LOOP
           Maxdat_Statistics.TABLE_STATS('EMRS_D_ALERT');

           INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
           VALUES (SEQ_JOB_ID.Nextval, 'ALERT_UPD THREAD'||IDX,'STARTED',SYSDATE)
           RETURNING JOB_ID INTO v_job_id;

           COMMIT;

           MERGE /*+ Enable_Parallel_Dml Parallel */
            INTO  EMRS_D_ALERT D
           USING ( 
                    SELECT                
                                  s.ALERT_ID
                                , s.CASE_ID
                                , s.CLIENT_ID
                                , s.MESSAGE
                                , s.START_DATE
                                , s.END_DATE
                                , s.VOID_IND
                                , s.SYSTEM_ALERT_IND
                                , s.REF_TYPE
                                , s.REF_ID
                                , s.LOCK_ID
                                , s.RECORD_COUNT
                                , s.ALERT_HANDLER
                                , s.CREATED_BY                              AS  RECORD_NAME
                                , s.CREATE_TS                               AS  RECORD_DATE
                                , TO_CHAR(s.CREATE_TS, c_time_format)       AS  RECORD_TIME
                                , s.UPDATED_BY                              AS  MODIFIED_NAME
                                , s.UPDATE_TS                               AS  MODIFIED_DATE
                                , TO_CHAR(s.UPDATE_TS, c_time_format)       AS  MODIFIED_TIME                                                               
                     FROM EMRS_D_ALERT D, EMRS_S_ALERT_STG S
                    WHERE D.ALERT_ID = S.ALERT_ID
                      AND SUBSTR(S.ALERT_ID,-1) = IDX
                  ) C ON (D.ALERT_ID = C.ALERT_ID)
            WHEN MATCHED THEN UPDATE
             SET              
                              d.CASE_ID                                 =   c.CASE_ID
                            , d.CLIENT_ID                               =   c.CLIENT_ID
                            , d.MESSAGE                                 =   c.MESSAGE
                            , d.START_DATE                              =   c.START_DATE
                            , d.END_DATE                                =   c.END_DATE
                            , d.VOID_IND                                =   c.VOID_IND
                            , d.SYSTEM_ALERT_IND                        =   c.SYSTEM_ALERT_IND
                            , d.REF_TYPE                                =   c.REF_TYPE 
                            , d.REF_ID                                  =   c.REF_ID                                 
                            , d.LOCK_ID                                 =   c.LOCK_ID
                            , d.RECORD_COUNT                            =   c.RECORD_COUNT
                            , d.ALERT_HANDLER                           =   c.ALERT_HANDLER
                            , d.RECORD_NAME                             =   c.RECORD_NAME
                            , d.RECORD_DATE                             =   c.RECORD_DATE
                            , d.RECORD_TIME                             =   c.RECORD_TIME
                            , d.MODIFIED_NAME                           =   c.MODIFIED_NAME
                            , d.MODIFIED_DATE                           =   c.MODIFIED_DATE
                            , d.MODIFIED_TIME                           =   c.MODIFIED_TIME
             Log Errors INTO Errlog_Alert ('ALERT_UPD') Reject Limit Unlimited;

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
            SELECT c_critical, con_pkg, con_pkg || '.ALERT_UPD', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_ALERT', ALERT_ID
              FROM Errlog_Alert
             WHERE Ora_Err_Tag$ = 'ALERT_UPD';

            v_err_cnt := SQL%RowCount;

            UPDATE CORP_ETL_JOB_STATISTICS
               SET ERROR_COUNT = v_err_cnt
                 , RECORD_COUNT = v_upd_cnt + v_err_cnt
                 , PROCESSED_COUNT = v_upd_cnt + v_err_cnt
             WHERE JOB_ID =  v_job_id;

            DELETE FROM Errlog_Alert WHERE ora_err_tag$ = 'ALERT_UPD';

            COMMIT;

       END LOOP;

    END IF;

    Maxdat_Statistics.TABLE_STATS('EMRS_D_ALERT');

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, con_pkg || '.ALERT_UPD', 1, v_desc, v_code, 'EMRS_D_ALERT');

      COMMIT;
END ALERT_UPD;

PROCEDURE CASE_INS
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_ins_cnt number;
    v_err_cnt number;
    to_process number := 0;
    Run_Multiple varchar2(1) := 'N';
BEGIN

    DELETE FROM Errlog_Case WHERE ora_err_tag$ = 'CASE_INS';

    Maxdat_Statistics.TABLE_STATS('EMRS_S_CASES_STG');

    SELECT COUNT(1) INTO to_process FROM EMRS_S_CASES_STG;

    SELECT CASE WHEN to_process > NVL(Value,1000000)
                THEN 'Y' ELSE 'N' END INTO Run_Multiple
      FROM CORP_ETL_CONTROL WHERE NAME = 'EMRS_REC_THRESHOLD';

    IF Run_Multiple = 'N' THEN

        INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
        VALUES (SEQ_JOB_ID.Nextval, 'CASE_INS','STARTED',SYSDATE)
        RETURNING JOB_ID INTO v_job_id;

        COMMIT;

        INSERT /*+ Enable_Parallel_Dml Parallel */
          INTO Emrs_D_Case (  
                              CASE_ID
                            , CASE_CIN
                            , FAMILY_NUMBER
                            , CASE_STATUS_DATE
                            , CASE_EDUCATED_IND
                            , CASE_EDUCATED_DATE
                            , CASE_NEED_TRANSLATOR_IND
                            , CASE_PHONE
                            , CASE_PHONE_REMINDER_USE
                            , CASE_EDUCATED_BY
                            , CASE_STAFF_ID
                            , CASE_LANGUAGE_CD
                            , CASE_HOW_EDUCATED_CD
                            , CASE_STATUS
                            , CASE_HEAD_FNAME
                            , CASE_HEAD_LNAME
                            , CASE_HEAD_MI
                            , CASE_HEAD_SSN
                            , CASE_TEAM
                            , CASE_LOAD
                            , CLIENT_ID
                            , FMNB_ID
                            , LOAD_TYPE
                            , CASE_SPOKEN_LANGUAGE_CD
                            , NOTE_REF_ID
                            , ANNIVERSARY_DT
                            , STATE_STAFF_ID_EXT
                            , CASE_GENERIC_FIELD1_DATE
                            , CASE_GENERIC_FIELD2_DATE
                            , CASE_GENERIC_FIELD3_NUM
                            , CASE_GENERIC_FIELD4_NUM
                            , CASE_GENERIC_FIELD5_TXT
                            , CASE_GENERIC_FIELD6_TXT
                            , CASE_GENERIC_FIELD7_TXT
                            , CASE_GENERIC_FIELD8_TXT
                            , CASE_GENERIC_FIELD9_TXT
                            , CASE_GENERIC_FIELD10_TXT
                            , CASE_GENERIC_REF11_ID
                            , CASE_GENERIC_REF12_ID
                            , LAST_STATE_UPDATE_TS 
                            , LAST_STATE_UPDATED_BY 
                            , PREF_CONTACT_METHOD_CD
                            , RECORD_NAME
                            , RECORD_DATE
                            , RECORD_TIME
                            , MODIFIED_NAME
                            , MODIFIED_DATE
                            , MODIFIED_TIME
                        )
        SELECT                CASE_ID
                            , CASE_CIN
                            , FAMILY_NUMBER
                            , CASE_STATUS_DATE
                            , CASE_EDUCATED_IND
                            , CASE_EDUCATED_DATE
                            , CASE_NEED_TRANSLATOR_IND
                            , CASE_PHONE
                            , CASE_PHONE_REMINDER_USE
                            , CASE_EDUCATED_BY
                            , CASE_STAFF_ID
                            , CASE_LANGUAGE_CD
                            , CASE_HOW_EDUCATED_CD
                            , CASE_STATUS
                            , CASE_HEAD_FNAME
                            , CASE_HEAD_LNAME
                            , CASE_HEAD_MI
                            , CASE_HEAD_SSN
                            , CASE_TEAM
                            , CASE_LOAD
                            , CLNT_CLIENT_ID
                            , FMNB_ID
                            , LOAD_TYPE
                            , CASE_SPOKEN_LANGUAGE_CD
                            , NOTE_REF_ID
                            , ANNIVERSARY_DT
                            , STATE_STAFF_ID_EXT
                            , CASE_GENERIC_FIELD1_DATE
                            , CASE_GENERIC_FIELD2_DATE
                            , CASE_GENERIC_FIELD3_NUM
                            , CASE_GENERIC_FIELD4_NUM
                            , CASE_GENERIC_FIELD5_TXT
                            , CASE_GENERIC_FIELD6_TXT
                            , CASE_GENERIC_FIELD7_TXT
                            , CASE_GENERIC_FIELD8_TXT
                            , CASE_GENERIC_FIELD9_TXT
                            , CASE_GENERIC_FIELD10_TXT
                            , CASE_GENERIC_REF11_ID
                            , CASE_GENERIC_REF12_ID
                            , LAST_STATE_UPDATE_TS 
                            , LAST_STATE_UPDATED_BY 
                            , PREF_CONTACT_METHOD_CD
                            , CREATED_BY
                            , CREATION_DATE
                            , TO_CHAR(CREATION_DATE, c_time_format)
                            , LAST_UPDATED_BY
                            , LAST_UPDATE_DATE
                            , TO_CHAR(LAST_UPDATE_DATE, c_time_format)                                                            
          FROM emrs_s_cases_stg s
         WHERE NOT EXISTS (SELECT 1 FROM emrs_d_case C WHERE C.case_id = S.case_id)
           Log Errors INTO Errlog_Case ('CASE_INS') Reject Limit Unlimited;

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
        SELECT c_critical, con_pkg, con_pkg || '.CASE_INS', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_CASE', CASE_ID
          FROM Errlog_Case
         WHERE Ora_Err_Tag$ = 'CASE_INS';

        v_err_cnt := SQL%RowCount;

        UPDATE CORP_ETL_JOB_STATISTICS
           SET ERROR_COUNT = v_err_cnt
             , RECORD_COUNT = v_ins_cnt + v_err_cnt
             , PROCESSED_COUNT = v_ins_cnt + v_err_cnt
         WHERE JOB_ID =  v_job_id;

        COMMIT;

    ELSE

       FOR IDX In 0..9
       LOOP

            Maxdat_Statistics.TABLE_STATS('EMRS_D_CASE');

            INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
            VALUES (SEQ_JOB_ID.Nextval, 'CASE_INS THREAD'||IDX,'STARTED',SYSDATE)
            RETURNING JOB_ID INTO v_job_id;

            COMMIT;

            INSERT /*+ Enable_Parallel_Dml Parallel */
          INTO Emrs_D_Case (  
                              CASE_ID
                            , CASE_CIN
                            , FAMILY_NUMBER
                            , CASE_STATUS_DATE
                            , CASE_EDUCATED_IND
                            , CASE_EDUCATED_DATE
                            , CASE_NEED_TRANSLATOR_IND
                            , CASE_PHONE
                            , CASE_PHONE_REMINDER_USE
                            , CASE_EDUCATED_BY
                            , CASE_STAFF_ID
                            , CASE_LANGUAGE_CD
                            , CASE_HOW_EDUCATED_CD
                            , CASE_STATUS
                            , CASE_HEAD_FNAME
                            , CASE_HEAD_LNAME
                            , CASE_HEAD_MI
                            , CASE_HEAD_SSN
                            , CASE_TEAM
                            , CASE_LOAD
                            , CLIENT_ID
                            , FMNB_ID
                            , LOAD_TYPE
                            , CASE_SPOKEN_LANGUAGE_CD
                            , NOTE_REF_ID
                            , ANNIVERSARY_DT
                            , STATE_STAFF_ID_EXT
                            , CASE_GENERIC_FIELD1_DATE
                            , CASE_GENERIC_FIELD2_DATE
                            , CASE_GENERIC_FIELD3_NUM
                            , CASE_GENERIC_FIELD4_NUM
                            , CASE_GENERIC_FIELD5_TXT
                            , CASE_GENERIC_FIELD6_TXT
                            , CASE_GENERIC_FIELD7_TXT
                            , CASE_GENERIC_FIELD8_TXT
                            , CASE_GENERIC_FIELD9_TXT
                            , CASE_GENERIC_FIELD10_TXT
                            , CASE_GENERIC_REF11_ID
                            , CASE_GENERIC_REF12_ID
                            , LAST_STATE_UPDATE_TS 
                            , LAST_STATE_UPDATED_BY 
                            , PREF_CONTACT_METHOD_CD
                            , RECORD_NAME
                            , RECORD_DATE
                            , RECORD_TIME
                            , MODIFIED_NAME
                            , MODIFIED_DATE
                            , MODIFIED_TIME
                        )
        SELECT                CASE_ID
                            , CASE_CIN
                            , FAMILY_NUMBER
                            , CASE_STATUS_DATE
                            , CASE_EDUCATED_IND
                            , CASE_EDUCATED_DATE
                            , CASE_NEED_TRANSLATOR_IND
                            , CASE_PHONE
                            , CASE_PHONE_REMINDER_USE
                            , CASE_EDUCATED_BY
                            , CASE_STAFF_ID
                            , CASE_LANGUAGE_CD
                            , CASE_HOW_EDUCATED_CD
                            , CASE_STATUS
                            , CASE_HEAD_FNAME
                            , CASE_HEAD_LNAME
                            , CASE_HEAD_MI
                            , CASE_HEAD_SSN
                            , CASE_TEAM
                            , CASE_LOAD
                            , CLNT_CLIENT_ID
                            , FMNB_ID
                            , LOAD_TYPE
                            , CASE_SPOKEN_LANGUAGE_CD
                            , NOTE_REF_ID
                            , ANNIVERSARY_DT
                            , STATE_STAFF_ID_EXT
                            , CASE_GENERIC_FIELD1_DATE
                            , CASE_GENERIC_FIELD2_DATE
                            , CASE_GENERIC_FIELD3_NUM
                            , CASE_GENERIC_FIELD4_NUM
                            , CASE_GENERIC_FIELD5_TXT
                            , CASE_GENERIC_FIELD6_TXT
                            , CASE_GENERIC_FIELD7_TXT
                            , CASE_GENERIC_FIELD8_TXT
                            , CASE_GENERIC_FIELD9_TXT
                            , CASE_GENERIC_FIELD10_TXT
                            , CASE_GENERIC_REF11_ID
                            , CASE_GENERIC_REF12_ID
                            , LAST_STATE_UPDATE_TS 
                            , LAST_STATE_UPDATED_BY 
                            , PREF_CONTACT_METHOD_CD
                            , CREATED_BY
                            , CREATION_DATE
                            , TO_CHAR(CREATION_DATE, c_time_format)
                            , LAST_UPDATED_BY
                            , LAST_UPDATE_DATE
                            , TO_CHAR(LAST_UPDATE_DATE, c_time_format)                                                            
              FROM emrs_s_cases_stg s
             WHERE SUBSTR(S.CASE_ID,-1) = IDX
               AND NOT EXISTS (SELECT 1 FROM emrs_d_case C WHERE C.case_id = S.case_id)
               Log Errors INTO Errlog_Case ('CASE_INS') Reject Limit Unlimited;

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
            SELECT c_critical, con_pkg, con_pkg || '.CASE_INS', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_CASE', CASE_ID
              FROM Errlog_Case
             WHERE Ora_Err_Tag$ = 'CASE_INS';

            v_err_cnt := SQL%RowCount;

            UPDATE CORP_ETL_JOB_STATISTICS
               SET ERROR_COUNT = v_err_cnt
                 , RECORD_COUNT = v_ins_cnt + v_err_cnt
                 , PROCESSED_COUNT = v_ins_cnt + v_err_cnt
             WHERE JOB_ID =  v_job_id;

            DELETE FROM Errlog_Case WHERE ora_err_tag$ = 'CASE_INS';

            COMMIT;

       END LOOP;

    END IF;

    Maxdat_Statistics.TABLE_STATS('EMRS_D_CASE');

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, con_pkg || '.CASE_INS', 1, v_desc, v_code, 'EMRS_D_CASE');

      COMMIT;
END CASE_INS;

PROCEDURE CASE_UPD
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
    to_process number := 0;
    Run_Multiple varchar2(1) := 'N';
BEGIN

    DELETE FROM Errlog_Case WHERE ora_err_tag$ = 'CASE_UPD';

    Maxdat_Statistics.TABLE_STATS('EMRS_S_CASES_STG');

    SELECT COUNT(1) INTO to_process FROM EMRS_S_CASES_STG;

    SELECT CASE WHEN to_process > NVL(Value,1000000)
                THEN 'Y' ELSE 'N' END INTO Run_Multiple
      FROM CORP_ETL_CONTROL WHERE NAME = 'EMRS_REC_THRESHOLD';

    IF Run_Multiple = 'N' THEN

       INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
       VALUES (SEQ_JOB_ID.Nextval, 'CASE_UPD','STARTED',SYSDATE)
       RETURNING JOB_ID INTO v_job_id;

       COMMIT;

       Maxdat_Statistics.TABLE_STATS('EMRS_D_CASE');

       MERGE /*+ Enable_Parallel_Dml Parallel */
        INTO  EMRS_D_CASE D
       USING ( 
                SELECT                
                          s.CASE_ID
                        , s.CASE_CIN
                        , s.FAMILY_NUMBER
                        , s.CASE_STATUS_DATE
                        , s.CASE_EDUCATED_IND
                        , s.CASE_EDUCATED_DATE
                        , s.CASE_NEED_TRANSLATOR_IND
                        , s.CASE_PHONE
                        , s.CASE_PHONE_REMINDER_USE
                        , s.CASE_EDUCATED_BY
                        , s.CASE_STAFF_ID
                        , s.CASE_LANGUAGE_CD
                        , s.CASE_HOW_EDUCATED_CD
                        , s.CASE_STATUS
                        , s.CASE_HEAD_FNAME
                        , s.CASE_HEAD_LNAME
                        , s.CASE_HEAD_MI
                        , s.CASE_HEAD_SSN
                        , s.CASE_TEAM
                        , s.CASE_LOAD
                        , s.CLNT_CLIENT_ID
                        , s.FMNB_ID
                        , s.LOAD_TYPE
                        , s.CASE_SPOKEN_LANGUAGE_CD
                        , s.NOTE_REF_ID
                        , s.ANNIVERSARY_DT
                        , s.STATE_STAFF_ID_EXT
                        , s.CASE_GENERIC_FIELD1_DATE
                        , s.CASE_GENERIC_FIELD2_DATE
                        , s.CASE_GENERIC_FIELD3_NUM
                        , s.CASE_GENERIC_FIELD4_NUM
                        , s.CASE_GENERIC_FIELD5_TXT
                        , s.CASE_GENERIC_FIELD6_TXT
                        , s.CASE_GENERIC_FIELD7_TXT
                        , s.CASE_GENERIC_FIELD8_TXT
                        , s.CASE_GENERIC_FIELD9_TXT
                        , s.CASE_GENERIC_FIELD10_TXT
                        , s.CASE_GENERIC_REF11_ID
                        , s.CASE_GENERIC_REF12_ID
                        , s.LAST_STATE_UPDATE_TS 
                        , s.LAST_STATE_UPDATED_BY 
                        , s.PREF_CONTACT_METHOD_CD
                        , s.CREATED_BY                                  AS  RECORD_NAME
                        , s.CREATION_DATE                               AS  RECORD_DATE
                        , TO_CHAR(s.CREATION_DATE, c_time_format)       AS  RECORD_TIME
                        , s.LAST_UPDATED_BY                             AS  MODIFIED_NAME
                        , s.LAST_UPDATE_DATE                            AS  MODIFIED_DATE
                        , TO_CHAR(s.LAST_UPDATE_DATE, c_time_format)    AS  MODIFIED_TIME
                 FROM EMRS_D_CASE D, EMRS_S_CASES_STG S
                WHERE D.CASE_ID = S.CASE_ID
              ) C ON (D.CASE_ID = C.CASE_ID)
        WHEN MATCHED THEN UPDATE
         SET              d.CASE_CIN                                =   c.CASE_CIN
                        , d.FAMILY_NUMBER                           =   c.FAMILY_NUMBER
                        , d.CASE_STATUS_DATE                        =   c.CASE_STATUS_DATE
                        , d.CASE_EDUCATED_IND                       =   c.CASE_EDUCATED_IND
                        , d.CASE_EDUCATED_DATE                      =   c.CASE_EDUCATED_DATE
                        , d.CASE_NEED_TRANSLATOR_IND                =   c.CASE_NEED_TRANSLATOR_IND
                        , d.CASE_PHONE                              =   c.CASE_PHONE
                        , d.CASE_PHONE_REMINDER_USE                 =   c.CASE_PHONE_REMINDER_USE
                        , d.CASE_EDUCATED_BY                        =   c.CASE_EDUCATED_BY
                        , d.CASE_STAFF_ID                           =   c.CASE_STAFF_ID
                        , d.CASE_LANGUAGE_CD                        =   c.CASE_LANGUAGE_CD
                        , d.CASE_HOW_EDUCATED_CD                    =   c.CASE_LANGUAGE_CD
                        , d.CASE_STATUS                             =   c.CASE_STATUS
                        , d.CASE_HEAD_FNAME                         =   c.CASE_HEAD_FNAME
                        , d.CASE_HEAD_LNAME                         =   c.CASE_HEAD_LNAME
                        , d.CASE_HEAD_MI                            =   c.CASE_HEAD_MI
                        , d.CASE_HEAD_SSN                           =   c.CASE_HEAD_SSN
                        , d.CASE_TEAM                               =   c.CASE_TEAM
                        , d.CASE_LOAD                               =   c.CASE_LOAD
                        , d.CLIENT_ID                               =   c.CLNT_CLIENT_ID
                        , d.FMNB_ID                                 =   c.FMNB_ID
                        , d.LOAD_TYPE                               =   c.LOAD_TYPE
                        , d.CASE_SPOKEN_LANGUAGE_CD                 =   c.CASE_SPOKEN_LANGUAGE_CD
                        , d.NOTE_REF_ID                             =   c.NOTE_REF_ID
                        , d.ANNIVERSARY_DT                          =   c.ANNIVERSARY_DT
                        , d.STATE_STAFF_ID_EXT                      =   c.STATE_STAFF_ID_EXT
                        , d.CASE_GENERIC_FIELD1_DATE                =   c.CASE_GENERIC_FIELD1_DATE
                        , d.CASE_GENERIC_FIELD2_DATE                =   c.CASE_GENERIC_FIELD2_DATE
                        , d.CASE_GENERIC_FIELD3_NUM                 =   c.CASE_GENERIC_FIELD3_NUM
                        , d.CASE_GENERIC_FIELD4_NUM                 =   c.CASE_GENERIC_FIELD4_NUM
                        , d.CASE_GENERIC_FIELD5_TXT                 =   c.CASE_GENERIC_FIELD5_TXT
                        , d.CASE_GENERIC_FIELD6_TXT                 =   c.CASE_GENERIC_FIELD6_TXT
                        , d.CASE_GENERIC_FIELD7_TXT                 =   c.CASE_GENERIC_FIELD7_TXT
                        , d.CASE_GENERIC_FIELD8_TXT                 =   c.CASE_GENERIC_FIELD8_TXT
                        , d.CASE_GENERIC_FIELD9_TXT                 =   c.CASE_GENERIC_FIELD9_TXT
                        , d.CASE_GENERIC_FIELD10_TXT                =   c.CASE_GENERIC_FIELD10_TXT
                        , d.CASE_GENERIC_REF11_ID                   =   c.CASE_GENERIC_REF11_ID
                        , d.CASE_GENERIC_REF12_ID                   =   c.CASE_GENERIC_REF12_ID
                        , d.LAST_STATE_UPDATE_TS                    =   c.LAST_STATE_UPDATE_TS 
                        , d.LAST_STATE_UPDATED_BY                   =   c.LAST_STATE_UPDATED_BY 
                        , d.PREF_CONTACT_METHOD_CD                  =   c.PREF_CONTACT_METHOD_CD
                        , d.RECORD_NAME                             =   c.RECORD_NAME
                        , d.RECORD_DATE                             =   c.RECORD_DATE
                        , d.RECORD_TIME                             =   c.RECORD_TIME
                        , d.MODIFIED_NAME                           =   c.MODIFIED_NAME
                        , d.MODIFIED_DATE                           =   c.MODIFIED_DATE
                        , d.MODIFIED_TIME                           =   c.MODIFIED_TIME
         Log Errors INTO Errlog_Case ('CASE_UPD') Reject Limit Unlimited;

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
        SELECT c_critical, con_pkg, con_pkg || '.CASE_UPD', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_CASE', CASE_ID
          FROM Errlog_Case
         WHERE Ora_Err_Tag$ = 'CASE_UPD';

        v_err_cnt := SQL%RowCount;

        UPDATE CORP_ETL_JOB_STATISTICS
           SET ERROR_COUNT = v_err_cnt
             , RECORD_COUNT = v_upd_cnt + v_err_cnt
             , PROCESSED_COUNT = v_upd_cnt + v_err_cnt
         WHERE JOB_ID =  v_job_id;

        COMMIT;

    ELSE

       FOR IDX In 0..9
       LOOP
           Maxdat_Statistics.TABLE_STATS('EMRS_D_CASE');

           INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
           VALUES (SEQ_JOB_ID.Nextval, 'CASE_UPD THREAD'||IDX,'STARTED',SYSDATE)
           RETURNING JOB_ID INTO v_job_id;

           COMMIT;

           MERGE /*+ Enable_Parallel_Dml Parallel */
            INTO  EMRS_D_CASE D
           USING ( 
                    SELECT                
                              s.CASE_ID
                            , s.CASE_CIN
                            , s.FAMILY_NUMBER
                            , s.CASE_STATUS_DATE
                            , s.CASE_EDUCATED_IND
                            , s.CASE_EDUCATED_DATE
                            , s.CASE_NEED_TRANSLATOR_IND
                            , s.CASE_PHONE
                            , s.CASE_PHONE_REMINDER_USE
                            , s.CASE_EDUCATED_BY
                            , s.CASE_STAFF_ID
                            , s.CASE_LANGUAGE_CD
                            , s.CASE_HOW_EDUCATED_CD
                            , s.CASE_STATUS
                            , s.CASE_HEAD_FNAME
                            , s.CASE_HEAD_LNAME
                            , s.CASE_HEAD_MI
                            , s.CASE_HEAD_SSN
                            , s.CASE_TEAM
                            , s.CASE_LOAD
                            , s.CLNT_CLIENT_ID
                            , s.FMNB_ID
                            , s.LOAD_TYPE
                            , s.CASE_SPOKEN_LANGUAGE_CD
                            , s.NOTE_REF_ID
                            , s.ANNIVERSARY_DT
                            , s.STATE_STAFF_ID_EXT
                            , s.CASE_GENERIC_FIELD1_DATE
                            , s.CASE_GENERIC_FIELD2_DATE
                            , s.CASE_GENERIC_FIELD3_NUM
                            , s.CASE_GENERIC_FIELD4_NUM
                            , s.CASE_GENERIC_FIELD5_TXT
                            , s.CASE_GENERIC_FIELD6_TXT
                            , s.CASE_GENERIC_FIELD7_TXT
                            , s.CASE_GENERIC_FIELD8_TXT
                            , s.CASE_GENERIC_FIELD9_TXT
                            , s.CASE_GENERIC_FIELD10_TXT
                            , s.CASE_GENERIC_REF11_ID
                            , s.CASE_GENERIC_REF12_ID
                            , s.LAST_STATE_UPDATE_TS 
                            , s.LAST_STATE_UPDATED_BY 
                            , s.PREF_CONTACT_METHOD_CD
                            , s.CREATED_BY                                  AS  RECORD_NAME
                            , s.CREATION_DATE                               AS  RECORD_DATE
                            , TO_CHAR(s.CREATION_DATE, c_time_format)       AS  RECORD_TIME
                            , s.LAST_UPDATED_BY                             AS  MODIFIED_NAME
                            , s.LAST_UPDATE_DATE                            AS  MODIFIED_DATE
                            , TO_CHAR(s.LAST_UPDATE_DATE, c_time_format)    AS  MODIFIED_TIME
                     FROM EMRS_D_CASE D, EMRS_S_CASES_STG S
                    WHERE D.CASE_ID = S.CASE_ID
                      AND SUBSTR(S.CASE_ID,-1) = IDX
                  ) C ON (D.CASE_ID = C.CASE_ID)
            WHEN MATCHED THEN UPDATE
             SET              d.CASE_CIN                                =   c.CASE_CIN
                            , d.FAMILY_NUMBER                           =   c.FAMILY_NUMBER
                            , d.CASE_STATUS_DATE                        =   c.CASE_STATUS_DATE
                            , d.CASE_EDUCATED_IND                       =   c.CASE_EDUCATED_IND
                            , d.CASE_EDUCATED_DATE                      =   c.CASE_EDUCATED_DATE
                            , d.CASE_NEED_TRANSLATOR_IND                =   c.CASE_NEED_TRANSLATOR_IND
                            , d.CASE_PHONE                              =   c.CASE_PHONE
                            , d.CASE_PHONE_REMINDER_USE                 =   c.CASE_PHONE_REMINDER_USE
                            , d.CASE_EDUCATED_BY                        =   c.CASE_EDUCATED_BY
                            , d.CASE_STAFF_ID                           =   c.CASE_STAFF_ID
                            , d.CASE_LANGUAGE_CD                        =   c.CASE_LANGUAGE_CD
                            , d.CASE_HOW_EDUCATED_CD                    =   c.CASE_LANGUAGE_CD
                            , d.CASE_STATUS                             =   c.CASE_STATUS
                            , d.CASE_HEAD_FNAME                         =   c.CASE_HEAD_FNAME
                            , d.CASE_HEAD_LNAME                         =   c.CASE_HEAD_LNAME
                            , d.CASE_HEAD_MI                            =   c.CASE_HEAD_MI
                            , d.CASE_HEAD_SSN                           =   c.CASE_HEAD_SSN
                            , d.CASE_TEAM                               =   c.CASE_TEAM
                            , d.CASE_LOAD                               =   c.CASE_LOAD
                            , d.CLIENT_ID                               =   c.CLNT_CLIENT_ID
                            , d.FMNB_ID                                 =   c.FMNB_ID
                            , d.LOAD_TYPE                               =   c.LOAD_TYPE
                            , d.CASE_SPOKEN_LANGUAGE_CD                 =   c.CASE_SPOKEN_LANGUAGE_CD
                            , d.NOTE_REF_ID                             =   c.NOTE_REF_ID
                            , d.ANNIVERSARY_DT                          =   c.ANNIVERSARY_DT
                            , d.STATE_STAFF_ID_EXT                      =   c.STATE_STAFF_ID_EXT
                            , d.CASE_GENERIC_FIELD1_DATE                =   c.CASE_GENERIC_FIELD1_DATE
                            , d.CASE_GENERIC_FIELD2_DATE                =   c.CASE_GENERIC_FIELD2_DATE
                            , d.CASE_GENERIC_FIELD3_NUM                 =   c.CASE_GENERIC_FIELD3_NUM
                            , d.CASE_GENERIC_FIELD4_NUM                 =   c.CASE_GENERIC_FIELD4_NUM
                            , d.CASE_GENERIC_FIELD5_TXT                 =   c.CASE_GENERIC_FIELD5_TXT
                            , d.CASE_GENERIC_FIELD6_TXT                 =   c.CASE_GENERIC_FIELD6_TXT
                            , d.CASE_GENERIC_FIELD7_TXT                 =   c.CASE_GENERIC_FIELD7_TXT
                            , d.CASE_GENERIC_FIELD8_TXT                 =   c.CASE_GENERIC_FIELD8_TXT
                            , d.CASE_GENERIC_FIELD9_TXT                 =   c.CASE_GENERIC_FIELD9_TXT
                            , d.CASE_GENERIC_FIELD10_TXT                =   c.CASE_GENERIC_FIELD10_TXT
                            , d.CASE_GENERIC_REF11_ID                   =   c.CASE_GENERIC_REF11_ID
                            , d.CASE_GENERIC_REF12_ID                   =   c.CASE_GENERIC_REF12_ID
                            , d.LAST_STATE_UPDATE_TS                    =   c.LAST_STATE_UPDATE_TS 
                            , d.LAST_STATE_UPDATED_BY                   =   c.LAST_STATE_UPDATED_BY 
                            , d.PREF_CONTACT_METHOD_CD                  =   c.PREF_CONTACT_METHOD_CD
                            , d.RECORD_NAME                             =   c.RECORD_NAME
                            , d.RECORD_DATE                             =   c.RECORD_DATE
                            , d.RECORD_TIME                             =   c.RECORD_TIME
                            , d.MODIFIED_NAME                           =   c.MODIFIED_NAME
                            , d.MODIFIED_DATE                           =   c.MODIFIED_DATE
                            , d.MODIFIED_TIME                           =   c.MODIFIED_TIME
             Log Errors INTO Errlog_Case ('CASE_UPD') Reject Limit Unlimited;

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
            SELECT c_critical, con_pkg, con_pkg || '.CASE_UPD', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_CASE', CASE_ID
              FROM Errlog_Case
             WHERE Ora_Err_Tag$ = 'CASE_UPD';

            v_err_cnt := SQL%RowCount;

            UPDATE CORP_ETL_JOB_STATISTICS
               SET ERROR_COUNT = v_err_cnt
                 , RECORD_COUNT = v_upd_cnt + v_err_cnt
                 , PROCESSED_COUNT = v_upd_cnt + v_err_cnt
             WHERE JOB_ID =  v_job_id;

            DELETE FROM Errlog_Case WHERE ora_err_tag$ = 'CASE_UPD';

            COMMIT;

       END LOOP;

    END IF;

    Maxdat_Statistics.TABLE_STATS('EMRS_D_CASE');

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, con_pkg || '.CASE_UPD', 1, v_desc, v_code, 'EMRS_D_CASE');

      COMMIT;
END CASE_UPD;

PROCEDURE CLIENT_INS
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_ins_cnt number;
    v_err_cnt number;
    to_process number := 0;
    Run_Multiple varchar2(1) := 'N';
BEGIN

    DELETE FROM Errlog_Client WHERE ora_err_tag$ = 'CLIENT_INS';

    Maxdat_Statistics.TABLE_STATS('EMRS_S_CLIENT_STG');

    SELECT COUNT(1) INTO to_process FROM EMRS_S_CLIENT_STG;

    SELECT CASE WHEN to_process > NVL(Value,1000000)
                THEN 'Y' ELSE 'N' END INTO Run_Multiple
      FROM CORP_ETL_CONTROL WHERE NAME = 'EMRS_REC_THRESHOLD';

    IF Run_Multiple = 'N' THEN

        INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
        VALUES (SEQ_JOB_ID.Nextval, 'CLIENT_INS','STARTED',SYSDATE)
        RETURNING JOB_ID INTO v_job_id;

        COMMIT;

        INSERT /*+ Enable_Parallel_Dml Parallel */
          INTO Emrs_D_Client
               (
                  CLIENT_ID
                , CLNT_CLNT_CLIENT_ID
                , CLNT_FNAME
                , FIRST_NAME_CANON
                , FIRST_NAME_SOUNDLIKE
                , CLNT_LNAME
                , LAST_NAME_CANON
                , LAST_NAME_SOUNDLIKE
                , CLNT_MI
                , CLNT_GENDER_CD
                , CLNT_CITIZEN
                , CLNT_ETHNICITY
                , CLNT_RACE
                , CLNT_DOB
                , CLNT_DOD
                , CLNT_TPL_PRESENT
                , CLNT_SSN
                , CLNT_NATIONAL_ID
                , CLNT_FROM_PACMIS
                , CLNT_SHARE_PREMIUM
                , CLNT_NOT_BORN
                , CLNT_HIPAA_PRIVACY_IND
                , CLNT_FINET_VENDOR_NBR
                , CLNT_ENROLL_STATUS
                , CLNT_ENROLL_STATUS_DATE
                , SCHED_AUTO_ASSIGN_DATE
                , CLNT_CIN
                , CLNT_COMMENT
                , CLNT_PSEUDO_ID
                , CLNT_DISPLAY_NAME
                , SSNVL_ID
                , NOTE_REF_ID
                , CLNT_MARITAL_CD
                , CLNT_STATUS_CD
                , CLNT_EXPECTED_DOB
                , CLNT_PREG_TERM_DATE
                , CLNT_PREG_TERM_REAS_CD
                , CLIENT_TYPE_CD
                , SUPPLEMENTAL_NBR
                , CLIENT_LANGUAGE
                , STATE_LANGUAGE
                , DO_NOT_CALL_IND
                , WRITTEN_LANGUAGE
                , SUFFIX
                , SALUTATION_CD
                , DOMESTIC_VIOLENCE_IND
                , ENGLISH_FLUENCY_CD
                , ENGLISH_LITERACY_CD
                , TRIBE_CD
                , CLNT_GENERIC_FIELD1_DATE
                , CLNT_GENERIC_FIELD2_DATE
                , CLNT_GENERIC_FIELD3_NUM
                , CLNT_GENERIC_FIELD4_NUM
                , CLNT_GENERIC_FIELD5_TXT
                , CLNT_GENERIC_FIELD6_TXT
                , CLNT_GENERIC_FIELD7_TXT
                , CLNT_GENERIC_FIELD8_TXT
                , CLNT_GENERIC_FIELD9_TXT
                , CLNT_GENERIC_FIELD10_TXT
                , CLNT_GENERIC_REF11_ID
                , CLNT_GENERIC_REF12_ID
                , DOD_SOURCE_CD
                , DO_NOT_TEXT_IND
                , DO_NOT_EMAIL_IND
                , LAST_STATE_UPDATE_TS
                , LAST_STATE_UPDATED_BY
                , COMPARABLE_KEY
                , RECORD_NAME
                , RECORD_DATE
                , RECORD_TIME
                , MODIFIED_NAME
                , MODIFIED_DATE
                , MODIFIED_TIME                
               )
        SELECT
                  CLIENT_ID
                , CLNT_CLNT_CLIENT_ID
                , CLNT_FNAME
                , FIRST_NAME_CANON
                , FIRST_NAME_SOUNDLIKE
                , CLNT_LNAME
                , LAST_NAME_CANON
                , LAST_NAME_SOUNDLIKE
                , CLNT_MI
                , CLNT_GENDER_CD
                , CLNT_CITIZEN
                , CLNT_ETHNICITY
                , CLNT_RACE
                , CLNT_DOB
                , CLNT_DOD
                , CLNT_TPL_PRESENT
                , CLNT_SSN
                , CLNT_NATIONAL_ID
                , CLNT_FROM_PACMIS
                , CLNT_SHARE_PREMIUM
                , CLNT_NOT_BORN
                , CLNT_HIPAA_PRIVACY_IND
                , CLNT_FINET_VENDOR_NBR
                , CLNT_ENROLL_STATUS
                , CLNT_ENROLL_STATUS_DATE
                , SCHED_AUTO_ASSIGN_DATE
                , CLNT_CIN
                , CLNT_COMMENT
                , CLNT_PSEUDO_ID
                , CLNT_DISPLAY_NAME
                , SSNVL_ID
                , NOTE_REF_ID
                , CLNT_MARITAL_CD
                , CLNT_STATUS_CD
                , CLNT_EXPECTED_DOB
                , CLNT_PREG_TERM_DATE
                , CLNT_PREG_TERM_REAS_CD
                , CLIENT_TYPE_CD
                , SUPPLEMENTAL_NBR
                , CLIENT_LANGUAGE
                , STATE_LANGUAGE
                , DO_NOT_CALL_IND
                , WRITTEN_LANGUAGE
                , SUFFIX
                , SALUTATION_CD
                , DOMESTIC_VIOLENCE_IND
                , ENGLISH_FLUENCY_CD
                , ENGLISH_LITERACY_CD
                , TRIBE_CD
                , CLNT_GENERIC_FIELD1_DATE
                , CLNT_GENERIC_FIELD2_DATE
                , CLNT_GENERIC_FIELD3_NUM
                , CLNT_GENERIC_FIELD4_NUM
                , CLNT_GENERIC_FIELD5_TXT
                , CLNT_GENERIC_FIELD6_TXT
                , CLNT_GENERIC_FIELD7_TXT
                , CLNT_GENERIC_FIELD8_TXT
                , CLNT_GENERIC_FIELD9_TXT
                , CLNT_GENERIC_FIELD10_TXT
                , CLNT_GENERIC_REF11_ID
                , CLNT_GENERIC_REF12_ID
                , DOD_SOURCE_CD
                , DO_NOT_TEXT_IND
                , DO_NOT_EMAIL_IND
                , LAST_STATE_UPDATE_TS
                , LAST_STATE_UPDATED_BY
                , COMPARABLE_KEY
                , CREATED_BY
                , CREATION_DATE
                , TO_CHAR(CREATION_DATE, c_time_format)
                , LAST_UPDATED_BY
                , LAST_UPDATE_DATE
                , TO_CHAR(LAST_UPDATE_DATE, c_time_format)                                                            
        FROM emrs_s_client_stg s
         WHERE NOT EXISTS (SELECT 1 FROM emrs_d_client C WHERE C.client_id = S.client_id)
           Log Errors INTO Errlog_Client ('CLIENT_INS') Reject Limit Unlimited;

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
        SELECT c_critical, con_pkg, con_pkg || '.CLIENT_INS', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_CLIENT', CLIENT_ID
          FROM Errlog_Client
         WHERE Ora_Err_Tag$ = 'CLIENT_INS';

        v_err_cnt := SQL%RowCount;

        UPDATE CORP_ETL_JOB_STATISTICS
           SET ERROR_COUNT = v_err_cnt
             , RECORD_COUNT = v_ins_cnt + v_err_cnt
             , PROCESSED_COUNT = v_ins_cnt + v_err_cnt
         WHERE JOB_ID =  v_job_id;

        COMMIT;

    ELSE

       FOR IDX In 0..9
       LOOP

           Maxdat_Statistics.TABLE_STATS('EMRS_D_CLIENT');

           INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
           VALUES (SEQ_JOB_ID.Nextval, 'CLIENT_INS THREAD'||IDX,'STARTED',SYSDATE)
           RETURNING JOB_ID INTO v_job_id;

           COMMIT;

        INSERT /*+ Enable_Parallel_Dml Parallel */
          INTO Emrs_D_Client
               (
                  CLIENT_ID
                , CLNT_CLNT_CLIENT_ID
                , CLNT_FNAME
                , FIRST_NAME_CANON
                , FIRST_NAME_SOUNDLIKE
                , CLNT_LNAME
                , LAST_NAME_CANON
                , LAST_NAME_SOUNDLIKE
                , CLNT_MI
                , CLNT_GENDER_CD
                , CLNT_CITIZEN
                , CLNT_ETHNICITY
                , CLNT_RACE
                , CLNT_DOB
                , CLNT_DOD
                , CLNT_TPL_PRESENT
                , CLNT_SSN
                , CLNT_NATIONAL_ID
                , CLNT_FROM_PACMIS
                , CLNT_SHARE_PREMIUM
                , CLNT_NOT_BORN
                , CLNT_HIPAA_PRIVACY_IND
                , CLNT_FINET_VENDOR_NBR
                , CLNT_ENROLL_STATUS
                , CLNT_ENROLL_STATUS_DATE
                , SCHED_AUTO_ASSIGN_DATE
                , CLNT_CIN
                , CLNT_COMMENT
                , CLNT_PSEUDO_ID
                , CLNT_DISPLAY_NAME
                , SSNVL_ID
                , NOTE_REF_ID
                , CLNT_MARITAL_CD
                , CLNT_STATUS_CD
                , CLNT_EXPECTED_DOB
                , CLNT_PREG_TERM_DATE
                , CLNT_PREG_TERM_REAS_CD
                , CLIENT_TYPE_CD
                , SUPPLEMENTAL_NBR
                , CLIENT_LANGUAGE
                , STATE_LANGUAGE
                , DO_NOT_CALL_IND
                , WRITTEN_LANGUAGE
                , SUFFIX
                , SALUTATION_CD
                , DOMESTIC_VIOLENCE_IND
                , ENGLISH_FLUENCY_CD
                , ENGLISH_LITERACY_CD
                , TRIBE_CD
                , CLNT_GENERIC_FIELD1_DATE
                , CLNT_GENERIC_FIELD2_DATE
                , CLNT_GENERIC_FIELD3_NUM
                , CLNT_GENERIC_FIELD4_NUM
                , CLNT_GENERIC_FIELD5_TXT
                , CLNT_GENERIC_FIELD6_TXT
                , CLNT_GENERIC_FIELD7_TXT
                , CLNT_GENERIC_FIELD8_TXT
                , CLNT_GENERIC_FIELD9_TXT
                , CLNT_GENERIC_FIELD10_TXT
                , CLNT_GENERIC_REF11_ID
                , CLNT_GENERIC_REF12_ID
                , DOD_SOURCE_CD
                , DO_NOT_TEXT_IND
                , DO_NOT_EMAIL_IND
                , LAST_STATE_UPDATE_TS
                , LAST_STATE_UPDATED_BY
                , COMPARABLE_KEY
                , RECORD_NAME
                , RECORD_DATE
                , RECORD_TIME
                , MODIFIED_NAME
                , MODIFIED_DATE
                , MODIFIED_TIME                
               )
        SELECT
                  CLIENT_ID
                , CLNT_CLNT_CLIENT_ID
                , CLNT_FNAME
                , FIRST_NAME_CANON
                , FIRST_NAME_SOUNDLIKE
                , CLNT_LNAME
                , LAST_NAME_CANON
                , LAST_NAME_SOUNDLIKE
                , CLNT_MI
                , CLNT_GENDER_CD
                , CLNT_CITIZEN
                , CLNT_ETHNICITY
                , CLNT_RACE
                , CLNT_DOB
                , CLNT_DOD
                , CLNT_TPL_PRESENT
                , CLNT_SSN
                , CLNT_NATIONAL_ID
                , CLNT_FROM_PACMIS
                , CLNT_SHARE_PREMIUM
                , CLNT_NOT_BORN
                , CLNT_HIPAA_PRIVACY_IND
                , CLNT_FINET_VENDOR_NBR
                , CLNT_ENROLL_STATUS
                , CLNT_ENROLL_STATUS_DATE
                , SCHED_AUTO_ASSIGN_DATE
                , CLNT_CIN
                , CLNT_COMMENT
                , CLNT_PSEUDO_ID
                , CLNT_DISPLAY_NAME
                , SSNVL_ID
                , NOTE_REF_ID
                , CLNT_MARITAL_CD
                , CLNT_STATUS_CD
                , CLNT_EXPECTED_DOB
                , CLNT_PREG_TERM_DATE
                , CLNT_PREG_TERM_REAS_CD
                , CLIENT_TYPE_CD
                , SUPPLEMENTAL_NBR
                , CLIENT_LANGUAGE
                , STATE_LANGUAGE
                , DO_NOT_CALL_IND
                , WRITTEN_LANGUAGE
                , SUFFIX
                , SALUTATION_CD
                , DOMESTIC_VIOLENCE_IND
                , ENGLISH_FLUENCY_CD
                , ENGLISH_LITERACY_CD
                , TRIBE_CD
                , CLNT_GENERIC_FIELD1_DATE
                , CLNT_GENERIC_FIELD2_DATE
                , CLNT_GENERIC_FIELD3_NUM
                , CLNT_GENERIC_FIELD4_NUM
                , CLNT_GENERIC_FIELD5_TXT
                , CLNT_GENERIC_FIELD6_TXT
                , CLNT_GENERIC_FIELD7_TXT
                , CLNT_GENERIC_FIELD8_TXT
                , CLNT_GENERIC_FIELD9_TXT
                , CLNT_GENERIC_FIELD10_TXT
                , CLNT_GENERIC_REF11_ID
                , CLNT_GENERIC_REF12_ID
                , DOD_SOURCE_CD
                , DO_NOT_TEXT_IND
                , DO_NOT_EMAIL_IND
                , LAST_STATE_UPDATE_TS
                , LAST_STATE_UPDATED_BY
                , COMPARABLE_KEY
                , CREATED_BY
                , CREATION_DATE
                , TO_CHAR(CREATION_DATE, c_time_format)
                , LAST_UPDATED_BY
                , LAST_UPDATE_DATE
                , TO_CHAR(LAST_UPDATE_DATE, c_time_format)                                                            
        FROM emrs_s_client_stg s
         WHERE SUBSTR(s.CLIENT_ID, -1) = IDX
           AND NOT EXISTS (SELECT 1 FROM emrs_d_client C WHERE C.client_id = S.client_id)
           Log Errors INTO Errlog_Client ('CLIENT_INS') Reject Limit Unlimited;

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
          SELECT c_critical, con_pkg, con_pkg || '.CLIENT_INS', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_CLIENT', CLIENT_ID
            FROM Errlog_Client
           WHERE Ora_Err_Tag$ = 'CLIENT_INS';

          v_err_cnt := SQL%RowCount;

          UPDATE CORP_ETL_JOB_STATISTICS
             SET ERROR_COUNT = v_err_cnt
               , RECORD_COUNT = v_ins_cnt + v_err_cnt
               , PROCESSED_COUNT = v_ins_cnt + v_err_cnt
           WHERE JOB_ID =  v_job_id;

          DELETE FROM Errlog_Client WHERE ora_err_tag$ = 'CLIENT_INS';

          COMMIT;

      END LOOP;

    END IF;

    Maxdat_Statistics.TABLE_STATS('EMRS_D_CLIENT');

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, con_pkg || '.CLIENT_INS', 1, v_desc, v_code, 'EMRS_D_CLIENT');

      COMMIT;
END CLIENT_INS;

PROCEDURE CLIENT_UPD
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
    to_process number := 0;
    Run_Multiple varchar2(1) := 'N';
BEGIN

    DELETE FROM Errlog_Client WHERE ora_err_tag$ = 'CLIENT_UPD';

    -- Maxdat_Statistics.TABLE_STATS('EMRS_S_CLIENT_STG');
    Maxdat_Statistics.TABLE_STATS('EMRS_D_CLIENT');

    SELECT COUNT(1) INTO to_process FROM EMRS_S_CLIENT_STG;

    SELECT CASE WHEN to_process > NVL(Value,1000000)
                THEN 'Y' ELSE 'N' END INTO Run_Multiple
      FROM CORP_ETL_CONTROL WHERE NAME = 'EMRS_REC_THRESHOLD';

    IF Run_Multiple = 'N' THEN

      INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
      VALUES (SEQ_JOB_ID.Nextval, 'CLIENT_UPD','STARTED',SYSDATE)
      RETURNING JOB_ID INTO v_job_id;

      COMMIT;

       MERGE /*+ Enable_Parallel_Dml Parallel */
        INTO  EMRS_D_CLIENT D
       USING ( SELECT
                      s.CLIENT_ID
                    , s.CLNT_CLNT_CLIENT_ID
                    , s.CLNT_FNAME
                    , s.FIRST_NAME_CANON
                    , s.FIRST_NAME_SOUNDLIKE
                    , s.CLNT_LNAME
                    , s.LAST_NAME_CANON
                    , s.LAST_NAME_SOUNDLIKE
                    , s.CLNT_MI
                    , s.CLNT_GENDER_CD
                    , s.CLNT_CITIZEN
                    , s.CLNT_ETHNICITY
                    , s.CLNT_RACE
                    , s.CLNT_DOB
                    , s.CLNT_DOD
                    , s.CLNT_TPL_PRESENT
                    , s.CLNT_SSN
                    , s.CLNT_NATIONAL_ID
                    , s.CLNT_FROM_PACMIS
                    , s.CLNT_SHARE_PREMIUM
                    , s.CLNT_NOT_BORN
                    , s.CLNT_HIPAA_PRIVACY_IND
                    , s.CLNT_FINET_VENDOR_NBR
                    , s.CLNT_ENROLL_STATUS
                    , s.CLNT_ENROLL_STATUS_DATE
                    , s.SCHED_AUTO_ASSIGN_DATE
                    , s.CLNT_CIN
                    , s.CLNT_COMMENT
                    , s.CREATED_BY
                    , s.CREATION_DATE
                    , s.LAST_UPDATED_BY
                    , s.LAST_UPDATE_DATE
                    , s.CLNT_PSEUDO_ID
                    , s.CLNT_DISPLAY_NAME
                    , s.SSNVL_ID
                    , s.NOTE_REF_ID
                    , s.CLNT_MARITAL_CD
                    , s.CLNT_STATUS_CD
                    , s.CLNT_EXPECTED_DOB
                    , s.CLNT_PREG_TERM_DATE
                    , s.CLNT_PREG_TERM_REAS_CD
                    , s.CLIENT_TYPE_CD
                    , s.SUPPLEMENTAL_NBR
                    , s.CLIENT_LANGUAGE
                    , s.STATE_LANGUAGE
                    , s.DO_NOT_CALL_IND
                    , s.WRITTEN_LANGUAGE
                    , s.SUFFIX
                    , s.SALUTATION_CD
                    , s.DOMESTIC_VIOLENCE_IND
                    , s.ENGLISH_FLUENCY_CD
                    , s.ENGLISH_LITERACY_CD
                    , s.TRIBE_CD
                    , s.CLNT_GENERIC_FIELD1_DATE
                    , s.CLNT_GENERIC_FIELD2_DATE
                    , s.CLNT_GENERIC_FIELD3_NUM
                    , s.CLNT_GENERIC_FIELD4_NUM
                    , s.CLNT_GENERIC_FIELD5_TXT
                    , s.CLNT_GENERIC_FIELD6_TXT
                    , s.CLNT_GENERIC_FIELD7_TXT
                    , s.CLNT_GENERIC_FIELD8_TXT
                    , s.CLNT_GENERIC_FIELD9_TXT
                    , s.CLNT_GENERIC_FIELD10_TXT
                    , s.CLNT_GENERIC_REF11_ID
                    , s.CLNT_GENERIC_REF12_ID
                    , s.DOD_SOURCE_CD
                    , s.DO_NOT_TEXT_IND
                    , s.DO_NOT_EMAIL_IND
                    , s.LAST_STATE_UPDATE_TS
                    , s.LAST_STATE_UPDATED_BY
                    , s.COMPARABLE_KEY
                    , s.CREATED_BY                                  AS  RECORD_NAME
                    , s.CREATION_DATE                               AS  RECORD_DATE
                    , TO_CHAR(s.CREATION_DATE, c_time_format)       AS  RECORD_TIME
                    , s.LAST_UPDATED_BY                             AS  MODIFIED_NAME
                    , s.LAST_UPDATE_DATE                            AS  MODIFIED_DATE
                    , TO_CHAR(s.LAST_UPDATE_DATE, c_time_format)    AS  MODIFIED_TIME
                 FROM EMRS_D_CLIENT D, EMRS_S_CLIENT_STG S
                WHERE D.CLIENT_ID = S.CLIENT_ID
                  ) C ON (D.CLIENT_ID = C.CLIENT_ID)
        WHEN MATCHED THEN UPDATE
         SET          
              d.CLNT_CLNT_CLIENT_ID         =   c.CLNT_CLNT_CLIENT_ID
            , d.CLNT_FNAME                  =   c.CLNT_FNAME
            , d.FIRST_NAME_CANON            =   c.FIRST_NAME_CANON
            , d.FIRST_NAME_SOUNDLIKE        =   c.FIRST_NAME_SOUNDLIKE
            , d.CLNT_LNAME                  =   c.CLNT_LNAME
            , d.LAST_NAME_CANON             =   c.LAST_NAME_CANON
            , d.LAST_NAME_SOUNDLIKE         =   c.LAST_NAME_SOUNDLIKE
            , d.CLNT_MI                     =   c.CLNT_MI
            , d.CLNT_GENDER_CD              =   c.CLNT_GENDER_CD
            , d.CLNT_CITIZEN                =   c.CLNT_CITIZEN
            , d.CLNT_ETHNICITY              =   c.CLNT_ETHNICITY
            , d.CLNT_RACE                   =   c.CLNT_RACE
            , d.CLNT_DOB                    =   c.CLNT_DOB
            , d.CLNT_DOD                    =   c.CLNT_DOD
            , d.CLNT_TPL_PRESENT            =   c.CLNT_TPL_PRESENT
            , d.CLNT_SSN                    =   c.CLNT_SSN
            , d.CLNT_NATIONAL_ID            =   c.CLNT_NATIONAL_ID
            , d.CLNT_FROM_PACMIS            =   c.CLNT_FROM_PACMIS
            , d.CLNT_SHARE_PREMIUM          =   c.CLNT_SHARE_PREMIUM
            , d.CLNT_NOT_BORN               =   c.CLNT_NOT_BORN
            , d.CLNT_HIPAA_PRIVACY_IND      =   c.CLNT_HIPAA_PRIVACY_IND
            , d.CLNT_FINET_VENDOR_NBR       =   c.CLNT_FINET_VENDOR_NBR
            , d.CLNT_ENROLL_STATUS          =   c.CLNT_ENROLL_STATUS
            , d.CLNT_ENROLL_STATUS_DATE     =   c.CLNT_ENROLL_STATUS_DATE
            , d.SCHED_AUTO_ASSIGN_DATE      =   c.SCHED_AUTO_ASSIGN_DATE
            , d.CLNT_CIN                    =   c.CLNT_CIN
            , d.CLNT_COMMENT                =   c.CLNT_COMMENT
            , d.CLNT_PSEUDO_ID              =   c.CLNT_PSEUDO_ID
            , d.CLNT_DISPLAY_NAME           =   c.CLNT_DISPLAY_NAME
            , d.SSNVL_ID                    =   c.SSNVL_ID
            , d.NOTE_REF_ID                 =   c.NOTE_REF_ID
            , d.CLNT_MARITAL_CD             =   c.CLNT_MARITAL_CD
            , d.CLNT_STATUS_CD              =   c.CLNT_STATUS_CD
            , d.CLNT_EXPECTED_DOB           =   c.CLNT_EXPECTED_DOB
            , d.CLNT_PREG_TERM_DATE         =   c.CLNT_PREG_TERM_DATE
            , d.CLNT_PREG_TERM_REAS_CD      =   c.CLNT_PREG_TERM_REAS_CD
            , d.CLIENT_TYPE_CD              =   c.CLIENT_TYPE_CD
            , d.SUPPLEMENTAL_NBR            =   c.SUPPLEMENTAL_NBR
            , d.CLIENT_LANGUAGE             =   c.CLIENT_LANGUAGE
            , d.STATE_LANGUAGE              =   c.STATE_LANGUAGE
            , d.DO_NOT_CALL_IND             =   c.DO_NOT_CALL_IND
            , d.WRITTEN_LANGUAGE            =   c.WRITTEN_LANGUAGE
            , d.SUFFIX                      =   c.SUFFIX
            , d.SALUTATION_CD               =   c.SALUTATION_CD
            , d.DOMESTIC_VIOLENCE_IND       =   c.DOMESTIC_VIOLENCE_IND
            , d.ENGLISH_FLUENCY_CD          =   c.ENGLISH_FLUENCY_CD
            , d.ENGLISH_LITERACY_CD         =   c.ENGLISH_LITERACY_CD
            , d.TRIBE_CD                    =   c.TRIBE_CD
            , d.CLNT_GENERIC_FIELD1_DATE    =   c.CLNT_GENERIC_FIELD1_DATE
            , d.CLNT_GENERIC_FIELD2_DATE    =   c.CLNT_GENERIC_FIELD2_DATE
            , d.CLNT_GENERIC_FIELD3_NUM     =   c.CLNT_GENERIC_FIELD3_NUM
            , d.CLNT_GENERIC_FIELD4_NUM     =   c.CLNT_GENERIC_FIELD4_NUM
            , d.CLNT_GENERIC_FIELD5_TXT     =   c.CLNT_GENERIC_FIELD5_TXT
            , d.CLNT_GENERIC_FIELD6_TXT     =   c.CLNT_GENERIC_FIELD6_TXT
            , d.CLNT_GENERIC_FIELD7_TXT     =   c.CLNT_GENERIC_FIELD7_TXT
            , d.CLNT_GENERIC_FIELD8_TXT     =   c.CLNT_GENERIC_FIELD8_TXT
            , d.CLNT_GENERIC_FIELD9_TXT     =   c.CLNT_GENERIC_FIELD9_TXT
            , d.CLNT_GENERIC_FIELD10_TXT    =   c.CLNT_GENERIC_FIELD10_TXT
            , d.CLNT_GENERIC_REF11_ID       =   c.CLNT_GENERIC_REF11_ID
            , d.CLNT_GENERIC_REF12_ID       =   c.CLNT_GENERIC_REF12_ID
            , d.DOD_SOURCE_CD               =   c.DOD_SOURCE_CD
            , d.DO_NOT_TEXT_IND             =   c.DO_NOT_TEXT_IND
            , d.DO_NOT_EMAIL_IND            =   c.DO_NOT_EMAIL_IND
            , d.LAST_STATE_UPDATE_TS        =   c.LAST_STATE_UPDATE_TS
            , d.LAST_STATE_UPDATED_BY       =   c.LAST_STATE_UPDATED_BY
            , d.COMPARABLE_KEY              =   c.COMPARABLE_KEY
            , d.RECORD_NAME                 =   c.RECORD_NAME
            , d.RECORD_DATE                 =   c.RECORD_DATE
            , d.RECORD_TIME                 =   c.RECORD_TIME
            , d.MODIFIED_NAME               =   c.MODIFIED_NAME
            , d.MODIFIED_DATE               =   c.MODIFIED_DATE
            , d.MODIFIED_TIME               =   c.MODIFIED_TIME
         Log Errors INTO Errlog_Client ('CLIENT_UPD') Reject Limit Unlimited;

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
          SELECT c_critical, con_pkg, con_pkg || '.CLIENT_UPD', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_CLIENT', CLIENT_ID
            FROM Errlog_Client
           WHERE Ora_Err_Tag$ = 'CLIENT_UPD';

          v_err_cnt := SQL%RowCount;

          UPDATE CORP_ETL_JOB_STATISTICS
             SET ERROR_COUNT = v_err_cnt
               , RECORD_COUNT = v_upd_cnt + v_err_cnt
               , PROCESSED_COUNT = v_upd_cnt + v_err_cnt
           WHERE JOB_ID =  v_job_id;

          COMMIT;

    ELSE

       FOR IDX In 0..9
       LOOP

            INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
            VALUES (SEQ_JOB_ID.Nextval, 'CLIENT_UPD THREAD'||IDX,'STARTED',SYSDATE)
            RETURNING JOB_ID INTO v_job_id;

            COMMIT;

               MERGE /*+ Enable_Parallel_Dml Parallel */
                INTO  EMRS_D_CLIENT D
               USING ( SELECT
                              s.CLIENT_ID
                            , s.CLNT_CLNT_CLIENT_ID
                            , s.CLNT_FNAME
                            , s.FIRST_NAME_CANON
                            , s.FIRST_NAME_SOUNDLIKE
                            , s.CLNT_LNAME
                            , s.LAST_NAME_CANON
                            , s.LAST_NAME_SOUNDLIKE
                            , s.CLNT_MI
                            , s.CLNT_GENDER_CD
                            , s.CLNT_CITIZEN
                            , s.CLNT_ETHNICITY
                            , s.CLNT_RACE
                            , s.CLNT_DOB
                            , s.CLNT_DOD
                            , s.CLNT_TPL_PRESENT
                            , s.CLNT_SSN
                            , s.CLNT_NATIONAL_ID
                            , s.CLNT_FROM_PACMIS
                            , s.CLNT_SHARE_PREMIUM
                            , s.CLNT_NOT_BORN
                            , s.CLNT_HIPAA_PRIVACY_IND
                            , s.CLNT_FINET_VENDOR_NBR
                            , s.CLNT_ENROLL_STATUS
                            , s.CLNT_ENROLL_STATUS_DATE
                            , s.SCHED_AUTO_ASSIGN_DATE
                            , s.CLNT_CIN
                            , s.CLNT_COMMENT
                            , s.CREATED_BY
                            , s.CREATION_DATE
                            , s.LAST_UPDATED_BY
                            , s.LAST_UPDATE_DATE
                            , s.CLNT_PSEUDO_ID
                            , s.CLNT_DISPLAY_NAME
                            , s.SSNVL_ID
                            , s.NOTE_REF_ID
                            , s.CLNT_MARITAL_CD
                            , s.CLNT_STATUS_CD
                            , s.CLNT_EXPECTED_DOB
                            , s.CLNT_PREG_TERM_DATE
                            , s.CLNT_PREG_TERM_REAS_CD
                            , s.CLIENT_TYPE_CD
                            , s.SUPPLEMENTAL_NBR
                            , s.CLIENT_LANGUAGE
                            , s.STATE_LANGUAGE
                            , s.DO_NOT_CALL_IND
                            , s.WRITTEN_LANGUAGE
                            , s.SUFFIX
                            , s.SALUTATION_CD
                            , s.DOMESTIC_VIOLENCE_IND
                            , s.ENGLISH_FLUENCY_CD
                            , s.ENGLISH_LITERACY_CD
                            , s.TRIBE_CD
                            , s.CLNT_GENERIC_FIELD1_DATE
                            , s.CLNT_GENERIC_FIELD2_DATE
                            , s.CLNT_GENERIC_FIELD3_NUM
                            , s.CLNT_GENERIC_FIELD4_NUM
                            , s.CLNT_GENERIC_FIELD5_TXT
                            , s.CLNT_GENERIC_FIELD6_TXT
                            , s.CLNT_GENERIC_FIELD7_TXT
                            , s.CLNT_GENERIC_FIELD8_TXT
                            , s.CLNT_GENERIC_FIELD9_TXT
                            , s.CLNT_GENERIC_FIELD10_TXT
                            , s.CLNT_GENERIC_REF11_ID
                            , s.CLNT_GENERIC_REF12_ID
                            , s.DOD_SOURCE_CD
                            , s.DO_NOT_TEXT_IND
                            , s.DO_NOT_EMAIL_IND
                            , s.LAST_STATE_UPDATE_TS
                            , s.LAST_STATE_UPDATED_BY
                            , s.COMPARABLE_KEY
                            , s.CREATED_BY                                  AS  RECORD_NAME
                            , s.CREATION_DATE                               AS  RECORD_DATE
                            , TO_CHAR(s.CREATION_DATE, c_time_format)       AS  RECORD_TIME
                            , s.LAST_UPDATED_BY                             AS  MODIFIED_NAME
                            , s.LAST_UPDATE_DATE                            AS  MODIFIED_DATE
                            , TO_CHAR(s.LAST_UPDATE_DATE, c_time_format)    AS  MODIFIED_TIME
                         FROM EMRS_D_CLIENT D, EMRS_S_CLIENT_STG S
                        WHERE D.CLIENT_ID = S.CLIENT_ID
                         AND  SUBSTR(S.CLIENT_ID, -1) = IDX
                          ) C ON (D.CLIENT_ID = C.CLIENT_ID)
                WHEN MATCHED THEN UPDATE
                 SET          
                      d.CLNT_CLNT_CLIENT_ID         =   c.CLNT_CLNT_CLIENT_ID
                    , d.CLNT_FNAME                  =   c.CLNT_FNAME
                    , d.FIRST_NAME_CANON            =   c.FIRST_NAME_CANON
                    , d.FIRST_NAME_SOUNDLIKE        =   c.FIRST_NAME_SOUNDLIKE
                    , d.CLNT_LNAME                  =   c.CLNT_LNAME
                    , d.LAST_NAME_CANON             =   c.LAST_NAME_CANON
                    , d.LAST_NAME_SOUNDLIKE         =   c.LAST_NAME_SOUNDLIKE
                    , d.CLNT_MI                     =   c.CLNT_MI
                    , d.CLNT_GENDER_CD              =   c.CLNT_GENDER_CD
                    , d.CLNT_CITIZEN                =   c.CLNT_CITIZEN
                    , d.CLNT_ETHNICITY              =   c.CLNT_ETHNICITY
                    , d.CLNT_RACE                   =   c.CLNT_RACE
                    , d.CLNT_DOB                    =   c.CLNT_DOB
                    , d.CLNT_DOD                    =   c.CLNT_DOD
                    , d.CLNT_TPL_PRESENT            =   c.CLNT_TPL_PRESENT
                    , d.CLNT_SSN                    =   c.CLNT_SSN
                    , d.CLNT_NATIONAL_ID            =   c.CLNT_NATIONAL_ID
                    , d.CLNT_FROM_PACMIS            =   c.CLNT_FROM_PACMIS
                    , d.CLNT_SHARE_PREMIUM          =   c.CLNT_SHARE_PREMIUM
                    , d.CLNT_NOT_BORN               =   c.CLNT_NOT_BORN
                    , d.CLNT_HIPAA_PRIVACY_IND      =   c.CLNT_HIPAA_PRIVACY_IND
                    , d.CLNT_FINET_VENDOR_NBR       =   c.CLNT_FINET_VENDOR_NBR
                    , d.CLNT_ENROLL_STATUS          =   c.CLNT_ENROLL_STATUS
                    , d.CLNT_ENROLL_STATUS_DATE     =   c.CLNT_ENROLL_STATUS_DATE
                    , d.SCHED_AUTO_ASSIGN_DATE      =   c.SCHED_AUTO_ASSIGN_DATE
                    , d.CLNT_CIN                    =   c.CLNT_CIN
                    , d.CLNT_COMMENT                =   c.CLNT_COMMENT
                    , d.CLNT_PSEUDO_ID              =   c.CLNT_PSEUDO_ID
                    , d.CLNT_DISPLAY_NAME           =   c.CLNT_DISPLAY_NAME
                    , d.SSNVL_ID                    =   c.SSNVL_ID
                    , d.NOTE_REF_ID                 =   c.NOTE_REF_ID
                    , d.CLNT_MARITAL_CD             =   c.CLNT_MARITAL_CD
                    , d.CLNT_STATUS_CD              =   c.CLNT_STATUS_CD
                    , d.CLNT_EXPECTED_DOB           =   c.CLNT_EXPECTED_DOB
                    , d.CLNT_PREG_TERM_DATE         =   c.CLNT_PREG_TERM_DATE
                    , d.CLNT_PREG_TERM_REAS_CD      =   c.CLNT_PREG_TERM_REAS_CD
                    , d.CLIENT_TYPE_CD              =   c.CLIENT_TYPE_CD
                    , d.SUPPLEMENTAL_NBR            =   c.SUPPLEMENTAL_NBR
                    , d.CLIENT_LANGUAGE             =   c.CLIENT_LANGUAGE
                    , d.STATE_LANGUAGE              =   c.STATE_LANGUAGE
                    , d.DO_NOT_CALL_IND             =   c.DO_NOT_CALL_IND
                    , d.WRITTEN_LANGUAGE            =   c.WRITTEN_LANGUAGE
                    , d.SUFFIX                      =   c.SUFFIX
                    , d.SALUTATION_CD               =   c.SALUTATION_CD
                    , d.DOMESTIC_VIOLENCE_IND       =   c.DOMESTIC_VIOLENCE_IND
                    , d.ENGLISH_FLUENCY_CD          =   c.ENGLISH_FLUENCY_CD
                    , d.ENGLISH_LITERACY_CD         =   c.ENGLISH_LITERACY_CD
                    , d.TRIBE_CD                    =   c.TRIBE_CD
                    , d.CLNT_GENERIC_FIELD1_DATE    =   c.CLNT_GENERIC_FIELD1_DATE
                    , d.CLNT_GENERIC_FIELD2_DATE    =   c.CLNT_GENERIC_FIELD2_DATE
                    , d.CLNT_GENERIC_FIELD3_NUM     =   c.CLNT_GENERIC_FIELD3_NUM
                    , d.CLNT_GENERIC_FIELD4_NUM     =   c.CLNT_GENERIC_FIELD4_NUM
                    , d.CLNT_GENERIC_FIELD5_TXT     =   c.CLNT_GENERIC_FIELD5_TXT
                    , d.CLNT_GENERIC_FIELD6_TXT     =   c.CLNT_GENERIC_FIELD6_TXT
                    , d.CLNT_GENERIC_FIELD7_TXT     =   c.CLNT_GENERIC_FIELD7_TXT
                    , d.CLNT_GENERIC_FIELD8_TXT     =   c.CLNT_GENERIC_FIELD8_TXT
                    , d.CLNT_GENERIC_FIELD9_TXT     =   c.CLNT_GENERIC_FIELD9_TXT
                    , d.CLNT_GENERIC_FIELD10_TXT    =   c.CLNT_GENERIC_FIELD10_TXT
                    , d.CLNT_GENERIC_REF11_ID       =   c.CLNT_GENERIC_REF11_ID
                    , d.CLNT_GENERIC_REF12_ID       =   c.CLNT_GENERIC_REF12_ID
                    , d.DOD_SOURCE_CD               =   c.DOD_SOURCE_CD
                    , d.DO_NOT_TEXT_IND             =   c.DO_NOT_TEXT_IND
                    , d.DO_NOT_EMAIL_IND            =   c.DO_NOT_EMAIL_IND
                    , d.LAST_STATE_UPDATE_TS        =   c.LAST_STATE_UPDATE_TS
                    , d.LAST_STATE_UPDATED_BY       =   c.LAST_STATE_UPDATED_BY
                    , d.COMPARABLE_KEY              =   c.COMPARABLE_KEY
                    , d.RECORD_NAME                 =   c.RECORD_NAME
                    , d.RECORD_DATE                 =   c.RECORD_DATE
                    , d.RECORD_TIME                 =   c.RECORD_TIME
                    , d.MODIFIED_NAME               =   c.MODIFIED_NAME
                    , d.MODIFIED_DATE               =   c.MODIFIED_DATE
                    , d.MODIFIED_TIME               =   c.MODIFIED_TIME
                 Log Errors INTO Errlog_Client ('CLIENT_UPD') Reject Limit Unlimited;

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
                SELECT c_critical, con_pkg, con_pkg || '.CLIENT_UPD', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_CLIENT', CLIENT_ID
                  FROM Errlog_Client
                 WHERE Ora_Err_Tag$ = 'CLIENT_UPD';

                v_err_cnt := SQL%RowCount;

                UPDATE CORP_ETL_JOB_STATISTICS
                   SET ERROR_COUNT = v_err_cnt
                     , RECORD_COUNT = v_upd_cnt + v_err_cnt
                     , PROCESSED_COUNT = v_upd_cnt + v_err_cnt
                 WHERE JOB_ID =  v_job_id;

                 DELETE FROM Errlog_Client WHERE ora_err_tag$ = 'CLIENT_UPD';

                COMMIT;

      END LOOP;

    END IF;

    Maxdat_Statistics.TABLE_STATS('EMRS_D_CLIENT');


EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, con_pkg || '.CLIENT_UPD', 1, v_desc, v_code, 'EMRS_D_CLIENT');

      COMMIT;
END CLIENT_UPD;

PROCEDURE CASE_CLIENT_INS
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_ins_cnt number;
    v_err_cnt number;
    to_process number := 0;
    Run_Multiple varchar2(1) := 'N';
BEGIN

    DELETE FROM Errlog_CSCL WHERE ora_err_tag$ = 'CASE_CLIENT_INS';

    Maxdat_Statistics.TABLE_STATS('EMRS_S_CASE_CLIENT_STG');

    SELECT COUNT(1) INTO to_process FROM EMRS_S_CASE_CLIENT_STG;

    SELECT CASE WHEN to_process > NVL(Value,1000000)
                THEN 'Y' ELSE 'N' END INTO Run_Multiple
      FROM CORP_ETL_CONTROL WHERE NAME = 'EMRS_REC_THRESHOLD';

    IF Run_Multiple = 'N' THEN

        INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
        VALUES (SEQ_JOB_ID.Nextval, 'CASE_CLIENT_INS','STARTED',SYSDATE)
        RETURNING JOB_ID INTO v_job_id;

        COMMIT;

        INSERT /*+ Enable_Parallel_Dml Parallel */
          INTO Emrs_D_Case_Client 
                        (  
                              CASE_CLIENT_ID
                            , CSCL_STATUS_BEGIN_DATE
                            , CSCL_CLOSE_REASON
                            , CSCL_RELATIONSHIP_CD
                            , CSCL_ELIG_DETERMINATION_DATE
                            , CSCL_MEDICAL_IND
                            , CASE_ID
                            , CLIENT_ID
                            , CSCL_STATUS_END_DATE
                            , CSCL_BYB_TEMP_ID
                            , CSCL_APPL_CLIENT_ID
                            , CSCL_ACTUAL_TERM_DATE
                            , CSCL_PACMIS_STATUS_CD
                            , CSCL_LEGACY
                            , RHSP
                            , RHGA
                            , CSCL_STATUS_CD
                            , CSCL_ADLK_ID
                            , CSCL_RES_ADDR_ID
                            , CSCL_ELIG_BEGIN_DT
                            , CSCL_ELIG_END_DT
                            , ANNIVERSARY_DT
                            , PROGRAM_CD
                            , PROGRAM_STATUS_CD
                            , ELIG_BEGIN_ND
                            , ELIG_END_ND
                            , EPISODE_ID
                            , CSCL_GENERIC_FIELD1_DATE
                            , CSCL_GENERIC_FIELD2_DATE
                            , CSCL_GENERIC_FIELD3_NUM
                            , CSCL_GENERIC_FIELD4_NUM
                            , CSCL_GENERIC_FIELD5_TXT
                            , CSCL_GENERIC_FIELD6_TXT
                            , CSCL_GENERIC_FIELD7_TXT
                            , CSCL_GENERIC_FIELD8_TXT
                            , CSCL_GENERIC_FIELD9_TXT
                            , CSCL_GENERIC_FIELD10_TXT
                            , CSCL_GENERIC_REF11_ID
                            , CSCL_GENERIC_REF12_ID
                            , STATUS_BEGIN_NDT
                            , STATUS_END_NDT
                            , CHANGE_NOTES
                            , RECORD_NAME
                            , RECORD_DATE
                            , RECORD_TIME
                            , MODIFIED_NAME
                            , MODIFIED_DATE
                            , MODIFIED_TIME
                        )
        SELECT                CSCL_ID
                            , CSCL_STATUS_BEGIN_DATE
                            , CSCL_CLOSE_REASON
                            , CSCL_RELATIONSHIP_CD
                            , CSCL_ELIG_DETERMINATION_DATE
                            , CSCL_MEDICAL_IND
                            , CSCL_CASE_ID
                            , CSCL_CLNT_CLIENT_ID
                            , CSCL_STATUS_END_DATE
                            , CSCL_BYB_TEMP_ID
                            , CSCL_APPL_CLIENT_ID
                            , CSCL_ACTUAL_TERM_DATE
                            , CSCL_PACMIS_STATUS_CD
                            , CSCL_LEGACY
                            , RHSP
                            , RHGA
                            , CSCL_STATUS_CD
                            , CSCL_ADLK_ID
                            , CSCL_RES_ADDR_ID
                            , CSCL_ELIG_BEGIN_DT
                            , CSCL_ELIG_END_DT
                            , ANNIVERSARY_DT
                            , PROGRAM_CD
                            , PROGRAM_STATUS_CD
                            , ELIG_BEGIN_ND
                            , ELIG_END_ND
                            , EPISODE_ID
                            , CSCL_GENERIC_FIELD1_DATE
                            , CSCL_GENERIC_FIELD2_DATE
                            , CSCL_GENERIC_FIELD3_NUM
                            , CSCL_GENERIC_FIELD4_NUM
                            , CSCL_GENERIC_FIELD5_TXT
                            , CSCL_GENERIC_FIELD6_TXT
                            , CSCL_GENERIC_FIELD7_TXT
                            , CSCL_GENERIC_FIELD8_TXT
                            , CSCL_GENERIC_FIELD9_TXT
                            , CSCL_GENERIC_FIELD10_TXT
                            , CSCL_GENERIC_REF11_ID
                            , CSCL_GENERIC_REF12_ID
                            , STATUS_BEGIN_NDT
                            , STATUS_END_NDT
                            , CHANGE_NOTES
                            , CREATED_BY
                            , CREATION_DATE
                            , TO_CHAR(CREATION_DATE, c_time_format)
                            , LAST_UPDATED_BY
                            , LAST_UPDATE_DATE
                            , TO_CHAR(LAST_UPDATE_DATE, c_time_format)                                                            
          FROM emrs_s_case_client_stg s
         WHERE NOT EXISTS (SELECT 1 FROM emrs_d_case_client C WHERE C.case_client_id = S.cscl_id)
           Log Errors INTO Errlog_CSCL ('CASE_CLIENT_INS') Reject Limit Unlimited;

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
        SELECT c_critical, con_pkg, con_pkg || '.CASE_CLIENT_INS', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_CASE_CLIENT', CASE_CLIENT_ID
          FROM Errlog_CSCL
         WHERE Ora_Err_Tag$ = 'CASE_CLIENT_INS';

        v_err_cnt := SQL%RowCount;

        UPDATE CORP_ETL_JOB_STATISTICS
           SET ERROR_COUNT = v_err_cnt
             , RECORD_COUNT = v_ins_cnt + v_err_cnt
             , PROCESSED_COUNT = v_ins_cnt + v_err_cnt
         WHERE JOB_ID =  v_job_id;

        COMMIT;

    ELSE

       FOR IDX In 0..9
       LOOP

            Maxdat_Statistics.TABLE_STATS('EMRS_D_CASE_CLIENT');

            INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
            VALUES (SEQ_JOB_ID.Nextval, 'CASE_CLIENT_INS THREAD'||IDX,'STARTED',SYSDATE)
            RETURNING JOB_ID INTO v_job_id;

            COMMIT;

        INSERT /*+ Enable_Parallel_Dml Parallel */
          INTO Emrs_D_Case_Client 
                        (  
                              CASE_CLIENT_ID
                            , CSCL_STATUS_BEGIN_DATE
                            , CSCL_CLOSE_REASON
                            , CSCL_RELATIONSHIP_CD
                            , CSCL_ELIG_DETERMINATION_DATE
                            , CSCL_MEDICAL_IND
                            , CASE_ID
                            , CLIENT_ID
                            , CSCL_STATUS_END_DATE
                            , CSCL_BYB_TEMP_ID
                            , CSCL_APPL_CLIENT_ID
                            , CSCL_ACTUAL_TERM_DATE
                            , CSCL_PACMIS_STATUS_CD
                            , CSCL_LEGACY
                            , RHSP
                            , RHGA
                            , CSCL_STATUS_CD
                            , CSCL_ADLK_ID
                            , CSCL_RES_ADDR_ID
                            , CSCL_ELIG_BEGIN_DT
                            , CSCL_ELIG_END_DT
                            , ANNIVERSARY_DT
                            , PROGRAM_CD
                            , PROGRAM_STATUS_CD
                            , ELIG_BEGIN_ND
                            , ELIG_END_ND
                            , EPISODE_ID
                            , CSCL_GENERIC_FIELD1_DATE
                            , CSCL_GENERIC_FIELD2_DATE
                            , CSCL_GENERIC_FIELD3_NUM
                            , CSCL_GENERIC_FIELD4_NUM
                            , CSCL_GENERIC_FIELD5_TXT
                            , CSCL_GENERIC_FIELD6_TXT
                            , CSCL_GENERIC_FIELD7_TXT
                            , CSCL_GENERIC_FIELD8_TXT
                            , CSCL_GENERIC_FIELD9_TXT
                            , CSCL_GENERIC_FIELD10_TXT
                            , CSCL_GENERIC_REF11_ID
                            , CSCL_GENERIC_REF12_ID
                            , STATUS_BEGIN_NDT
                            , STATUS_END_NDT
                            , CHANGE_NOTES
                            , RECORD_NAME
                            , RECORD_DATE
                            , RECORD_TIME
                            , MODIFIED_NAME
                            , MODIFIED_DATE
                            , MODIFIED_TIME
                        )
        SELECT                CSCL_ID
                            , CSCL_STATUS_BEGIN_DATE
                            , CSCL_CLOSE_REASON
                            , CSCL_RELATIONSHIP_CD
                            , CSCL_ELIG_DETERMINATION_DATE
                            , CSCL_MEDICAL_IND
                            , CSCL_CASE_ID
                            , CSCL_CLNT_CLIENT_ID
                            , CSCL_STATUS_END_DATE
                            , CSCL_BYB_TEMP_ID
                            , CSCL_APPL_CLIENT_ID
                            , CSCL_ACTUAL_TERM_DATE
                            , CSCL_PACMIS_STATUS_CD
                            , CSCL_LEGACY
                            , RHSP
                            , RHGA
                            , CSCL_STATUS_CD
                            , CSCL_ADLK_ID
                            , CSCL_RES_ADDR_ID
                            , CSCL_ELIG_BEGIN_DT
                            , CSCL_ELIG_END_DT
                            , ANNIVERSARY_DT
                            , PROGRAM_CD
                            , PROGRAM_STATUS_CD
                            , ELIG_BEGIN_ND
                            , ELIG_END_ND
                            , EPISODE_ID
                            , CSCL_GENERIC_FIELD1_DATE
                            , CSCL_GENERIC_FIELD2_DATE
                            , CSCL_GENERIC_FIELD3_NUM
                            , CSCL_GENERIC_FIELD4_NUM
                            , CSCL_GENERIC_FIELD5_TXT
                            , CSCL_GENERIC_FIELD6_TXT
                            , CSCL_GENERIC_FIELD7_TXT
                            , CSCL_GENERIC_FIELD8_TXT
                            , CSCL_GENERIC_FIELD9_TXT
                            , CSCL_GENERIC_FIELD10_TXT
                            , CSCL_GENERIC_REF11_ID
                            , CSCL_GENERIC_REF12_ID
                            , STATUS_BEGIN_NDT
                            , STATUS_END_NDT
                            , CHANGE_NOTES
                            , CREATED_BY
                            , CREATION_DATE
                            , TO_CHAR(CREATION_DATE, c_time_format)
                            , LAST_UPDATED_BY
                            , LAST_UPDATE_DATE
                            , TO_CHAR(LAST_UPDATE_DATE, c_time_format)                                                            
          FROM emrs_s_case_client_stg s
         WHERE SUBSTR(S.CSCL_ID,-1) = IDX
           AND NOT EXISTS (SELECT 1 FROM emrs_d_case_client C WHERE C.case_client_id = S.cscl_id)
           Log Errors INTO Errlog_CSCL ('CASE_CLIENT_INS') Reject Limit Unlimited;

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
            SELECT c_critical, con_pkg, con_pkg || '.CASE_CLIENT_INS', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_CASE_CLIENT', CASE_ID
              FROM Errlog_CSCL
             WHERE Ora_Err_Tag$ = 'CASE_CLIENT_INS';

            v_err_cnt := SQL%RowCount;

            UPDATE CORP_ETL_JOB_STATISTICS
               SET ERROR_COUNT = v_err_cnt
                 , RECORD_COUNT = v_ins_cnt + v_err_cnt
                 , PROCESSED_COUNT = v_ins_cnt + v_err_cnt
             WHERE JOB_ID =  v_job_id;

            DELETE FROM Errlog_CSCL WHERE ora_err_tag$ = 'CASE_CLIENT_INS';

            COMMIT;

       END LOOP;

    END IF;

    Maxdat_Statistics.TABLE_STATS('EMRS_D_CASE_CLIENT');

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, con_pkg || '.CASE_CLIENT_INS', 1, v_desc, v_code, 'EMRS_D_CASE_CLIENT');

      COMMIT;
END CASE_CLIENT_INS;

PROCEDURE CASE_CLIENT_UPD
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
    to_process number := 0;
    Run_Multiple varchar2(1) := 'N';
BEGIN

    DELETE FROM Errlog_CSCL WHERE ora_err_tag$ = 'CASE_CLIENT_UPD';

    Maxdat_Statistics.TABLE_STATS('EMRS_S_CASE_CLIENT_STG');

    SELECT COUNT(1) INTO to_process FROM EMRS_S_CASE_CLIENT_STG;

    SELECT CASE WHEN to_process > NVL(Value,1000000)
                THEN 'Y' ELSE 'N' END INTO Run_Multiple
      FROM CORP_ETL_CONTROL WHERE NAME = 'EMRS_REC_THRESHOLD';

    IF Run_Multiple = 'N' THEN

       INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
       VALUES (SEQ_JOB_ID.Nextval, 'CASE_CLIENT_UPD','STARTED',SYSDATE)
       RETURNING JOB_ID INTO v_job_id;

       COMMIT;

       Maxdat_Statistics.TABLE_STATS('EMRS_D_CASE_CLIENT');

       MERGE /*+ Enable_Parallel_Dml Parallel */
        INTO  EMRS_D_CASE_CLIENT D
       USING ( 
                SELECT                
                          s.CSCL_ID
                        , s.CSCL_STATUS_BEGIN_DATE
                        , s.CSCL_CLOSE_REASON
                        , s.CSCL_RELATIONSHIP_CD
                        , s.CSCL_ELIG_DETERMINATION_DATE
                        , s.CSCL_MEDICAL_IND
                        , s.CSCL_CASE_ID
                        , s.CSCL_CLNT_CLIENT_ID
                        , s.CSCL_STATUS_END_DATE
                        , s.CSCL_BYB_TEMP_ID
                        , s.CSCL_APPL_CLIENT_ID
                        , s.CSCL_ACTUAL_TERM_DATE
                        , s.CSCL_PACMIS_STATUS_CD
                        , s.CSCL_LEGACY
                        , s.RHSP
                        , s.RHGA
                        , s.CSCL_STATUS_CD
                        , s.CSCL_ADLK_ID
                        , s.CSCL_RES_ADDR_ID
                        , s.CSCL_ELIG_BEGIN_DT
                        , s.CSCL_ELIG_END_DT
                        , s.ANNIVERSARY_DT
                        , s.PROGRAM_CD
                        , s.PROGRAM_STATUS_CD
                        , s.ELIG_BEGIN_ND
                        , s.ELIG_END_ND
                        , s.EPISODE_ID
                        , s.CSCL_GENERIC_FIELD1_DATE
                        , s.CSCL_GENERIC_FIELD2_DATE
                        , s.CSCL_GENERIC_FIELD3_NUM
                        , s.CSCL_GENERIC_FIELD4_NUM
                        , s.CSCL_GENERIC_FIELD5_TXT
                        , s.CSCL_GENERIC_FIELD6_TXT
                        , s.CSCL_GENERIC_FIELD7_TXT
                        , s.CSCL_GENERIC_FIELD8_TXT
                        , s.CSCL_GENERIC_FIELD9_TXT
                        , s.CSCL_GENERIC_FIELD10_TXT
                        , s.CSCL_GENERIC_REF11_ID
                        , s.CSCL_GENERIC_REF12_ID
                        , s.STATUS_BEGIN_NDT
                        , s.STATUS_END_NDT
                        , s.CHANGE_NOTES
                        , s.CREATED_BY                                  AS  RECORD_NAME
                        , s.CREATION_DATE                               AS  RECORD_DATE
                        , TO_CHAR(s.CREATION_DATE, c_time_format)       AS  RECORD_TIME
                        , s.LAST_UPDATED_BY                             AS  MODIFIED_NAME
                        , s.LAST_UPDATE_DATE                            AS  MODIFIED_DATE
                        , TO_CHAR(s.LAST_UPDATE_DATE, c_time_format)    AS  MODIFIED_TIME
                 FROM EMRS_D_CASE_CLIENT D, EMRS_S_CASE_CLIENT_STG S
                WHERE D.CASE_CLIENT_ID = S.CSCL_ID
              ) C ON (D.CASE_CLIENT_ID = C.CSCL_ID)
        WHEN MATCHED THEN UPDATE
         SET              
                          d.CSCL_STATUS_BEGIN_DATE                  =   c.CSCL_STATUS_BEGIN_DATE
                        , d.CSCL_CLOSE_REASON                       =   c.CSCL_CLOSE_REASON
                        , d.CSCL_RELATIONSHIP_CD                    =   c.CSCL_RELATIONSHIP_CD
                        , d.CSCL_ELIG_DETERMINATION_DATE            =   c.CSCL_ELIG_DETERMINATION_DATE
                        , d.CSCL_MEDICAL_IND                        =   c.CSCL_MEDICAL_IND
                        , d.CASE_ID                                 =   c.CSCL_CASE_ID
                        , d.CLIENT_ID                               =   c.CSCL_CLNT_CLIENT_ID
                        , d.CSCL_STATUS_END_DATE                    =   c.CSCL_STATUS_END_DATE
                        , d.CSCL_BYB_TEMP_ID                        =   c.CSCL_BYB_TEMP_ID
                        , d.CSCL_APPL_CLIENT_ID                     =   c.CSCL_APPL_CLIENT_ID
                        , d.CSCL_ACTUAL_TERM_DATE                   =   c.CSCL_ACTUAL_TERM_DATE
                        , d.CSCL_PACMIS_STATUS_CD                   =   c.CSCL_PACMIS_STATUS_CD
                        , d.CSCL_LEGACY                             =   c.CSCL_LEGACY
                        , d.RHSP                                    =   c.RHSP
                        , d.RHGA                                    =   c.RHGA
                        , d.CSCL_STATUS_CD                          =   c.CSCL_STATUS_CD
                        , d.CSCL_ADLK_ID                            =   c.CSCL_ADLK_ID
                        , d.CSCL_RES_ADDR_ID                        =   c.CSCL_RES_ADDR_ID
                        , d.CSCL_ELIG_BEGIN_DT                      =   c.CSCL_ELIG_BEGIN_DT
                        , d.CSCL_ELIG_END_DT                        =   c.CSCL_ELIG_END_DT
                        , d.ANNIVERSARY_DT                          =   c.ANNIVERSARY_DT
                        , d.PROGRAM_CD                              =   c.PROGRAM_CD
                        , d.PROGRAM_STATUS_CD                       =   c.PROGRAM_STATUS_CD
                        , d.ELIG_BEGIN_ND                           =   c.ELIG_BEGIN_ND
                        , d.ELIG_END_ND                             =   c.ELIG_END_ND
                        , d.EPISODE_ID                              =   c.EPISODE_ID
                        , d.CSCL_GENERIC_FIELD1_DATE                =   c.CSCL_GENERIC_FIELD1_DATE
                        , d.CSCL_GENERIC_FIELD2_DATE                =   c.CSCL_GENERIC_FIELD2_DATE
                        , d.CSCL_GENERIC_FIELD3_NUM                 =   c.CSCL_GENERIC_FIELD3_NUM
                        , d.CSCL_GENERIC_FIELD4_NUM                 =   c.CSCL_GENERIC_FIELD4_NUM
                        , d.CSCL_GENERIC_FIELD5_TXT                 =   c.CSCL_GENERIC_FIELD5_TXT
                        , d.CSCL_GENERIC_FIELD6_TXT                 =   c.CSCL_GENERIC_FIELD6_TXT
                        , d.CSCL_GENERIC_FIELD7_TXT                 =   c.CSCL_GENERIC_FIELD7_TXT
                        , d.CSCL_GENERIC_FIELD8_TXT                 =   c.CSCL_GENERIC_FIELD8_TXT
                        , d.CSCL_GENERIC_FIELD9_TXT                 =   c.CSCL_GENERIC_FIELD9_TXT
                        , d.CSCL_GENERIC_FIELD10_TXT                =   c.CSCL_GENERIC_FIELD10_TXT
                        , d.CSCL_GENERIC_REF11_ID                   =   c.CSCL_GENERIC_REF11_ID
                        , d.CSCL_GENERIC_REF12_ID                   =   c.CSCL_GENERIC_REF12_ID
                        , d.STATUS_BEGIN_NDT                        =   c.STATUS_BEGIN_NDT
                        , d.STATUS_END_NDT                          =   c.STATUS_END_NDT
                        , d.CHANGE_NOTES                            =   c.CHANGE_NOTES
                        , d.RECORD_NAME                             =   c.RECORD_NAME
                        , d.RECORD_DATE                             =   c.RECORD_DATE
                        , d.RECORD_TIME                             =   c.RECORD_TIME
                        , d.MODIFIED_NAME                           =   c.MODIFIED_NAME
                        , d.MODIFIED_DATE                           =   c.MODIFIED_DATE
                        , d.MODIFIED_TIME                           =   c.MODIFIED_TIME
         Log Errors INTO Errlog_CSCL ('CASE_CLIENT_UPD') Reject Limit Unlimited;

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
        SELECT c_critical, con_pkg, con_pkg || '.CASE_CLIENT_UPD', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_CASE_CLIENT', CASE_CLIENT_ID
          FROM Errlog_CSCL
         WHERE Ora_Err_Tag$ = 'CASE_CLIENT_UPD';

        v_err_cnt := SQL%RowCount;

        UPDATE CORP_ETL_JOB_STATISTICS
           SET ERROR_COUNT = v_err_cnt
             , RECORD_COUNT = v_upd_cnt + v_err_cnt
             , PROCESSED_COUNT = v_upd_cnt + v_err_cnt
         WHERE JOB_ID =  v_job_id;

        COMMIT;

    ELSE

       FOR IDX In 0..9
       LOOP
           Maxdat_Statistics.TABLE_STATS('EMRS_D_CASE_CLIENT');

           INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
           VALUES (SEQ_JOB_ID.Nextval, 'CASE_CLIENT_UPD THREAD'||IDX,'STARTED',SYSDATE)
           RETURNING JOB_ID INTO v_job_id;

           COMMIT;

           MERGE /*+ Enable_Parallel_Dml Parallel */
            INTO  EMRS_D_CASE_CLIENT D
           USING ( 
                    SELECT                
                              s.CSCL_ID
                            , s.CSCL_STATUS_BEGIN_DATE
                            , s.CSCL_CLOSE_REASON
                            , s.CSCL_RELATIONSHIP_CD
                            , s.CSCL_ELIG_DETERMINATION_DATE
                            , s.CSCL_MEDICAL_IND
                            , s.CSCL_CASE_ID
                            , s.CSCL_CLNT_CLIENT_ID
                            , s.CSCL_STATUS_END_DATE
                            , s.CSCL_BYB_TEMP_ID
                            , s.CSCL_APPL_CLIENT_ID
                            , s.CSCL_ACTUAL_TERM_DATE
                            , s.CSCL_PACMIS_STATUS_CD
                            , s.CSCL_LEGACY
                            , s.RHSP
                            , s.RHGA
                            , s.CSCL_STATUS_CD
                            , s.CSCL_ADLK_ID
                            , s.CSCL_RES_ADDR_ID
                            , s.CSCL_ELIG_BEGIN_DT
                            , s.CSCL_ELIG_END_DT
                            , s.ANNIVERSARY_DT
                            , s.PROGRAM_CD
                            , s.PROGRAM_STATUS_CD
                            , s.ELIG_BEGIN_ND
                            , s.ELIG_END_ND
                            , s.EPISODE_ID
                            , s.CSCL_GENERIC_FIELD1_DATE
                            , s.CSCL_GENERIC_FIELD2_DATE
                            , s.CSCL_GENERIC_FIELD3_NUM
                            , s.CSCL_GENERIC_FIELD4_NUM
                            , s.CSCL_GENERIC_FIELD5_TXT
                            , s.CSCL_GENERIC_FIELD6_TXT
                            , s.CSCL_GENERIC_FIELD7_TXT
                            , s.CSCL_GENERIC_FIELD8_TXT
                            , s.CSCL_GENERIC_FIELD9_TXT
                            , s.CSCL_GENERIC_FIELD10_TXT
                            , s.CSCL_GENERIC_REF11_ID
                            , s.CSCL_GENERIC_REF12_ID
                            , s.STATUS_BEGIN_NDT
                            , s.STATUS_END_NDT
                            , s.CHANGE_NOTES
                            , s.CREATED_BY                                  AS  RECORD_NAME
                            , s.CREATION_DATE                               AS  RECORD_DATE
                            , TO_CHAR(s.CREATION_DATE, c_time_format)       AS  RECORD_TIME
                            , s.LAST_UPDATED_BY                             AS  MODIFIED_NAME
                            , s.LAST_UPDATE_DATE                            AS  MODIFIED_DATE
                            , TO_CHAR(s.LAST_UPDATE_DATE, c_time_format)    AS  MODIFIED_TIME
                     FROM EMRS_D_CASE_CLIENT D, EMRS_S_CASE_CLIENT_STG S
                    WHERE   SUBSTR(S.CSCL_ID,-1) = IDX
                      AND   D.CASE_CLIENT_ID = S.CSCL_ID
                  ) C ON (D.CASE_CLIENT_ID = C.CSCL_ID)
            WHEN MATCHED THEN UPDATE
             SET              
                              d.CSCL_STATUS_BEGIN_DATE                  =   c.CSCL_STATUS_BEGIN_DATE
                            , d.CSCL_CLOSE_REASON                       =   c.CSCL_CLOSE_REASON
                            , d.CSCL_RELATIONSHIP_CD                    =   c.CSCL_RELATIONSHIP_CD
                            , d.CSCL_ELIG_DETERMINATION_DATE            =   c.CSCL_ELIG_DETERMINATION_DATE
                            , d.CSCL_MEDICAL_IND                        =   c.CSCL_MEDICAL_IND
                            , d.CASE_ID                                 =   c.CSCL_CASE_ID
                            , d.CLIENT_ID                               =   c.CSCL_CLNT_CLIENT_ID
                            , d.CSCL_STATUS_END_DATE                    =   c.CSCL_STATUS_END_DATE
                            , d.CSCL_BYB_TEMP_ID                        =   c.CSCL_BYB_TEMP_ID
                            , d.CSCL_APPL_CLIENT_ID                     =   c.CSCL_APPL_CLIENT_ID
                            , d.CSCL_ACTUAL_TERM_DATE                   =   c.CSCL_ACTUAL_TERM_DATE
                            , d.CSCL_PACMIS_STATUS_CD                   =   c.CSCL_PACMIS_STATUS_CD
                            , d.CSCL_LEGACY                             =   c.CSCL_LEGACY
                            , d.RHSP                                    =   c.RHSP
                            , d.RHGA                                    =   c.RHGA
                            , d.CSCL_STATUS_CD                          =   c.CSCL_STATUS_CD
                            , d.CSCL_ADLK_ID                            =   c.CSCL_ADLK_ID
                            , d.CSCL_RES_ADDR_ID                        =   c.CSCL_RES_ADDR_ID
                            , d.CSCL_ELIG_BEGIN_DT                      =   c.CSCL_ELIG_BEGIN_DT
                            , d.CSCL_ELIG_END_DT                        =   c.CSCL_ELIG_END_DT
                            , d.ANNIVERSARY_DT                          =   c.ANNIVERSARY_DT
                            , d.PROGRAM_CD                              =   c.PROGRAM_CD
                            , d.PROGRAM_STATUS_CD                       =   c.PROGRAM_STATUS_CD
                            , d.ELIG_BEGIN_ND                           =   c.ELIG_BEGIN_ND
                            , d.ELIG_END_ND                             =   c.ELIG_END_ND
                            , d.EPISODE_ID                              =   c.EPISODE_ID
                            , d.CSCL_GENERIC_FIELD1_DATE                =   c.CSCL_GENERIC_FIELD1_DATE
                            , d.CSCL_GENERIC_FIELD2_DATE                =   c.CSCL_GENERIC_FIELD2_DATE
                            , d.CSCL_GENERIC_FIELD3_NUM                 =   c.CSCL_GENERIC_FIELD3_NUM
                            , d.CSCL_GENERIC_FIELD4_NUM                 =   c.CSCL_GENERIC_FIELD4_NUM
                            , d.CSCL_GENERIC_FIELD5_TXT                 =   c.CSCL_GENERIC_FIELD5_TXT
                            , d.CSCL_GENERIC_FIELD6_TXT                 =   c.CSCL_GENERIC_FIELD6_TXT
                            , d.CSCL_GENERIC_FIELD7_TXT                 =   c.CSCL_GENERIC_FIELD7_TXT
                            , d.CSCL_GENERIC_FIELD8_TXT                 =   c.CSCL_GENERIC_FIELD8_TXT
                            , d.CSCL_GENERIC_FIELD9_TXT                 =   c.CSCL_GENERIC_FIELD9_TXT
                            , d.CSCL_GENERIC_FIELD10_TXT                =   c.CSCL_GENERIC_FIELD10_TXT
                            , d.CSCL_GENERIC_REF11_ID                   =   c.CSCL_GENERIC_REF11_ID
                            , d.CSCL_GENERIC_REF12_ID                   =   c.CSCL_GENERIC_REF12_ID
                            , d.STATUS_BEGIN_NDT                        =   c.STATUS_BEGIN_NDT
                            , d.STATUS_END_NDT                          =   c.STATUS_END_NDT
                            , d.CHANGE_NOTES                            =   c.CHANGE_NOTES
                            , d.RECORD_NAME                             =   c.RECORD_NAME
                            , d.RECORD_DATE                             =   c.RECORD_DATE
                            , d.RECORD_TIME                             =   c.RECORD_TIME
                            , d.MODIFIED_NAME                           =   c.MODIFIED_NAME
                            , d.MODIFIED_DATE                           =   c.MODIFIED_DATE
                            , d.MODIFIED_TIME                           =   c.MODIFIED_TIME
             Log Errors INTO Errlog_CSCL ('CASE_CLIENT_UPD') Reject Limit Unlimited;

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
            SELECT c_critical, con_pkg, con_pkg || '.CASE_CLIENT_UPD', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_CASE_CLIENT', CASE_CLIENT_ID
              FROM Errlog_CSCL
             WHERE Ora_Err_Tag$ = 'CASE_CLIENT_UPD';

            v_err_cnt := SQL%RowCount;

            UPDATE CORP_ETL_JOB_STATISTICS
               SET ERROR_COUNT = v_err_cnt
                 , RECORD_COUNT = v_upd_cnt + v_err_cnt
                 , PROCESSED_COUNT = v_upd_cnt + v_err_cnt
             WHERE JOB_ID =  v_job_id;

            DELETE FROM Errlog_CSCL WHERE ora_err_tag$ = 'CASE_CLIENT_UPD';

            COMMIT;

       END LOOP;

    END IF;

    Maxdat_Statistics.TABLE_STATS('EMRS_D_CASE_CLIENT');

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, con_pkg || '.CASE_CLIENT_UPD', 1, v_desc, v_code, 'EMRS_D_CASE_CLIENT');

      COMMIT;
END CASE_CLIENT_UPD;

PROCEDURE CLIENT_SUPPLEMENTARY_INFO_INS
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_ins_cnt number;
    v_err_cnt number;
    to_process number := 0;
    Run_Multiple varchar2(1) := 'N';
BEGIN

    DELETE FROM Errlog_ClientSuppInfo WHERE ora_err_tag$ = 'CLIENT_SUPPLEMENTARY_INFO_INS';

    Maxdat_Statistics.TABLE_STATS('EMRS_S_CLIENT_SUPPLEMENTARY_INFO_STG');

    SELECT COUNT(1) INTO to_process FROM EMRS_S_CLIENT_SUPPLEMENTARY_INFO_STG;

    SELECT CASE WHEN to_process > NVL(Value,1000000)
                THEN 'Y' ELSE 'N' END INTO Run_Multiple
      FROM CORP_ETL_CONTROL WHERE NAME = 'EMRS_REC_THRESHOLD';

    IF Run_Multiple = 'N' THEN

        INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
        VALUES (SEQ_JOB_ID.Nextval, 'CLIENT_SUPPLEMENTARY_INFO_INS','STARTED',SYSDATE)
        RETURNING JOB_ID INTO v_job_id;

        COMMIT;

        INSERT /*+ Enable_Parallel_Dml Parallel */
          INTO Emrs_D_Client_Supplementary_Info
               (
                  CLIENT_ID
                , CASE_CLIENT_ID
                , CASE_ID
                , CASE_CIN
                , HOH_ID
                , CASE_STATUS
                , CASE_CLIENT_STATUS
                , LAST_NAME
                , LAST_NAME_CANON
                , LAST_NAME_SOUNDLIKE
                , FIRST_NAME
                , FIRST_NAME_CANON
                , FIRST_NAME_SOUNDLIKE
                , MIDDLE_INITIAL
                , CLIENT_CIN
                , SSN
                , GENDER_CD
                , DOB
                , DOB_NUM
                , CLIENT_TYPE_CD
                , ADDR_ID
                , ADDR_TYPE_CD
                , ADDR_COUNTY
                , ADDR_ZIP
                , ADDR_ZIP_FOUR
                , ADDR_ATTN
                , ADDR_STREET_1
                , ADDR_STREET_2
                , ADDR_CITY
                , ADDR_BAD_DATE
                , ADDR_BAD_DATE_SATISFIED
                , CASE_CREATED_BY
                , CASE_CREATE_TS
                , CASE_UPDATED_BY
                , CASE_UPDATE_TS
                , PROGRAM_CD
                , ADDR_STATE_CD
                , ADDR_COUNTRY
                , CLNT_GENERIC_FIELD1_DATE
                , CLNT_GENERIC_FIELD2_DATE
                , CLNT_GENERIC_FIELD3_NUM
                , CLNT_GENERIC_FIELD4_NUM
                , CLNT_GENERIC_FIELD5_TXT
                , CLNT_GENERIC_FIELD6_TXT
                , CLNT_GENERIC_FIELD7_TXT
                , CLNT_GENERIC_FIELD8_TXT
                , CLNT_GENERIC_FIELD9_TXT
                , CLNT_GENERIC_FIELD10_TXT
                , RECORD_NAME
                , RECORD_DATE
                , RECORD_TIME
                , MODIFIED_NAME
                , MODIFIED_DATE
                , MODIFIED_TIME                
               )
        SELECT
                  CLIENT_ID
                , CASE_CLIENT_ID
                , CASE_ID
                , CASE_CIN
                , HOH_ID
                , CASE_STATUS
                , CASE_CLIENT_STATUS
                , LAST_NAME
                , LAST_NAME_CANON
                , LAST_NAME_SOUNDLIKE
                , FIRST_NAME
                , FIRST_NAME_CANON
                , FIRST_NAME_SOUNDLIKE
                , MIDDLE_INITIAL
                , CLIENT_CIN
                , SSN
                , GENDER_CD
                , DOB
                , DOB_NUM
                , CLIENT_TYPE_CD
                , ADDR_ID
                , ADDR_TYPE_CD
                , ADDR_COUNTY
                , ADDR_ZIP
                , ADDR_ZIP_FOUR
                , ADDR_ATTN
                , ADDR_STREET_1
                , ADDR_STREET_2
                , ADDR_CITY
                , ADDR_BAD_DATE
                , ADDR_BAD_DATE_SATISFIED
                , CASE_CREATED_BY
                , CASE_CREATE_TS
                , CASE_UPDATED_BY
                , CASE_UPDATE_TS
                , PROGRAM_CD
                , ADDR_STATE_CD
                , ADDR_COUNTRY
                , CLNT_GENERIC_FIELD1_DATE
                , CLNT_GENERIC_FIELD2_DATE
                , CLNT_GENERIC_FIELD3_NUM
                , CLNT_GENERIC_FIELD4_NUM
                , CLNT_GENERIC_FIELD5_TXT
                , CLNT_GENERIC_FIELD6_TXT
                , CLNT_GENERIC_FIELD7_TXT
                , CLNT_GENERIC_FIELD8_TXT
                , CLNT_GENERIC_FIELD9_TXT
                , CLNT_GENERIC_FIELD10_TXT
                , CREATED_BY
                , CREATE_TS
                , TO_CHAR(CREATE_TS, c_time_format)
                , UPDATED_BY
                , UPDATE_TS
                , TO_CHAR(UPDATE_TS, c_time_format)                                                            
        FROM emrs_s_client_supplementary_info_stg s
         WHERE NOT EXISTS (SELECT 1 FROM emrs_d_client_supplementary_info C WHERE C.client_id = S.client_id AND C.program_cd = S.program_cd)
           Log Errors INTO Errlog_ClientSuppInfo ('CLIENT_SUPPLEMENTARY_INFO_INS') Reject Limit Unlimited;

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
        SELECT c_critical, con_pkg, con_pkg || '.CLIENT_SUPPLEMENTARY_INFO_INS', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_CLIENT_SUPPLEMENTARY_INFO', CLIENT_ID
          FROM Errlog_ClientSuppInfo
         WHERE Ora_Err_Tag$ = 'CLIENT_SUPPLEMENTARY_INFO_INS';

        v_err_cnt := SQL%RowCount;

        UPDATE CORP_ETL_JOB_STATISTICS
           SET ERROR_COUNT = v_err_cnt
             , RECORD_COUNT = v_ins_cnt + v_err_cnt
             , PROCESSED_COUNT = v_ins_cnt + v_err_cnt
         WHERE JOB_ID =  v_job_id;

        COMMIT;

    ELSE

       FOR IDX In 0..9
       LOOP

           Maxdat_Statistics.TABLE_STATS('EMRS_D_CLIENT_SUPPLEMENTARY_INFO');

           INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
           VALUES (SEQ_JOB_ID.Nextval, 'CLIENT_SUPPLEMENTARY_INFO_INS THREAD'||IDX,'STARTED',SYSDATE)
           RETURNING JOB_ID INTO v_job_id;

           COMMIT;

            INSERT /*+ Enable_Parallel_Dml Parallel */
              INTO Emrs_D_Client_Supplementary_Info
                   (
                      CLIENT_ID
                    , CASE_CLIENT_ID
                    , CASE_ID
                    , CASE_CIN
                    , HOH_ID
                    , CASE_STATUS
                    , CASE_CLIENT_STATUS
                    , LAST_NAME
                    , LAST_NAME_CANON
                    , LAST_NAME_SOUNDLIKE
                    , FIRST_NAME
                    , FIRST_NAME_CANON
                    , FIRST_NAME_SOUNDLIKE
                    , MIDDLE_INITIAL
                    , CLIENT_CIN
                    , SSN
                    , GENDER_CD
                    , DOB
                    , DOB_NUM
                    , CLIENT_TYPE_CD
                    , ADDR_ID
                    , ADDR_TYPE_CD
                    , ADDR_COUNTY
                    , ADDR_ZIP
                    , ADDR_ZIP_FOUR
                    , ADDR_ATTN
                    , ADDR_STREET_1
                    , ADDR_STREET_2
                    , ADDR_CITY
                    , ADDR_BAD_DATE
                    , ADDR_BAD_DATE_SATISFIED
                    , CASE_CREATED_BY
                    , CASE_CREATE_TS
                    , CASE_UPDATED_BY
                    , CASE_UPDATE_TS
                    , PROGRAM_CD
                    , ADDR_STATE_CD
                    , ADDR_COUNTRY
                    , CLNT_GENERIC_FIELD1_DATE
                    , CLNT_GENERIC_FIELD2_DATE
                    , CLNT_GENERIC_FIELD3_NUM
                    , CLNT_GENERIC_FIELD4_NUM
                    , CLNT_GENERIC_FIELD5_TXT
                    , CLNT_GENERIC_FIELD6_TXT
                    , CLNT_GENERIC_FIELD7_TXT
                    , CLNT_GENERIC_FIELD8_TXT
                    , CLNT_GENERIC_FIELD9_TXT
                    , CLNT_GENERIC_FIELD10_TXT
                    , RECORD_NAME
                    , RECORD_DATE
                    , RECORD_TIME
                    , MODIFIED_NAME
                    , MODIFIED_DATE
                    , MODIFIED_TIME                
                   )
            SELECT
                      CLIENT_ID
                    , CASE_CLIENT_ID
                    , CASE_ID
                    , CASE_CIN
                    , HOH_ID
                    , CASE_STATUS
                    , CASE_CLIENT_STATUS
                    , LAST_NAME
                    , LAST_NAME_CANON
                    , LAST_NAME_SOUNDLIKE
                    , FIRST_NAME
                    , FIRST_NAME_CANON
                    , FIRST_NAME_SOUNDLIKE
                    , MIDDLE_INITIAL
                    , CLIENT_CIN
                    , SSN
                    , GENDER_CD
                    , DOB
                    , DOB_NUM
                    , CLIENT_TYPE_CD
                    , ADDR_ID
                    , ADDR_TYPE_CD
                    , ADDR_COUNTY
                    , ADDR_ZIP
                    , ADDR_ZIP_FOUR
                    , ADDR_ATTN
                    , ADDR_STREET_1
                    , ADDR_STREET_2
                    , ADDR_CITY
                    , ADDR_BAD_DATE
                    , ADDR_BAD_DATE_SATISFIED
                    , CASE_CREATED_BY
                    , CASE_CREATE_TS
                    , CASE_UPDATED_BY
                    , CASE_UPDATE_TS
                    , PROGRAM_CD
                    , ADDR_STATE_CD
                    , ADDR_COUNTRY
                    , CLNT_GENERIC_FIELD1_DATE
                    , CLNT_GENERIC_FIELD2_DATE
                    , CLNT_GENERIC_FIELD3_NUM
                    , CLNT_GENERIC_FIELD4_NUM
                    , CLNT_GENERIC_FIELD5_TXT
                    , CLNT_GENERIC_FIELD6_TXT
                    , CLNT_GENERIC_FIELD7_TXT
                    , CLNT_GENERIC_FIELD8_TXT
                    , CLNT_GENERIC_FIELD9_TXT
                    , CLNT_GENERIC_FIELD10_TXT
                    , CREATED_BY
                    , CREATE_TS
                    , TO_CHAR(CREATE_TS, c_time_format)
                    , UPDATED_BY
                    , UPDATE_TS
                    , TO_CHAR(UPDATE_TS, c_time_format)                                                            
            FROM emrs_s_client_supplementary_info_stg s
             WHERE SUBSTR(s.CLIENT_ID, -1) = IDX
               AND NOT EXISTS (SELECT 1 FROM emrs_d_client_supplementary_info C WHERE C.client_id = S.client_id AND C.program_cd = S.program_cd)
               Log Errors INTO Errlog_ClientSuppInfo ('CLIENT_SUPPLEMENTARY_INFO_INS') Reject Limit Unlimited;

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
          SELECT c_critical, con_pkg, con_pkg || '.CLIENT_SUPPLEMENTARY_INFO_INS', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_CLIENT_SUPPLEMENTARY_INFO', CLIENT_ID
            FROM Errlog_ClientSuppInfo
           WHERE Ora_Err_Tag$ = 'CLIENT_SUPPLEMENTARY_INFO_INS';

          v_err_cnt := SQL%RowCount;

          UPDATE CORP_ETL_JOB_STATISTICS
             SET ERROR_COUNT = v_err_cnt
               , RECORD_COUNT = v_ins_cnt + v_err_cnt
               , PROCESSED_COUNT = v_ins_cnt + v_err_cnt
           WHERE JOB_ID =  v_job_id;

          DELETE FROM Errlog_ClientSuppInfo WHERE ora_err_tag$ = 'CLIENT_SUPPLEMENTARY_INFO_INS';

          COMMIT;

      END LOOP;

    END IF;

    Maxdat_Statistics.TABLE_STATS('EMRS_D_CLIENT_SUPPLEMENTARY_INFO');

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, con_pkg || '.CLIENT_SUPPLEMENTARY_INFO_INS', 1, v_desc, v_code, 'EMRS_D_CLIENT_SUPPLEMENTARY_INFO');

      COMMIT;
END CLIENT_SUPPLEMENTARY_INFO_INS;


PROCEDURE CLIENT_SUPPLEMENTARY_INFO_UPD
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
    to_process number := 0;
    Run_Multiple varchar2(1) := 'N';
BEGIN

    DELETE FROM Errlog_ClientSuppInfo WHERE ora_err_tag$ = 'CLIENT_SUPPLEMENTARY_INFO_UPD';

    Maxdat_Statistics.TABLE_STATS('EMRS_D_CLIENT_SUPPLEMENTARY_INFO');

    SELECT COUNT(1) INTO to_process FROM EMRS_S_CLIENT_SUPPLEMENTARY_INFO_STG;

    SELECT CASE WHEN to_process > NVL(Value,1000000)
                THEN 'Y' ELSE 'N' END INTO Run_Multiple
      FROM CORP_ETL_CONTROL WHERE NAME = 'EMRS_REC_THRESHOLD';

    IF Run_Multiple = 'N' THEN

      INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
      VALUES (SEQ_JOB_ID.Nextval, 'CLIENT_SUPPLEMENTARY_INFO_UPD','STARTED',SYSDATE)
      RETURNING JOB_ID INTO v_job_id;

      COMMIT;

       MERGE /*+ Enable_Parallel_Dml Parallel */
        INTO  EMRS_D_CLIENT_SUPPLEMENTARY_INFO D
       USING ( SELECT
                      s.CLIENT_ID
                    , s.CASE_CLIENT_ID
                    , s.CASE_ID
                    , s.CASE_CIN
                    , s.HOH_ID
                    , s.CASE_STATUS
                    , s.CASE_CLIENT_STATUS
                    , s.LAST_NAME
                    , s.LAST_NAME_CANON
                    , s.LAST_NAME_SOUNDLIKE
                    , s.FIRST_NAME
                    , s.FIRST_NAME_CANON
                    , s.FIRST_NAME_SOUNDLIKE
                    , s.MIDDLE_INITIAL
                    , s.CLIENT_CIN
                    , s.SSN
                    , s.GENDER_CD
                    , s.DOB
                    , s.DOB_NUM
                    , s.CLIENT_TYPE_CD
                    , s.ADDR_ID
                    , s.ADDR_TYPE_CD
                    , s.ADDR_COUNTY
                    , s.ADDR_ZIP
                    , s.ADDR_ZIP_FOUR
                    , s.ADDR_ATTN
                    , s.ADDR_STREET_1
                    , s.ADDR_STREET_2
                    , s.ADDR_CITY
                    , s.ADDR_BAD_DATE
                    , s.ADDR_BAD_DATE_SATISFIED
                    , s.CASE_CREATED_BY
                    , s.CASE_CREATE_TS
                    , s.CASE_UPDATED_BY
                    , s.CASE_UPDATE_TS
                    , s.PROGRAM_CD
                    , s.ADDR_STATE_CD
                    , s.ADDR_COUNTRY
                    , s.CLNT_GENERIC_FIELD1_DATE
                    , s.CLNT_GENERIC_FIELD2_DATE
                    , s.CLNT_GENERIC_FIELD3_NUM
                    , s.CLNT_GENERIC_FIELD4_NUM
                    , s.CLNT_GENERIC_FIELD5_TXT
                    , s.CLNT_GENERIC_FIELD6_TXT
                    , s.CLNT_GENERIC_FIELD7_TXT
                    , s.CLNT_GENERIC_FIELD8_TXT
                    , s.CLNT_GENERIC_FIELD9_TXT
                    , s.CLNT_GENERIC_FIELD10_TXT
                    , s.CREATED_BY                                      AS  RECORD_NAME
                    , s.CREATE_TS                                       AS  RECORD_DATE
                    , TO_CHAR(s.CREATE_TS, c_time_format)               AS  RECORD_TIME
                    , s.UPDATED_BY                                      AS  MODIFIED_NAME
                    , s.UPDATE_TS                                       AS  MODIFIED_DATE
                    , TO_CHAR(s.UPDATE_TS, c_time_format)               AS  MODIFIED_TIME                                 
                 FROM EMRS_D_CLIENT_SUPPLEMENTARY_INFO D, EMRS_S_CLIENT_SUPPLEMENTARY_INFO_STG S
                WHERE D.CLIENT_ID = S.CLIENT_ID
                  AND D.PROGRAM_CD = S.PROGRAM_CD
                  ) C ON (D.CLIENT_ID = C.CLIENT_ID AND D.PROGRAM_CD = C.PROGRAM_CD)
        WHEN MATCHED THEN UPDATE
         SET          
                      d.CASE_CLIENT_ID                  =   c.CASE_CLIENT_ID
                    , d.CASE_ID                         =   c.CASE_ID
                    , d.CASE_CIN                        =   c.CASE_CIN
                    , d.HOH_ID                          =   c.HOH_ID
                    , d.CASE_STATUS                     =   c.CASE_STATUS
                    , d.CASE_CLIENT_STATUS              =   c.CASE_CLIENT_STATUS
                    , d.LAST_NAME                       =   c.LAST_NAME
                    , d.LAST_NAME_CANON                 =   c.LAST_NAME_CANON
                    , d.LAST_NAME_SOUNDLIKE             =   c.LAST_NAME_SOUNDLIKE
                    , d.FIRST_NAME                      =   c.FIRST_NAME
                    , d.FIRST_NAME_CANON                =   c.FIRST_NAME_CANON
                    , d.FIRST_NAME_SOUNDLIKE            =   c.FIRST_NAME_SOUNDLIKE
                    , d.MIDDLE_INITIAL                  =   c.MIDDLE_INITIAL
                    , d.CLIENT_CIN                      =   c.CLIENT_CIN
                    , d.SSN                             =   c.SSN
                    , d.GENDER_CD                       =   c.GENDER_CD
                    , d.DOB                             =   c.DOB
                    , d.DOB_NUM                         =   c.DOB_NUM
                    , d.CLIENT_TYPE_CD                  =   c.CLIENT_TYPE_CD
                    , d.ADDR_ID                         =   c.ADDR_ID
                    , d.ADDR_TYPE_CD                    =   c.ADDR_TYPE_CD
                    , d.ADDR_COUNTY                     =   c.ADDR_COUNTY
                    , d.ADDR_ZIP                        =   c.ADDR_ZIP
                    , d.ADDR_ZIP_FOUR                   =   c.ADDR_ZIP_FOUR
                    , d.ADDR_ATTN                       =   c.ADDR_ATTN
                    , d.ADDR_STREET_1                   =   c.ADDR_STREET_1
                    , d.ADDR_STREET_2                   =   c.ADDR_STREET_2
                    , d.ADDR_CITY                       =   c.ADDR_CITY
                    , d.ADDR_BAD_DATE                   =   c.ADDR_BAD_DATE
                    , d.ADDR_BAD_DATE_SATISFIED         =   c.ADDR_BAD_DATE_SATISFIED
                    , d.CASE_CREATED_BY                 =   c.CASE_CREATED_BY
                    , d.CASE_CREATE_TS                  =   c.CASE_CREATE_TS
                    , d.CASE_UPDATED_BY                 =   c.CASE_UPDATED_BY
                    , d.CASE_UPDATE_TS                  =   c.CASE_UPDATE_TS
                    , d.ADDR_STATE_CD                   =   c.ADDR_STATE_CD
                    , d.ADDR_COUNTRY                    =   c.ADDR_COUNTRY
                    , d.CLNT_GENERIC_FIELD1_DATE        =   c.CLNT_GENERIC_FIELD1_DATE
                    , d.CLNT_GENERIC_FIELD2_DATE        =   c.CLNT_GENERIC_FIELD2_DATE
                    , d.CLNT_GENERIC_FIELD3_NUM         =   c.CLNT_GENERIC_FIELD3_NUM
                    , d.CLNT_GENERIC_FIELD4_NUM         =   c.CLNT_GENERIC_FIELD4_NUM
                    , d.CLNT_GENERIC_FIELD5_TXT         =   c.CLNT_GENERIC_FIELD5_TXT
                    , d.CLNT_GENERIC_FIELD6_TXT         =   c.CLNT_GENERIC_FIELD6_TXT
                    , d.CLNT_GENERIC_FIELD7_TXT         =   c.CLNT_GENERIC_FIELD7_TXT
                    , d.CLNT_GENERIC_FIELD8_TXT         =   c.CLNT_GENERIC_FIELD8_TXT
                    , d.CLNT_GENERIC_FIELD9_TXT         =   c.CLNT_GENERIC_FIELD9_TXT
                    , d.CLNT_GENERIC_FIELD10_TXT        =   c.CLNT_GENERIC_FIELD10_TXT
         Log Errors INTO Errlog_ClientSuppInfo ('CLIENT_SUPPLEMENTARY_INFO_UPD') Reject Limit Unlimited;

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
          SELECT c_critical, con_pkg, con_pkg || '.CLIENT_SUPPLEMENTARY_INFO_UPD', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_CLIENT_SUPPLEMENTARY_INFO', CLIENT_ID
            FROM Errlog_ClientSuppInfo
           WHERE Ora_Err_Tag$ = 'CLIENT_SUPPLEMENTARY_INFO_UPD';

          v_err_cnt := SQL%RowCount;

          UPDATE CORP_ETL_JOB_STATISTICS
             SET ERROR_COUNT = v_err_cnt
               , RECORD_COUNT = v_upd_cnt + v_err_cnt
               , PROCESSED_COUNT = v_upd_cnt + v_err_cnt
           WHERE JOB_ID =  v_job_id;

          COMMIT;

    ELSE

       FOR IDX In 0..9
       LOOP

            INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
            VALUES (SEQ_JOB_ID.Nextval, 'CLIENT_SUPPLEMENTARY_INFO_UPD THREAD'||IDX,'STARTED',SYSDATE)
            RETURNING JOB_ID INTO v_job_id;

            COMMIT;

           MERGE /*+ Enable_Parallel_Dml Parallel */
            INTO  EMRS_D_CLIENT_SUPPLEMENTARY_INFO D
           USING ( SELECT
                          s.CLIENT_ID
                        , s.CASE_CLIENT_ID
                        , s.CASE_ID
                        , s.CASE_CIN
                        , s.HOH_ID
                        , s.CASE_STATUS
                        , s.CASE_CLIENT_STATUS
                        , s.LAST_NAME
                        , s.LAST_NAME_CANON
                        , s.LAST_NAME_SOUNDLIKE
                        , s.FIRST_NAME
                        , s.FIRST_NAME_CANON
                        , s.FIRST_NAME_SOUNDLIKE
                        , s.MIDDLE_INITIAL
                        , s.CLIENT_CIN
                        , s.SSN
                        , s.GENDER_CD
                        , s.DOB
                        , s.DOB_NUM
                        , s.CLIENT_TYPE_CD
                        , s.ADDR_ID
                        , s.ADDR_TYPE_CD
                        , s.ADDR_COUNTY
                        , s.ADDR_ZIP
                        , s.ADDR_ZIP_FOUR
                        , s.ADDR_ATTN
                        , s.ADDR_STREET_1
                        , s.ADDR_STREET_2
                        , s.ADDR_CITY
                        , s.ADDR_BAD_DATE
                        , s.ADDR_BAD_DATE_SATISFIED
                        , s.CASE_CREATED_BY
                        , s.CASE_CREATE_TS
                        , s.CASE_UPDATED_BY
                        , s.CASE_UPDATE_TS
                        , s.PROGRAM_CD
                        , s.ADDR_STATE_CD
                        , s.ADDR_COUNTRY
                        , s.CLNT_GENERIC_FIELD1_DATE
                        , s.CLNT_GENERIC_FIELD2_DATE
                        , s.CLNT_GENERIC_FIELD3_NUM
                        , s.CLNT_GENERIC_FIELD4_NUM
                        , s.CLNT_GENERIC_FIELD5_TXT
                        , s.CLNT_GENERIC_FIELD6_TXT
                        , s.CLNT_GENERIC_FIELD7_TXT
                        , s.CLNT_GENERIC_FIELD8_TXT
                        , s.CLNT_GENERIC_FIELD9_TXT
                        , s.CLNT_GENERIC_FIELD10_TXT
                        , s.CREATED_BY                                  AS  RECORD_NAME
                        , s.CREATE_TS                                   AS  RECORD_DATE
                        , TO_CHAR(s.CREATE_TS, c_time_format)           AS  RECORD_TIME
                        , s.UPDATED_BY                                  AS  MODIFIED_NAME
                        , s.UPDATE_TS                                   AS  MODIFIED_DATE
                        , TO_CHAR(s.UPDATE_TS, c_time_format)           AS  MODIFIED_TIME                                 
                     FROM EMRS_D_CLIENT_SUPPLEMENTARY_INFO D, EMRS_S_CLIENT_SUPPLEMENTARY_INFO_STG S
                    WHERE D.CLIENT_ID = S.CLIENT_ID
                      AND D.PROGRAM_CD = S.PROGRAM_CD
                      AND SUBSTR(S.CLIENT_ID, -1) = IDX
                      ) C ON (D.CLIENT_ID = C.CLIENT_ID AND D.PROGRAM_CD = C.PROGRAM_CD)
            WHEN MATCHED THEN UPDATE
             SET          
                          d.CASE_CLIENT_ID                  =   c.CASE_CLIENT_ID
                        , d.CASE_ID                         =   c.CASE_ID
                        , d.CASE_CIN                        =   c.CASE_CIN
                        , d.HOH_ID                          =   c.HOH_ID
                        , d.CASE_STATUS                     =   c.CASE_STATUS
                        , d.CASE_CLIENT_STATUS              =   c.CASE_CLIENT_STATUS
                        , d.LAST_NAME                       =   c.LAST_NAME
                        , d.LAST_NAME_CANON                 =   c.LAST_NAME_CANON
                        , d.LAST_NAME_SOUNDLIKE             =   c.LAST_NAME_SOUNDLIKE
                        , d.FIRST_NAME                      =   c.FIRST_NAME
                        , d.FIRST_NAME_CANON                =   c.FIRST_NAME_CANON
                        , d.FIRST_NAME_SOUNDLIKE            =   c.FIRST_NAME_SOUNDLIKE
                        , d.MIDDLE_INITIAL                  =   c.MIDDLE_INITIAL
                        , d.CLIENT_CIN                      =   c.CLIENT_CIN
                        , d.SSN                             =   c.SSN
                        , d.GENDER_CD                       =   c.GENDER_CD
                        , d.DOB                             =   c.DOB
                        , d.DOB_NUM                         =   c.DOB_NUM
                        , d.CLIENT_TYPE_CD                  =   c.CLIENT_TYPE_CD
                        , d.ADDR_ID                         =   c.ADDR_ID
                        , d.ADDR_TYPE_CD                    =   c.ADDR_TYPE_CD
                        , d.ADDR_COUNTY                     =   c.ADDR_COUNTY
                        , d.ADDR_ZIP                        =   c.ADDR_ZIP
                        , d.ADDR_ZIP_FOUR                   =   c.ADDR_ZIP_FOUR
                        , d.ADDR_ATTN                       =   c.ADDR_ATTN
                        , d.ADDR_STREET_1                   =   c.ADDR_STREET_1
                        , d.ADDR_STREET_2                   =   c.ADDR_STREET_2
                        , d.ADDR_CITY                       =   c.ADDR_CITY
                        , d.ADDR_BAD_DATE                   =   c.ADDR_BAD_DATE
                        , d.ADDR_BAD_DATE_SATISFIED         =   c.ADDR_BAD_DATE_SATISFIED
                        , d.CASE_CREATED_BY                 =   c.CASE_CREATED_BY
                        , d.CASE_CREATE_TS                  =   c.CASE_CREATE_TS
                        , d.CASE_UPDATED_BY                 =   c.CASE_UPDATED_BY
                        , d.CASE_UPDATE_TS                  =   c.CASE_UPDATE_TS
                        , d.ADDR_STATE_CD                   =   c.ADDR_STATE_CD
                        , d.ADDR_COUNTRY                    =   c.ADDR_COUNTRY
                        , d.CLNT_GENERIC_FIELD1_DATE        =   c.CLNT_GENERIC_FIELD1_DATE
                        , d.CLNT_GENERIC_FIELD2_DATE        =   c.CLNT_GENERIC_FIELD2_DATE
                        , d.CLNT_GENERIC_FIELD3_NUM         =   c.CLNT_GENERIC_FIELD3_NUM
                        , d.CLNT_GENERIC_FIELD4_NUM         =   c.CLNT_GENERIC_FIELD4_NUM
                        , d.CLNT_GENERIC_FIELD5_TXT         =   c.CLNT_GENERIC_FIELD5_TXT
                        , d.CLNT_GENERIC_FIELD6_TXT         =   c.CLNT_GENERIC_FIELD6_TXT
                        , d.CLNT_GENERIC_FIELD7_TXT         =   c.CLNT_GENERIC_FIELD7_TXT
                        , d.CLNT_GENERIC_FIELD8_TXT         =   c.CLNT_GENERIC_FIELD8_TXT
                        , d.CLNT_GENERIC_FIELD9_TXT         =   c.CLNT_GENERIC_FIELD9_TXT
                        , d.CLNT_GENERIC_FIELD10_TXT        =   c.CLNT_GENERIC_FIELD10_TXT
             Log Errors INTO Errlog_ClientSuppInfo ('CLIENT_SUPPLEMENTARY_INFO_UPD') Reject Limit Unlimited;

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
                SELECT c_critical, con_pkg, con_pkg || '.CLIENT_SUPPLEMENTARY_INFO_UPD', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_CLIENT_SUPPLEMENTARY_INFO', CLIENT_ID
                  FROM Errlog_Client
                 WHERE Ora_Err_Tag$ = 'CLIENT_SUPPLEMENTARY_INFO_UPD';

                v_err_cnt := SQL%RowCount;

                UPDATE CORP_ETL_JOB_STATISTICS
                   SET ERROR_COUNT = v_err_cnt
                     , RECORD_COUNT = v_upd_cnt + v_err_cnt
                     , PROCESSED_COUNT = v_upd_cnt + v_err_cnt
                 WHERE JOB_ID =  v_job_id;

                 DELETE FROM Errlog_Client WHERE ora_err_tag$ = 'CLIENT_SUPPLEMENTARY_INFO_UPD';

                COMMIT;

      END LOOP;

    END IF;

    Maxdat_Statistics.TABLE_STATS('EMRS_D_CLIENT_SUPPLEMENTARY_INFO');

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, con_pkg || '.CLIENT_SUPPLEMENTARY_INFO_UPD', 1, v_desc, v_code, 'EMRS_D_CLIENT_SUPPLEMENTARY_INFO');

      COMMIT;
END CLIENT_SUPPLEMENTARY_INFO_UPD;
    
PROCEDURE EMAIL_ADDRESS_INS
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_ins_cnt number;
    v_err_cnt number;
    to_process number := 0;
    Run_Multiple varchar2(1) := 'N';
BEGIN

    DELETE FROM Errlog_Email_Address WHERE ora_err_tag$ = 'EMAIL_ADDRESS_INS';

    Maxdat_Statistics.TABLE_STATS('EMRS_S_EMAIL_ADDRESS_STG');

    SELECT COUNT(1) INTO to_process FROM EMRS_S_EMAIL_ADDRESS_STG;

    SELECT CASE WHEN to_process > NVL(Value,1000000)
                THEN 'Y' ELSE 'N' END INTO Run_Multiple
      FROM CORP_ETL_CONTROL WHERE NAME = 'EMRS_REC_THRESHOLD';

    IF Run_Multiple = 'N' THEN

        INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
        VALUES (SEQ_JOB_ID.Nextval, 'EMAIL_ADDRESS_INS','STARTED',SYSDATE)
        RETURNING JOB_ID INTO v_job_id;

        COMMIT;

        INSERT /*+ Enable_Parallel_Dml Parallel */
          INTO Emrs_D_Email_Address   
                          ( email_id,
                            email_begin_date,
                            email_type_cd,
                            email_end_date,
                            client_id,
                            email_address,
                            email_dolk_id,
                            email_case_id,
                            status_cd,
                            email_bad_date,
                            email_bad_date_satisfied,
                            contact_method_ind,
                            comparable_key,
                            email_begin_ndt,
                            email_end_ndt,
                            start_ndt,
                            end_ndt,
                            record_name,
                            record_date,
                            record_time,
                            modified_name,
                            modified_date,
                            modified_time)
        SELECT                                              
                            email_id,
                            email_begin_date,
                            email_type_cd,
                            email_end_date,
                            client_id,
                            email_address,
                            email_dolk_id,
                            email_case_id,
                            status_cd,
                            email_bad_date,
                            email_bad_date_satisfied,
                            contact_method_ind,
                            comparable_key,
                            email_begin_ndt,
                            email_end_ndt,
                            start_ndt,
                            end_ndt,
                            created_by,
                            creation_date,
                            TO_CHAR(creation_date, c_time_format),
                            last_updated_by,
                            last_update_date,
                            TO_CHAR(last_update_date, c_time_format)                                                            
          FROM emrs_s_email_address_stg s
         WHERE NOT EXISTS (SELECT 1 FROM emrs_d_email_address C WHERE C.email_id = S.email_id)
           Log Errors INTO Errlog_Email_Address ('EMAIL_ADDRESS_INS') Reject Limit Unlimited;

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
        SELECT c_critical, con_pkg, con_pkg || '.EMAIL_ADDRESS_INS', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_EMAIL_ADDRESS', EMAIL_ID
          FROM Errlog_Email_Address
         WHERE Ora_Err_Tag$ = 'EMAIL_ADDRESS_INS';

        v_err_cnt := SQL%RowCount;

        UPDATE CORP_ETL_JOB_STATISTICS
           SET ERROR_COUNT = v_err_cnt
             , RECORD_COUNT = v_ins_cnt + v_err_cnt
             , PROCESSED_COUNT = v_ins_cnt + v_err_cnt
         WHERE JOB_ID =  v_job_id;

        COMMIT;

    ELSE

       FOR IDX In 0..9
       LOOP

            Maxdat_Statistics.TABLE_STATS('EMRS_D_EMAIL_ADDRESS');

            INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
            VALUES (SEQ_JOB_ID.Nextval, 'EMAIL_ADDRESS_INS THREAD'||IDX,'STARTED',SYSDATE)
            RETURNING JOB_ID INTO v_job_id;

            COMMIT;

            INSERT /*+ Enable_Parallel_Dml Parallel */
            INTO Emrs_D_Email_Address   
                          ( email_id,
                            email_begin_date,
                            email_type_cd,
                            email_end_date,
                            client_id,
                            email_address,
                            email_dolk_id,
                            email_case_id,
                            status_cd,
                            email_bad_date,
                            email_bad_date_satisfied,
                            contact_method_ind,
                            comparable_key,
                            email_begin_ndt,
                            email_end_ndt,
                            start_ndt,
                            end_ndt,
                            record_name,
                            record_date,
                            record_time,
                            modified_name,
                            modified_date,
                            modified_time)
          SELECT                                              
                            email_id,
                            email_begin_date,
                            email_type_cd,
                            email_end_date,
                            client_id,
                            email_address,
                            email_dolk_id,
                            email_case_id,
                            status_cd,
                            email_bad_date,
                            email_bad_date_satisfied,
                            contact_method_ind,
                            comparable_key,
                            email_begin_ndt,
                            email_end_ndt,
                            start_ndt,
                            end_ndt,
                            created_by,
                            creation_date,
                            TO_CHAR(creation_date, c_time_format),
                            last_updated_by,
                            last_update_date,
                            TO_CHAR(last_update_date, c_time_format)                                                            
          FROM emrs_s_email_address_stg s
          WHERE NOT EXISTS (SELECT 1 FROM emrs_d_email_address C WHERE C.email_id = S.email_id)
          Log Errors INTO Errlog_Email_Address ('EMAIL_ADDRESS_INS') Reject Limit Unlimited;

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
            SELECT c_critical, con_pkg, con_pkg || '.EMAIL_ADDRESS_INS', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_EMAIL_ADDRESS', EMAIL_ID
              FROM Errlog_Email_Address
             WHERE Ora_Err_Tag$ = 'EMAIL_ADDRESS_INS';

            v_err_cnt := SQL%RowCount;

            UPDATE CORP_ETL_JOB_STATISTICS
               SET ERROR_COUNT = v_err_cnt
                 , RECORD_COUNT = v_ins_cnt + v_err_cnt
                 , PROCESSED_COUNT = v_ins_cnt + v_err_cnt
             WHERE JOB_ID =  v_job_id;

            DELETE FROM Errlog_Email_Address WHERE ora_err_tag$ = 'EMAIL_ADDRESS_INS';

            COMMIT;

       END LOOP;

    END IF;

    Maxdat_Statistics.TABLE_STATS('EMRS_D_EMAIL_ADDRESS');

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, con_pkg || '.EMAIL_ADDRESS_INS', 1, v_desc, v_code, 'EMRS_D_EMAIL_ADDRESS');

      COMMIT;

END EMAIL_ADDRESS_INS;

PROCEDURE EMAIL_ADDRESS_UPD
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
    to_process number := 0;
    Run_Multiple varchar2(1) := 'N';
BEGIN

    DELETE FROM Errlog_Email_Address WHERE ora_err_tag$ = 'EMAIL_ADDRESS_UPD';

    Maxdat_Statistics.TABLE_STATS('EMRS_S_EMAIL_ADDRESS_STG');

    SELECT COUNT(1) INTO to_process FROM EMRS_S_EMAIL_ADDRESS_STG;

    SELECT CASE WHEN to_process > NVL(Value,1000000)
                THEN 'Y' ELSE 'N' END INTO Run_Multiple
      FROM CORP_ETL_CONTROL WHERE NAME = 'EMRS_REC_THRESHOLD';

    IF Run_Multiple = 'N' THEN

       INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
       VALUES (SEQ_JOB_ID.Nextval, 'EMAIL_ADDRESS_UPD','STARTED',SYSDATE)
       RETURNING JOB_ID INTO v_job_id;

       COMMIT;

       Maxdat_Statistics.TABLE_STATS('EMRS_D_EMAIL_ADDRESS');

       MERGE /*+ Enable_Parallel_Dml Parallel */
        INTO  EMRS_D_EMAIL_ADDRESS D
       USING ( 
                SELECT    email_id,
                            email_begin_date,
                            email_type_cd,
                            email_end_date,
                            client_id,
                            email_address,
                            email_dolk_id,
                            email_case_id,
                            status_cd,
                            email_bad_date,
                            email_bad_date_satisfied,
                            contact_method_ind,
                            comparable_key,
                            email_begin_ndt,
                            email_end_ndt,
                            start_ndt,
                            end_ndt,
                            created_by record_name,
                            creation_date record_date,
                            TO_CHAR(creation_date, c_time_format) record_time,
                            last_updated_by modified_name,
                            last_update_date modified_date,
                            TO_CHAR(last_update_date, c_time_format)  modified_time                
                 FROM emrs_s_email_address_stg                
              ) C ON (D.email_id = C.email_id)
        WHEN MATCHED THEN UPDATE
         SET            d.email_begin_date  =   c.email_begin_date
                        , d.email_type_cd   =   c.email_type_cd
                        , d.email_end_date  =   c.email_end_date
                        , d.client_id       =   c.client_id
                        , d.email_address   =   c.email_address
                        , d.email_dolk_id   =   c.email_dolk_id
                        , d.email_case_id   =   c.email_case_id
                        , d.status_cd       =   c.status_cd
                        , d.email_bad_date  =   c.email_bad_date
                        , d.email_bad_date_satisfied  =   c.email_bad_date_satisfied
                        , d.contact_method_ind  =   c.contact_method_ind
                        , d.comparable_key  =   c.comparable_key
                        , d.email_begin_ndt  =   c.email_begin_ndt
                        , d.email_end_ndt  =   c.email_end_ndt
                        , d.start_ndt  =   c.start_ndt
                        , d.end_ndt =   c.end_ndt                       
                        , d.modified_name =   c.modified_name
                        , d.modified_date =   c.modified_date
                        , d.modified_time =   c.modified_time
         Log Errors INTO Errlog_Email_Address ('EMAIL_ADDRESS_UPD') Reject Limit Unlimited;

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
        SELECT c_critical, con_pkg, con_pkg || '.EMAIL_ADDRESS_UPD', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_EMAIL_ADDRESS', EMAIL_ID
          FROM Errlog_Email_Address
         WHERE Ora_Err_Tag$ = 'EMAIL_ADDRESS_UPD';

        v_err_cnt := SQL%RowCount;

        UPDATE CORP_ETL_JOB_STATISTICS
           SET ERROR_COUNT = v_err_cnt
             , RECORD_COUNT = v_upd_cnt + v_err_cnt
             , PROCESSED_COUNT = v_upd_cnt + v_err_cnt
         WHERE JOB_ID =  v_job_id;

        COMMIT;

    ELSE

       FOR IDX In 0..9
       LOOP
           Maxdat_Statistics.TABLE_STATS('EMRS_D_EMAIL_ADDRESS');

           INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
           VALUES (SEQ_JOB_ID.Nextval, 'EMAIL_ADDRESS_UPD THREAD'||IDX,'STARTED',SYSDATE)
           RETURNING JOB_ID INTO v_job_id;

           COMMIT;

           MERGE /*+ Enable_Parallel_Dml Parallel */
           INTO  EMRS_D_EMAIL_ADDRESS D
           USING ( 
                SELECT    email_id,
                            email_begin_date,
                            email_type_cd,
                            email_end_date,
                            client_id,
                            email_address,
                            email_dolk_id,
                            email_case_id,
                            status_cd,
                            email_bad_date,
                            email_bad_date_satisfied,
                            contact_method_ind,
                            comparable_key,
                            email_begin_ndt,
                            email_end_ndt,
                            start_ndt,
                            end_ndt,
                            created_by record_name,
                            creation_date record_date,
                            TO_CHAR(creation_date, c_time_format) record_time,
                            last_updated_by modified_name,
                            last_update_date modified_date,
                            TO_CHAR(last_update_date, c_time_format)  modified_time                
                 FROM emrs_s_email_address_stg                
              ) C ON (D.email_id = C.email_id)
           WHEN MATCHED THEN UPDATE
           SET            d.email_begin_date  =   c.email_begin_date
                        , d.email_type_cd   =   c.email_type_cd
                        , d.email_end_date  =   c.email_end_date
                        , d.client_id       =   c.client_id
                        , d.email_address   =   c.email_address
                        , d.email_dolk_id   =   c.email_dolk_id
                        , d.email_case_id   =   c.email_case_id
                        , d.status_cd       =   c.status_cd
                        , d.email_bad_date  =   c.email_bad_date
                        , d.email_bad_date_satisfied  =   c.email_bad_date_satisfied
                        , d.contact_method_ind  =   c.contact_method_ind
                        , d.comparable_key  =   c.comparable_key
                        , d.email_begin_ndt  =   c.email_begin_ndt
                        , d.email_end_ndt  =   c.email_end_ndt
                        , d.start_ndt  =   c.start_ndt
                        , d.end_ndt =   c.end_ndt                       
                        , d.modified_name =   c.modified_name
                        , d.modified_date =   c.modified_date
                        , d.modified_time =   c.modified_time
           Log Errors INTO Errlog_Email_Address ('EMAIL_ADDRESS_UPD') Reject Limit Unlimited;

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
            SELECT c_critical, con_pkg, con_pkg || '.EMAIL_ADDRESS_UPD', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_EMAIL_ADDRESS', EMAIL_ID
              FROM Errlog_Email_Address
             WHERE Ora_Err_Tag$ = 'EMAIL_ADDRESS_UPD';

            v_err_cnt := SQL%RowCount;

            UPDATE CORP_ETL_JOB_STATISTICS
               SET ERROR_COUNT = v_err_cnt
                 , RECORD_COUNT = v_upd_cnt + v_err_cnt
                 , PROCESSED_COUNT = v_upd_cnt + v_err_cnt
             WHERE JOB_ID =  v_job_id;

            DELETE FROM Errlog_Email_Address WHERE ora_err_tag$ = 'EMAIL_ADDRESS_UPD';

            COMMIT;

       END LOOP;

    END IF;

    Maxdat_Statistics.TABLE_STATS('EMRS_D_EMAIL_ADDRESS');

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, con_pkg || '.EMAIL_ADDRESS_UPD', 1, v_desc, v_code, 'EMRS_D_EMAIL_ADDRESS');

      COMMIT;

END EMAIL_ADDRESS_UPD;    


END;
/

grant execute on EMRS_LAEB_CASE_CLIENT_ETL_PKG to MAXDAT_LAEB_READ_ONLY;

alter session set plsql_code_type = interpreted;