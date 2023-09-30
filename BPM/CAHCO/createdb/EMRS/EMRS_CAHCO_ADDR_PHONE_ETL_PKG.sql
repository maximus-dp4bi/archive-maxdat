alter session set plsql_code_type = native;

create or replace package CAHCO_ADDR_PHONE_ETL_PKG as


  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL$';
  SVN_REVISION varchar2(20) := '$Revision$';
  SVN_REVISION_DATE varchar2(60) := '$Date$';
  SVN_REVISION_AUTHOR varchar2(20) := '$Author$';

  con_pkg    CONSTANT  VARCHAR2(30) := $$PLSQL_UNIT;
  c_abort    CONSTANT  corp_etl_error_log.err_level%TYPE := 'ABORT';
  c_critical CONSTANT  corp_etl_error_log.err_level%TYPE := 'CRITICAL';
  c_log      CONSTANT  corp_etl_error_log.err_level%TYPE := 'LOG';

  PROCEDURE ADDRESS_INS;
  PROCEDURE ADDRESS_UPD;
  
  PROCEDURE ADDRESS_HIST_INS;
  PROCEDURE ADDRESS_HIST_UPD;
  
  PROCEDURE PHONE_INS;
  PROCEDURE PHONE_UPD;
  
  PROCEDURE PHONE_HIST_INS;
  PROCEDURE PHONE_HIST_UPD;
    
end;
/

CREATE OR REPLACE PACKAGE BODY CAHCO_ADDR_PHONE_ETL_PKG AS

    v_code corp_etl_error_log.error_codes%TYPE;
    v_desc corp_etl_error_log.error_desc%TYPE;

PROCEDURE ADDRESS_INS
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_ins_cnt number;
    v_err_cnt number;

BEGIN

    DELETE FROM Errlog_Address WHERE ora_err_tag$ = 'ADRRESS_INS';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'ADDRESS_INS','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;
    
    Maxdat_Statistics.TABLE_STATS('EMRS_S_DEMOGRAPHICS_STG');

    INSERT /*+ Enable_Parallel_Dml Parallel */
      INTO EMRS_D_ADDRESS (address_id
        ,addr_street_1
        ,addr_street_2
        ,addr_city
        ,addr_state_cd
        ,addr_zip
        ,addr_zip_four
        ,addr_type_cd
        ,addr_type
        ,addr_country
        ,client_number                
        ,addr_ctlk_id
        ,residence_addr_county
        ,residence_addr_zip
        ,addr_bad_date
        ,case_number
        ,start_ndt
        ,end_ndt
        ,record_name
        ,record_date
        ,modified_name
        ,modified_date
        ,source_addr_begin_date
        ,source_addr_end_date)
    SELECT  dm.DemographyID address_id
        ,dm.Address1 addr_street_1
        ,dm.Address2 addr_street_2
        ,dm.City addr_city
        ,dm.State addr_state_cd
        ,dm.MailingZip addr_zip
        ,dm.ZipPlus addr_zip_four
        ,'ML' addr_type_cd
        ,'Mailing Address' addr_type
        ,'USA' addr_country
        ,dm.BeneficiaryID client_number                
        ,dm.MailingCounty addr_ctlk_id
        ,dm.ResidenceCounty residence_addr_county
        ,dm.ResidenceZip residence_addr_zip
        ,dm.BadAddrFlagSetDate addr_bad_date
        ,dm.CaseRowID case_number        
        ,TO_NUMBER(TO_CHAR(TRUNC(dm.RecordCreateDate),'YYYYMMDDHH24MISS')) start_ndt
        ,20501231000000 end_ndt
        ,dm.RecordCreateName record_name
        ,dm.RecordCreateDate record_date
        ,dm.NameLastModified modified_name
        ,dm.DateLastModified modified_date       
        ,TRUNC(dm.RecordCreateDate) source_addr_begin_date
        ,TO_DATE('2050/12/31','YYYY/MM/DD') source_addr_end_date        
     FROM emrs_s_demographics_stg dm    
     WHERE NOT EXISTS(SELECT 1 FROM emrs_d_address da WHERE dm.DemographyID = da.address_id)
     LOG Errors INTO Errlog_Address ('ADDRESS_INS') Reject Limit Unlimited;

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
    SELECT c_critical, con_pkg, 'CAHCO_ADDR_PHONE_ETL_PKG.ADDRESS_INS', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_ADDRESS', ADDRESS_ID
      FROM Errlog_Address
     WHERE Ora_Err_Tag$ = 'ADDRESS_INS';

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
      VALUES( c_critical, con_pkg, 'CAHCO_ADDR_PHONE_ETL_PKG.ADDRESS_INS', 1, v_desc, v_code, 'EMRS_D_ADDRESS');

      COMMIT;
END ADDRESS_INS;

PROCEDURE ADDRESS_UPD
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

    DELETE FROM Errlog_Address WHERE ora_err_tag$ = 'ADDRESS_UPD';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'ADDRESS_UPD','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;

   MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  EMRS_D_ADDRESS s
   USING (SELECT ad.*
                 ,t.dp_address_id
          FROM (SELECT dm.DemographyID address_id
                        ,dm.Address1 addr_street_1
                        ,dm.Address2 addr_street_2
                        ,dm.City addr_city
                        ,dm.State addr_state_cd
                        ,dm.MailingZip addr_zip
                        ,dm.ZipPlus addr_zip_four
                        ,'ML' addr_type_cd
                        ,'Mailing Address' addr_type
                        ,'USA' addr_country
                        ,dm.BeneficiaryID client_number                
                        ,dm.MailingCounty addr_ctlk_id
                        ,dm.ResidenceCounty residence_addr_county
                        ,dm.ResidenceZip residence_addr_zip
                        ,dm.BadAddrFlagSetDate addr_bad_date
                        ,dm.CaseRowID case_number
                        ,TO_NUMBER(TO_CHAR(TRUNC(dm.DateLastModified),'YYYYMMDDHH24MISS')) start_ndt
                        ,20501231000000 end_ndt
                        ,dm.RecordCreateName record_name
                        ,dm.RecordCreateDate record_date
                        ,dm.NameLastModified modified_name
                        ,dm.DateLastModified modified_date
                        ,TRUNC(dm.DateLastModified) source_addr_begin_date
                        ,TO_DATE('2050/12/31','YYYY/MM/DD') source_addr_end_date        
                FROM emrs_s_demographics_stg dm    ) ad    
          JOIN emrs_d_address t ON ad.address_id = t.address_id
          WHERE COALESCE(t.addr_street_1,'*') != COALESCE(ad.addr_street_1,'*') 
            OR COALESCE(t.addr_street_2,'*') != COALESCE(ad.addr_street_2,'*')
            OR COALESCE(t.addr_city,'*') != COALESCE(ad.addr_city,'*')
            OR COALESCE(t.addr_state_cd,'*') != COALESCE(ad.addr_state_cd,'*')
            OR COALESCE(t.addr_zip,'*') != COALESCE(ad.addr_zip,'*')
            OR COALESCE(t.addr_zip_four,'*') != COALESCE(ad.addr_zip_four,'*')
            OR COALESCE(t.addr_type_cd,'*') != COALESCE(ad.addr_type_cd,'*')
            OR COALESCE(t.addr_type,'*') != COALESCE(ad.addr_type,'*')
            OR COALESCE(t.addr_country,'*') != COALESCE(ad.addr_country,'*')
            OR COALESCE(t.client_number,0) != COALESCE(ad.client_number,0)
            OR COALESCE(t.addr_ctlk_id,'*') != COALESCE(ad.addr_ctlk_id,'*')            
            OR COALESCE(t.addr_bad_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(ad.addr_bad_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.case_number,0) != COALESCE(ad.case_number,0)
            OR COALESCE(t.start_ndt,0) != COALESCE(ad.start_ndt,0)
            OR COALESCE(t.end_ndt,0) != COALESCE(ad.end_ndt,0)
            OR COALESCE(t.record_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(ad.record_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.record_name,'*') != COALESCE(ad.record_name,'*')
            OR COALESCE(t.modified_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(ad.modified_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.modified_name,'*') != COALESCE(ad.modified_name,'*')            
            OR COALESCE(t.source_addr_begin_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(ad.source_addr_begin_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.source_addr_end_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(ad.source_addr_end_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.residence_addr_zip,'*') != COALESCE(ad.residence_addr_zip,'*')
            OR COALESCE(t.residence_addr_county,'*') != COALESCE(ad.residence_addr_county,'*')   
          ) st ON (s.dp_address_id = st.dp_address_id)
    WHEN MATCHED THEN UPDATE
     SET s.addr_street_1 = st.addr_street_1
        ,s.addr_street_2 = st.addr_street_2
        ,s.addr_city = st.addr_city
        ,s.addr_state_cd = st.addr_state_cd
        ,s.addr_zip = st.addr_zip
        ,s.addr_zip_four = st.addr_zip_four
        ,s.addr_type_cd = st.addr_type_cd
        ,s.addr_type = st.addr_type
        ,s.addr_country = st.addr_country
        ,s.client_number = st.client_number
        ,s.addr_ctlk_id = st.addr_ctlk_id
        ,s.addr_bad_date = st.addr_bad_date
        ,s.case_number = st.case_number      
        ,s.record_date = st.record_date
        ,s.record_name = st.record_name
        ,s.modified_date = st.modified_date
        ,s.modified_name = st.modified_name    
        ,s.residence_addr_zip = st.residence_addr_zip
        ,s.residence_addr_county = st.residence_addr_county
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
    SELECT c_critical, con_pkg, 'CAHCO_ADDR_PHONE_ETL_PKG.ADDRESS_UPD', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_ADDRESS', ADDRESS_ID
      FROM Errlog_Address
     WHERE Ora_Err_Tag$ = 'ADDRESS_UPD';

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
      VALUES( c_critical, con_pkg, 'CAHCO_ADDR_PHONE_ETL_PKG.ADDRESS_UPD', 1, v_desc, v_code, 'EMRS_D_ADDRESS');

      COMMIT;
END ADDRESS_UPD;


PROCEDURE ADDRESS_HIST_INS
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_ins_cnt number;
    v_err_cnt number;

BEGIN

    DELETE FROM Errlog_Address_Hist WHERE ora_err_tag$ = 'ADDRESS_HIST_INS';

    MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  emrs_s_demographics_stg s
    USING (SELECT dm.DemographyId address_id
                  ,h.dp_address_history_id
            FROM emrs_s_demographics_stg dm
              JOIN emrs_d_address_history h ON dm.DemographyID = h.address_id 
              AND h.source_addr_end_date = TO_DATE('12/31/2050','mm/dd/yyyy') ) ht ON (s.DemographyId = ht.address_id)
    WHEN MATCHED THEN UPDATE
    SET existing_rec_dp_address_id = dp_address_history_id ;
    
    COMMIT;
    
    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'ADDRESS_HIST_INS','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;

    MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  EMRS_D_ADDRESS_HISTORY h
     USING (SELECT dm.DemographyId address_id
                    ,TRUNC(dm.DateLastModified) source_addr_begin_date
                    ,CASE WHEN TRUNC(dm.DateLastModified-1) < h.source_addr_begin_date THEN h.source_addr_begin_date ELSE TRUNC(dm.DateLastModified-1) END nw_source_addr_end_date
                    ,CASE WHEN TRUNC(dm.DateLastModified-1) < h.source_addr_begin_date THEN TO_NUMBER(TO_CHAR(h.source_addr_begin_date,'YYYYMMDDHH24MISS'))
                    ELSE TO_NUMBER(TO_CHAR(TRUNC(dm.DateLastModified-1),'YYYYMMDDHH24MISS')) END nw_source_addr_end_date_ndt
                    ,h.dp_address_history_id
            FROM emrs_s_demographics_stg dm
              JOIN emrs_d_address_history h ON dm.DemographyID = h.address_id 
            WHERE  TRUNC(dm.DateLastModified) != h.source_addr_begin_date
            AND h.source_addr_end_date = TO_DATE('2050/12/31','yyyy/mm/dd') ) ht ON (ht.dp_address_history_id = h.dp_address_history_id)
    WHEN MATCHED THEN UPDATE
     SET h.source_addr_end_date = ht.nw_source_addr_end_date      
         ,h.end_ndt = ht.nw_source_addr_end_date_ndt
     Log Errors INTO Errlog_Address_Hist ('ADDRESS_HIST_INS') Reject Limit Unlimited;
 
 
    INSERT /*+ Enable_Parallel_Dml Parallel */
      INTO EMRS_D_ADDRESS_HISTORY (address_id
        ,addr_street_1
        ,addr_street_2
        ,addr_city
        ,addr_state_cd
        ,addr_zip
        ,addr_zip_four
        ,addr_type_cd
        ,addr_type
        ,addr_country
        ,client_number                
        ,addr_ctlk_id
        ,residence_addr_county
        ,residence_addr_zip
        ,addr_bad_date
        ,case_number
        ,start_ndt
        ,end_ndt
        ,record_name
        ,record_date
        ,modified_name
        ,modified_date
        ,source_addr_begin_date
        ,source_addr_end_date)
    SELECT  dm.DemographyID address_id
        ,dm.Address1 addr_street_1
        ,dm.Address2 addr_street_2
        ,dm.City addr_city
        ,dm.State addr_state_cd
        ,dm.MailingZip addr_zip
        ,dm.ZipPlus addr_zip_four
        ,'ML' addr_type_cd
        ,'Mailing Address' addr_type
        ,'USA' addr_country
        ,dm.BeneficiaryID client_number                
        ,dm.MailingCounty addr_ctlk_id
        ,dm.ResidenceCounty residence_addr_county
        ,dm.ResidenceZip residence_addr_zip
        ,dm.BadAddrFlagSetDate addr_bad_date
        ,dm.CaseRowID case_number        
        ,CASE WHEN da.address_id IS NULL THEN TO_NUMBER(TO_CHAR(TRUNC(dm.RecordCreateDate),'YYYYMMDDHH24MISS'))
           ELSE TO_NUMBER(TO_CHAR(TRUNC(dm.DateLastModified),'YYYYMMDDHH24MISS')) END start_ndt           
        ,20501231000000 end_ndt
        ,dm.RecordCreateName record_name
        ,dm.RecordCreateDate record_date
        ,dm.NameLastModified modified_name
        ,dm.DateLastModified modified_date
        --,TRUNC(dm.DateLastModified) source_addr_begin_date
        ,CASE WHEN da.address_id IS NULL THEN TRUNC(dm.RecordCreateDate) ELSE TRUNC(dm.DateLastModified) END source_addr_begin_date
        ,TO_DATE('2050/12/31','YYYY/MM/DD') source_addr_end_date        
     FROM emrs_s_demographics_stg dm  
       LEFT JOIN emrs_d_address_history da ON dm.existing_rec_dp_address_id = da.dp_address_history_id --AND da.source_addr_end_date = TO_DATE('12/31/2050','mm/dd/yyyy')
     WHERE da.address_id IS NULL OR (da.address_id IS NOT NULL AND TRUNC(dm.DateLastModified) != da.source_addr_begin_date)
     LOG Errors INTO Errlog_Address_Hist ('ADDRESS_HIST_INS') Reject Limit Unlimited;

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
    SELECT c_critical, con_pkg, 'CAHCO_ADDR_PHONE_ETL_PKG.ADDRESS_HIST_INS', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_ADDRESS_HISTORY', ADDRESS_ID
      FROM Errlog_Address_Hist
     WHERE Ora_Err_Tag$ = 'ADDRESS_HIST_INS';

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
      VALUES( c_critical, con_pkg, 'CAHCO_ADDR_PHONE_ETL_PKG.ADDRESS_HIST_INS', 1, v_desc, v_code, 'EMRS_D_ADDRESS_HISTORY');

      COMMIT;
END ADDRESS_HIST_INS;

PROCEDURE ADDRESS_HIST_UPD
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_Address_Hist WHERE ora_err_tag$ = 'ADDRESS_HIST_UPD';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'ADDRESS_HIST_UPD','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

   MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  EMRS_D_ADDRESS_HISTORY s
   USING (SELECT ad.*
                 ,t.dp_address_history_id
          FROM (SELECT dm.DemographyID address_id
                        ,dm.Address1 addr_street_1
                        ,dm.Address2 addr_street_2
                        ,dm.City addr_city
                        ,dm.State addr_state_cd
                        ,dm.MailingZip addr_zip
                        ,dm.ZipPlus addr_zip_four
                        ,'ML' addr_type_cd
                        ,'Mailing Address' addr_type
                        ,'USA' addr_country
                        ,dm.BeneficiaryID client_number                
                        ,dm.MailingCounty addr_ctlk_id
                        ,dm.ResidenceCounty residence_addr_county
                        ,dm.ResidenceZip residence_addr_zip
                        ,dm.BadAddrFlagSetDate addr_bad_date
                        ,dm.CaseRowID case_number
                        ,TO_NUMBER(TO_CHAR(TRUNC(dm.DateLastModified),'YYYYMMDDHH24MISS')) start_ndt
                        ,20501231000000 end_ndt
                        ,dm.RecordCreateName record_name
                        ,dm.RecordCreateDate record_date
                        ,dm.NameLastModified modified_name
                        ,dm.DateLastModified modified_date
                        ,TRUNC(dm.DateLastModified) source_addr_begin_date
                        ,TO_DATE('2050/12/31','YYYY/MM/DD') source_addr_end_date  
                        ,dm.existing_rec_dp_address_id
                FROM emrs_s_demographics_stg dm    ) ad    
                 JOIN emrs_d_address_history t ON ad.existing_rec_dp_address_id = t.dp_address_history_id AND t.source_addr_begin_date = ad.source_addr_begin_date
          WHERE COALESCE(t.addr_street_1,'*') != COALESCE(ad.addr_street_1,'*') 
            OR COALESCE(t.addr_street_2,'*') != COALESCE(ad.addr_street_2,'*')
            OR COALESCE(t.addr_city,'*') != COALESCE(ad.addr_city,'*')
            OR COALESCE(t.addr_state_cd,'*') != COALESCE(ad.addr_state_cd,'*')
            OR COALESCE(t.addr_zip,'*') != COALESCE(ad.addr_zip,'*')
            OR COALESCE(t.addr_zip_four,'*') != COALESCE(ad.addr_zip_four,'*')
            OR COALESCE(t.addr_type_cd,'*') != COALESCE(ad.addr_type_cd,'*')
            OR COALESCE(t.addr_type,'*') != COALESCE(ad.addr_type,'*')
            OR COALESCE(t.addr_country,'*') != COALESCE(ad.addr_country,'*')
            OR COALESCE(t.client_number,0) != COALESCE(ad.client_number,0)
            OR COALESCE(t.addr_ctlk_id,'*') != COALESCE(ad.addr_ctlk_id,'*')            
            OR COALESCE(t.addr_bad_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(ad.addr_bad_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.case_number,0) != COALESCE(ad.case_number,0)        
            OR COALESCE(t.record_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(ad.record_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.record_name,'*') != COALESCE(ad.record_name,'*')
            OR COALESCE(t.modified_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(ad.modified_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.modified_name,'*') != COALESCE(ad.modified_name,'*')                     
            OR COALESCE(t.residence_addr_zip,'*') != COALESCE(ad.residence_addr_zip,'*')
            OR COALESCE(t.residence_addr_county,'*') != COALESCE(ad.residence_addr_county,'*')   
          ) st ON (s.dp_address_history_id  = st.dp_address_history_id)
    WHEN MATCHED THEN UPDATE
     SET s.addr_street_1 = st.addr_street_1
        ,s.addr_street_2 = st.addr_street_2
        ,s.addr_city = st.addr_city
        ,s.addr_state_cd = st.addr_state_cd
        ,s.addr_zip = st.addr_zip
        ,s.addr_zip_four = st.addr_zip_four
        ,s.addr_type_cd = st.addr_type_cd
        ,s.addr_type = st.addr_type
        ,s.addr_country = st.addr_country
        ,s.client_number = st.client_number
        ,s.addr_ctlk_id = st.addr_ctlk_id
        ,s.addr_bad_date = st.addr_bad_date
        ,s.case_number = st.case_number     
        ,s.record_date = st.record_date
        ,s.record_name = st.record_name
        ,s.modified_date = st.modified_date
        ,s.modified_name = st.modified_name     
        ,s.residence_addr_zip = st.residence_addr_zip
        ,s.residence_addr_county = st.residence_addr_county
     Log Errors INTO Errlog_Address_Hist ('ADDRESS_HIST_UPD') Reject Limit Unlimited;
     
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
    SELECT c_critical, con_pkg, 'CAHCO_ADDR_PHONE_ETL_PKG.ADDRESS_HIST_UPD', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_ADDRESS_HISTORY', ADDRESS_ID
      FROM Errlog_Address_Hist
     WHERE Ora_Err_Tag$ = 'ADDRESS_HIST_UPD';

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
      VALUES( c_critical, con_pkg, 'CAHCO_ADDR_PHONE_ETL_PKG.ADDRESS_HIST_UPD', 1, v_desc, v_code, 'EMRS_D_ADDRESS_HISTORY');

      COMMIT;
END ADDRESS_HIST_UPD;

PROCEDURE PHONE_INS
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_ins_cnt number;
    v_err_cnt number;

BEGIN

  EXECUTE IMMEDIATE 'TRUNCATE TABLE EMRS_S_PHONE_STG';

   INSERT /*+ Enable_Parallel_Dml Parallel */
      INTO EMRS_S_PHONE_STG (phone_id, 
                         phon_area_code,
                         phon_phone_number,
                         phone_type, 
                         phone_type_cd, 
                         case_number, 
                         client_number, 
                         end_ndt, 
                         modified_date, 
                         modified_name, 
                         record_date, 
                         record_name, 
                         source_phone_begin_date, 
                         source_phone_end_date, 
                         start_ndt,
                         existing_rec_dp_phone_id)
    SELECT d.phone_id
          ,d.phon_area_code
          ,d.phon_phone_number
          ,d.phone_type
          ,d.phone_type_cd
          ,d.case_number
          ,d.client_number
          ,d.end_ndt
          ,d.modified_date
          ,d.modified_name
          ,d.record_date
          ,d.record_name
          ,CASE WHEN dp_phone_history_id IS NOT NULL THEN TRUNC(d.modified_date) ELSE TRUNC(d.record_date) END source_phone_begin_date
          ,d.source_phone_end_date
          ,CASE WHEN dp_phone_history_id IS NOT NULL THEN TO_NUMBER(TO_CHAR(TRUNC(d.modified_date),'YYYYMMDDHH24MISS'))
             ELSE TO_NUMBER(TO_CHAR(TRUNC(d.record_date),'YYYYMMDDHH24MISS')) END start_ndt          
          ,t.dp_phone_history_id
    FROM (
        SELECT dm.DemographyID phone_id              
              ,TO_DATE('2050/12/31','YYYY/MM/DD') source_phone_end_date
              ,dm.BeneficiaryID client_number
              ,dm.RecordCreateName record_name
              ,dm.RecordCreateDate record_date
              ,dm.NameLastModified modified_name
              ,dm.DateLastModified modified_date
              ,SUBSTR(MobilePhone,1,3) mb_area_code
              ,SUBSTR(MaxstarPhone,1,3) mx_area_code
              ,SUBSTR(MEDSPhone,1,3) md_area_code
              ,SUBSTR(FaxNumber,1,3) fx_area_code
              ,SUBSTR(MobilePhone,4,7) mb_phone_number
              ,SUBSTR(MaxstarPhone,4,7) mx_phone_number
              ,SUBSTR(MEDSPhone,4,7) md_phone_number
              ,SUBSTR(FaxNumber,4,7) fx_phone_number
              ,'MB' mb_phone_type_code
              ,'A2' mx_phone_type_code
              ,'A1' md_phone_type_code
              ,'FAX' fx_phone_type_code
              ,'Mobile Phone' mb_phone_type
              ,'Maxstar Phone' mx_phone_type
              ,'MEDS Phone' md_phone_type
              ,'Fax Number' fx_phone_type
              ,dm.CaseRowID case_number           
              ,TO_NUMBER(TO_CHAR(TRUNC(dm.RecordCreateDate),'YYYYMMDDHH24MISS')) start_ndt
              ,20501231000000 end_ndt
        FROM emrs_s_demographics_stg dm
        WHERE maxstarphone IS NOT NULL
          OR medsphone IS NOT NULL
          OR mobilephone IS NOT NULL
          OR faxnumber IS NOT NULL ) 
    UNPIVOT ( (phone_type_cd,phone_type,phon_area_code,phon_phone_number)
      FOR sk IN ( (mb_phone_type_code, mb_phone_type,mb_area_code,mb_phone_number) AS 1,
                  (mx_phone_type_code, mx_phone_type,mx_area_code,mx_phone_number) AS 2,
                  (md_phone_type_code, md_phone_type,md_area_code,md_phone_number) AS 3,
                  (fx_phone_type_code, fx_phone_type,fx_area_code,fx_phone_number) AS 4 ) ) d
      LEFT JOIN emrs_d_phone_history t ON d.phone_id = t.phone_id AND d.phone_type_cd = t.phone_type_cd AND t.source_phone_end_date = TO_DATE('2050/12/31','YYYY/MM/DD')          
    WHERE d.phon_area_code IS NOT NULL
    AND d.phon_phone_number IS NOT NULL;

    COMMIT;
    
    Maxdat_Statistics.TABLE_STATS('EMRS_S_PHONE_STG');
    
    DELETE FROM Errlog_Phone WHERE ora_err_tag$ = 'PHONE_INS';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'PHONE_INS','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;

    INSERT /*+ Enable_Parallel_Dml Parallel */
      INTO EMRS_D_PHONE (phone_id, 
                         phon_area_code,
                         phon_phone_number,
                         phone_type, 
                         phone_type_cd, 
                         case_number, 
                         client_number, 
                         end_ndt, 
                         modified_date, 
                         modified_name, 
                         record_date, 
                         record_name, 
                         source_phone_begin_date, 
                         source_phone_end_date, 
                         start_ndt)
    SELECT d.phone_id
          ,d.phon_area_code
          ,d.phon_phone_number
          ,d.phone_type
          ,d.phone_type_cd
          ,d.case_number
          ,d.client_number
          ,d.end_ndt
          ,d.modified_date
          ,d.modified_name
          ,d.record_date
          ,d.record_name
          ,d.source_phone_begin_date
          ,d.source_phone_end_date
          ,d.start_ndt
    FROM emrs_s_phone_stg d
    WHERE NOT EXISTS(SELECT 1 FROM emrs_d_phone p WHERE p.phone_id = d.phone_id AND p.phone_type_cd = d.phone_type_cd) 
    LOG Errors INTO Errlog_Phone ('PHONE_INS') Reject Limit Unlimited;

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
    SELECT c_critical, con_pkg, 'CAHCO_ADDR_PHONE_ETL_PKG.PHONE_INS', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_PHONE', PHONE_ID
      FROM Errlog_Phone
     WHERE Ora_Err_Tag$ = 'PHONE_INS';

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
      VALUES( c_critical, con_pkg, 'CAHCO_ADDR_PHONE_ETL_PKG.PHONE_INS', 1, v_desc, v_code, 'EMRS_D_PHONE');

      COMMIT;
END PHONE_INS;

PROCEDURE PHONE_UPD
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

    DELETE FROM Errlog_Phone WHERE ora_err_tag$ = 'PHONE_UPD';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'PHONE_UPD','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;

   MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  EMRS_D_PHONE s
   USING (SELECT d.phone_id
                ,d.phon_area_code
                ,d.phon_phone_number
                ,d.phone_type
                ,d.phone_type_cd
                ,d.case_number
                ,d.client_number
                ,d.end_ndt
                ,d.modified_date
                ,d.modified_name
                ,d.record_date
                ,d.record_name
                ,d.source_phone_begin_date
                ,d.source_phone_end_date
                ,d.start_ndt
                ,t.dp_phone_id
          FROM emrs_s_phone_stg d
           JOIN emrs_d_phone t ON d.phone_id = t.phone_id AND d.phone_type_cd = t.phone_type_cd
          WHERE ( COALESCE(t.phon_area_code,'*') != COALESCE(d.phon_area_code,'*') 
            OR COALESCE(t.phon_phone_number,'*') != COALESCE(d.phon_phone_number,'*')
            OR COALESCE(t.phone_type_cd,'*') != COALESCE(d.phone_type_cd,'*')
            OR COALESCE(t.phone_type,'*') != COALESCE(d.phone_type,'*')            
            OR COALESCE(t.client_number,0) != COALESCE(d.client_number,0)            
            OR COALESCE(t.case_number,0) != COALESCE(d.case_number,0)
            OR COALESCE(t.record_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(d.record_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.record_name,'*') != COALESCE(d.record_name,'*')
            OR COALESCE(t.modified_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(d.modified_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.modified_name,'*') != COALESCE(d.modified_name,'*')  )         
          ) st ON (s.dp_phone_id = st.dp_phone_id)
    WHEN MATCHED THEN UPDATE
     SET s.phon_area_code = st.phon_area_code
         ,s.phon_phone_number = st.phon_phone_number
         ,s.phone_type = st.phone_type   
         ,s.case_number = st.case_number
         ,s.client_number = st.client_number      
         ,s.modified_date = st.modified_date
         ,s.modified_name = st.modified_name
         ,s.record_date = st.record_date
         ,s.record_name = st.record_name      
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
    SELECT c_critical, con_pkg, 'CAHCO_ADDR_PHONE_ETL_PKG.PHONE_UPD', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_PHONE', PHONE_ID
      FROM Errlog_Phone
     WHERE Ora_Err_Tag$ = 'PHONE_UPD';

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
      VALUES( c_critical, con_pkg, 'CAHCO_ADDR_PHONE_ETL_PKG.PHONE_UPD', 1, v_desc, v_code, 'EMRS_D_PHONE');

      COMMIT;
END PHONE_UPD;


PROCEDURE PHONE_HIST_INS
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_ins_cnt number;
    v_err_cnt number;

BEGIN

    DELETE FROM Errlog_Phone_Hist WHERE ora_err_tag$ = 'PHONE_HIST_INS';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'PHONE_HIST_INS','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;
 
    MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  EMRS_D_PHONE_HISTORY h
     USING (SELECT d.phone_id       
                ,d.phone_type
                ,d.phone_type_cd          
                ,d.source_phone_begin_date              
                ,CASE WHEN TRUNC(d.source_phone_begin_date-1) < h.source_phone_begin_date THEN h.source_phone_begin_date ELSE TRUNC(d.source_phone_begin_date-1) END nw_source_phone_end_date
                ,CASE WHEN TRUNC(d.source_phone_begin_date-1) < h.source_phone_begin_date THEN TO_NUMBER(TO_CHAR(h.source_phone_begin_date,'YYYYMMDDHH24MISS'))
                    ELSE TO_NUMBER(TO_CHAR(d.source_phone_begin_date-1,'YYYYMMDDHH24MISS')) END nw_source_phone_end_date_ndt
                ,h.dp_phone_history_id
            FROM emrs_s_phone_stg d
              JOIN emrs_d_phone_history h ON d.existing_rec_dp_phone_id = h.dp_phone_history_id
            WHERE d.source_phone_begin_date != h.source_phone_begin_date            
            ) ht ON (ht.dp_phone_history_id = h.dp_phone_history_id)
    WHEN MATCHED THEN UPDATE
     SET h.source_phone_end_date = ht.nw_source_phone_end_date 
        ,h.end_ndt = nw_source_phone_end_date_ndt
     Log Errors INTO Errlog_Phone_Hist ('PHONE_HIST_INS') Reject Limit Unlimited;
 
 
    INSERT /*+ Enable_Parallel_Dml Parallel */
      INTO EMRS_D_PHONE_HISTORY (phone_id, 
                         phon_area_code,
                         phon_phone_number,
                         phone_type, 
                         phone_type_cd, 
                         case_number, 
                         client_number, 
                         end_ndt, 
                         modified_date, 
                         modified_name, 
                         record_date, 
                         record_name, 
                         source_phone_begin_date, 
                         source_phone_end_date, 
                         start_ndt)
    SELECT d.phone_id
          ,d.phon_area_code
          ,d.phon_phone_number
          ,d.phone_type
          ,d.phone_type_cd
          ,d.case_number
          ,d.client_number
          ,d.end_ndt
          ,d.modified_date
          ,d.modified_name
          ,d.record_date
          ,d.record_name        
          ,d.source_phone_begin_date
          ,d.source_phone_end_date        
          ,d.start_ndt
    FROM emrs_s_phone_stg d
      LEFT JOIN emrs_d_phone_history p ON d.existing_rec_dp_phone_id = p.dp_phone_history_id
    WHERE (p.dp_phone_history_id IS NULL OR (p.dp_phone_history_id IS NOT NULL AND p.source_phone_begin_date ! = d.source_phone_begin_date ))    
     LOG Errors INTO Errlog_Phone_Hist ('PHONE_HIST_INS') Reject Limit Unlimited;

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
    SELECT c_critical, con_pkg, 'CAHCO_ADDR_PHONE_ETL_PKG.PHONE_HIST_INS', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_PHONE_HISTORY', PHONE_ID
      FROM Errlog_Phone_Hist
     WHERE Ora_Err_Tag$ = 'PHONE_HIST_INS';

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
      VALUES( c_critical, con_pkg, 'CAHCO_ADDR_PHONE_ETL_PKG.PHONE_HIST_INS', 1, v_desc, v_code, 'EMRS_D_PHONE_HISTORY');

      COMMIT;
END PHONE_HIST_INS;

PROCEDURE PHONE_HIST_UPD
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_Phone_Hist WHERE ora_err_tag$ = 'PHONE_HIST_UPD';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'PHONE_HIST_UPD','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

  MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  EMRS_D_PHONE_HISTORY s
   USING (SELECT d.phone_id
                ,d.phon_area_code
                ,d.phon_phone_number
                ,d.phone_type
                ,d.phone_type_cd
                ,d.case_number
                ,d.client_number
                ,d.end_ndt
                ,d.modified_date
                ,d.modified_name
                ,d.record_date
                ,d.record_name
                ,d.source_phone_begin_date
                ,d.source_phone_end_date
                ,d.start_ndt
                ,t.dp_phone_history_id
          FROM emrs_s_phone_stg d
                  JOIN emrs_d_phone_history t ON d.existing_rec_dp_phone_id = t.dp_phone_history_id AND d.source_phone_begin_date = t.source_phone_begin_date
            WHERE ( COALESCE(t.phon_area_code,'*') != COALESCE(d.phon_area_code,'*') 
            OR COALESCE(t.phon_phone_number,'*') != COALESCE(d.phon_phone_number,'*')
            OR COALESCE(t.phone_type_cd,'*') != COALESCE(d.phone_type_cd,'*')
            OR COALESCE(t.phone_type,'*') != COALESCE(d.phone_type,'*')            
            OR COALESCE(t.client_number,0) != COALESCE(d.client_number,0)            
            OR COALESCE(t.case_number,0) != COALESCE(d.case_number,0)       
            OR COALESCE(t.record_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(d.record_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.record_name,'*') != COALESCE(d.record_name,'*')
            OR COALESCE(t.modified_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(d.modified_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.modified_name,'*') != COALESCE(d.modified_name,'*') )         
          ) st ON (s.dp_phone_history_id = st.dp_phone_history_id)
    WHEN MATCHED THEN UPDATE
     SET s.phon_area_code = st.phon_area_code
         ,s.phon_phone_number = st.phon_phone_number
         ,s.phone_type = st.phone_type   
         ,s.case_number = st.case_number
         ,s.client_number = st.client_number     
         ,s.modified_date = st.modified_date
         ,s.modified_name = st.modified_name
         ,s.record_date = st.record_date
         ,s.record_name = st.record_name     
     Log Errors INTO Errlog_Phone_Hist ('PHONE_HIST_UPD') Reject Limit Unlimited;
     
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
    SELECT c_critical, con_pkg, 'CAHCO_ADDR_PHONE_ETL_PKG.PHONE_HIST_UPD', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_PHONE_HISTORY', PHONE_ID
      FROM Errlog_Phone_Hist
     WHERE Ora_Err_Tag$ = 'PHONE_HIST_UPD';

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
      VALUES( c_critical, con_pkg, 'CAHCO_ADDR_PHONE_ETL_PKG.PHONE_HIST_UPD', 1, v_desc, v_code, 'EMRS_D_PHONE_HISTORY');

      COMMIT;
END PHONE_HIST_UPD;

END;

/


grant execute on CAHCO_ENROLL_ETL_PKG to MAXDAT_READ_ONLY;

alter session set plsql_code_type = interpreted;