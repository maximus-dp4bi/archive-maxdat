alter session set plsql_code_type = native;

create or replace package CAHCO_ETL_PKG as


  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL$';
  SVN_REVISION varchar2(20) := '$Revision$';
  SVN_REVISION_DATE varchar2(60) := '$Date$';
  SVN_REVISION_AUTHOR varchar2(20) := '$Author$';

  con_pkg    CONSTANT VARCHAR2(30) := $$PLSQL_UNIT;
  c_abort    CONSTANT corp_etl_error_log.err_level%TYPE := 'ABORT';
  c_critical CONSTANT corp_etl_error_log.err_level%TYPE := 'CRITICAL';
  c_log      CONSTANT corp_etl_error_log.err_level%TYPE := 'LOG';
  c_one_sec  CONSTANT DECIMAL(10,5) := 1/(24*60*60) ; 

  PROCEDURE CASE_INS;
  PROCEDURE CASE_UPD;

  PROCEDURE CLIENT_INS;
  PROCEDURE CLIENT_UPD;

  PROCEDURE CLIENT_HIST_ELIG_INS;
  PROCEDURE CLIENT_HIST_ENRL_INS;
  PROCEDURE CLIENT_HIST_EXTN_INS;

  PROCEDURE CLIENT_HIST_ELIG_UPD;
  PROCEDURE CLIENT_HIST_ENRL_UPD;
  PROCEDURE CLIENT_HIST_EXTN_UPD;

  PROCEDURE OB_CALLS_PRE_LOAD;
  PROCEDURE OB_CALLS_INS;
  PROCEDURE OB_CALLS_UPD;

  PROCEDURE PROCESS_OB_CALLS;

  PROCEDURE IVR_CALLS_PRE_LOAD;
  PROCEDURE IVR_CALLS_INS;
  PROCEDURE IVR_CALLS_UPD;
  
  PROCEDURE PROCESS_IVR_CALLS;
  
  PROCEDURE PROCESS_CRM_INCIDENTS;
  PROCEDURE PROCESS_CRM_ACTIVITY;
  

end;
/


CREATE OR REPLACE PACKAGE BODY MAXDAT.CAHCO_ETL_PKG AS

    v_code corp_etl_error_log.error_codes%TYPE;
    v_desc corp_etl_error_log.error_desc%TYPE;

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
          INTO Emrs_D_Case (case_number, case_id, clnt_client_id, mails_returned, addr_bad_date, addr_bad_flag,
                            record_name, record_date,  modified_name,  modified_date)
        SELECT case_number, case_id, clnt_client_id, mails_returned, addr_bad_date, addr_bad_flag, record_name, record_date,  modified_name,  modified_date
          FROM emrs_s_cases_stg s
         WHERE NOT EXISTS (SELECT 1 FROM emrs_d_case C WHERE C.Case_Number = S.Case_Number)
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
        SELECT c_critical, con_pkg, 'CAHCO_ETL_PKG.CASE_INS', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_CASE', Case_Number
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

           -- Maxdat_Statistics.TABLE_STATS('EMRS_D_CASE');

            INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
            VALUES (SEQ_JOB_ID.Nextval, 'CASE_INS THREAD'||IDX,'STARTED',SYSDATE)
            RETURNING JOB_ID INTO v_job_id;

            COMMIT;

            INSERT /*+ Enable_Parallel_Dml Parallel */
              INTO Emrs_D_Case (case_number, case_id, clnt_client_id, mails_returned, addr_bad_date, addr_bad_flag,
                                record_name, record_date,  modified_name,  modified_date)
            SELECT case_number, case_id, clnt_client_id, mails_returned, addr_bad_date, addr_bad_flag, record_name, record_date,  modified_name,  modified_date
              FROM emrs_s_cases_stg s
             WHERE SUBSTR(S.CASE_NUMBER,-1) = IDX
               AND NOT EXISTS (SELECT 1 FROM emrs_d_case C WHERE C.Case_Number = S.Case_Number)
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
            SELECT c_critical, con_pkg, 'CAHCO_ETL_PKG.CASE_INS', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_CASE', Case_Number
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
      VALUES( c_critical, con_pkg, 'CAHCO_ETL_PKG.CASE_INS', 1, v_desc, v_code, 'EMRS_D_CASE');

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

    --Maxdat_Statistics.TABLE_STATS('EMRS_S_CASES_STG');

    SELECT COUNT(1) INTO to_process FROM EMRS_S_CASES_STG;

    SELECT CASE WHEN to_process > NVL(Value,1000000)
                THEN 'Y' ELSE 'N' END INTO Run_Multiple
      FROM CORP_ETL_CONTROL WHERE NAME = 'EMRS_REC_THRESHOLD';

    IF Run_Multiple = 'N' THEN

       INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
       VALUES (SEQ_JOB_ID.Nextval, 'CASE_UPD','STARTED',SYSDATE)
       RETURNING JOB_ID INTO v_job_id;

       COMMIT;

       --Maxdat_Statistics.TABLE_STATS('EMRS_D_CASE');

       MERGE /*+ Enable_Parallel_Dml Parallel */
        INTO  EMRS_D_CASE D
       USING ( SELECT S.CASE_NUMBER, S.CASE_ID, S.CLNT_CLIENT_ID, S.MAILS_RETURNED, S.ADDR_BAD_DATE, S.ADDR_BAD_FLAG, S.MODIFIED_NAME, S.MODIFIED_DATE
                 FROM EMRS_D_CASE D, EMRS_S_CASES_STG S
                WHERE D.CASE_NUMBER = S.CASE_NUMBER
                  AND ((NVL(D.CLNT_CLIENT_ID,-1) != NVL(S.CLNT_CLIENT_ID,-1)) OR
                       (NVL(D.MAILS_RETURNED,'N') != NVL(S.MAILS_RETURNED,'N')) OR
                       (NVL(D.ADDR_BAD_FLAG,'*') != NVL(S.ADDR_BAD_FLAG,'*')) OR                       
                       (NVL(D.ADDR_BAD_DATE,  to_date('07/07/7777','mm/dd/yyyy'))  !=   NVL(S.ADDR_BAD_DATE,to_date('07/07/7777','mm/dd/yyyy'))))
              ) C ON (D.CASE_NUMBER = C.CASE_NUMBER)
        WHEN MATCHED THEN UPDATE
         SET D.CASE_ID = C.CASE_ID
           , D.CLNT_CLIENT_ID = C.CLNT_CLIENT_ID
           , D.MAILS_RETURNED = C.MAILS_RETURNED
           , D.ADDR_BAD_DATE = C.ADDR_BAD_DATE
           , D.ADDR_BAD_FLAG = C.ADDR_BAD_FLAG
		   , D.MODIFIED_NAME = C.MODIFIED_NAME
		   , D.MODIFIED_DATE = C.MODIFIED_DATE
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
        SELECT c_critical, con_pkg, 'CAHCO_ETL_PKG.CASE_UPD', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_CASE', Case_Number
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
           --Maxdat_Statistics.TABLE_STATS('EMRS_D_CASE');

           INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
           VALUES (SEQ_JOB_ID.Nextval, 'CASE_UPD THREAD'||IDX,'STARTED',SYSDATE)
           RETURNING JOB_ID INTO v_job_id;

           COMMIT;

           MERGE /*+ Enable_Parallel_Dml Parallel */
            INTO  EMRS_D_CASE D
           USING ( SELECT S.CASE_NUMBER, S.CASE_ID, S.CLNT_CLIENT_ID, S.MAILS_RETURNED, S.ADDR_BAD_DATE, S.ADDR_BAD_FLAG, S.MODIFIED_NAME, S.MODIFIED_DATE
                     FROM EMRS_D_CASE D, EMRS_S_CASES_STG S
                    WHERE D.CASE_NUMBER = S.CASE_NUMBER
                      AND SUBSTR(S.CASE_NUMBER,-1) = IDX
                      AND ((NVL(D.CLNT_CLIENT_ID,-1) != NVL(S.CLNT_CLIENT_ID,-1)) OR
                           (NVL(D.MAILS_RETURNED,'N') != NVL(S.MAILS_RETURNED,'N')) OR
                           (NVL(D.ADDR_BAD_FLAG,'*') != NVL(S.ADDR_BAD_FLAG,'*')) OR                             
                           (NVL(D.ADDR_BAD_DATE,  to_date('07/07/7777','mm/dd/yyyy'))  !=   NVL(S.ADDR_BAD_DATE,to_date('07/07/7777','mm/dd/yyyy'))))
                  ) C ON (D.CASE_NUMBER = C.CASE_NUMBER)
            WHEN MATCHED THEN UPDATE
             SET D.CASE_ID = C.CASE_ID
               , D.CLNT_CLIENT_ID = C.CLNT_CLIENT_ID
               , D.MAILS_RETURNED = C.MAILS_RETURNED
               , D.ADDR_BAD_DATE = C.ADDR_BAD_DATE
               , D.ADDR_BAD_FLAG = C.ADDR_BAD_FLAG
		       , D.MODIFIED_NAME = C.MODIFIED_NAME
		       , D.MODIFIED_DATE = C.MODIFIED_DATE
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
            SELECT c_critical, con_pkg, 'CAHCO_ETL_PKG.CASE_UPD', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_CASE', Case_Number
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

    --Maxdat_Statistics.TABLE_STATS('EMRS_D_CASE');

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, 'CAHCO_ETL_PKG.CASE_UPD', 1, v_desc, v_code, 'EMRS_D_CASE');

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

    -- Maxdat_Statistics.TABLE_STATS('EMRS_S_CLIENT_STG');

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
               (client_number,  case_number,  cin,  addressokflag,  aidcode,  aliencode,  assigninthiscounty,  dob,  hcoclosedate,
                othhealthcoveragecode,  oldmedicalstatus,  olddentalstaus,  firstname,  middleinitial,  lastname,  eligibilityworkernum,
                ethniccode,  participantlang,  writtenlangcode,  mcalplnmedsstatus,  dtlmedshcpstatus,  medicalid,  mandatorvolunstatus,
                mandatorycounty,  denvolstatus,  maximusstatus,  isdualeligible,  isgrandfatherdlelig,  grandfatherdleligplan,  alowedplanfordlelig,
                medsfilecreationdate,  transmitdate,  pregnancyduedate,  exemptedbydr,  medicalexemption,  exemptionenddate,  dentalexemption,
                dentalexempenddate,  ccsindicator,  icfindicator,  medicarecarriercode,  medicareindicator,  isnonmeds,  switchtomeds,
                switchtomedsdate,  medicalpktrequested,  mpacketstatus,  dentalpktrequested,  dpacketstatus,  donotbulkemail,  donotbulkpostalmail,
                donotemail,  donotfax,  donotphone,  authorizedrepname,  carriertype,  carrier2type,  carrier3type, cci_status,  cci_maximusoptout,
                cci_paceeligible,  cci_mltssstatus,  cci_espdstatus,  cci_ignorelisind,  cci_ohcfmandatory,  defaultpathextension,  defaultpathextensionexemptionid,
                eaflag,  enrlexclind,  esrdind,  expresslanepin,  expresslaneaffirmation,  expresslaneparent,  expresslanestatusmedical,  expresslanestatusdental,
                hcpstatusprevious,  hcbshighind,  hicn,  institutionalind,  lisind,  mceligstat,  medicarecarrier2code,  medicarecarrier3code,  medicarestatusparta,
                medicarestatuspartb,  medicarestatuspartd,  optoutind,  passiveenrollment,  sinsiind,  socamt,  subplanind,  recordcreatedate,  recordcreatename,
                datelastmodified,
                namelastmodified,  enrollmentstatus,  sendidltrdate,  importdate,  countychangercvddate,  triggerforvolunmails,
                planoflasttrans,  lasttransdate,  lasttransrcvdid,  lasttransenrordisenr,  lasttransaccepted,  lastmedenrlrecid,  lastdisenrlrecid,
                lastdisenroldate,  lastdisenrlaccepted,  lastplanid,  lastenrlopenplanid,  lastplanactivateddate,  lastmcalffstrans,
                dtllasttransid,  dtllastopentrans,  dtlenrlstatus,  lastdentalenrleffdate,  dentalplanactive,  lastdtltranseord,  planoflastdtltrans,
                lastdtlffstrans,  gmccombinedchoice,  extendeddefaultpathtriggerdate,  aidcodemandatoryexpirationdate,  cmceligibilitydefaultpathresetdate,
                mltsseligibilitydefaultpathresetdate,  denbbmaildate,  medbbmaildate,  medrlmaildate,  denrlmaildate, ialettersentdate,  idlettersentdate,
                dialettersentdate,  didlettersenddate,  didlettersentdate,  mcalmvltrsentdate,  dtlmvltrsentdate,  firstspecialdlmaildate,
                secspecialdlmaildate,  thirdspecialdlmaildate,  ondisenrlpath,  medicalbbasent,  dentalbbasent, dexemplettersenddate,  mexemptlettersenddate,
                campaigncompleted,  mincompletesentdate,  incompletechoiceformcounter, spdstatus, sex,
                medicaleligibilityreasonid, dentaleligibilityreasonid, spdeligibilityreasonid, medicarecontractnum, medicareplanid, medicareplanstartdate)
        SELECT
                client_number,  case_number,  cin,  addressokflag,  aidcode,  aliencode,  assigninthiscounty,  dob,  hcoclosedate,
                othhealthcoveragecode,  oldmedicalstatus,  olddentalstaus,  firstname,  middleinitial,  lastname,  eligibilityworkernum,
                ethniccode,  participantlang,  writtenlangcode,  mcalplnmedsstatus,  dtlmedshcpstatus,  medicalid,  mandatorvolunstatus,
                mandatorycounty,  denvolstatus,  maximusstatus,  isdualeligible,  isgrandfatherdlelig,  grandfatherdleligplan,  alowedplanfordlelig,
                medsfilecreationdate,  transmitdate,  pregnancyduedate,  exemptedbydr,  medicalexemption,  exemptionenddate,  dentalexemption,
                dentalexempenddate,  ccsindicator,  icfindicator,  medicarecarriercode,  medicareindicator,  isnonmeds,  switchtomeds,
                switchtomedsdate,  medicalpktrequested,  mpacketstatus,  dentalpktrequested,  dpacketstatus,  donotbulkemail,  donotbulkpostalmail,
                donotemail,  donotfax,  donotphone,  authorizedrepname,  carriertype,  carrier2type,  carrier3type, cci_status,  cci_maximusoptout,
                cci_paceeligible,  cci_mltssstatus,  cci_espdstatus,  cci_ignorelisind,  cci_ohcfmandatory,  defaultpathextension,  defaultpathextensionexemptionid,
                eaflag,  enrlexclind,  esrdind,  expresslanepin,  expresslaneaffirmation,  expresslaneparent,  expresslanestatusmedical,  expresslanestatusdental,
                hcpstatusprevious,  hcbshighind,  hicn,  institutionalind,  lisind,  mceligstat,  medicarecarrier2code,  medicarecarrier3code,  medicarestatusparta,
                medicarestatuspartb,  medicarestatuspartd,  optoutind,  passiveenrollment,  sinsiind,  socamt,  subplanind,  recordcreatedate,  recordcreatename,
                case when datelastmodified > be_modifiedon then datelastmodified else be_modifiedon end ,
                namelastmodified,  enrollmentstatus,  sendidltrdate,  importdate,  countychangercvddate,  triggerforvolunmails,
                planoflasttrans,  lasttransdate,  lasttransrcvdid,  lasttransenrordisenr,  lasttransaccepted,  lastmedenrlrecid,  lastdisenrlrecid,
                lastdisenroldate,  lastdisenrlaccepted,  lastplanid,  lastenrlopenplanid,  lastplanactivateddate,  lastmcalffstrans,
                dtllasttransid,  dtllastopentrans,  dtlenrlstatus,  lastdentalenrleffdate,  dentalplanactive,  lastdtltranseord,  planoflastdtltrans,
                lastdtlffstrans,  gmccombinedchoice,  extendeddefaultpathtriggerdate,  aidcodemandatoryexpirationdate,  cmceligibilitydefaultpathresetdate,
                mltsseligibilitydefaultpathresetdate,  denbbmaildate,  medbbmaildate,  medrlmaildate,  denrlmaildate, ialettersentdate,  idlettersentdate,
                dialettersentdate,  didlettersenddate,  didlettersentdate,  mcalmvltrsentdate,  dtlmvltrsentdate,  firstspecialdlmaildate,
                secspecialdlmaildate,  thirdspecialdlmaildate,  ondisenrlpath,  medicalbbasent,  dentalbbasent, dexemplettersenddate,  mexemptlettersenddate,
                campaigncompleted,  mincompletesentdate,  incompletechoiceformcounter, spdstatus, sex,
                medicaleligibilityreasonid, dentaleligibilityreasonid, spdeligibilityreasonid, medicarecontractnum, medicareplanid, medicareplanstartdate
        FROM emrs_s_client_stg s
         WHERE NOT EXISTS (SELECT 1 FROM emrs_d_client C WHERE C.Client_Number = S.Client_Number)
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
        SELECT c_critical, con_pkg, 'CAHCO_ETL_PKG.CLIENT_INS', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_CLIENT', Client_Number
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

           --Maxdat_Statistics.TABLE_STATS('EMRS_D_CLIENT');

           INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
           VALUES (SEQ_JOB_ID.Nextval, 'CLIENT_INS THREAD'||IDX,'STARTED',SYSDATE)
           RETURNING JOB_ID INTO v_job_id;

           COMMIT;

          INSERT /*+ Enable_Parallel_Dml Parallel */
            INTO Emrs_D_Client
                 (client_number,  case_number,  cin,  addressokflag,  aidcode,  aliencode,  assigninthiscounty,  dob,  hcoclosedate,
                  othhealthcoveragecode,  oldmedicalstatus,  olddentalstaus,  firstname,  middleinitial,  lastname,  eligibilityworkernum,
                  ethniccode,  participantlang,  writtenlangcode,  mcalplnmedsstatus,  dtlmedshcpstatus,  medicalid,  mandatorvolunstatus,
                  mandatorycounty,  denvolstatus,  maximusstatus,  isdualeligible,  isgrandfatherdlelig,  grandfatherdleligplan,  alowedplanfordlelig,
                  medsfilecreationdate,  transmitdate,  pregnancyduedate,  exemptedbydr,  medicalexemption,  exemptionenddate,  dentalexemption,
                  dentalexempenddate,  ccsindicator,  icfindicator,  medicarecarriercode,  medicareindicator,  isnonmeds,  switchtomeds,
                  switchtomedsdate,  medicalpktrequested,  mpacketstatus,  dentalpktrequested,  dpacketstatus,  donotbulkemail,  donotbulkpostalmail,
                  donotemail,  donotfax,  donotphone,  authorizedrepname,  carriertype,  carrier2type,  carrier3type, cci_status,  cci_maximusoptout,
                  cci_paceeligible,  cci_mltssstatus,  cci_espdstatus,  cci_ignorelisind,  cci_ohcfmandatory,  defaultpathextension,  defaultpathextensionexemptionid,
                  eaflag,  enrlexclind,  esrdind,  expresslanepin,  expresslaneaffirmation,  expresslaneparent,  expresslanestatusmedical,  expresslanestatusdental,
                  hcpstatusprevious,  hcbshighind,  hicn,  institutionalind,  lisind,  mceligstat,  medicarecarrier2code,  medicarecarrier3code,  medicarestatusparta,
                  medicarestatuspartb,  medicarestatuspartd,  optoutind,  passiveenrollment,  sinsiind,  socamt,  subplanind,  recordcreatedate,  recordcreatename,
                  datelastmodified,
                  namelastmodified,  enrollmentstatus,  sendidltrdate,  importdate,  countychangercvddate,  triggerforvolunmails,
                  planoflasttrans,  lasttransdate,  lasttransrcvdid,  lasttransenrordisenr,  lasttransaccepted,  lastmedenrlrecid,  lastdisenrlrecid,
                  lastdisenroldate,  lastdisenrlaccepted,  lastplanid,  lastenrlopenplanid,  lastplanactivateddate,  lastmcalffstrans,
                  dtllasttransid,  dtllastopentrans,  dtlenrlstatus,  lastdentalenrleffdate,  dentalplanactive,  lastdtltranseord,  planoflastdtltrans,
                  lastdtlffstrans,  gmccombinedchoice,  extendeddefaultpathtriggerdate,  aidcodemandatoryexpirationdate,  cmceligibilitydefaultpathresetdate,
                  mltsseligibilitydefaultpathresetdate,  denbbmaildate,  medbbmaildate,  medrlmaildate,  denrlmaildate, ialettersentdate,  idlettersentdate,
                  dialettersentdate,  didlettersenddate,  didlettersentdate,  mcalmvltrsentdate,  dtlmvltrsentdate,  firstspecialdlmaildate,
                  secspecialdlmaildate,  thirdspecialdlmaildate,  ondisenrlpath,  medicalbbasent,  dentalbbasent, dexemplettersenddate,  mexemptlettersenddate,
                  campaigncompleted,  mincompletesentdate,  incompletechoiceformcounter, spdstatus, sex, 
                  medicaleligibilityreasonid, dentaleligibilityreasonid, spdeligibilityreasonid, medicarecontractnum, medicareplanid, medicareplanstartdate)
          SELECT
                  client_number,  case_number,  cin,  addressokflag,  aidcode,  aliencode,  assigninthiscounty,  dob,  hcoclosedate,
                  othhealthcoveragecode,  oldmedicalstatus,  olddentalstaus,  firstname,  middleinitial,  lastname,  eligibilityworkernum,
                  ethniccode,  participantlang,  writtenlangcode,  mcalplnmedsstatus,  dtlmedshcpstatus,  medicalid,  mandatorvolunstatus,
                  mandatorycounty,  denvolstatus,  maximusstatus,  isdualeligible,  isgrandfatherdlelig,  grandfatherdleligplan,  alowedplanfordlelig,
                  medsfilecreationdate,  transmitdate,  pregnancyduedate,  exemptedbydr,  medicalexemption,  exemptionenddate,  dentalexemption,
                  dentalexempenddate,  ccsindicator,  icfindicator,  medicarecarriercode,  medicareindicator,  isnonmeds,  switchtomeds,
                  switchtomedsdate,  medicalpktrequested,  mpacketstatus,  dentalpktrequested,  dpacketstatus,  donotbulkemail,  donotbulkpostalmail,
                  donotemail,  donotfax,  donotphone,  authorizedrepname,  carriertype,  carrier2type,  carrier3type, cci_status,  cci_maximusoptout,
                  cci_paceeligible,  cci_mltssstatus,  cci_espdstatus,  cci_ignorelisind,  cci_ohcfmandatory,  defaultpathextension,  defaultpathextensionexemptionid,
                  eaflag,  enrlexclind,  esrdind,  expresslanepin,  expresslaneaffirmation,  expresslaneparent,  expresslanestatusmedical,  expresslanestatusdental,
                  hcpstatusprevious,  hcbshighind,  hicn,  institutionalind,  lisind,  mceligstat,  medicarecarrier2code,  medicarecarrier3code,  medicarestatusparta,
                  medicarestatuspartb,  medicarestatuspartd,  optoutind,  passiveenrollment,  sinsiind,  socamt,  subplanind,  recordcreatedate,  recordcreatename,
                  case when datelastmodified > be_modifiedon then datelastmodified else be_modifiedon end ,
                  namelastmodified,  enrollmentstatus,  sendidltrdate,  importdate,  countychangercvddate,  triggerforvolunmails,
                  planoflasttrans,  lasttransdate,  lasttransrcvdid,  lasttransenrordisenr,  lasttransaccepted,  lastmedenrlrecid,  lastdisenrlrecid,
                  lastdisenroldate,  lastdisenrlaccepted,  lastplanid,  lastenrlopenplanid,  lastplanactivateddate,  lastmcalffstrans,
                  dtllasttransid,  dtllastopentrans,  dtlenrlstatus,  lastdentalenrleffdate,  dentalplanactive,  lastdtltranseord,  planoflastdtltrans,
                  lastdtlffstrans,  gmccombinedchoice,  extendeddefaultpathtriggerdate,  aidcodemandatoryexpirationdate,  cmceligibilitydefaultpathresetdate,
                  mltsseligibilitydefaultpathresetdate,  denbbmaildate,  medbbmaildate,  medrlmaildate,  denrlmaildate, ialettersentdate,  idlettersentdate,
                  dialettersentdate,  didlettersenddate,  didlettersentdate,  mcalmvltrsentdate,  dtlmvltrsentdate,  firstspecialdlmaildate,
                  secspecialdlmaildate,  thirdspecialdlmaildate,  ondisenrlpath,  medicalbbasent,  dentalbbasent, dexemplettersenddate,  mexemptlettersenddate,
                  campaigncompleted,  mincompletesentdate,  incompletechoiceformcounter, spdstatus, sex,
                  medicaleligibilityreasonid, dentaleligibilityreasonid, spdeligibilityreasonid, medicarecontractnum, medicareplanid, medicareplanstartdate

          FROM emrs_s_client_stg s
         WHERE S.PARTITIONIDX = IDX
           AND NOT EXISTS (SELECT 1 FROM emrs_d_client C WHERE C.Client_Number = S.Client_Number)
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
          SELECT c_critical, con_pkg, 'CAHCO_ETL_PKG.CLIENT_INS', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_CLIENT', Client_Number
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

    -- Maxdat_Statistics.TABLE_STATS('EMRS_D_CLIENT');

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, 'CAHCO_ETL_PKG.CLIENT_INS', 1, v_desc, v_code, 'EMRS_D_CLIENT');

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

    --OLD  Maxdat_Statistics.TABLE_STATS('EMRS_S_CLIENT_STG');
    -- Maxdat_Statistics.TABLE_STATS('EMRS_D_CLIENT');

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
                  s.client_number, s.case_number, s.cin, s.addressokflag, s.aidcode, s.aliencode, s.assigninthiscounty, s.dob, s.hcoclosedate,
                  s.othhealthcoveragecode,  s.oldmedicalstatus,  s.olddentalstaus,  s.firstname,  s.middleinitial,  s.lastname,  s.eligibilityworkernum,
                  s.ethniccode,  s.participantlang,  s.writtenlangcode,  s.mcalplnmedsstatus,  s.dtlmedshcpstatus,  s.medicalid,  s.mandatorvolunstatus,
                  s.mandatorycounty,  s.denvolstatus,  s.maximusstatus,  s.isdualeligible,  s.isgrandfatherdlelig,  s.grandfatherdleligplan, s.alowedplanfordlelig,
                  s.medsfilecreationdate,  s.transmitdate,  s.pregnancyduedate,  s.exemptedbydr,  s.medicalexemption,  s.exemptionenddate,  s.dentalexemption,
                  s.dentalexempenddate,  s.ccsindicator,  s.icfindicator,  s.medicarecarriercode, s.medicareindicator,  s.isnonmeds,  s.switchtomeds,
                  s.switchtomedsdate,  s.medicalpktrequested,  s.mpacketstatus,  s.dentalpktrequested,  s.dpacketstatus,  s.donotbulkemail, s.donotbulkpostalmail,
                  s.donotemail,  s.donotfax,  s.donotphone,  s.authorizedrepname,  s.carriertype,  s.carrier2type,  s.carrier3type, s.cci_status,  s.cci_maximusoptout,
                  s.cci_paceeligible,  s.cci_mltssstatus,  s.cci_espdstatus,  s.cci_ignorelisind,  s.cci_ohcfmandatory,  s.defaultpathextension,  s.defaultpathextensionexemptionid,
                  s.eaflag,  s.enrlexclind,  s.esrdind,  s.expresslanepin,  s.expresslaneaffirmation,  s.expresslaneparent,  s.expresslanestatusmedical,  s.expresslanestatusdental,
                  s.hcpstatusprevious,  s.hcbshighind,  s.hicn,  s.institutionalind,  s.lisind,  s.mceligstat,  s.medicarecarrier2code,  s.medicarecarrier3code,  s.medicarestatusparta,
                  s.medicarestatuspartb,  s.medicarestatuspartd,  s.optoutind,  s.passiveenrollment,  s.sinsiind,  s.socamt,  s.subplanind,  s.recordcreatedate,  s.recordcreatename,
                  case when s.datelastmodified > s.be_modifiedon then s.datelastmodified else s.be_modifiedon end as modifiedon,
                  s.namelastmodified,  s.enrollmentstatus,  s.sendidltrdate,  s.importdate,  s.countychangercvddate,  s.triggerforvolunmails,
                  s.planoflasttrans,  s.lasttransdate,  s.lasttransrcvdid,  s.lasttransenrordisenr,  s.lasttransaccepted,  s.lastmedenrlrecid,  s.lastdisenrlrecid,
                  s.lastdisenroldate,  s.lastdisenrlaccepted,  s.lastplanid,  s.lastenrlopenplanid,  s.lastplanactivateddate,  s.lastmcalffstrans,
                  s.dtllasttransid,  s.dtllastopentrans,  s.dtlenrlstatus,  s.lastdentalenrleffdate,  s.dentalplanactive,  s.lastdtltranseord,  s.planoflastdtltrans,
                  s.lastdtlffstrans,  s.gmccombinedchoice,  s.extendeddefaultpathtriggerdate,  s.aidcodemandatoryexpirationdate,  s.cmceligibilitydefaultpathresetdate,
                  s.mltsseligibilitydefaultpathresetdate,  s.denbbmaildate,  s.medbbmaildate,  s.medrlmaildate,  s.denrlmaildate, s.ialettersentdate,  s.idlettersentdate,
                  s.dialettersentdate,  s.didlettersenddate,  s.didlettersentdate,  s.mcalmvltrsentdate,  s.dtlmvltrsentdate,  s.firstspecialdlmaildate,
                  s.secspecialdlmaildate,  s.thirdspecialdlmaildate,  s.ondisenrlpath,  s.medicalbbasent,  s.dentalbbasent, s.dexemplettersenddate,  s.mexemptlettersenddate,
                  s.campaigncompleted,  s.mincompletesentdate,  s.incompletechoiceformcounter, s.spdstatus, s.sex, 
                  s.medicaleligibilityreasonid, s.dentaleligibilityreasonid, s.spdeligibilityreasonid, s.medicarecontractnum, s.medicareplanid, s.medicareplanstartdate

                 FROM EMRS_D_CLIENT D, EMRS_S_CLIENT_STG S
                WHERE D.CLIENT_NUMBER = S.CLIENT_NUMBER
                  AND (
                        NVL(d.case_number,-1) != NVL(s.case_number,-1) OR
                        NVL(d.cin,'*') != NVL(s.cin,'*') OR
                        NVL(d.addressokflag,'*') != NVL(s.addressokflag,'*') OR
                        NVL(d.aidcode,'*') != NVL(s.aidcode,'*') OR
                        NVL(d.aliencode,'*') != NVL(s.aliencode,'*') OR
                        NVL(d.assigninthiscounty,'*') != NVL(s.assigninthiscounty,'*') OR
                        NVL(d.dob,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.dob,  to_date('07/07/7777','mm/dd/yyyy')) OR
                        NVL(d.hcoclosedate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.hcoclosedate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                        NVL(d.othhealthcoveragecode,'*') != NVL(s.othhealthcoveragecode,'*') OR
                        NVL(d.oldmedicalstatus,'*') != NVL(s.oldmedicalstatus,'*') OR
                        NVL(d.olddentalstaus,'*') != NVL(s.olddentalstaus,'*') OR
                        NVL(d.firstname,'*') != NVL(s.firstname,'*') OR
                        NVL(d.middleinitial,'*') != NVL(s.middleinitial,'*') OR
                        NVL(d.lastname,'*') != NVL(s.lastname,'*') OR
                        NVL(d.sex,'*') != NVL(s.sex,'*') OR
                        NVL(d.eligibilityworkernum,'*') != NVL(s.eligibilityworkernum,'*') OR
                        NVL(d.ethniccode,'*') != NVL(s.ethniccode,'*') OR
                        NVL(d.participantlang,'*') != NVL(s.participantlang,'*') OR
                        NVL(d.writtenlangcode,'*') != NVL(s.writtenlangcode,'*') OR
                        NVL(d.mcalplnmedsstatus,'*') != NVL(s.mcalplnmedsstatus,'*') OR
                        NVL(d.dtlmedshcpstatus,'*') != NVL(s.dtlmedshcpstatus,'*') OR
                        NVL(d.medicalid,'*') != NVL(s.medicalid,'*') OR
                        NVL(d.mandatorvolunstatus,'*') != NVL(s.mandatorvolunstatus,'*') OR
                        NVL(d.mandatorycounty,'*') != NVL(s.mandatorycounty,'*') OR
                        NVL(d.denvolstatus,'*') != NVL(s.denvolstatus,'*') OR
                        NVL(d.maximusstatus,'*') != NVL(s.maximusstatus,'*') OR
                        NVL(d.isdualeligible,'*') != NVL(s.isdualeligible,'*') OR
                        NVL(d.isgrandfatherdlelig,'*') != NVL(s.isgrandfatherdlelig,'*') OR
                        NVL(d.grandfatherdleligplan,'*') != NVL(s.grandfatherdleligplan,'*') OR
                        NVL(d.alowedplanfordlelig,'*') != NVL(s.alowedplanfordlelig,'*') OR
                        NVL(d.medsfilecreationdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.medsfilecreationdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                        NVL(d.transmitdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.transmitdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                        NVL(d.pregnancyduedate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.pregnancyduedate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                        NVL(d.exemptedbydr,'*') != NVL(s.exemptedbydr,'*') OR
                        NVL(d.medicalexemption,'*') != NVL(s.medicalexemption,'*') OR
                        NVL(d.exemptionenddate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.exemptionenddate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                        NVL(d.dentalexemption,'*') != NVL(s.dentalexemption,'*') OR
                        NVL(d.dentalexempenddate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.dentalexempenddate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                        NVL(d.ccsindicator,'*') != NVL(s.ccsindicator,'*') OR
                        NVL(d.icfindicator,'*') != NVL(s.icfindicator,'*') OR
                        NVL(d.medicarecarriercode,'*') != NVL(s.medicarecarriercode,'*') OR
                        NVL(d.medicareindicator,'*') != NVL(s.medicareindicator,'*') OR
                        NVL(d.isnonmeds,'*') != NVL(s.isnonmeds,'*') OR
                        NVL(d.switchtomeds,'*') != NVL(s.switchtomeds,'*') OR
                        NVL(d.switchtomedsdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.switchtomedsdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                        NVL(d.medicalpktrequested,'*') != NVL(s.medicalpktrequested,'*') OR
                        NVL(d.mpacketstatus,'*') != NVL(s.mpacketstatus,'*') OR
                        NVL(d.dentalpktrequested,'*') != NVL(s.dentalpktrequested,'*') OR
                        NVL(d.dpacketstatus,'*') != NVL(s.dpacketstatus,'*') OR
                        NVL(d.donotbulkemail,'*') != NVL(s.donotbulkemail,'*') OR
                        NVL(d.donotbulkpostalmail,'*') != NVL(s.donotbulkpostalmail,'*') OR
                        NVL(d.donotemail,'*') != NVL(s.donotemail,'*') OR
                        NVL(d.donotfax,'*') != NVL(s.donotfax,'*') OR
                        NVL(d.donotphone,'*') != NVL(s.donotphone,'*') OR
                        NVL(d.authorizedrepname,'*') != NVL(s.authorizedrepname,'*') OR
                        NVL(d.carriertype,'*') != NVL(s.carriertype,'*') OR
                        NVL(d.carrier2type,'*') != NVL(s.carrier2type,'*') OR
                        NVL(d.carrier3type,'*') != NVL(s.carrier3type,'*') OR
                        NVL(d.cci_status,'*') != NVL(s.cci_status,'*') OR
                        NVL(d.cci_maximusoptout,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.cci_maximusoptout,  to_date('07/07/7777','mm/dd/yyyy')) OR
                        NVL(d.cci_paceeligible,'*') != NVL(s.cci_paceeligible,'*') OR
                        NVL(d.cci_mltssstatus,'*') != NVL(s.cci_mltssstatus,'*') OR
                        NVL(d.cci_espdstatus,'*') != NVL(s.cci_espdstatus,'*') OR
                        NVL(d.cci_ignorelisind,'*') != NVL(s.cci_ignorelisind,'*') OR
                        NVL(d.cci_ohcfmandatory,'*') != NVL(s.cci_ohcfmandatory,'*') OR
                        NVL(d.defaultpathextension,'*') != NVL(s.defaultpathextension,'*') OR
                        NVL(d.defaultpathextensionexemptionid,-1) != NVL(s.defaultpathextensionexemptionid,-1) OR
                        NVL(d.eaflag,'*') != NVL(s.eaflag,'*') OR
                        NVL(d.enrlexclind,'*') != NVL(s.enrlexclind,'*') OR
                        NVL(d.esrdind,'*') != NVL(s.esrdind,'*') OR
                        NVL(d.expresslanepin,'*') != NVL(s.expresslanepin,'*') OR
                        NVL(d.expresslaneaffirmation,'*') != NVL(s.expresslaneaffirmation,'*') OR
                        NVL(d.expresslaneparent,'*') != NVL(s.expresslaneparent,'*') OR
                        NVL(d.expresslanestatusmedical,'*') != NVL(s.expresslanestatusmedical,'*') OR
                        NVL(d.expresslanestatusdental,'*') != NVL(s.expresslanestatusdental,'*') OR
                        NVL(d.hcpstatusprevious,'*') != NVL(s.hcpstatusprevious,'*') OR
                        NVL(d.hcbshighind,'*') != NVL(s.hcbshighind,'*') OR
                        NVL(d.hicn,'*') != NVL(s.hicn,'*') OR
                        NVL(d.institutionalind,'*') != NVL(s.institutionalind,'*') OR
                        NVL(d.lisind,'*') != NVL(s.lisind,'*') OR
                        NVL(d.mceligstat,'*') != NVL(s.mceligstat,'*') OR
                        NVL(d.medicarecarrier2code,'*') != NVL(s.medicarecarrier2code,'*') OR
                        NVL(d.medicarecarrier3code,'*') != NVL(s.medicarecarrier3code,'*') OR
                        NVL(d.medicarestatusparta,'*') != NVL(s.medicarestatusparta,'*') OR
                        NVL(d.medicarestatuspartb,'*') != NVL(s.medicarestatuspartb,'*') OR
                        NVL(d.medicarestatuspartd,'*') != NVL(s.medicarestatuspartd,'*') OR
                        NVL(d.optoutind,'*') != NVL(s.optoutind,'*') OR
                        NVL(d.passiveenrollment,'*') != NVL(s.passiveenrollment,'*') OR
                        NVL(d.sinsiind,'*') != NVL(s.sinsiind,'*') OR
                        NVL(d.socamt,'*') != NVL(s.socamt,'*') OR
                        NVL(d.subplanind,'*') != NVL(s.subplanind,'*') OR
                        NVL(d.enrollmentstatus,'*') != NVL(s.enrollmentstatus,'*') OR
                        NVL(d.sendidltrdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.sendidltrdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                        NVL(d.importdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.importdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                        NVL(d.countychangercvddate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.countychangercvddate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                        NVL(d.triggerforvolunmails,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.triggerforvolunmails,  to_date('07/07/7777','mm/dd/yyyy')) OR
                        NVL(d.planoflasttrans,'*') != NVL(s.planoflasttrans,'*') OR
                        NVL(d.lasttransdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.lasttransdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                        NVL(d.lasttransrcvdid,-1) != NVL(s.lasttransrcvdid,-1) OR
                        NVL(d.lasttransenrordisenr,'*') != NVL(s.lasttransenrordisenr,'*') OR
                        NVL(d.lasttransaccepted,'*') != NVL(s.lasttransaccepted,'*') OR
                        NVL(d.lastmedenrlrecid,-1) != NVL(s.lastmedenrlrecid,-1) OR
                        NVL(d.lastdisenrlrecid,-1) != NVL(s.lastdisenrlrecid,-1) OR
                        NVL(d.lastdisenroldate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.lastdisenroldate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                        NVL(d.lastdisenrlaccepted,'*') != NVL(s.lastdisenrlaccepted,'*') OR
                        NVL(d.lastplanid,'*') != NVL(s.lastplanid,'*') OR
                        NVL(d.lastenrlopenplanid,-1) != NVL(s.lastenrlopenplanid,-1) OR
                        NVL(d.lastplanactivateddate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.lastplanactivateddate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                        NVL(d.lastmcalffstrans,-1) != NVL(s.lastmcalffstrans,-1) OR
                        NVL(d.dtllasttransid,-1) != NVL(s.dtllasttransid,-1) OR
                        NVL(d.dtllastopentrans,-1) != NVL(s.dtllastopentrans,-1) OR
                        NVL(d.dtlenrlstatus,'*') != NVL(s.dtlenrlstatus,'*') OR
                        NVL(d.lastdentalenrleffdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.lastdentalenrleffdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                        NVL(d.dentalplanactive,'*') != NVL(s.dentalplanactive,'*') OR
                        NVL(d.lastdtltranseord,'*') != NVL(s.lastdtltranseord,'*') OR
                        NVL(d.planoflastdtltrans,'*') != NVL(s.planoflastdtltrans,'*') OR
                        NVL(d.lastdtlffstrans,-1) != NVL(s.lastdtlffstrans,-1) OR
                        NVL(d.gmccombinedchoice,'*') != NVL(s.gmccombinedchoice,'*') OR
                        NVL(d.extendeddefaultpathtriggerdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.extendeddefaultpathtriggerdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                        NVL(d.aidcodemandatoryexpirationdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.aidcodemandatoryexpirationdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                        NVL(d.cmceligibilitydefaultpathresetdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.cmceligibilitydefaultpathresetdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                        NVL(d.mltsseligibilitydefaultpathresetdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.mltsseligibilitydefaultpathresetdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                        NVL(d.denbbmaildate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.denbbmaildate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                        NVL(d.medbbmaildate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.medbbmaildate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                        NVL(d.medrlmaildate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.medrlmaildate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                        NVL(d.denrlmaildate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.denrlmaildate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                        NVL(d.ialettersentdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.ialettersentdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                        NVL(d.idlettersentdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.idlettersentdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                        NVL(d.dialettersentdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.dialettersentdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                        NVL(d.didlettersenddate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.didlettersenddate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                        NVL(d.didlettersentdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.didlettersentdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                        NVL(d.mcalmvltrsentdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.mcalmvltrsentdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                        NVL(d.dtlmvltrsentdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.dtlmvltrsentdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                        NVL(d.firstspecialdlmaildate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.firstspecialdlmaildate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                        NVL(d.secspecialdlmaildate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.secspecialdlmaildate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                        NVL(d.thirdspecialdlmaildate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.thirdspecialdlmaildate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                        NVL(d.ondisenrlpath,'*') != NVL(s.ondisenrlpath,'*') OR
                        NVL(d.medicalbbasent,'*') != NVL(s.medicalbbasent,'*') OR
                        NVL(d.dentalbbasent,'*') != NVL(s.dentalbbasent,'*') OR
                        NVL(d.dexemplettersenddate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.dexemplettersenddate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                        NVL(d.mexemptlettersenddate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.mexemptlettersenddate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                        NVL(d.campaigncompleted,'*') != NVL(s.campaigncompleted,'*') OR
                        NVL(d.mincompletesentdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.mincompletesentdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                        NVL(d.incompletechoiceformcounter,'*') != NVL(s.incompletechoiceformcounter,'*') OR
                        NVL(d.spdstatus,'*') != NVL(s.spdstatus,'*') OR
                        NVL(d.medicaleligibilityreasonid,-1) != NVL(s.medicaleligibilityreasonid,-1) OR
                        NVL(d.dentaleligibilityreasonid,-1) != NVL(s.dentaleligibilityreasonid,-1) OR
                        NVL(d.spdeligibilityreasonid,-1) != NVL(s.spdeligibilityreasonid,-1) OR
                        NVL(d.medicarecontractnum,'*') != NVL(s.medicarecontractnum,'*') OR
                        NVL(d.medicareplanid,-1) != NVL(s.medicareplanid,-1) OR
                        NVL(d.medicareplanstartdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.medicareplanstartdate,  to_date('07/07/7777','mm/dd/yyyy'))
                        )
                  ) C ON (D.CLIENT_NUMBER = C.CLIENT_NUMBER)
        WHEN MATCHED THEN UPDATE
         SET  d.case_number = c.case_number ,
              d.cin = c.cin ,
              d.addressokflag = c.addressokflag ,
              d.aidcode = c.aidcode ,
              d.aliencode = c.aliencode ,
              d.assigninthiscounty = c.assigninthiscounty ,
              d.dob = c.dob ,
              d.hcoclosedate = c.hcoclosedate ,
              d.othhealthcoveragecode = c.othhealthcoveragecode ,
              d.oldmedicalstatus = c.oldmedicalstatus ,
              d.olddentalstaus = c.olddentalstaus ,
              d.firstname = c.firstname ,
              d.middleinitial = c.middleinitial ,
              d.lastname = c.lastname ,
              d.eligibilityworkernum = c.eligibilityworkernum ,
              d.ethniccode = c.ethniccode ,
              d.participantlang = c.participantlang ,
              d.writtenlangcode = c.writtenlangcode ,
              d.mcalplnmedsstatus = c.mcalplnmedsstatus ,
              d.dtlmedshcpstatus = c.dtlmedshcpstatus ,
              d.medicalid = c.medicalid ,
              d.mandatorvolunstatus = c.mandatorvolunstatus ,
              d.mandatorycounty = c.mandatorycounty ,
              d.denvolstatus = c.denvolstatus ,
              d.maximusstatus = c.maximusstatus ,
              d.isdualeligible = c.isdualeligible ,
              d.isgrandfatherdlelig = c.isgrandfatherdlelig ,
              d.grandfatherdleligplan = c.grandfatherdleligplan ,
              d.alowedplanfordlelig = c.alowedplanfordlelig ,
              d.medsfilecreationdate = c.medsfilecreationdate ,
              d.transmitdate = c.transmitdate ,
              d.pregnancyduedate = c.pregnancyduedate ,
              d.exemptedbydr = c.exemptedbydr ,
              d.medicalexemption = c.medicalexemption ,
              d.exemptionenddate = c.exemptionenddate ,
              d.dentalexemption = c.dentalexemption ,
              d.dentalexempenddate = c.dentalexempenddate ,
              d.ccsindicator = c.ccsindicator ,
              d.icfindicator = c.icfindicator ,
              d.medicarecarriercode = c.medicarecarriercode ,
              d.medicareindicator = c.medicareindicator ,
              d.isnonmeds = c.isnonmeds ,
              d.switchtomeds = c.switchtomeds ,
              d.switchtomedsdate = c.switchtomedsdate ,
              d.medicalpktrequested = c.medicalpktrequested ,
              d.mpacketstatus = c.mpacketstatus ,
              d.dentalpktrequested = c.dentalpktrequested ,
              d.dpacketstatus = c.dpacketstatus ,
              d.donotbulkemail = c.donotbulkemail ,
              d.donotbulkpostalmail = c.donotbulkpostalmail ,
              d.donotemail = c.donotemail ,
              d.donotfax = c.donotfax ,
              d.donotphone = c.donotphone ,
              d.authorizedrepname = c.authorizedrepname ,
              d.carriertype = c.carriertype ,
              d.carrier2type = c.carrier2type ,
              d.carrier3type = c.carrier3type ,
              d.cci_status = c.cci_status ,
              d.cci_maximusoptout = c.cci_maximusoptout ,
              d.cci_paceeligible = c.cci_paceeligible ,
              d.cci_mltssstatus = c.cci_mltssstatus ,
              d.cci_espdstatus = c.cci_espdstatus ,
              d.cci_ignorelisind = c.cci_ignorelisind ,
              d.cci_ohcfmandatory = c.cci_ohcfmandatory ,
              d.defaultpathextension = c.defaultpathextension ,
              d.defaultpathextensionexemptionid = c.defaultpathextensionexemptionid ,
              d.eaflag = c.eaflag ,
              d.enrlexclind = c.enrlexclind ,
              d.esrdind = c.esrdind ,
              d.expresslanepin = c.expresslanepin ,
              d.expresslaneaffirmation = c.expresslaneaffirmation ,
              d.expresslaneparent = c.expresslaneparent ,
              d.expresslanestatusmedical = c.expresslanestatusmedical ,
              d.expresslanestatusdental = c.expresslanestatusdental ,
              d.hcpstatusprevious = c.hcpstatusprevious ,
              d.hcbshighind = c.hcbshighind ,
              d.hicn = c.hicn ,
              d.institutionalind = c.institutionalind ,
              d.lisind = c.lisind ,
              d.mceligstat = c.mceligstat ,
              d.medicarecarrier2code = c.medicarecarrier2code ,
              d.medicarecarrier3code = c.medicarecarrier3code ,
              d.medicarestatusparta = c.medicarestatusparta ,
              d.medicarestatuspartb = c.medicarestatuspartb ,
              d.medicarestatuspartd = c.medicarestatuspartd ,
              d.optoutind = c.optoutind ,
              d.passiveenrollment = c.passiveenrollment ,
              d.sinsiind = c.sinsiind ,
              d.socamt = c.socamt ,
              d.subplanind = c.subplanind ,
              d.recordcreatedate = c.recordcreatedate ,
              d.recordcreatename = c.recordcreatename ,
              d.datelastmodified = c.modifiedon ,
              d.namelastmodified = c.namelastmodified ,
              d.enrollmentstatus = c.enrollmentstatus ,
              d.sendidltrdate = c.sendidltrdate ,
              d.importdate = c.importdate ,
              d.countychangercvddate = c.countychangercvddate ,
              d.triggerforvolunmails = c.triggerforvolunmails ,
              d.planoflasttrans = c.planoflasttrans ,
              d.lasttransdate = c.lasttransdate ,
              d.lasttransrcvdid = c.lasttransrcvdid ,
              d.lasttransenrordisenr = c.lasttransenrordisenr ,
              d.lasttransaccepted = c.lasttransaccepted ,
              d.lastmedenrlrecid = c.lastmedenrlrecid ,
              d.lastdisenrlrecid = c.lastdisenrlrecid ,
              d.lastdisenroldate = c.lastdisenroldate ,
              d.lastdisenrlaccepted = c.lastdisenrlaccepted ,
              d.lastplanid = c.lastplanid ,
              d.lastenrlopenplanid = c.lastenrlopenplanid ,
              d.lastplanactivateddate = c.lastplanactivateddate ,
              d.lastmcalffstrans = c.lastmcalffstrans ,
              d.dtllasttransid = c.dtllasttransid ,
              d.dtllastopentrans = c.dtllastopentrans ,
              d.dtlenrlstatus = c.dtlenrlstatus ,
              d.lastdentalenrleffdate = c.lastdentalenrleffdate ,
              d.dentalplanactive = c.dentalplanactive ,
              d.lastdtltranseord = c.lastdtltranseord ,
              d.planoflastdtltrans = c.planoflastdtltrans ,
              d.lastdtlffstrans = c.lastdtlffstrans ,
              d.gmccombinedchoice = c.gmccombinedchoice ,
              d.extendeddefaultpathtriggerdate = c.extendeddefaultpathtriggerdate ,
              d.aidcodemandatoryexpirationdate = c.aidcodemandatoryexpirationdate ,
              d.cmceligibilitydefaultpathresetdate = c.cmceligibilitydefaultpathresetdate ,
              d.mltsseligibilitydefaultpathresetdate = c.mltsseligibilitydefaultpathresetdate ,
              d.denbbmaildate = c.denbbmaildate ,
              d.medbbmaildate = c.medbbmaildate ,
              d.medrlmaildate = c.medrlmaildate ,
              d.denrlmaildate = c.denrlmaildate ,
              d.ialettersentdate = c.ialettersentdate ,
              d.idlettersentdate = c.idlettersentdate ,
              d.dialettersentdate = c.dialettersentdate ,
              d.didlettersenddate = c.didlettersenddate ,
              d.didlettersentdate = c.didlettersentdate ,
              d.mcalmvltrsentdate = c.mcalmvltrsentdate ,
              d.dtlmvltrsentdate = c.dtlmvltrsentdate ,
              d.firstspecialdlmaildate = c.firstspecialdlmaildate ,
              d.secspecialdlmaildate = c.secspecialdlmaildate ,
              d.thirdspecialdlmaildate = c.thirdspecialdlmaildate ,
              d.ondisenrlpath = c.ondisenrlpath ,
              d.medicalbbasent = c.medicalbbasent ,
              d.dentalbbasent = c.dentalbbasent ,
              d.dexemplettersenddate = c.dexemplettersenddate ,
              d.mexemptlettersenddate = c.mexemptlettersenddate ,
              d.campaigncompleted = c.campaigncompleted ,
              d.mincompletesentdate = c.mincompletesentdate ,
              d.incompletechoiceformcounter = c.incompletechoiceformcounter ,
              d.spdstatus = c.spdstatus,
              d.sex = c.sex,
              d.medicaleligibilityreasonid = c.medicaleligibilityreasonid,
              d.dentaleligibilityreasonid = c.dentaleligibilityreasonid,
              d.spdeligibilityreasonid = c.spdeligibilityreasonid,
              d.medicarecontractnum = c.medicarecontractnum,
              d.medicareplanid = c.medicareplanid,
              d.medicareplanstartdate = c.medicareplanstartdate              
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
          SELECT c_critical, con_pkg, 'CAHCO_ETL_PKG.CLIENT_UPD', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_CLIENT', Client_Number
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
                        s.client_number, s.case_number, s.cin, s.addressokflag, s.aidcode, s.aliencode, s.assigninthiscounty, s.dob, s.hcoclosedate,
                        s.othhealthcoveragecode,  s.oldmedicalstatus,  s.olddentalstaus,  s.firstname,  s.middleinitial,  s.lastname,  s.eligibilityworkernum,
                        s.ethniccode,  s.participantlang,  s.writtenlangcode,  s.mcalplnmedsstatus,  s.dtlmedshcpstatus,  s.medicalid,  s.mandatorvolunstatus,
                        s.mandatorycounty,  s.denvolstatus,  s.maximusstatus,  s.isdualeligible,  s.isgrandfatherdlelig,  s.grandfatherdleligplan, s.alowedplanfordlelig,
                        s.medsfilecreationdate,  s.transmitdate,  s.pregnancyduedate,  s.exemptedbydr,  s.medicalexemption,  s.exemptionenddate,  s.dentalexemption,
                        s.dentalexempenddate,  s.ccsindicator,  s.icfindicator,  s.medicarecarriercode, s.medicareindicator,  s.isnonmeds,  s.switchtomeds,
                        s.switchtomedsdate,  s.medicalpktrequested,  s.mpacketstatus,  s.dentalpktrequested,  s.dpacketstatus,  s.donotbulkemail, s.donotbulkpostalmail,
                        s.donotemail,  s.donotfax,  s.donotphone,  s.authorizedrepname,  s.carriertype,  s.carrier2type,  s.carrier3type, s.cci_status,  s.cci_maximusoptout,
                        s.cci_paceeligible,  s.cci_mltssstatus,  s.cci_espdstatus,  s.cci_ignorelisind,  s.cci_ohcfmandatory,  s.defaultpathextension,  s.defaultpathextensionexemptionid,
                        s.eaflag,  s.enrlexclind,  s.esrdind,  s.expresslanepin,  s.expresslaneaffirmation,  s.expresslaneparent,  s.expresslanestatusmedical,  s.expresslanestatusdental,
                        s.hcpstatusprevious,  s.hcbshighind,  s.hicn,  s.institutionalind,  s.lisind,  s.mceligstat,  s.medicarecarrier2code,  s.medicarecarrier3code,  s.medicarestatusparta,
                        s.medicarestatuspartb,  s.medicarestatuspartd,  s.optoutind,  s.passiveenrollment,  s.sinsiind,  s.socamt,  s.subplanind,  s.recordcreatedate,  s.recordcreatename,
                        case when s.datelastmodified > s.be_modifiedon then s.datelastmodified else s.be_modifiedon end as modifiedon,
                        s.namelastmodified,  s.enrollmentstatus,  s.sendidltrdate,  s.importdate,  s.countychangercvddate,  s.triggerforvolunmails,
                        s.planoflasttrans,  s.lasttransdate,  s.lasttransrcvdid,  s.lasttransenrordisenr,  s.lasttransaccepted,  s.lastmedenrlrecid,  s.lastdisenrlrecid,
                        s.lastdisenroldate,  s.lastdisenrlaccepted,  s.lastplanid,  s.lastenrlopenplanid,  s.lastplanactivateddate,  s.lastmcalffstrans,
                        s.dtllasttransid,  s.dtllastopentrans,  s.dtlenrlstatus,  s.lastdentalenrleffdate,  s.dentalplanactive,  s.lastdtltranseord,  s.planoflastdtltrans,
                        s.lastdtlffstrans,  s.gmccombinedchoice,  s.extendeddefaultpathtriggerdate,  s.aidcodemandatoryexpirationdate,  s.cmceligibilitydefaultpathresetdate,
                        s.mltsseligibilitydefaultpathresetdate,  s.denbbmaildate,  s.medbbmaildate,  s.medrlmaildate,  s.denrlmaildate, s.ialettersentdate,  s.idlettersentdate,
                        s.dialettersentdate,  s.didlettersenddate,  s.didlettersentdate,  s.mcalmvltrsentdate,  s.dtlmvltrsentdate,  s.firstspecialdlmaildate,
                        s.secspecialdlmaildate,  s.thirdspecialdlmaildate,  s.ondisenrlpath,  s.medicalbbasent,  s.dentalbbasent, s.dexemplettersenddate,  s.mexemptlettersenddate,
                        s.campaigncompleted,  s.mincompletesentdate,  s.incompletechoiceformcounter, s.spdstatus, s.sex,
                        s.medicaleligibilityreasonid, s.dentaleligibilityreasonid, s.spdeligibilityreasonid, s.medicarecontractnum, s.medicareplanid, s.medicareplanstartdate

                       FROM EMRS_D_CLIENT D, EMRS_S_CLIENT_STG S
                      WHERE D.CLIENT_NUMBER = S.CLIENT_NUMBER AND S.PARTITIONIDX = IDX
                        AND (
                              NVL(d.case_number,-1) != NVL(s.case_number,-1) OR
                              NVL(d.cin,'*') != NVL(s.cin,'*') OR
                              NVL(d.addressokflag,'*') != NVL(s.addressokflag,'*') OR
                              NVL(d.aidcode,'*') != NVL(s.aidcode,'*') OR
                              NVL(d.aliencode,'*') != NVL(s.aliencode,'*') OR
                              NVL(d.assigninthiscounty,'*') != NVL(s.assigninthiscounty,'*') OR
                              NVL(d.dob,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.dob,  to_date('07/07/7777','mm/dd/yyyy')) OR
                              NVL(d.hcoclosedate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.hcoclosedate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                              NVL(d.othhealthcoveragecode,'*') != NVL(s.othhealthcoveragecode,'*') OR
                              NVL(d.oldmedicalstatus,'*') != NVL(s.oldmedicalstatus,'*') OR
                              NVL(d.olddentalstaus,'*') != NVL(s.olddentalstaus,'*') OR
                              NVL(d.firstname,'*') != NVL(s.firstname,'*') OR
                              NVL(d.middleinitial,'*') != NVL(s.middleinitial,'*') OR
                              NVL(d.lastname,'*') != NVL(s.lastname,'*') OR
                              NVL(d.sex,'*') != NVL(s.sex,'*') OR
                              NVL(d.eligibilityworkernum,'*') != NVL(s.eligibilityworkernum,'*') OR
                              NVL(d.ethniccode,'*') != NVL(s.ethniccode,'*') OR
                              NVL(d.participantlang,'*') != NVL(s.participantlang,'*') OR
                              NVL(d.writtenlangcode,'*') != NVL(s.writtenlangcode,'*') OR
                              NVL(d.mcalplnmedsstatus,'*') != NVL(s.mcalplnmedsstatus,'*') OR
                              NVL(d.dtlmedshcpstatus,'*') != NVL(s.dtlmedshcpstatus,'*') OR
                              NVL(d.medicalid,'*') != NVL(s.medicalid,'*') OR
                              NVL(d.mandatorvolunstatus,'*') != NVL(s.mandatorvolunstatus,'*') OR
                              NVL(d.mandatorycounty,'*') != NVL(s.mandatorycounty,'*') OR
                              NVL(d.denvolstatus,'*') != NVL(s.denvolstatus,'*') OR
                              NVL(d.maximusstatus,'*') != NVL(s.maximusstatus,'*') OR
                              NVL(d.isdualeligible,'*') != NVL(s.isdualeligible,'*') OR
                              NVL(d.isgrandfatherdlelig,'*') != NVL(s.isgrandfatherdlelig,'*') OR
                              NVL(d.grandfatherdleligplan,'*') != NVL(s.grandfatherdleligplan,'*') OR
                              NVL(d.alowedplanfordlelig,'*') != NVL(s.alowedplanfordlelig,'*') OR
                              NVL(d.medsfilecreationdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.medsfilecreationdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                              NVL(d.transmitdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.transmitdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                              NVL(d.pregnancyduedate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.pregnancyduedate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                              NVL(d.exemptedbydr,'*') != NVL(s.exemptedbydr,'*') OR
                              NVL(d.medicalexemption,'*') != NVL(s.medicalexemption,'*') OR
                              NVL(d.exemptionenddate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.exemptionenddate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                              NVL(d.dentalexemption,'*') != NVL(s.dentalexemption,'*') OR
                              NVL(d.dentalexempenddate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.dentalexempenddate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                              NVL(d.ccsindicator,'*') != NVL(s.ccsindicator,'*') OR
                              NVL(d.icfindicator,'*') != NVL(s.icfindicator,'*') OR
                              NVL(d.medicarecarriercode,'*') != NVL(s.medicarecarriercode,'*') OR
                              NVL(d.medicareindicator,'*') != NVL(s.medicareindicator,'*') OR
                              NVL(d.isnonmeds,'*') != NVL(s.isnonmeds,'*') OR
                              NVL(d.switchtomeds,'*') != NVL(s.switchtomeds,'*') OR
                              NVL(d.switchtomedsdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.switchtomedsdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                              NVL(d.medicalpktrequested,'*') != NVL(s.medicalpktrequested,'*') OR
                              NVL(d.mpacketstatus,'*') != NVL(s.mpacketstatus,'*') OR
                              NVL(d.dentalpktrequested,'*') != NVL(s.dentalpktrequested,'*') OR
                              NVL(d.dpacketstatus,'*') != NVL(s.dpacketstatus,'*') OR
                              NVL(d.donotbulkemail,'*') != NVL(s.donotbulkemail,'*') OR
                              NVL(d.donotbulkpostalmail,'*') != NVL(s.donotbulkpostalmail,'*') OR
                              NVL(d.donotemail,'*') != NVL(s.donotemail,'*') OR
                              NVL(d.donotfax,'*') != NVL(s.donotfax,'*') OR
                              NVL(d.donotphone,'*') != NVL(s.donotphone,'*') OR
                              NVL(d.authorizedrepname,'*') != NVL(s.authorizedrepname,'*') OR
                              NVL(d.carriertype,'*') != NVL(s.carriertype,'*') OR
                              NVL(d.carrier2type,'*') != NVL(s.carrier2type,'*') OR
                              NVL(d.carrier3type,'*') != NVL(s.carrier3type,'*') OR
                              NVL(d.cci_status,'*') != NVL(s.cci_status,'*') OR
                              NVL(d.cci_maximusoptout,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.cci_maximusoptout,  to_date('07/07/7777','mm/dd/yyyy')) OR
                              NVL(d.cci_paceeligible,'*') != NVL(s.cci_paceeligible,'*') OR
                              NVL(d.cci_mltssstatus,'*') != NVL(s.cci_mltssstatus,'*') OR
                              NVL(d.cci_espdstatus,'*') != NVL(s.cci_espdstatus,'*') OR
                              NVL(d.cci_ignorelisind,'*') != NVL(s.cci_ignorelisind,'*') OR
                              NVL(d.cci_ohcfmandatory,'*') != NVL(s.cci_ohcfmandatory,'*') OR
                              NVL(d.defaultpathextension,'*') != NVL(s.defaultpathextension,'*') OR
                              NVL(d.defaultpathextensionexemptionid,-1) != NVL(s.defaultpathextensionexemptionid,-1) OR
                              NVL(d.eaflag,'*') != NVL(s.eaflag,'*') OR
                              NVL(d.enrlexclind,'*') != NVL(s.enrlexclind,'*') OR
                              NVL(d.esrdind,'*') != NVL(s.esrdind,'*') OR
                              NVL(d.expresslanepin,'*') != NVL(s.expresslanepin,'*') OR
                              NVL(d.expresslaneaffirmation,'*') != NVL(s.expresslaneaffirmation,'*') OR
                              NVL(d.expresslaneparent,'*') != NVL(s.expresslaneparent,'*') OR
                              NVL(d.expresslanestatusmedical,'*') != NVL(s.expresslanestatusmedical,'*') OR
                              NVL(d.expresslanestatusdental,'*') != NVL(s.expresslanestatusdental,'*') OR
                              NVL(d.hcpstatusprevious,'*') != NVL(s.hcpstatusprevious,'*') OR
                              NVL(d.hcbshighind,'*') != NVL(s.hcbshighind,'*') OR
                              NVL(d.hicn,'*') != NVL(s.hicn,'*') OR
                              NVL(d.institutionalind,'*') != NVL(s.institutionalind,'*') OR
                              NVL(d.lisind,'*') != NVL(s.lisind,'*') OR
                              NVL(d.mceligstat,'*') != NVL(s.mceligstat,'*') OR
                              NVL(d.medicarecarrier2code,'*') != NVL(s.medicarecarrier2code,'*') OR
                              NVL(d.medicarecarrier3code,'*') != NVL(s.medicarecarrier3code,'*') OR
                              NVL(d.medicarestatusparta,'*') != NVL(s.medicarestatusparta,'*') OR
                              NVL(d.medicarestatuspartb,'*') != NVL(s.medicarestatuspartb,'*') OR
                              NVL(d.medicarestatuspartd,'*') != NVL(s.medicarestatuspartd,'*') OR
                              NVL(d.optoutind,'*') != NVL(s.optoutind,'*') OR
                              NVL(d.passiveenrollment,'*') != NVL(s.passiveenrollment,'*') OR
                              NVL(d.sinsiind,'*') != NVL(s.sinsiind,'*') OR
                              NVL(d.socamt,'*') != NVL(s.socamt,'*') OR
                              NVL(d.subplanind,'*') != NVL(s.subplanind,'*') OR
                              NVL(d.enrollmentstatus,'*') != NVL(s.enrollmentstatus,'*') OR
                              NVL(d.sendidltrdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.sendidltrdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                              NVL(d.importdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.importdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                              NVL(d.countychangercvddate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.countychangercvddate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                              NVL(d.triggerforvolunmails,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.triggerforvolunmails,  to_date('07/07/7777','mm/dd/yyyy')) OR
                              NVL(d.planoflasttrans,'*') != NVL(s.planoflasttrans,'*') OR
                              NVL(d.lasttransdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.lasttransdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                              NVL(d.lasttransrcvdid,-1) != NVL(s.lasttransrcvdid,-1) OR
                              NVL(d.lasttransenrordisenr,'*') != NVL(s.lasttransenrordisenr,'*') OR
                              NVL(d.lasttransaccepted,'*') != NVL(s.lasttransaccepted,'*') OR
                              NVL(d.lastmedenrlrecid,-1) != NVL(s.lastmedenrlrecid,-1) OR
                              NVL(d.lastdisenrlrecid,-1) != NVL(s.lastdisenrlrecid,-1) OR
                              NVL(d.lastdisenroldate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.lastdisenroldate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                              NVL(d.lastdisenrlaccepted,'*') != NVL(s.lastdisenrlaccepted,'*') OR
                              NVL(d.lastplanid,'*') != NVL(s.lastplanid,'*') OR
                              NVL(d.lastenrlopenplanid,-1) != NVL(s.lastenrlopenplanid,-1) OR
                              NVL(d.lastplanactivateddate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.lastplanactivateddate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                              NVL(d.lastmcalffstrans,-1) != NVL(s.lastmcalffstrans,-1) OR
                              NVL(d.dtllasttransid,-1) != NVL(s.dtllasttransid,-1) OR
                              NVL(d.dtllastopentrans,-1) != NVL(s.dtllastopentrans,-1) OR
                              NVL(d.dtlenrlstatus,'*') != NVL(s.dtlenrlstatus,'*') OR
                              NVL(d.lastdentalenrleffdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.lastdentalenrleffdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                              NVL(d.dentalplanactive,'*') != NVL(s.dentalplanactive,'*') OR
                              NVL(d.lastdtltranseord,'*') != NVL(s.lastdtltranseord,'*') OR
                              NVL(d.planoflastdtltrans,'*') != NVL(s.planoflastdtltrans,'*') OR
                              NVL(d.lastdtlffstrans,-1) != NVL(s.lastdtlffstrans,-1) OR
                              NVL(d.gmccombinedchoice,'*') != NVL(s.gmccombinedchoice,'*') OR
                              NVL(d.extendeddefaultpathtriggerdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.extendeddefaultpathtriggerdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                              NVL(d.aidcodemandatoryexpirationdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.aidcodemandatoryexpirationdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                              NVL(d.cmceligibilitydefaultpathresetdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.cmceligibilitydefaultpathresetdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                              NVL(d.mltsseligibilitydefaultpathresetdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.mltsseligibilitydefaultpathresetdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                              NVL(d.denbbmaildate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.denbbmaildate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                              NVL(d.medbbmaildate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.medbbmaildate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                              NVL(d.medrlmaildate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.medrlmaildate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                              NVL(d.denrlmaildate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.denrlmaildate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                              NVL(d.ialettersentdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.ialettersentdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                              NVL(d.idlettersentdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.idlettersentdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                              NVL(d.dialettersentdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.dialettersentdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                              NVL(d.didlettersenddate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.didlettersenddate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                              NVL(d.didlettersentdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.didlettersentdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                              NVL(d.mcalmvltrsentdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.mcalmvltrsentdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                              NVL(d.dtlmvltrsentdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.dtlmvltrsentdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                              NVL(d.firstspecialdlmaildate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.firstspecialdlmaildate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                              NVL(d.secspecialdlmaildate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.secspecialdlmaildate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                              NVL(d.thirdspecialdlmaildate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.thirdspecialdlmaildate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                              NVL(d.ondisenrlpath,'*') != NVL(s.ondisenrlpath,'*') OR
                              NVL(d.medicalbbasent,'*') != NVL(s.medicalbbasent,'*') OR
                              NVL(d.dentalbbasent,'*') != NVL(s.dentalbbasent,'*') OR
                              NVL(d.dexemplettersenddate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.dexemplettersenddate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                              NVL(d.mexemptlettersenddate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.mexemptlettersenddate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                              NVL(d.campaigncompleted,'*') != NVL(s.campaigncompleted,'*') OR
                              NVL(d.mincompletesentdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.mincompletesentdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                              NVL(d.incompletechoiceformcounter,'*') != NVL(s.incompletechoiceformcounter,'*') OR
                              NVL(d.spdstatus,'*') != NVL(s.spdstatus,'*') OR
                              NVL(d.medicaleligibilityreasonid,-1) != NVL(s.medicaleligibilityreasonid,-1) OR
                              NVL(d.dentaleligibilityreasonid,-1) != NVL(s.dentaleligibilityreasonid,-1) OR
                              NVL(d.spdeligibilityreasonid,-1) != NVL(s.spdeligibilityreasonid,-1) OR
                              NVL(d.medicarecontractnum,'*') != NVL(s.medicarecontractnum,'*') OR
                              NVL(d.medicareplanid,-1) != NVL(s.medicareplanid,-1) OR
                              NVL(d.medicareplanstartdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.medicareplanstartdate,  to_date('07/07/7777','mm/dd/yyyy'))                              
                              )
                        ) C ON (D.CLIENT_NUMBER = C.CLIENT_NUMBER)
              WHEN MATCHED THEN UPDATE
               SET  d.case_number = c.case_number ,
                    d.cin = c.cin ,
                    d.addressokflag = c.addressokflag ,
                    d.aidcode = c.aidcode ,
                    d.aliencode = c.aliencode ,
                    d.assigninthiscounty = c.assigninthiscounty ,
                    d.dob = c.dob ,
                    d.hcoclosedate = c.hcoclosedate ,
                    d.othhealthcoveragecode = c.othhealthcoveragecode ,
                    d.oldmedicalstatus = c.oldmedicalstatus ,
                    d.olddentalstaus = c.olddentalstaus ,
                    d.firstname = c.firstname ,
                    d.middleinitial = c.middleinitial ,
                    d.lastname = c.lastname ,
                    d.eligibilityworkernum = c.eligibilityworkernum ,
                    d.ethniccode = c.ethniccode ,
                    d.participantlang = c.participantlang ,
                    d.writtenlangcode = c.writtenlangcode ,
                    d.mcalplnmedsstatus = c.mcalplnmedsstatus ,
                    d.dtlmedshcpstatus = c.dtlmedshcpstatus ,
                    d.medicalid = c.medicalid ,
                    d.mandatorvolunstatus = c.mandatorvolunstatus ,
                    d.mandatorycounty = c.mandatorycounty ,
                    d.denvolstatus = c.denvolstatus ,
                    d.maximusstatus = c.maximusstatus ,
                    d.isdualeligible = c.isdualeligible ,
                    d.isgrandfatherdlelig = c.isgrandfatherdlelig ,
                    d.grandfatherdleligplan = c.grandfatherdleligplan ,
                    d.alowedplanfordlelig = c.alowedplanfordlelig ,
                    d.medsfilecreationdate = c.medsfilecreationdate ,
                    d.transmitdate = c.transmitdate ,
                    d.pregnancyduedate = c.pregnancyduedate ,
                    d.exemptedbydr = c.exemptedbydr ,
                    d.medicalexemption = c.medicalexemption ,
                    d.exemptionenddate = c.exemptionenddate ,
                    d.dentalexemption = c.dentalexemption ,
                    d.dentalexempenddate = c.dentalexempenddate ,
                    d.ccsindicator = c.ccsindicator ,
                    d.icfindicator = c.icfindicator ,
                    d.medicarecarriercode = c.medicarecarriercode ,
                    d.medicareindicator = c.medicareindicator ,
                    d.isnonmeds = c.isnonmeds ,
                    d.switchtomeds = c.switchtomeds ,
                    d.switchtomedsdate = c.switchtomedsdate ,
                    d.medicalpktrequested = c.medicalpktrequested ,
                    d.mpacketstatus = c.mpacketstatus ,
                    d.dentalpktrequested = c.dentalpktrequested ,
                    d.dpacketstatus = c.dpacketstatus ,
                    d.donotbulkemail = c.donotbulkemail ,
                    d.donotbulkpostalmail = c.donotbulkpostalmail ,
                    d.donotemail = c.donotemail ,
                    d.donotfax = c.donotfax ,
                    d.donotphone = c.donotphone ,
                    d.authorizedrepname = c.authorizedrepname ,
                    d.carriertype = c.carriertype ,
                    d.carrier2type = c.carrier2type ,
                    d.carrier3type = c.carrier3type ,
                    d.cci_status = c.cci_status ,
                    d.cci_maximusoptout = c.cci_maximusoptout ,
                    d.cci_paceeligible = c.cci_paceeligible ,
                    d.cci_mltssstatus = c.cci_mltssstatus ,
                    d.cci_espdstatus = c.cci_espdstatus ,
                    d.cci_ignorelisind = c.cci_ignorelisind ,
                    d.cci_ohcfmandatory = c.cci_ohcfmandatory ,
                    d.defaultpathextension = c.defaultpathextension ,
                    d.defaultpathextensionexemptionid = c.defaultpathextensionexemptionid ,
                    d.eaflag = c.eaflag ,
                    d.enrlexclind = c.enrlexclind ,
                    d.esrdind = c.esrdind ,
                    d.expresslanepin = c.expresslanepin ,
                    d.expresslaneaffirmation = c.expresslaneaffirmation ,
                    d.expresslaneparent = c.expresslaneparent ,
                    d.expresslanestatusmedical = c.expresslanestatusmedical ,
                    d.expresslanestatusdental = c.expresslanestatusdental ,
                    d.hcpstatusprevious = c.hcpstatusprevious ,
                    d.hcbshighind = c.hcbshighind ,
                    d.hicn = c.hicn ,
                    d.institutionalind = c.institutionalind ,
                    d.lisind = c.lisind ,
                    d.mceligstat = c.mceligstat ,
                    d.medicarecarrier2code = c.medicarecarrier2code ,
                    d.medicarecarrier3code = c.medicarecarrier3code ,
                    d.medicarestatusparta = c.medicarestatusparta ,
                    d.medicarestatuspartb = c.medicarestatuspartb ,
                    d.medicarestatuspartd = c.medicarestatuspartd ,
                    d.optoutind = c.optoutind ,
                    d.passiveenrollment = c.passiveenrollment ,
                    d.sinsiind = c.sinsiind ,
                    d.socamt = c.socamt ,
                    d.subplanind = c.subplanind ,
                    d.recordcreatedate = c.recordcreatedate ,
                    d.recordcreatename = c.recordcreatename ,
                    d.datelastmodified = c.modifiedon ,
                    d.namelastmodified = c.namelastmodified ,
                    d.enrollmentstatus = c.enrollmentstatus ,
                    d.sendidltrdate = c.sendidltrdate ,
                    d.importdate = c.importdate ,
                    d.countychangercvddate = c.countychangercvddate ,
                    d.triggerforvolunmails = c.triggerforvolunmails ,
                    d.planoflasttrans = c.planoflasttrans ,
                    d.lasttransdate = c.lasttransdate ,
                    d.lasttransrcvdid = c.lasttransrcvdid ,
                    d.lasttransenrordisenr = c.lasttransenrordisenr ,
                    d.lasttransaccepted = c.lasttransaccepted ,
                    d.lastmedenrlrecid = c.lastmedenrlrecid ,
                    d.lastdisenrlrecid = c.lastdisenrlrecid ,
                    d.lastdisenroldate = c.lastdisenroldate ,
                    d.lastdisenrlaccepted = c.lastdisenrlaccepted ,
                    d.lastplanid = c.lastplanid ,
                    d.lastenrlopenplanid = c.lastenrlopenplanid ,
                    d.lastplanactivateddate = c.lastplanactivateddate ,
                    d.lastmcalffstrans = c.lastmcalffstrans ,
                    d.dtllasttransid = c.dtllasttransid ,
                    d.dtllastopentrans = c.dtllastopentrans ,
                    d.dtlenrlstatus = c.dtlenrlstatus ,
                    d.lastdentalenrleffdate = c.lastdentalenrleffdate ,
                    d.dentalplanactive = c.dentalplanactive ,
                    d.lastdtltranseord = c.lastdtltranseord ,
                    d.planoflastdtltrans = c.planoflastdtltrans ,
                    d.lastdtlffstrans = c.lastdtlffstrans ,
                    d.gmccombinedchoice = c.gmccombinedchoice ,
                    d.extendeddefaultpathtriggerdate = c.extendeddefaultpathtriggerdate ,
                    d.aidcodemandatoryexpirationdate = c.aidcodemandatoryexpirationdate ,
                    d.cmceligibilitydefaultpathresetdate = c.cmceligibilitydefaultpathresetdate ,
                    d.mltsseligibilitydefaultpathresetdate = c.mltsseligibilitydefaultpathresetdate ,
                    d.denbbmaildate = c.denbbmaildate ,
                    d.medbbmaildate = c.medbbmaildate ,
                    d.medrlmaildate = c.medrlmaildate ,
                    d.denrlmaildate = c.denrlmaildate ,
                    d.ialettersentdate = c.ialettersentdate ,
                    d.idlettersentdate = c.idlettersentdate ,
                    d.dialettersentdate = c.dialettersentdate ,
                    d.didlettersenddate = c.didlettersenddate ,
                    d.didlettersentdate = c.didlettersentdate ,
                    d.mcalmvltrsentdate = c.mcalmvltrsentdate ,
                    d.dtlmvltrsentdate = c.dtlmvltrsentdate ,
                    d.firstspecialdlmaildate = c.firstspecialdlmaildate ,
                    d.secspecialdlmaildate = c.secspecialdlmaildate ,
                    d.thirdspecialdlmaildate = c.thirdspecialdlmaildate ,
                    d.ondisenrlpath = c.ondisenrlpath ,
                    d.medicalbbasent = c.medicalbbasent ,
                    d.dentalbbasent = c.dentalbbasent ,
                    d.dexemplettersenddate = c.dexemplettersenddate ,
                    d.mexemptlettersenddate = c.mexemptlettersenddate ,
                    d.campaigncompleted = c.campaigncompleted ,
                    d.mincompletesentdate = c.mincompletesentdate ,
                    d.incompletechoiceformcounter = c.incompletechoiceformcounter ,
                    d.spdstatus = c.spdstatus,
                    d.sex = c.sex,
                    d.medicaleligibilityreasonid = c.medicaleligibilityreasonid,
                    d.dentaleligibilityreasonid = c.dentaleligibilityreasonid,
                    d.spdeligibilityreasonid = c.spdeligibilityreasonid,
                    d.medicarecontractnum = c.medicarecontractnum,
                    d.medicareplanid = c.medicareplanid,
                    d.medicareplanstartdate = c.medicareplanstartdate                    
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
                SELECT c_critical, con_pkg, 'CAHCO_ETL_PKG.CLIENT_UPD', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_CLIENT', Client_Number
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
      VALUES( c_critical, con_pkg, 'CAHCO_ETL_PKG.CLIENT_UPD', 1, v_desc, v_code, 'EMRS_D_CLIENT');

      COMMIT;
END CLIENT_UPD;

PROCEDURE CLIENT_HIST_ELIG_INS
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_ins_cnt number;
    v_err_cnt number;
    to_process number := 0;
    Run_Multiple varchar2(1) := 'N';
BEGIN

    DELETE FROM Errlog_Client WHERE ora_err_tag$ = 'CLIENT_HIST_ELIG_INS';

    Maxdat_Statistics.TABLE_STATS('EMRS_S_CLIENT_STG');

    SELECT COUNT(1) INTO to_process FROM EMRS_S_CLIENT_STG;

    SELECT CASE WHEN to_process > NVL(Value,1000000)
                THEN 'Y' ELSE 'N' END INTO Run_Multiple
      FROM CORP_ETL_CONTROL WHERE NAME = 'EMRS_REC_THRESHOLD';

    IF Run_Multiple = 'N' THEN

        INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
        VALUES (SEQ_JOB_ID.Nextval, 'CLIENT_HIST_ELIG_INS','STARTED',SYSDATE)
        RETURNING JOB_ID INTO v_job_id;

        COMMIT;

        INSERT /*+ Enable_Parallel_Dml Parallel */
          INTO Emrs_D_Client_Hist_Elig
               (client_number, case_number, cin,   addressokflag,   aidcode,   aliencode,   assigninthiscounty,   dob,   hcoclosedate,
                othhealthcoveragecode,   oldmedicalstatus,   olddentalstaus,   firstname,   middleinitial,   lastname,   eligibilityworkernum,
                ethniccode,   participantlang,   writtenlangcode,   mcalplnmedsstatus,   dtlmedshcpstatus,   medicalid,   mandatorvolunstatus,
                mandatorycounty,   denvolstatus,   maximusstatus,   isdualeligible,   isgrandfatherdlelig,   grandfatherdleligplan,   alowedplanfordlelig,
                medsfilecreationdate,   transmitdate,   pregnancyduedate,   exemptedbydr,   medicalexemption,   exemptionenddate,   dentalexemption,
                dentalexempenddate,   ccsindicator,   icfindicator,   medicarecarriercode,   medicareindicator,   isnonmeds,   switchtomeds,   switchtomedsdate,
                medicalpktrequested,   mpacketstatus,   dentalpktrequested,   dpacketstatus,   donotbulkemail,   donotbulkpostalmail,   donotemail,   donotfax,
                donotphone,   authorizedrepname,   carriertype,   carrier2type,   carrier3type,   cci_status,   cci_maximusoptout,   cci_paceeligible,
                cci_mltssstatus,   cci_espdstatus,   cci_ignorelisind,   cci_ohcfmandatory,   defaultpathextension,   defaultpathextensionexemptionid,   eaflag,
                enrlexclind,   esrdind,   expresslanepin,   expresslaneaffirmation,   expresslaneparent,   expresslanestatusmedical,   expresslanestatusdental,
                hcpstatusprevious,   hcbshighind,   hicn,   institutionalind,   lisind,   mceligstat,   medicarecarrier2code,   medicarecarrier3code,
                medicarestatusparta,   medicarestatuspartb,   medicarestatuspartd,   optoutind,   passiveenrollment,   sinsiind,   socamt,   subplanind,
                recordcreatedate,   recordcreatename, namelastmodified, datelastmodified, record_start_Date,   record_end_Date, spdstatus, sex,
                medicaleligibilityreasonid, dentaleligibilityreasonid, spdeligibilityreasonid, medicarecontractnum, medicareplanid, medicareplanstartdate
                )
        SELECT
              client_number, case_number, cin,   addressokflag,   aidcode,   aliencode,   assigninthiscounty,   dob,   hcoclosedate,
              othhealthcoveragecode,   oldmedicalstatus,   olddentalstaus,   firstname,   middleinitial,   lastname,   eligibilityworkernum,
              ethniccode,   participantlang,   writtenlangcode,   mcalplnmedsstatus,   dtlmedshcpstatus,   medicalid,   mandatorvolunstatus,
              mandatorycounty,   denvolstatus,   maximusstatus,   isdualeligible,   isgrandfatherdlelig,   grandfatherdleligplan,   alowedplanfordlelig,
              medsfilecreationdate,   transmitdate,   pregnancyduedate,   exemptedbydr,   medicalexemption,   exemptionenddate,   dentalexemption,
              dentalexempenddate,   ccsindicator,   icfindicator,   medicarecarriercode,   medicareindicator,   isnonmeds,   switchtomeds,   switchtomedsdate,
              medicalpktrequested,   mpacketstatus,   dentalpktrequested,   dpacketstatus,   donotbulkemail,   donotbulkpostalmail,   donotemail,   donotfax,
              donotphone,   authorizedrepname,   carriertype,   carrier2type,   carrier3type,   cci_status,   cci_maximusoptout,   cci_paceeligible,
              cci_mltssstatus,   cci_espdstatus,   cci_ignorelisind,   cci_ohcfmandatory,   defaultpathextension,   defaultpathextensionexemptionid,   eaflag,
              enrlexclind,   esrdind,   expresslanepin,   expresslaneaffirmation,   expresslaneparent,   expresslanestatusmedical,   expresslanestatusdental,
              hcpstatusprevious,   hcbshighind,   hicn,   institutionalind,   lisind,   mceligstat,   medicarecarrier2code,   medicarecarrier3code,
              medicarestatusparta,   medicarestatuspartb,   medicarestatuspartd,   optoutind,   passiveenrollment,   sinsiind,   socamt,   subplanind,
              recordcreatedate,   recordcreatename, namelastmodified,
              case when datelastmodified > be_modifiedon then datelastmodified else be_modifiedon end,
              --case when datelastmodified > be_modifiedon then datelastmodified else be_modifiedon end as record_start_Date,
              trunc(recordcreatedate) as record_start_Date,
              to_date('12312050','MMDDYYYY') as record_end_Date,
              spdstatus, sex,
              medicaleligibilityreasonid, dentaleligibilityreasonid, spdeligibilityreasonid, medicarecontractnum, medicareplanid, medicareplanstartdate              
          FROM emrs_s_client_stg s
         WHERE NOT EXISTS (SELECT 1 FROM emrs_d_client C WHERE C.Client_Number = S.Client_Number)
           Log Errors INTO Errlog_Client ('CLIENT_HIST_ELIG_INS') Reject Limit Unlimited;

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
        SELECT c_critical, con_pkg, 'CAHCO_ETL_PKG.CLIENT_HIST_ELIG_INS', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_CLIENT_HIST_ELIG', Client_Number
          FROM Errlog_Client
         WHERE Ora_Err_Tag$ = 'CLIENT_HIST_ELIG_INS';

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

            INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
            VALUES (SEQ_JOB_ID.Nextval, 'CLIENT_HIST_ELIG_INS THREAD'||IDX,'STARTED',SYSDATE)
            RETURNING JOB_ID INTO v_job_id;

            COMMIT;

            INSERT /*+ Enable_Parallel_Dml Parallel */
              INTO Emrs_D_Client_Hist_Elig
                   (client_number, case_number, cin,   addressokflag,   aidcode,   aliencode,   assigninthiscounty,   dob,   hcoclosedate,
                    othhealthcoveragecode,   oldmedicalstatus,   olddentalstaus,   firstname,   middleinitial,   lastname,   eligibilityworkernum,
                    ethniccode,   participantlang,   writtenlangcode,   mcalplnmedsstatus,   dtlmedshcpstatus,   medicalid,   mandatorvolunstatus,
                    mandatorycounty,   denvolstatus,   maximusstatus,   isdualeligible,   isgrandfatherdlelig,   grandfatherdleligplan,   alowedplanfordlelig,
                    medsfilecreationdate,   transmitdate,   pregnancyduedate,   exemptedbydr,   medicalexemption,   exemptionenddate,   dentalexemption,
                    dentalexempenddate,   ccsindicator,   icfindicator,   medicarecarriercode,   medicareindicator,   isnonmeds,   switchtomeds,   switchtomedsdate,
                    medicalpktrequested,   mpacketstatus,   dentalpktrequested,   dpacketstatus,   donotbulkemail,   donotbulkpostalmail,   donotemail,   donotfax,
                    donotphone,   authorizedrepname,   carriertype,   carrier2type,   carrier3type,   cci_status,   cci_maximusoptout,   cci_paceeligible,
                    cci_mltssstatus,   cci_espdstatus,   cci_ignorelisind,   cci_ohcfmandatory,   defaultpathextension,   defaultpathextensionexemptionid,   eaflag,
                    enrlexclind,   esrdind,   expresslanepin,   expresslaneaffirmation,   expresslaneparent,   expresslanestatusmedical,   expresslanestatusdental,
                    hcpstatusprevious,   hcbshighind,   hicn,   institutionalind,   lisind,   mceligstat,   medicarecarrier2code,   medicarecarrier3code,
                    medicarestatusparta,   medicarestatuspartb,   medicarestatuspartd,   optoutind,   passiveenrollment,   sinsiind,   socamt,   subplanind,
                    recordcreatedate,   recordcreatename, namelastmodified, datelastmodified, record_start_Date,   record_end_Date, spdstatus, sex, 
                    medicaleligibilityreasonid, dentaleligibilityreasonid, spdeligibilityreasonid, medicarecontractnum, medicareplanid, medicareplanstartdate )
            SELECT
                  client_number, case_number, cin,   addressokflag,   aidcode,   aliencode,   assigninthiscounty,   dob,   hcoclosedate,
                  othhealthcoveragecode,   oldmedicalstatus,   olddentalstaus,   firstname,   middleinitial,   lastname,   eligibilityworkernum,
                  ethniccode,   participantlang,   writtenlangcode,   mcalplnmedsstatus,   dtlmedshcpstatus,   medicalid,   mandatorvolunstatus,
                  mandatorycounty,   denvolstatus,   maximusstatus,   isdualeligible,   isgrandfatherdlelig,   grandfatherdleligplan,   alowedplanfordlelig,
                  medsfilecreationdate,   transmitdate,   pregnancyduedate,   exemptedbydr,   medicalexemption,   exemptionenddate,   dentalexemption,
                  dentalexempenddate,   ccsindicator,   icfindicator,   medicarecarriercode,   medicareindicator,   isnonmeds,   switchtomeds,   switchtomedsdate,
                  medicalpktrequested,   mpacketstatus,   dentalpktrequested,   dpacketstatus,   donotbulkemail,   donotbulkpostalmail,   donotemail,   donotfax,
                  donotphone,   authorizedrepname,   carriertype,   carrier2type,   carrier3type,   cci_status,   cci_maximusoptout,   cci_paceeligible,
                  cci_mltssstatus,   cci_espdstatus,   cci_ignorelisind,   cci_ohcfmandatory,   defaultpathextension,   defaultpathextensionexemptionid,   eaflag,
                  enrlexclind,   esrdind,   expresslanepin,   expresslaneaffirmation,   expresslaneparent,   expresslanestatusmedical,   expresslanestatusdental,
                  hcpstatusprevious,   hcbshighind,   hicn,   institutionalind,   lisind,   mceligstat,   medicarecarrier2code,   medicarecarrier3code,
                  medicarestatusparta,   medicarestatuspartb,   medicarestatuspartd,   optoutind,   passiveenrollment,   sinsiind,   socamt,   subplanind,
                  recordcreatedate,   recordcreatename, namelastmodified,
                  case when datelastmodified > be_modifiedon then datelastmodified else be_modifiedon end,
                  trunc(recordcreatedate) as record_start_Date,
                  to_date('12312050','MMDDYYYY') as record_end_Date,
                  spdstatus , sex,
                  medicaleligibilityreasonid, dentaleligibilityreasonid, spdeligibilityreasonid, medicarecontractnum, medicareplanid, medicareplanstartdate                  
              FROM emrs_s_client_stg s
             WHERE S.PARTITIONIDX = IDX
               AND NOT EXISTS (SELECT 1 FROM emrs_d_client C WHERE C.Client_Number = S.Client_Number)
               Log Errors INTO Errlog_Client ('CLIENT_HIST_ELIG_INS') Reject Limit Unlimited;

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
            SELECT c_critical, con_pkg, 'CAHCO_ETL_PKG.CLIENT_HIST_ELIG_INS', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_CLIENT_HIST_ELIG', Client_Number
              FROM Errlog_Client
             WHERE Ora_Err_Tag$ = 'CLIENT_HIST_ELIG_INS';

            v_err_cnt := SQL%RowCount;

            UPDATE CORP_ETL_JOB_STATISTICS
               SET ERROR_COUNT = v_err_cnt
                 , RECORD_COUNT = v_ins_cnt + v_err_cnt
                 , PROCESSED_COUNT = v_ins_cnt + v_err_cnt
             WHERE JOB_ID =  v_job_id;

            DELETE FROM Errlog_Client WHERE ora_err_tag$ = 'CLIENT_HIST_ELIG_INS';

            COMMIT;

      END LOOP;

    END IF;

    -- Maxdat_Statistics.TABLE_STATS('EMRS_D_CLIENT_HIST_ELIG');

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, 'CAHCO_ETL_PKG.CLIENT_HIST_ELIG_INS', 1, v_desc, v_code, 'EMRS_D_CLIENT_HIST_ELIG');

      COMMIT;
END CLIENT_HIST_ELIG_INS;

PROCEDURE CLIENT_HIST_ENRL_INS
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_ins_cnt number;
    v_err_cnt number;
    to_process number := 0;
    Run_Multiple varchar2(1) := 'N';
BEGIN

    DELETE FROM Errlog_Client WHERE ora_err_tag$ = 'CLIENT_HIST_ENRL_INS';

    --Maxdat_Statistics.TABLE_STATS('EMRS_S_CLIENT_STG');

    SELECT COUNT(1) INTO to_process FROM EMRS_S_CLIENT_STG;

    SELECT CASE WHEN to_process > NVL(Value,1000000)
                THEN 'Y' ELSE 'N' END INTO Run_Multiple
      FROM CORP_ETL_CONTROL WHERE NAME = 'EMRS_REC_THRESHOLD';

    IF Run_Multiple = 'N' THEN

        INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
        VALUES (SEQ_JOB_ID.Nextval, 'CLIENT_HIST_ENRL_INS','STARTED',SYSDATE)
        RETURNING JOB_ID INTO v_job_id;

        COMMIT;

        INSERT /*+ Enable_Parallel_Dml Parallel */
          INTO Emrs_D_Client_Hist_Enrl
               (client_number, case_number, enrollmentstatus, sendidltrdate, importdate, countychangercvddate, triggerforvolunmails, planoflasttrans,
                lasttransdate, lasttransrcvdid, lasttransenrordisenr, lasttransaccepted, lastmedenrlrecid, lastdisenrlrecid, lastdisenroldate,
                lastdisenrlaccepted, lastplanid, lastenrlopenplanid, lastplanactivateddate, lastmcalffstrans, dtllasttransid, dtllastopentrans,
                dtlenrlstatus, lastdentalenrleffdate, dentalplanactive, lastdtltranseord, planoflastdtltrans, lastdtlffstrans, gmccombinedchoice,
                recordcreatedate, recordcreatename, namelastmodified, datelastmodified, record_start_Date, record_end_Date)
        SELECT
              client_number, case_number, enrollmentstatus, sendidltrdate, importdate, countychangercvddate, triggerforvolunmails, planoflasttrans,
              lasttransdate, lasttransrcvdid, lasttransenrordisenr, lasttransaccepted, lastmedenrlrecid, lastdisenrlrecid, lastdisenroldate,
              lastdisenrlaccepted, lastplanid, lastenrlopenplanid, lastplanactivateddate, lastmcalffstrans, dtllasttransid, dtllastopentrans,
              dtlenrlstatus, lastdentalenrleffdate, dentalplanactive, lastdtltranseord, planoflastdtltrans, lastdtlffstrans, gmccombinedchoice,
              recordcreatedate,   recordcreatename, namelastmodified,
              case when datelastmodified > be_modifiedon then datelastmodified else be_modifiedon end,
              trunc(recordcreatedate) as record_start_Date,
              to_date('12312050','MMDDYYYY') as record_end_Date

        FROM emrs_s_client_stg s
         WHERE NOT EXISTS (SELECT 1 FROM emrs_d_client C WHERE C.Client_Number = S.Client_Number)
           Log Errors INTO Errlog_Client ('CLIENT_HIST_ENRL_INS') Reject Limit Unlimited;

        v_ins_cnt := SQL%RowCount;

        UPDATE CORP_ETL_JOB_STATISTICS
           SET Job_end_date = SYSDATE
             , RECORD_COUNT = v_ins_cnt
             , PROCESSED_COUNT = v_ins_cnt
             , RECORD_INSERTED_COUNT = v_ins_cnt
             , JOB_STATUS_CD = 'COMPLETED'
         WHERE JOB_ID =  v_job_id;

        COMMIT;

--      Maxdat_Statistics.TABLE_STATS('EMRS_D_CLIENT_HIST_ENRL');

        INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name,driver_key_number)
        SELECT c_critical, con_pkg, 'CAHCO_ETL_PKG.CLIENT_HIST_ENRL_INS', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_CLIENT_HIST_ENRL', Client_Number
          FROM Errlog_Client
         WHERE Ora_Err_Tag$ = 'CLIENT_HIST_ENRL_INS';

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

            INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
            VALUES (SEQ_JOB_ID.Nextval, 'CLIENT_HIST_ENRL_INS THREAD'||IDX,'STARTED',SYSDATE)
            RETURNING JOB_ID INTO v_job_id;

            COMMIT;

            INSERT /*+ Enable_Parallel_Dml Parallel */
              INTO Emrs_D_Client_Hist_Enrl
                   (client_number, case_number, enrollmentstatus, sendidltrdate, importdate, countychangercvddate, triggerforvolunmails, planoflasttrans,
                    lasttransdate, lasttransrcvdid, lasttransenrordisenr, lasttransaccepted, lastmedenrlrecid, lastdisenrlrecid, lastdisenroldate,
                    lastdisenrlaccepted, lastplanid, lastenrlopenplanid, lastplanactivateddate, lastmcalffstrans, dtllasttransid, dtllastopentrans,
                    dtlenrlstatus, lastdentalenrleffdate, dentalplanactive, lastdtltranseord, planoflastdtltrans, lastdtlffstrans, gmccombinedchoice,
                    recordcreatedate, recordcreatename, namelastmodified, datelastmodified, record_start_Date, record_end_Date)
            SELECT
                  client_number, case_number, enrollmentstatus, sendidltrdate, importdate, countychangercvddate, triggerforvolunmails, planoflasttrans,
                  lasttransdate, lasttransrcvdid, lasttransenrordisenr, lasttransaccepted, lastmedenrlrecid, lastdisenrlrecid, lastdisenroldate,
                  lastdisenrlaccepted, lastplanid, lastenrlopenplanid, lastplanactivateddate, lastmcalffstrans, dtllasttransid, dtllastopentrans,
                  dtlenrlstatus, lastdentalenrleffdate, dentalplanactive, lastdtltranseord, planoflastdtltrans, lastdtlffstrans, gmccombinedchoice,
                  recordcreatedate,   recordcreatename, namelastmodified,
                  case when datelastmodified > be_modifiedon then datelastmodified else be_modifiedon end,
                  trunc(recordcreatedate) as record_start_Date,
                  to_date('12312050','MMDDYYYY') as record_end_Date

             FROM emrs_s_client_stg s
            WHERE S.PARTITIONIDX = IDX
              AND NOT EXISTS (SELECT 1 FROM emrs_d_client C WHERE C.Client_Number = S.Client_Number)
              Log Errors INTO Errlog_Client ('CLIENT_HIST_ENRL_INS') Reject Limit Unlimited;

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
            SELECT c_critical, con_pkg, 'CAHCO_ETL_PKG.CLIENT_HIST_ENRL_INS', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_CLIENT_HIST_ENRL', Client_Number
              FROM Errlog_Client
             WHERE Ora_Err_Tag$ = 'CLIENT_HIST_ENRL_INS';

            v_err_cnt := SQL%RowCount;

            UPDATE CORP_ETL_JOB_STATISTICS
               SET ERROR_COUNT = v_err_cnt
                 , RECORD_COUNT = v_ins_cnt + v_err_cnt
                 , PROCESSED_COUNT = v_ins_cnt + v_err_cnt
             WHERE JOB_ID =  v_job_id;

            DELETE FROM Errlog_Client WHERE ora_err_tag$ = 'CLIENT_HIST_ENRL_INS';

            COMMIT;

      END LOOP;

    END IF;

    Maxdat_Statistics.TABLE_STATS('EMRS_D_CLIENT_HIST_ENRL');

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, 'CAHCO_ETL_PKG.CLIENT_HIST_ENRL_INS', 1, v_desc, v_code, 'EMRS_D_CLIENT_HIST_ENRL');

      COMMIT;
END CLIENT_HIST_ENRL_INS;

PROCEDURE CLIENT_HIST_EXTN_INS
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_ins_cnt number;
    v_err_cnt number;
    to_process number := 0;
    Run_Multiple varchar2(1) := 'N';
BEGIN

    DELETE FROM Errlog_Client WHERE ora_err_tag$ = 'CLIENT_HIST_EXTN_INS';

    --Maxdat_Statistics.TABLE_STATS('EMRS_S_CLIENT_STG');

    SELECT COUNT(1) INTO to_process FROM EMRS_S_CLIENT_STG;

    SELECT CASE WHEN to_process > NVL(Value,1000000)
                THEN 'Y' ELSE 'N' END INTO Run_Multiple
      FROM CORP_ETL_CONTROL WHERE NAME = 'EMRS_REC_THRESHOLD';

    IF Run_Multiple = 'N' THEN

        INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
        VALUES (SEQ_JOB_ID.Nextval, 'CLIENT_HIST_EXTN_INS','STARTED',SYSDATE)
        RETURNING JOB_ID INTO v_job_id;

        COMMIT;

        INSERT /*+ Enable_Parallel_Dml Parallel */
          INTO Emrs_D_Client_Hist_Extn
               (client_number, case_number, extendeddefaultpathtriggerdate, aidcodemandatoryexpirationdate, cmceligibilitydefaultpathresetdate,
                mltsseligibilitydefaultpathresetdate, denbbmaildate, medbbmaildate, medrlmaildate, denrlmaildate, ialettersentdate, idlettersentdate,
                dialettersentdate, didlettersenddate, didlettersentdate, mcalmvltrsentdate, dtlmvltrsentdate, firstspecialdlmaildate, secspecialdlmaildate,
                thirdspecialdlmaildate, ondisenrlpath, medicalbbasent, dentalbbasent, dexemplettersenddate, mexemptlettersenddate, campaigncompleted,
                mincompletesentdate, incompletechoiceformcounter, recordcreatedate,   recordcreatename, namelastmodified,
                datelastmodified, record_start_Date, record_end_Date)
        SELECT
              client_number, case_number, extendeddefaultpathtriggerdate, aidcodemandatoryexpirationdate, cmceligibilitydefaultpathresetdate,
              mltsseligibilitydefaultpathresetdate, denbbmaildate, medbbmaildate, medrlmaildate, denrlmaildate, ialettersentdate, idlettersentdate,
              dialettersentdate, didlettersenddate, didlettersentdate, mcalmvltrsentdate, dtlmvltrsentdate, firstspecialdlmaildate, secspecialdlmaildate,
              thirdspecialdlmaildate, ondisenrlpath, medicalbbasent, dentalbbasent, dexemplettersenddate, mexemptlettersenddate, campaigncompleted,
              mincompletesentdate, incompletechoiceformcounter, recordcreatedate,   recordcreatename, namelastmodified,
              case when datelastmodified > be_modifiedon then datelastmodified else be_modifiedon end,
              trunc(recordcreatedate) as record_start_Date,
              to_date('12312050','MMDDYYYY') as record_end_Date

          FROM emrs_s_client_stg s
         WHERE NOT EXISTS (SELECT 1 FROM emrs_d_client C WHERE C.Client_Number = S.Client_Number)
           Log Errors INTO Errlog_Client ('CLIENT_HIST_EXTN_INS') Reject Limit Unlimited;

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
        SELECT c_critical, con_pkg, 'CAHCO_ETL_PKG.CLIENT_HIST_EXTN_INS', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_CLIENT_HIST_EXTN', Client_Number
          FROM Errlog_Client
         WHERE Ora_Err_Tag$ = 'CLIENT_HIST_EXTN_INS';

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

            INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
            VALUES (SEQ_JOB_ID.Nextval, 'CLIENT_HIST_EXTN_INS THREAD'||IDX,'STARTED',SYSDATE)
            RETURNING JOB_ID INTO v_job_id;

            COMMIT;

            INSERT /*+ Enable_Parallel_Dml Parallel */
              INTO Emrs_D_Client_Hist_Extn
                   (client_number, case_number, extendeddefaultpathtriggerdate, aidcodemandatoryexpirationdate, cmceligibilitydefaultpathresetdate,
                    mltsseligibilitydefaultpathresetdate, denbbmaildate, medbbmaildate, medrlmaildate, denrlmaildate, ialettersentdate, idlettersentdate,
                    dialettersentdate, didlettersenddate, didlettersentdate, mcalmvltrsentdate, dtlmvltrsentdate, firstspecialdlmaildate, secspecialdlmaildate,
                    thirdspecialdlmaildate, ondisenrlpath, medicalbbasent, dentalbbasent, dexemplettersenddate, mexemptlettersenddate, campaigncompleted,
                    mincompletesentdate, incompletechoiceformcounter, recordcreatedate,   recordcreatename, namelastmodified,
                    datelastmodified, record_start_Date, record_end_Date)
            SELECT
                  client_number, case_number, extendeddefaultpathtriggerdate, aidcodemandatoryexpirationdate, cmceligibilitydefaultpathresetdate,
                  mltsseligibilitydefaultpathresetdate, denbbmaildate, medbbmaildate, medrlmaildate, denrlmaildate, ialettersentdate, idlettersentdate,
                  dialettersentdate, didlettersenddate, didlettersentdate, mcalmvltrsentdate, dtlmvltrsentdate, firstspecialdlmaildate, secspecialdlmaildate,
                  thirdspecialdlmaildate, ondisenrlpath, medicalbbasent, dentalbbasent, dexemplettersenddate, mexemptlettersenddate, campaigncompleted,
                  mincompletesentdate, incompletechoiceformcounter, recordcreatedate,   recordcreatename, namelastmodified,
                  case when datelastmodified > be_modifiedon then datelastmodified else be_modifiedon end,
                  trunc(recordcreatedate) as record_start_Date,
                  to_date('12312050','MMDDYYYY') as record_end_Date

              FROM emrs_s_client_stg s
             WHERE S.PARTITIONIDX = IDX
               AND NOT EXISTS (SELECT 1 FROM emrs_d_client C WHERE C.Client_Number = S.Client_Number)
               Log Errors INTO Errlog_Client ('CLIENT_HIST_EXTN_INS') Reject Limit Unlimited;

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
            SELECT c_critical, con_pkg, 'CAHCO_ETL_PKG.CLIENT_HIST_EXTN_INS', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_CLIENT_HIST_EXTN', Client_Number
              FROM Errlog_Client
             WHERE Ora_Err_Tag$ = 'CLIENT_HIST_EXTN_INS';

            v_err_cnt := SQL%RowCount;

            UPDATE CORP_ETL_JOB_STATISTICS
               SET ERROR_COUNT = v_err_cnt
                 , RECORD_COUNT = v_ins_cnt + v_err_cnt
                 , PROCESSED_COUNT = v_ins_cnt + v_err_cnt
             WHERE JOB_ID =  v_job_id;

            DELETE FROM Errlog_Client WHERE ora_err_tag$ = 'CLIENT_HIST_EXTN_INS';

            COMMIT;

       END LOOP;

    END IF;

    Maxdat_Statistics.TABLE_STATS('EMRS_D_CLIENT_HIST_EXTN');

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, 'CAHCO_ETL_PKG.CLIENT_HIST_EXTN_INS', 1, v_desc, v_code, 'EMRS_D_CLIENT_HIST_EXTN');

      COMMIT;
END CLIENT_HIST_EXTN_INS;

PROCEDURE CLIENT_HIST_ELIG_UPD
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
    to_process number := 0;
    Run_Multiple varchar2(1) := 'N';
BEGIN
    SELECT COUNT(1) INTO to_process FROM EMRS_S_CLIENT_STG;

    SELECT CASE WHEN to_process > NVL(Value,1000000)
                THEN 'Y' ELSE 'N' END INTO Run_Multiple
      FROM CORP_ETL_CONTROL WHERE NAME = 'EMRS_REC_THRESHOLD';

    -- Maxdat_Statistics.TABLE_STATS('EMRS_S_CLIENT_STG');
    -- Maxdat_Statistics.TABLE_STATS('EMRS_D_CLIENT');

    IF Run_Multiple = 'N' THEN

       DELETE FROM Errlog_Client WHERE ora_err_tag$ IN ('CLIENT_HIST_ELIG_UPD','CLIENT_HIST_ELIG_OLDREC_UPD');
       DELETE FROM Client_Process WHERE Code = 'ELIG';

       INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
       VALUES (SEQ_JOB_ID.Nextval, 'CLIENT_HIST_ELIG_UPD','STARTED',SYSDATE)
       RETURNING JOB_ID INTO v_job_id;

       COMMIT;

       INSERT /*+ Enable_Parallel_Dml Parallel */
         INTO Emrs_D_Client_Hist_Elig
              (client_number, case_number, cin,   addressokflag,   aidcode,   aliencode,   assigninthiscounty,   dob,   hcoclosedate,
               othhealthcoveragecode,   oldmedicalstatus,   olddentalstaus,   firstname,   middleinitial,   lastname,   eligibilityworkernum,
               ethniccode,   participantlang,   writtenlangcode,   mcalplnmedsstatus,   dtlmedshcpstatus,   medicalid,   mandatorvolunstatus,
               mandatorycounty,   denvolstatus,   maximusstatus,   isdualeligible,   isgrandfatherdlelig,   grandfatherdleligplan,   alowedplanfordlelig,
               medsfilecreationdate,   transmitdate,   pregnancyduedate,   exemptedbydr,   medicalexemption,   exemptionenddate,   dentalexemption,
               dentalexempenddate,   ccsindicator,   icfindicator,   medicarecarriercode,   medicareindicator,   isnonmeds,   switchtomeds,   switchtomedsdate,
               medicalpktrequested,   mpacketstatus,   dentalpktrequested,   dpacketstatus,   donotbulkemail,   donotbulkpostalmail,   donotemail,   donotfax,
               donotphone,   authorizedrepname,   carriertype,   carrier2type,   carrier3type,   cci_status,   cci_maximusoptout,   cci_paceeligible,
               cci_mltssstatus,   cci_espdstatus,   cci_ignorelisind,   cci_ohcfmandatory,   defaultpathextension,   defaultpathextensionexemptionid,   eaflag,
               enrlexclind,   esrdind,   expresslanepin,   expresslaneaffirmation,   expresslaneparent,   expresslanestatusmedical,   expresslanestatusdental,
               hcpstatusprevious,   hcbshighind,   hicn,   institutionalind,   lisind,   mceligstat,   medicarecarrier2code,   medicarecarrier3code,
               medicarestatusparta,   medicarestatuspartb,   medicarestatuspartd,   optoutind,   passiveenrollment,   sinsiind,   socamt,   subplanind,
               recordcreatedate,   recordcreatename, namelastmodified, datelastmodified, record_start_Date,   record_end_Date, spdstatus, sex, 
               medicaleligibilityreasonid, dentaleligibilityreasonid, spdeligibilityreasonid, medicarecontractnum, medicareplanid, medicareplanstartdate)

       SELECT
               s.client_number, s.case_number, s.cin, s.addressokflag, s.aidcode, s.aliencode, s.assigninthiscounty, s.dob, s.hcoclosedate,
               s.othhealthcoveragecode,  s.oldmedicalstatus,  s.olddentalstaus,  s.firstname,  s.middleinitial,  s.lastname,  s.eligibilityworkernum,
               s.ethniccode,  s.participantlang,  s.writtenlangcode,  s.mcalplnmedsstatus,  s.dtlmedshcpstatus,  s.medicalid,  s.mandatorvolunstatus,
               s.mandatorycounty,  s.denvolstatus,  s.maximusstatus,  s.isdualeligible,  s.isgrandfatherdlelig,  s.grandfatherdleligplan, s.alowedplanfordlelig,
               s.medsfilecreationdate,  s.transmitdate,  s.pregnancyduedate,  s.exemptedbydr,  s.medicalexemption,  s.exemptionenddate,  s.dentalexemption,
               s.dentalexempenddate,  s.ccsindicator,  s.icfindicator,  s.medicarecarriercode, s.medicareindicator,  s.isnonmeds,  s.switchtomeds,
               s.switchtomedsdate,  s.medicalpktrequested,  s.mpacketstatus,  s.dentalpktrequested,  s.dpacketstatus,  s.donotbulkemail, s.donotbulkpostalmail,
               s.donotemail,  s.donotfax,  s.donotphone,  s.authorizedrepname,  s.carriertype,  s.carrier2type,  s.carrier3type, s.cci_status,  s.cci_maximusoptout,
               s.cci_paceeligible,  s.cci_mltssstatus,  s.cci_espdstatus,  s.cci_ignorelisind,  s.cci_ohcfmandatory,  s.defaultpathextension,  s.defaultpathextensionexemptionid,
               s.eaflag,  s.enrlexclind,  s.esrdind,  s.expresslanepin,  s.expresslaneaffirmation,  s.expresslaneparent,  s.expresslanestatusmedical,  s.expresslanestatusdental,
               s.hcpstatusprevious,  s.hcbshighind,  s.hicn,  s.institutionalind,  s.lisind,  s.mceligstat,  s.medicarecarrier2code,  s.medicarecarrier3code,  s.medicarestatusparta,
               s.medicarestatuspartb,  s.medicarestatuspartd,  s.optoutind,  s.passiveenrollment,  s.sinsiind,  s.socamt,  s.subplanind,  s.recordcreatedate,  s.recordcreatename,
               s.namelastmodified,
               case when s.datelastmodified > s.be_modifiedon then s.datelastmodified else s.be_modifiedon end as modifiedon,
               case when s.datelastmodified > s.be_modifiedon then s.datelastmodified else s.be_modifiedon end as record_start_Date,
               to_date('12312050','MMDDYYYY') as record_end_Date , s.spdstatus , s.sex,
               s.medicaleligibilityreasonid, s.dentaleligibilityreasonid, s.spdeligibilityreasonid, s.medicarecontractnum, s.medicareplanid, s.medicareplanstartdate

          FROM EMRS_D_CLIENT D, EMRS_S_CLIENT_STG S
         WHERE D.CLIENT_NUMBER = S.CLIENT_NUMBER
           AND (
                  NVL(d.case_number,-1) != NVL(s.case_number,-1) OR
                  NVL(d.cin,'*') != NVL(s.cin,'*') OR
                  NVL(d.addressokflag,'*') != NVL(s.addressokflag,'*') OR
                  NVL(d.aidcode,'*') != NVL(s.aidcode,'*') OR
                  NVL(d.aliencode,'*') != NVL(s.aliencode,'*') OR
                  NVL(d.assigninthiscounty,'*') != NVL(s.assigninthiscounty,'*') OR
                  NVL(d.dob,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.dob,  to_date('07/07/7777','mm/dd/yyyy')) OR
                  NVL(d.hcoclosedate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.hcoclosedate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                  NVL(d.othhealthcoveragecode,'*') != NVL(s.othhealthcoveragecode,'*') OR
                  NVL(d.oldmedicalstatus,'*') != NVL(s.oldmedicalstatus,'*') OR
                  NVL(d.olddentalstaus,'*') != NVL(s.olddentalstaus,'*') OR
                  NVL(d.firstname,'*') != NVL(s.firstname,'*') OR
                  NVL(d.middleinitial,'*') != NVL(s.middleinitial,'*') OR
                  NVL(d.lastname,'*') != NVL(s.lastname,'*') OR
                  NVL(d.sex,'*') != NVL(s.sex,'*') OR
                  NVL(d.eligibilityworkernum,'*') != NVL(s.eligibilityworkernum,'*') OR
                  NVL(d.ethniccode,'*') != NVL(s.ethniccode,'*') OR
                  NVL(d.participantlang,'*') != NVL(s.participantlang,'*') OR
                  NVL(d.writtenlangcode,'*') != NVL(s.writtenlangcode,'*') OR
                  NVL(d.mcalplnmedsstatus,'*') != NVL(s.mcalplnmedsstatus,'*') OR
                  NVL(d.dtlmedshcpstatus,'*') != NVL(s.dtlmedshcpstatus,'*') OR
                  NVL(d.medicalid,'*') != NVL(s.medicalid,'*') OR
                  NVL(d.mandatorvolunstatus,'*') != NVL(s.mandatorvolunstatus,'*') OR
                  NVL(d.mandatorycounty,'*') != NVL(s.mandatorycounty,'*') OR
                  NVL(d.denvolstatus,'*') != NVL(s.denvolstatus,'*') OR
                  NVL(d.maximusstatus,'*') != NVL(s.maximusstatus,'*') OR
                  NVL(d.isdualeligible,'*') != NVL(s.isdualeligible,'*') OR
                  NVL(d.isgrandfatherdlelig,'*') != NVL(s.isgrandfatherdlelig,'*') OR
                  NVL(d.grandfatherdleligplan,'*') != NVL(s.grandfatherdleligplan,'*') OR
                  NVL(d.alowedplanfordlelig,'*') != NVL(s.alowedplanfordlelig,'*') OR
                  NVL(d.medsfilecreationdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.medsfilecreationdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                  NVL(d.transmitdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.transmitdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                  NVL(d.pregnancyduedate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.pregnancyduedate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                  NVL(d.exemptedbydr,'*') != NVL(s.exemptedbydr,'*') OR
                  NVL(d.medicalexemption,'*') != NVL(s.medicalexemption,'*') OR
                  NVL(d.exemptionenddate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.exemptionenddate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                  NVL(d.dentalexemption,'*') != NVL(s.dentalexemption,'*') OR
                  NVL(d.dentalexempenddate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.dentalexempenddate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                  NVL(d.ccsindicator,'*') != NVL(s.ccsindicator,'*') OR
                  NVL(d.icfindicator,'*') != NVL(s.icfindicator,'*') OR
                  NVL(d.medicarecarriercode,'*') != NVL(s.medicarecarriercode,'*') OR
                  NVL(d.medicareindicator,'*') != NVL(s.medicareindicator,'*') OR
                  NVL(d.isnonmeds,'*') != NVL(s.isnonmeds,'*') OR
                  NVL(d.switchtomeds,'*') != NVL(s.switchtomeds,'*') OR
                  NVL(d.switchtomedsdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.switchtomedsdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                  NVL(d.medicalpktrequested,'*') != NVL(s.medicalpktrequested,'*') OR
                  NVL(d.mpacketstatus,'*') != NVL(s.mpacketstatus,'*') OR
                  NVL(d.dentalpktrequested,'*') != NVL(s.dentalpktrequested,'*') OR
                  NVL(d.dpacketstatus,'*') != NVL(s.dpacketstatus,'*') OR
                  NVL(d.donotbulkemail,'*') != NVL(s.donotbulkemail,'*') OR
                  NVL(d.donotbulkpostalmail,'*') != NVL(s.donotbulkpostalmail,'*') OR
                  NVL(d.donotemail,'*') != NVL(s.donotemail,'*') OR
                  NVL(d.donotfax,'*') != NVL(s.donotfax,'*') OR
                  NVL(d.donotphone,'*') != NVL(s.donotphone,'*') OR
                  NVL(d.authorizedrepname,'*') != NVL(s.authorizedrepname,'*') OR
                  NVL(d.carriertype,'*') != NVL(s.carriertype,'*') OR
                  NVL(d.carrier2type,'*') != NVL(s.carrier2type,'*') OR
                  NVL(d.carrier3type,'*') != NVL(s.carrier3type,'*') OR
                  NVL(d.cci_status,'*') != NVL(s.cci_status,'*') OR
                  NVL(d.cci_maximusoptout,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.cci_maximusoptout,  to_date('07/07/7777','mm/dd/yyyy')) OR
                  NVL(d.cci_paceeligible,'*') != NVL(s.cci_paceeligible,'*') OR
                  NVL(d.cci_mltssstatus,'*') != NVL(s.cci_mltssstatus,'*') OR
                  NVL(d.cci_espdstatus,'*') != NVL(s.cci_espdstatus,'*') OR
                  NVL(d.cci_ignorelisind,'*') != NVL(s.cci_ignorelisind,'*') OR
                  NVL(d.cci_ohcfmandatory,'*') != NVL(s.cci_ohcfmandatory,'*') OR
                  NVL(d.defaultpathextension,'*') != NVL(s.defaultpathextension,'*') OR
                  NVL(d.defaultpathextensionexemptionid,-1) != NVL(s.defaultpathextensionexemptionid,-1) OR
                  NVL(d.eaflag,'*') != NVL(s.eaflag,'*') OR
                  NVL(d.enrlexclind,'*') != NVL(s.enrlexclind,'*') OR
                  NVL(d.esrdind,'*') != NVL(s.esrdind,'*') OR
                  NVL(d.expresslanepin,'*') != NVL(s.expresslanepin,'*') OR
                  NVL(d.expresslaneaffirmation,'*') != NVL(s.expresslaneaffirmation,'*') OR
                  NVL(d.expresslaneparent,'*') != NVL(s.expresslaneparent,'*') OR
                  NVL(d.expresslanestatusmedical,'*') != NVL(s.expresslanestatusmedical,'*') OR
                  NVL(d.expresslanestatusdental,'*') != NVL(s.expresslanestatusdental,'*') OR
                  NVL(d.hcpstatusprevious,'*') != NVL(s.hcpstatusprevious,'*') OR
                  NVL(d.hcbshighind,'*') != NVL(s.hcbshighind,'*') OR
                  NVL(d.hicn,'*') != NVL(s.hicn,'*') OR
                  NVL(d.institutionalind,'*') != NVL(s.institutionalind,'*') OR
                  NVL(d.lisind,'*') != NVL(s.lisind,'*') OR
                  NVL(d.mceligstat,'*') != NVL(s.mceligstat,'*') OR
                  NVL(d.medicarecarrier2code,'*') != NVL(s.medicarecarrier2code,'*') OR
                  NVL(d.medicarecarrier3code,'*') != NVL(s.medicarecarrier3code,'*') OR
                  NVL(d.medicarestatusparta,'*') != NVL(s.medicarestatusparta,'*') OR
                  NVL(d.medicarestatuspartb,'*') != NVL(s.medicarestatuspartb,'*') OR
                  NVL(d.medicarestatuspartd,'*') != NVL(s.medicarestatuspartd,'*') OR
                  NVL(d.optoutind,'*') != NVL(s.optoutind,'*') OR
                  NVL(d.passiveenrollment,'*') != NVL(s.passiveenrollment,'*') OR
                  NVL(d.sinsiind,'*') != NVL(s.sinsiind,'*') OR
                  NVL(d.socamt,'*') != NVL(s.socamt,'*') OR
                  NVL(d.subplanind,'*') != NVL(s.subplanind,'*') OR
                  NVL(d.spdstatus,'*') != NVL(s.spdstatus,'*') OR
                  NVL(d.medicaleligibilityreasonid,-1) != NVL(s.medicaleligibilityreasonid,-1) OR
                  NVL(d.dentaleligibilityreasonid,-1) != NVL(s.dentaleligibilityreasonid,-1) OR
                  NVL(d.spdeligibilityreasonid,-1) != NVL(s.spdeligibilityreasonid,-1) OR
                  NVL(d.medicarecontractnum,'*') != NVL(s.medicarecontractnum,'*') OR
                  NVL(d.medicareplanid,-1) != NVL(s.medicareplanid,-1) OR
                  NVL(d.medicareplanstartdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.medicareplanstartdate,  to_date('07/07/7777','mm/dd/yyyy'))                  
                  )
       Log Errors INTO Errlog_Client ('CLIENT_HIST_ELIG_UPD') Reject Limit Unlimited;

        v_upd_cnt := SQL%RowCount;

        UPDATE CORP_ETL_JOB_STATISTICS
           SET Job_end_date = SYSDATE
             , RECORD_COUNT = v_upd_cnt
             , PROCESSED_COUNT = v_upd_cnt
             , RECORD_UPDATED_COUNT = v_upd_cnt
             , JOB_STATUS_CD = 'COMPLETED'
         WHERE JOB_ID =  v_job_id;

        COMMIT;

        Maxdat_Statistics.TABLE_STATS('CLIENT_PROCESS');

        MERGE /*+ Enable_Parallel_Dml Parallel */
         INTO  EMRS_D_CLIENT_HIST_ELIG D
        USING ( SELECT P.MODIFIED_ON, P.CLIENT_NUMBER, D.DP_CLIENT_ELIG_ID
                  FROM EMRS_D_CLIENT_HIST_ELIG D, CLIENT_PROCESS P
                 WHERE D.CLIENT_NUMBER = P.CLIENT_NUMBER
                   AND P.CODE = 'ELIG'
                   AND D.DP_CLIENT_ELIG_ID != P.PK_ID
                   AND D.RECORD_END_DATE = TO_DATE('12312050','MMDDYYYY')
               ) C ON (D.DP_CLIENT_ELIG_ID = C.DP_CLIENT_ELIG_ID )
         WHEN MATCHED THEN UPDATE
          SET D.RECORD_END_DATE = C.MODIFIED_ON - c_one_sec
            , D.CURRENT_FLAG = 'N'
          Log Errors INTO Errlog_Client ('CLIENT_HIST_ELIG_OLDREC_UPD') Reject Limit Unlimited;

         INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name,driver_key_number)
         SELECT c_critical, con_pkg, 'CAHCO_ETL_PKG.CLIENT_HIST_ELIG_UPD', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_CLIENT_HIST_ELIG', Client_Number
           FROM Errlog_Client
          WHERE Ora_Err_Tag$ IN ('CLIENT_HIST_ELIG_UPD','CLIENT_HIST_ELIG_OLDREC_UPD');

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

           DELETE FROM Errlog_Client WHERE ora_err_tag$ IN ('CLIENT_HIST_ELIG_UPD','CLIENT_HIST_ELIG_OLDREC_UPD');
           DELETE FROM Client_Process WHERE Code = 'ELIG';

           INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
           VALUES (SEQ_JOB_ID.Nextval, 'CLIENT_HIST_ELIG_UPD THREAD'||IDX,'STARTED',SYSDATE)
           RETURNING JOB_ID INTO v_job_id;

           COMMIT;

           INSERT /*+ Enable_Parallel_Dml Parallel */
             INTO Emrs_D_Client_Hist_Elig
                  (client_number, case_number, cin,   addressokflag,   aidcode,   aliencode,   assigninthiscounty,   dob,   hcoclosedate,
                   othhealthcoveragecode,   oldmedicalstatus,   olddentalstaus,   firstname,   middleinitial,   lastname,   eligibilityworkernum,
                   ethniccode,   participantlang,   writtenlangcode,   mcalplnmedsstatus,   dtlmedshcpstatus,   medicalid,   mandatorvolunstatus,
                   mandatorycounty,   denvolstatus,   maximusstatus,   isdualeligible,   isgrandfatherdlelig,   grandfatherdleligplan,   alowedplanfordlelig,
                   medsfilecreationdate,   transmitdate,   pregnancyduedate,   exemptedbydr,   medicalexemption,   exemptionenddate,   dentalexemption,
                   dentalexempenddate,   ccsindicator,   icfindicator,   medicarecarriercode,   medicareindicator,   isnonmeds,   switchtomeds,   switchtomedsdate,
                   medicalpktrequested,   mpacketstatus,   dentalpktrequested,   dpacketstatus,   donotbulkemail,   donotbulkpostalmail,   donotemail,   donotfax,
                   donotphone,   authorizedrepname,   carriertype,   carrier2type,   carrier3type,   cci_status,   cci_maximusoptout,   cci_paceeligible,
                   cci_mltssstatus,   cci_espdstatus,   cci_ignorelisind,   cci_ohcfmandatory,   defaultpathextension,   defaultpathextensionexemptionid,   eaflag,
                   enrlexclind,   esrdind,   expresslanepin,   expresslaneaffirmation,   expresslaneparent,   expresslanestatusmedical,   expresslanestatusdental,
                   hcpstatusprevious,   hcbshighind,   hicn,   institutionalind,   lisind,   mceligstat,   medicarecarrier2code,   medicarecarrier3code,
                   medicarestatusparta,   medicarestatuspartb,   medicarestatuspartd,   optoutind,   passiveenrollment,   sinsiind,   socamt,   subplanind,
                   recordcreatedate,   recordcreatename, namelastmodified, datelastmodified, record_start_Date,   record_end_Date, spdstatus, sex,
                   medicaleligibilityreasonid, dentaleligibilityreasonid, spdeligibilityreasonid, medicarecontractnum, medicareplanid, medicareplanstartdate)

           SELECT
                   s.client_number, s.case_number, s.cin, s.addressokflag, s.aidcode, s.aliencode, s.assigninthiscounty, s.dob, s.hcoclosedate,
                   s.othhealthcoveragecode,  s.oldmedicalstatus,  s.olddentalstaus,  s.firstname,  s.middleinitial,  s.lastname,  s.eligibilityworkernum,
                   s.ethniccode,  s.participantlang,  s.writtenlangcode,  s.mcalplnmedsstatus,  s.dtlmedshcpstatus,  s.medicalid,  s.mandatorvolunstatus,
                   s.mandatorycounty,  s.denvolstatus,  s.maximusstatus,  s.isdualeligible,  s.isgrandfatherdlelig,  s.grandfatherdleligplan, s.alowedplanfordlelig,
                   s.medsfilecreationdate,  s.transmitdate,  s.pregnancyduedate,  s.exemptedbydr,  s.medicalexemption,  s.exemptionenddate,  s.dentalexemption,
                   s.dentalexempenddate,  s.ccsindicator,  s.icfindicator,  s.medicarecarriercode, s.medicareindicator,  s.isnonmeds,  s.switchtomeds,
                   s.switchtomedsdate,  s.medicalpktrequested,  s.mpacketstatus,  s.dentalpktrequested,  s.dpacketstatus,  s.donotbulkemail, s.donotbulkpostalmail,
                   s.donotemail,  s.donotfax,  s.donotphone,  s.authorizedrepname,  s.carriertype,  s.carrier2type,  s.carrier3type, s.cci_status,  s.cci_maximusoptout,
                   s.cci_paceeligible,  s.cci_mltssstatus,  s.cci_espdstatus,  s.cci_ignorelisind,  s.cci_ohcfmandatory,  s.defaultpathextension,  s.defaultpathextensionexemptionid,
                   s.eaflag,  s.enrlexclind,  s.esrdind,  s.expresslanepin,  s.expresslaneaffirmation,  s.expresslaneparent,  s.expresslanestatusmedical,  s.expresslanestatusdental,
                   s.hcpstatusprevious,  s.hcbshighind,  s.hicn,  s.institutionalind,  s.lisind,  s.mceligstat,  s.medicarecarrier2code,  s.medicarecarrier3code,  s.medicarestatusparta,
                   s.medicarestatuspartb,  s.medicarestatuspartd,  s.optoutind,  s.passiveenrollment,  s.sinsiind,  s.socamt,  s.subplanind,  s.recordcreatedate,  s.recordcreatename,
                   s.namelastmodified,
                   case when s.datelastmodified > s.be_modifiedon then s.datelastmodified else s.be_modifiedon end as modifiedon,
                   case when s.datelastmodified > s.be_modifiedon then s.datelastmodified else s.be_modifiedon end as record_start_Date,
                   to_date('12312050','MMDDYYYY') as record_end_Date , s.spdstatus , s.sex, 
                   s.medicaleligibilityreasonid, s.dentaleligibilityreasonid, s.spdeligibilityreasonid, s.medicarecontractnum, s.medicareplanid, s.medicareplanstartdate

              FROM EMRS_D_CLIENT D, EMRS_S_CLIENT_STG S
             WHERE D.CLIENT_NUMBER = S.CLIENT_NUMBER AND S.PARTITIONIDX = IDX
               AND (
                      NVL(d.case_number,-1) != NVL(s.case_number,-1) OR
                      NVL(d.cin,'*') != NVL(s.cin,'*') OR
                      NVL(d.addressokflag,'*') != NVL(s.addressokflag,'*') OR
                      NVL(d.aidcode,'*') != NVL(s.aidcode,'*') OR
                      NVL(d.aliencode,'*') != NVL(s.aliencode,'*') OR
                      NVL(d.assigninthiscounty,'*') != NVL(s.assigninthiscounty,'*') OR
                      NVL(d.dob,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.dob,  to_date('07/07/7777','mm/dd/yyyy')) OR
                      NVL(d.hcoclosedate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.hcoclosedate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                      NVL(d.othhealthcoveragecode,'*') != NVL(s.othhealthcoveragecode,'*') OR
                      NVL(d.oldmedicalstatus,'*') != NVL(s.oldmedicalstatus,'*') OR
                      NVL(d.olddentalstaus,'*') != NVL(s.olddentalstaus,'*') OR
                      NVL(d.firstname,'*') != NVL(s.firstname,'*') OR
                      NVL(d.middleinitial,'*') != NVL(s.middleinitial,'*') OR
                      NVL(d.lastname,'*') != NVL(s.lastname,'*') OR
                      NVL(d.sex,'*') != NVL(s.sex,'*') OR
                      NVL(d.eligibilityworkernum,'*') != NVL(s.eligibilityworkernum,'*') OR
                      NVL(d.ethniccode,'*') != NVL(s.ethniccode,'*') OR
                      NVL(d.participantlang,'*') != NVL(s.participantlang,'*') OR
                      NVL(d.writtenlangcode,'*') != NVL(s.writtenlangcode,'*') OR
                      NVL(d.mcalplnmedsstatus,'*') != NVL(s.mcalplnmedsstatus,'*') OR
                      NVL(d.dtlmedshcpstatus,'*') != NVL(s.dtlmedshcpstatus,'*') OR
                      NVL(d.medicalid,'*') != NVL(s.medicalid,'*') OR
                      NVL(d.mandatorvolunstatus,'*') != NVL(s.mandatorvolunstatus,'*') OR
                      NVL(d.mandatorycounty,'*') != NVL(s.mandatorycounty,'*') OR
                      NVL(d.denvolstatus,'*') != NVL(s.denvolstatus,'*') OR
                      NVL(d.maximusstatus,'*') != NVL(s.maximusstatus,'*') OR
                      NVL(d.isdualeligible,'*') != NVL(s.isdualeligible,'*') OR
                      NVL(d.isgrandfatherdlelig,'*') != NVL(s.isgrandfatherdlelig,'*') OR
                      NVL(d.grandfatherdleligplan,'*') != NVL(s.grandfatherdleligplan,'*') OR
                      NVL(d.alowedplanfordlelig,'*') != NVL(s.alowedplanfordlelig,'*') OR
                      NVL(d.medsfilecreationdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.medsfilecreationdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                      NVL(d.transmitdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.transmitdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                      NVL(d.pregnancyduedate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.pregnancyduedate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                      NVL(d.exemptedbydr,'*') != NVL(s.exemptedbydr,'*') OR
                      NVL(d.medicalexemption,'*') != NVL(s.medicalexemption,'*') OR
                      NVL(d.exemptionenddate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.exemptionenddate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                      NVL(d.dentalexemption,'*') != NVL(s.dentalexemption,'*') OR
                      NVL(d.dentalexempenddate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.dentalexempenddate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                      NVL(d.ccsindicator,'*') != NVL(s.ccsindicator,'*') OR
                      NVL(d.icfindicator,'*') != NVL(s.icfindicator,'*') OR
                      NVL(d.medicarecarriercode,'*') != NVL(s.medicarecarriercode,'*') OR
                      NVL(d.medicareindicator,'*') != NVL(s.medicareindicator,'*') OR
                      NVL(d.isnonmeds,'*') != NVL(s.isnonmeds,'*') OR
                      NVL(d.switchtomeds,'*') != NVL(s.switchtomeds,'*') OR
                      NVL(d.switchtomedsdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.switchtomedsdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                      NVL(d.medicalpktrequested,'*') != NVL(s.medicalpktrequested,'*') OR
                      NVL(d.mpacketstatus,'*') != NVL(s.mpacketstatus,'*') OR
                      NVL(d.dentalpktrequested,'*') != NVL(s.dentalpktrequested,'*') OR
                      NVL(d.dpacketstatus,'*') != NVL(s.dpacketstatus,'*') OR
                      NVL(d.donotbulkemail,'*') != NVL(s.donotbulkemail,'*') OR
                      NVL(d.donotbulkpostalmail,'*') != NVL(s.donotbulkpostalmail,'*') OR
                      NVL(d.donotemail,'*') != NVL(s.donotemail,'*') OR
                      NVL(d.donotfax,'*') != NVL(s.donotfax,'*') OR
                      NVL(d.donotphone,'*') != NVL(s.donotphone,'*') OR
                      NVL(d.authorizedrepname,'*') != NVL(s.authorizedrepname,'*') OR
                      NVL(d.carriertype,'*') != NVL(s.carriertype,'*') OR
                      NVL(d.carrier2type,'*') != NVL(s.carrier2type,'*') OR
                      NVL(d.carrier3type,'*') != NVL(s.carrier3type,'*') OR
                      NVL(d.cci_status,'*') != NVL(s.cci_status,'*') OR
                      NVL(d.cci_maximusoptout,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.cci_maximusoptout,  to_date('07/07/7777','mm/dd/yyyy')) OR
                      NVL(d.cci_paceeligible,'*') != NVL(s.cci_paceeligible,'*') OR
                      NVL(d.cci_mltssstatus,'*') != NVL(s.cci_mltssstatus,'*') OR
                      NVL(d.cci_espdstatus,'*') != NVL(s.cci_espdstatus,'*') OR
                      NVL(d.cci_ignorelisind,'*') != NVL(s.cci_ignorelisind,'*') OR
                      NVL(d.cci_ohcfmandatory,'*') != NVL(s.cci_ohcfmandatory,'*') OR
                      NVL(d.defaultpathextension,'*') != NVL(s.defaultpathextension,'*') OR
                      NVL(d.defaultpathextensionexemptionid,-1) != NVL(s.defaultpathextensionexemptionid,-1) OR
                      NVL(d.eaflag,'*') != NVL(s.eaflag,'*') OR
                      NVL(d.enrlexclind,'*') != NVL(s.enrlexclind,'*') OR
                      NVL(d.esrdind,'*') != NVL(s.esrdind,'*') OR
                      NVL(d.expresslanepin,'*') != NVL(s.expresslanepin,'*') OR
                      NVL(d.expresslaneaffirmation,'*') != NVL(s.expresslaneaffirmation,'*') OR
                      NVL(d.expresslaneparent,'*') != NVL(s.expresslaneparent,'*') OR
                      NVL(d.expresslanestatusmedical,'*') != NVL(s.expresslanestatusmedical,'*') OR
                      NVL(d.expresslanestatusdental,'*') != NVL(s.expresslanestatusdental,'*') OR
                      NVL(d.hcpstatusprevious,'*') != NVL(s.hcpstatusprevious,'*') OR
                      NVL(d.hcbshighind,'*') != NVL(s.hcbshighind,'*') OR
                      NVL(d.hicn,'*') != NVL(s.hicn,'*') OR
                      NVL(d.institutionalind,'*') != NVL(s.institutionalind,'*') OR
                      NVL(d.lisind,'*') != NVL(s.lisind,'*') OR
                      NVL(d.mceligstat,'*') != NVL(s.mceligstat,'*') OR
                      NVL(d.medicarecarrier2code,'*') != NVL(s.medicarecarrier2code,'*') OR
                      NVL(d.medicarecarrier3code,'*') != NVL(s.medicarecarrier3code,'*') OR
                      NVL(d.medicarestatusparta,'*') != NVL(s.medicarestatusparta,'*') OR
                      NVL(d.medicarestatuspartb,'*') != NVL(s.medicarestatuspartb,'*') OR
                      NVL(d.medicarestatuspartd,'*') != NVL(s.medicarestatuspartd,'*') OR
                      NVL(d.optoutind,'*') != NVL(s.optoutind,'*') OR
                      NVL(d.passiveenrollment,'*') != NVL(s.passiveenrollment,'*') OR
                      NVL(d.sinsiind,'*') != NVL(s.sinsiind,'*') OR
                      NVL(d.socamt,'*') != NVL(s.socamt,'*') OR
                      NVL(d.subplanind,'*') != NVL(s.subplanind,'*') OR
                      NVL(d.spdstatus,'*') != NVL(s.spdstatus,'*') OR
                      NVL(d.medicaleligibilityreasonid,-1) != NVL(s.medicaleligibilityreasonid,-1) OR
                      NVL(d.dentaleligibilityreasonid,-1) != NVL(s.dentaleligibilityreasonid,-1) OR
                      NVL(d.spdeligibilityreasonid,-1) != NVL(s.spdeligibilityreasonid,-1) OR
                      NVL(d.medicarecontractnum,'*') != NVL(s.medicarecontractnum,'*') OR
                      NVL(d.medicareplanid,-1) != NVL(s.medicareplanid,-1) OR
                      NVL(d.medicareplanstartdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.medicareplanstartdate,  to_date('07/07/7777','mm/dd/yyyy'))                      
                      )
           Log Errors INTO Errlog_Client ('CLIENT_HIST_ELIG_UPD') Reject Limit Unlimited;

            v_upd_cnt := SQL%RowCount;

            UPDATE CORP_ETL_JOB_STATISTICS
               SET Job_end_date = SYSDATE
                 , RECORD_COUNT = v_upd_cnt
                 , PROCESSED_COUNT = v_upd_cnt
                 , RECORD_UPDATED_COUNT = v_upd_cnt
                 , JOB_STATUS_CD = 'COMPLETED'
             WHERE JOB_ID =  v_job_id;

            COMMIT;

            Maxdat_Statistics.TABLE_STATS('CLIENT_PROCESS');

           MERGE /*+ Enable_Parallel_Dml Parallel */
            INTO  EMRS_D_CLIENT_HIST_ELIG D
           USING ( SELECT P.MODIFIED_ON, P.CLIENT_NUMBER, D.DP_CLIENT_ELIG_ID
                     FROM EMRS_D_CLIENT_HIST_ELIG D, CLIENT_PROCESS P
                    WHERE D.CLIENT_NUMBER = P.CLIENT_NUMBER
                      AND P.CODE = 'ELIG'
                      AND D.DP_CLIENT_ELIG_ID != P.PK_ID
                      AND D.RECORD_END_DATE = TO_DATE('12312050','MMDDYYYY')
                  ) C ON (D.DP_CLIENT_ELIG_ID = C.DP_CLIENT_ELIG_ID )
            WHEN MATCHED THEN UPDATE
             SET D.RECORD_END_DATE = C.MODIFIED_ON - c_one_sec
               , D.CURRENT_FLAG = 'N'
             Log Errors INTO Errlog_Client ('CLIENT_HIST_ELIG_OLDREC_UPD') Reject Limit Unlimited;

            INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name,driver_key_number)
            SELECT c_critical, con_pkg, 'CAHCO_ETL_PKG.CLIENT_HIST_ELIG_UPD', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_CLIENT_HIST_ELIG', Client_Number
              FROM Errlog_Client
             WHERE Ora_Err_Tag$ IN ('CLIENT_HIST_ELIG_UPD','CLIENT_HIST_ELIG_OLDREC_UPD');

            v_err_cnt := SQL%RowCount;

            UPDATE CORP_ETL_JOB_STATISTICS
               SET ERROR_COUNT = v_err_cnt
                 , RECORD_COUNT = v_upd_cnt + v_err_cnt
                 , PROCESSED_COUNT = v_upd_cnt + v_err_cnt
             WHERE JOB_ID =  v_job_id;

            COMMIT;

       END LOOP;

    END IF;

    -- Maxdat_Statistics.TABLE_STATS('EMRS_D_CLIENT_HIST_ELIG');

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, 'CAHCO_ETL_PKG.CLIENT_HIST_ELIG_UPD', 1, v_desc, v_code, 'EMRS_D_CLIENT_HIST_ELIG');

      COMMIT;
END CLIENT_HIST_ELIG_UPD;

PROCEDURE CLIENT_HIST_ENRL_UPD
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
    to_process number := 0;
    Run_Multiple varchar2(1) := 'N';
BEGIN
    SELECT COUNT(1) INTO to_process FROM EMRS_S_CLIENT_STG;

    SELECT CASE WHEN to_process > NVL(Value,1000000)
                THEN 'Y' ELSE 'N' END INTO Run_Multiple
      FROM CORP_ETL_CONTROL WHERE NAME = 'EMRS_REC_THRESHOLD';

    -- Maxdat_Statistics.TABLE_STATS('EMRS_S_CLIENT_STG');
    -- Maxdat_Statistics.TABLE_STATS('EMRS_D_CLIENT');

    IF Run_Multiple = 'N' THEN

       DELETE FROM Errlog_Client WHERE ora_err_tag$ IN ('CLIENT_HIST_ENRL_UPD','CLIENT_HIST_ENRL_OLDREC_UPD');
       DELETE FROM Client_Process WHERE Code = 'ENRL';

       INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
       VALUES (SEQ_JOB_ID.Nextval, 'CLIENT_HIST_ENRL_UPD','STARTED',SYSDATE)
       RETURNING JOB_ID INTO v_job_id;

       COMMIT;

        INSERT /*+ Enable_Parallel_Dml Parallel */
          INTO Emrs_D_Client_Hist_Enrl
               (client_number, case_number, enrollmentstatus,  sendidltrdate,  importdate,  countychangercvddate,  triggerforvolunmails,
                planoflasttrans,  lasttransdate,  lasttransrcvdid,  lasttransenrordisenr,  lasttransaccepted,  lastmedenrlrecid,  lastdisenrlrecid,
                lastdisenroldate,  lastdisenrlaccepted,  lastplanid,  lastenrlopenplanid,  lastplanactivateddate,  lastmcalffstrans,
                dtllasttransid,  dtllastopentrans,  dtlenrlstatus,  lastdentalenrleffdate,  dentalplanactive,  lastdtltranseord,  planoflastdtltrans,
                lastdtlffstrans,  gmccombinedchoice,
                recordcreatedate,   recordcreatename, namelastmodified, datelastmodified, record_start_Date,   record_end_Date)

        SELECT
                s.client_number, s.case_number, s.enrollmentstatus,  s.sendidltrdate,  s.importdate,  s.countychangercvddate,  s.triggerforvolunmails,
                s.planoflasttrans,  s.lasttransdate,  s.lasttransrcvdid,  s.lasttransenrordisenr,  s.lasttransaccepted,  s.lastmedenrlrecid,  s.lastdisenrlrecid,
                s.lastdisenroldate,  s.lastdisenrlaccepted,  s.lastplanid,  s.lastenrlopenplanid,  s.lastplanactivateddate,  s.lastmcalffstrans,
                s.dtllasttransid,  s.dtllastopentrans,  s.dtlenrlstatus,  s.lastdentalenrleffdate,  s.dentalplanactive,  s.lastdtltranseord,  s.planoflastdtltrans,
                s.lastdtlffstrans,  s.gmccombinedchoice, s.recordcreatedate,  s.recordcreatename,  s.namelastmodified,
                case when s.datelastmodified > s.be_modifiedon then s.datelastmodified else s.be_modifiedon end as modifiedon,
                case when s.datelastmodified > s.be_modifiedon then s.datelastmodified else s.be_modifiedon end as record_start_Date,
                to_date('12312050','MMDDYYYY') as record_end_Date

           FROM EMRS_D_CLIENT D, EMRS_S_CLIENT_STG S
          WHERE D.CLIENT_NUMBER = S.CLIENT_NUMBER
            AND (
                  NVL(d.case_number,-1) != NVL(s.case_number,-1) OR
                  NVL(d.enrollmentstatus,'*') != NVL(s.enrollmentstatus,'*') OR
                  NVL(d.sendidltrdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.sendidltrdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                  NVL(d.importdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.importdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                  NVL(d.countychangercvddate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.countychangercvddate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                  NVL(d.triggerforvolunmails,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.triggerforvolunmails,  to_date('07/07/7777','mm/dd/yyyy')) OR
                  NVL(d.planoflasttrans,'*') != NVL(s.planoflasttrans,'*') OR
                  NVL(d.lasttransdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.lasttransdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                  NVL(d.lasttransrcvdid,-1) != NVL(s.lasttransrcvdid,-1) OR
                  NVL(d.lasttransenrordisenr,'*') != NVL(s.lasttransenrordisenr,'*') OR
                  NVL(d.lasttransaccepted,'*') != NVL(s.lasttransaccepted,'*') OR
                  NVL(d.lastmedenrlrecid,-1) != NVL(s.lastmedenrlrecid,-1) OR
                  NVL(d.lastdisenrlrecid,-1) != NVL(s.lastdisenrlrecid,-1) OR
                  NVL(d.lastdisenroldate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.lastdisenroldate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                  NVL(d.lastdisenrlaccepted,'*') != NVL(s.lastdisenrlaccepted,'*') OR
                  NVL(d.lastplanid,'*') != NVL(s.lastplanid,'*') OR
                  NVL(d.lastenrlopenplanid,-1) != NVL(s.lastenrlopenplanid,-1) OR
                  NVL(d.lastplanactivateddate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.lastplanactivateddate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                  NVL(d.lastmcalffstrans,-1) != NVL(s.lastmcalffstrans,-1) OR
                  NVL(d.dtllasttransid,-1) != NVL(s.dtllasttransid,-1) OR
                  NVL(d.dtllastopentrans,-1) != NVL(s.dtllastopentrans,-1) OR
                  NVL(d.dtlenrlstatus,'*') != NVL(s.dtlenrlstatus,'*') OR
                  NVL(d.lastdentalenrleffdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.lastdentalenrleffdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                  NVL(d.dentalplanactive,'*') != NVL(s.dentalplanactive,'*') OR
                  NVL(d.lastdtltranseord,'*') != NVL(s.lastdtltranseord,'*') OR
                  NVL(d.planoflastdtltrans,'*') != NVL(s.planoflastdtltrans,'*') OR
                  NVL(d.lastdtlffstrans,-1) != NVL(s.lastdtlffstrans,-1) OR
                  NVL(d.gmccombinedchoice,'*') != NVL(s.gmccombinedchoice,'*') )
       Log Errors INTO Errlog_Client ('CLIENT_HIST_ENRL_UPD') Reject Limit Unlimited;

        v_upd_cnt := SQL%RowCount;

        UPDATE CORP_ETL_JOB_STATISTICS
           SET Job_end_date = SYSDATE
             , RECORD_COUNT = v_upd_cnt
             , PROCESSED_COUNT = v_upd_cnt
             , RECORD_UPDATED_COUNT = v_upd_cnt
             , JOB_STATUS_CD = 'COMPLETED'
         WHERE JOB_ID =  v_job_id;

        COMMIT;

        Maxdat_Statistics.TABLE_STATS('CLIENT_PROCESS');

         MERGE /*+ Enable_Parallel_Dml Parallel */
          INTO  EMRS_D_CLIENT_HIST_ENRL D
         USING ( SELECT P.MODIFIED_ON, P.CLIENT_NUMBER, D.DP_CLIENT_ENRL_ID
                   FROM EMRS_D_CLIENT_HIST_ENRL D, CLIENT_PROCESS P
                  WHERE D.CLIENT_NUMBER = P.CLIENT_NUMBER
                    AND P.CODE = 'ENRL'
                    AND D.DP_CLIENT_ENRL_ID != P.PK_ID
                    AND D.RECORD_END_DATE = TO_DATE('12312050','MMDDYYYY')
                ) C ON (D.DP_CLIENT_ENRL_ID = C.DP_CLIENT_ENRL_ID )
          WHEN MATCHED THEN UPDATE
           SET D.RECORD_END_DATE = C.MODIFIED_ON - c_one_sec
             , D.CURRENT_FLAG = 'N'
           Log Errors INTO Errlog_Client ('CLIENT_HIST_ENRL_OLDREC_UPD') Reject Limit Unlimited;

        INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name,driver_key_number)
        SELECT c_critical, con_pkg, 'CAHCO_ETL_PKG.CLIENT_HIST_ENRL_UPD', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_CLIENT_HIST_ENRL', Client_Number
          FROM Errlog_Client
         WHERE Ora_Err_Tag$ IN ('CLIENT_HIST_ENRL_UPD','CLIENT_HIST_ENRL_OLDREC_UPD');

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
           DELETE FROM Errlog_Client WHERE ora_err_tag$ IN ('CLIENT_HIST_ENRL_UPD','CLIENT_HIST_ENRL_OLDREC_UPD');
           DELETE FROM Client_Process WHERE Code = 'ENRL';

           INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
           VALUES (SEQ_JOB_ID.Nextval, 'CLIENT_HIST_ENRL_UPD THREAD'||IDX,'STARTED',SYSDATE)
           RETURNING JOB_ID INTO v_job_id;

           COMMIT;

            INSERT /*+ Enable_Parallel_Dml Parallel */
              INTO Emrs_D_Client_Hist_Enrl
                   (client_number, case_number, enrollmentstatus,  sendidltrdate,  importdate,  countychangercvddate,  triggerforvolunmails,
                    planoflasttrans,  lasttransdate,  lasttransrcvdid,  lasttransenrordisenr,  lasttransaccepted,  lastmedenrlrecid,  lastdisenrlrecid,
                    lastdisenroldate,  lastdisenrlaccepted,  lastplanid,  lastenrlopenplanid,  lastplanactivateddate,  lastmcalffstrans,
                    dtllasttransid,  dtllastopentrans,  dtlenrlstatus,  lastdentalenrleffdate,  dentalplanactive,  lastdtltranseord,  planoflastdtltrans,
                    lastdtlffstrans,  gmccombinedchoice,
                    recordcreatedate,   recordcreatename, namelastmodified, datelastmodified, record_start_Date,   record_end_Date)

            SELECT
                    s.client_number, s.case_number, s.enrollmentstatus,  s.sendidltrdate,  s.importdate,  s.countychangercvddate,  s.triggerforvolunmails,
                    s.planoflasttrans,  s.lasttransdate,  s.lasttransrcvdid,  s.lasttransenrordisenr,  s.lasttransaccepted,  s.lastmedenrlrecid,  s.lastdisenrlrecid,
                    s.lastdisenroldate,  s.lastdisenrlaccepted,  s.lastplanid,  s.lastenrlopenplanid,  s.lastplanactivateddate,  s.lastmcalffstrans,
                    s.dtllasttransid,  s.dtllastopentrans,  s.dtlenrlstatus,  s.lastdentalenrleffdate,  s.dentalplanactive,  s.lastdtltranseord,  s.planoflastdtltrans,
                    s.lastdtlffstrans,  s.gmccombinedchoice, s.recordcreatedate,  s.recordcreatename,  s.namelastmodified,
                    case when s.datelastmodified > s.be_modifiedon then s.datelastmodified else s.be_modifiedon end as modifiedon,
                    case when s.datelastmodified > s.be_modifiedon then s.datelastmodified else s.be_modifiedon end as record_start_Date,
                    to_date('12312050','MMDDYYYY') as record_end_Date

               FROM EMRS_D_CLIENT D, EMRS_S_CLIENT_STG S
              WHERE D.CLIENT_NUMBER = S.CLIENT_NUMBER AND S.PARTITIONIDX = IDX
                AND (
                      NVL(d.case_number,-1) != NVL(s.case_number,-1) OR
                      NVL(d.enrollmentstatus,'*') != NVL(s.enrollmentstatus,'*') OR
                      NVL(d.sendidltrdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.sendidltrdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                      NVL(d.importdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.importdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                      NVL(d.countychangercvddate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.countychangercvddate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                      NVL(d.triggerforvolunmails,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.triggerforvolunmails,  to_date('07/07/7777','mm/dd/yyyy')) OR
                      NVL(d.planoflasttrans,'*') != NVL(s.planoflasttrans,'*') OR
                      NVL(d.lasttransdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.lasttransdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                      NVL(d.lasttransrcvdid,-1) != NVL(s.lasttransrcvdid,-1) OR
                      NVL(d.lasttransenrordisenr,'*') != NVL(s.lasttransenrordisenr,'*') OR
                      NVL(d.lasttransaccepted,'*') != NVL(s.lasttransaccepted,'*') OR
                      NVL(d.lastmedenrlrecid,-1) != NVL(s.lastmedenrlrecid,-1) OR
                      NVL(d.lastdisenrlrecid,-1) != NVL(s.lastdisenrlrecid,-1) OR
                      NVL(d.lastdisenroldate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.lastdisenroldate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                      NVL(d.lastdisenrlaccepted,'*') != NVL(s.lastdisenrlaccepted,'*') OR
                      NVL(d.lastplanid,'*') != NVL(s.lastplanid,'*') OR
                      NVL(d.lastenrlopenplanid,-1) != NVL(s.lastenrlopenplanid,-1) OR
                      NVL(d.lastplanactivateddate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.lastplanactivateddate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                      NVL(d.lastmcalffstrans,-1) != NVL(s.lastmcalffstrans,-1) OR
                      NVL(d.dtllasttransid,-1) != NVL(s.dtllasttransid,-1) OR
                      NVL(d.dtllastopentrans,-1) != NVL(s.dtllastopentrans,-1) OR
                      NVL(d.dtlenrlstatus,'*') != NVL(s.dtlenrlstatus,'*') OR
                      NVL(d.lastdentalenrleffdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.lastdentalenrleffdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                      NVL(d.dentalplanactive,'*') != NVL(s.dentalplanactive,'*') OR
                      NVL(d.lastdtltranseord,'*') != NVL(s.lastdtltranseord,'*') OR
                      NVL(d.planoflastdtltrans,'*') != NVL(s.planoflastdtltrans,'*') OR
                      NVL(d.lastdtlffstrans,-1) != NVL(s.lastdtlffstrans,-1) OR
                      NVL(d.gmccombinedchoice,'*') != NVL(s.gmccombinedchoice,'*') )
           Log Errors INTO Errlog_Client ('CLIENT_HIST_ENRL_UPD') Reject Limit Unlimited;

            v_upd_cnt := SQL%RowCount;

            UPDATE CORP_ETL_JOB_STATISTICS
               SET Job_end_date = SYSDATE
                 , RECORD_COUNT = v_upd_cnt
                 , PROCESSED_COUNT = v_upd_cnt
                 , RECORD_UPDATED_COUNT = v_upd_cnt
                 , JOB_STATUS_CD = 'COMPLETED'
             WHERE JOB_ID =  v_job_id;

            COMMIT;

            Maxdat_Statistics.TABLE_STATS('CLIENT_PROCESS');

             MERGE /*+ Enable_Parallel_Dml Parallel */
              INTO  EMRS_D_CLIENT_HIST_ENRL D
             USING ( SELECT P.MODIFIED_ON, P.CLIENT_NUMBER, D.DP_CLIENT_ENRL_ID
                       FROM EMRS_D_CLIENT_HIST_ENRL D, CLIENT_PROCESS P
                      WHERE D.CLIENT_NUMBER = P.CLIENT_NUMBER
                        AND P.CODE = 'ENRL'
                        AND D.DP_CLIENT_ENRL_ID != P.PK_ID
                        AND D.RECORD_END_DATE = TO_DATE('12312050','MMDDYYYY')
                    ) C ON (D.DP_CLIENT_ENRL_ID = C.DP_CLIENT_ENRL_ID )
              WHEN MATCHED THEN UPDATE
               SET D.RECORD_END_DATE = C.MODIFIED_ON - c_one_sec
                 , D.CURRENT_FLAG = 'N'
               Log Errors INTO Errlog_Client ('CLIENT_HIST_ENRL_OLDREC_UPD') Reject Limit Unlimited;

            INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name,driver_key_number)
            SELECT c_critical, con_pkg, 'CAHCO_ETL_PKG.CLIENT_HIST_ENRL_UPD', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_CLIENT_HIST_ENRL', Client_Number
              FROM Errlog_Client
             WHERE Ora_Err_Tag$ IN ('CLIENT_HIST_ENRL_UPD','CLIENT_HIST_ENRL_OLDREC_UPD');

            v_err_cnt := SQL%RowCount;

            UPDATE CORP_ETL_JOB_STATISTICS
               SET ERROR_COUNT = v_err_cnt
                 , RECORD_COUNT = v_upd_cnt + v_err_cnt
                 , PROCESSED_COUNT = v_upd_cnt + v_err_cnt
             WHERE JOB_ID =  v_job_id;

            COMMIT;

       END LOOP;

    END IF;

    -- Maxdat_Statistics.TABLE_STATS('EMRS_D_CLIENT_HIST_ENRL');

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, 'CAHCO_ETL_PKG.CLIENT_HIST_ENRL_UPD', 1, v_desc, v_code, 'EMRS_D_CLIENT_HIST_ENRL');

      COMMIT;
END CLIENT_HIST_ENRL_UPD;

PROCEDURE CLIENT_HIST_EXTN_UPD
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
    to_process number := 0;
    Run_Multiple varchar2(1) := 'N';
BEGIN
    SELECT COUNT(1) INTO to_process FROM EMRS_S_CLIENT_STG;

    SELECT CASE WHEN to_process > NVL(Value,1000000)
                THEN 'Y' ELSE 'N' END INTO Run_Multiple
      FROM CORP_ETL_CONTROL WHERE NAME = 'EMRS_REC_THRESHOLD';

    -- Maxdat_Statistics.TABLE_STATS('EMRS_S_CLIENT_STG');
    -- Maxdat_Statistics.TABLE_STATS('EMRS_D_CLIENT');

    IF Run_Multiple = 'N' THEN

        DELETE FROM Errlog_Client WHERE ora_err_tag$ IN ('CLIENT_HIST_EXTN_UPD','CLIENT_HIST_EXTN_OLDREC_UPD');
        DELETE FROM Client_Process WHERE Code = 'EXTN';

        INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
        VALUES (SEQ_JOB_ID.Nextval, 'CLIENT_HIST_EXTN_UPD','STARTED',SYSDATE)
        RETURNING JOB_ID INTO v_job_id;

        COMMIT;


        INSERT /*+ Enable_Parallel_Dml Parallel */
          INTO Emrs_D_Client_Hist_Extn
               (client_number, case_number, extendeddefaultpathtriggerdate,  aidcodemandatoryexpirationdate,  cmceligibilitydefaultpathresetdate,
                mltsseligibilitydefaultpathresetdate,  denbbmaildate,  medbbmaildate,  medrlmaildate,  denrlmaildate, ialettersentdate,  idlettersentdate,
                dialettersentdate,  didlettersenddate,  didlettersentdate,  mcalmvltrsentdate,  dtlmvltrsentdate,  firstspecialdlmaildate,
                secspecialdlmaildate,  thirdspecialdlmaildate,  ondisenrlpath,  medicalbbasent,  dentalbbasent, dexemplettersenddate,  mexemptlettersenddate,
                campaigncompleted,  mincompletesentdate,  incompletechoiceformcounter,
                recordcreatedate,   recordcreatename, namelastmodified, datelastmodified, record_start_Date,   record_end_Date)

        SELECT
                s.client_number, s.case_number, s.extendeddefaultpathtriggerdate,  s.aidcodemandatoryexpirationdate,  s.cmceligibilitydefaultpathresetdate,
                s.mltsseligibilitydefaultpathresetdate,  s.denbbmaildate,  s.medbbmaildate,  s.medrlmaildate,  s.denrlmaildate, s.ialettersentdate,  s.idlettersentdate,
                s.dialettersentdate,  s.didlettersenddate,  s.didlettersentdate,  s.mcalmvltrsentdate,  s.dtlmvltrsentdate,  s.firstspecialdlmaildate,
                s.secspecialdlmaildate,  s.thirdspecialdlmaildate,  s.ondisenrlpath,  s.medicalbbasent,  s.dentalbbasent, s.dexemplettersenddate,  s.mexemptlettersenddate,
                s.campaigncompleted,  s.mincompletesentdate,  s.incompletechoiceformcounter, s.recordcreatedate,  s.recordcreatename,  s.namelastmodified,
                case when s.datelastmodified > s.be_modifiedon then s.datelastmodified else s.be_modifiedon end as modifiedon,
                case when s.datelastmodified > s.be_modifiedon then s.datelastmodified else s.be_modifiedon end as record_start_Date,
                to_date('12312050','MMDDYYYY') as record_end_Date

           FROM EMRS_D_CLIENT D, EMRS_S_CLIENT_STG S
          WHERE D.CLIENT_NUMBER = S.CLIENT_NUMBER
            AND (
                  NVL(d.case_number,-1) != NVL(s.case_number,-1) OR
                  NVL(d.extendeddefaultpathtriggerdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.extendeddefaultpathtriggerdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                  NVL(d.aidcodemandatoryexpirationdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.aidcodemandatoryexpirationdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                  NVL(d.cmceligibilitydefaultpathresetdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.cmceligibilitydefaultpathresetdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                  NVL(d.mltsseligibilitydefaultpathresetdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.mltsseligibilitydefaultpathresetdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                  NVL(d.denbbmaildate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.denbbmaildate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                  NVL(d.medbbmaildate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.medbbmaildate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                  NVL(d.medrlmaildate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.medrlmaildate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                  NVL(d.denrlmaildate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.denrlmaildate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                  NVL(d.ialettersentdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.ialettersentdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                  NVL(d.idlettersentdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.idlettersentdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                  NVL(d.dialettersentdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.dialettersentdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                  NVL(d.didlettersenddate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.didlettersenddate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                  NVL(d.didlettersentdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.didlettersentdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                  NVL(d.mcalmvltrsentdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.mcalmvltrsentdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                  NVL(d.dtlmvltrsentdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.dtlmvltrsentdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                  NVL(d.firstspecialdlmaildate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.firstspecialdlmaildate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                  NVL(d.secspecialdlmaildate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.secspecialdlmaildate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                  NVL(d.thirdspecialdlmaildate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.thirdspecialdlmaildate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                  NVL(d.ondisenrlpath,'*') != NVL(s.ondisenrlpath,'*') OR
                  NVL(d.medicalbbasent,'*') != NVL(s.medicalbbasent,'*') OR
                  NVL(d.dentalbbasent,'*') != NVL(s.dentalbbasent,'*') OR
                  NVL(d.dexemplettersenddate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.dexemplettersenddate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                  NVL(d.mexemptlettersenddate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.mexemptlettersenddate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                  NVL(d.campaigncompleted,'*') != NVL(s.campaigncompleted,'*') OR
                  NVL(d.mincompletesentdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.mincompletesentdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                  NVL(d.incompletechoiceformcounter,'*') != NVL(s.incompletechoiceformcounter,'*')  )
       Log Errors INTO Errlog_Client ('CLIENT_HIST_EXTN_UPD') Reject Limit Unlimited;

        v_upd_cnt := SQL%RowCount;

        UPDATE CORP_ETL_JOB_STATISTICS
           SET Job_end_date = SYSDATE
             , RECORD_COUNT = v_upd_cnt
             , PROCESSED_COUNT = v_upd_cnt
             , RECORD_UPDATED_COUNT = v_upd_cnt
             , JOB_STATUS_CD = 'COMPLETED'
         WHERE JOB_ID =  v_job_id;

        COMMIT;

        Maxdat_Statistics.TABLE_STATS('CLIENT_PROCESS');

         MERGE /*+ Enable_Parallel_Dml Parallel */
          INTO  EMRS_D_CLIENT_HIST_EXTN D
         USING ( SELECT P.MODIFIED_ON, P.CLIENT_NUMBER, D.DP_CLIENT_EXTN_ID
                   FROM EMRS_D_CLIENT_HIST_EXTN D, CLIENT_PROCESS P
                  WHERE D.CLIENT_NUMBER = P.CLIENT_NUMBER
                    AND P.CODE = 'EXTN'
                    AND D.DP_CLIENT_EXTN_ID != P.PK_ID
                    AND D.RECORD_END_DATE = TO_DATE('12312050','MMDDYYYY')
                ) C ON (D.DP_CLIENT_EXTN_ID = C.DP_CLIENT_EXTN_ID )
          WHEN MATCHED THEN UPDATE
           SET D.RECORD_END_DATE = C.MODIFIED_ON - c_one_sec
             , D.CURRENT_FLAG = 'N'
           Log Errors INTO Errlog_Client ('CLIENT_HIST_EXTN_OLDREC_UPD') Reject Limit Unlimited;

        INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name,driver_key_number)
        SELECT c_critical, con_pkg, 'CAHCO_ETL_PKG.CLIENT_HIST_EXTN_UPD', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_CLIENT_HIST_EXTN', Client_Number
          FROM Errlog_Client
         WHERE Ora_Err_Tag$ IN ('CLIENT_HIST_EXTN_UPD','CLIENT_HIST_EXTN_OLDREC_UPD') ;

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
            DELETE FROM Errlog_Client WHERE ora_err_tag$ IN ('CLIENT_HIST_EXTN_UPD','CLIENT_HIST_EXTN_OLDREC_UPD');
            DELETE FROM Client_Process WHERE Code = 'EXTN';

            INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
            VALUES (SEQ_JOB_ID.Nextval, 'CLIENT_HIST_EXTN_UPD THREAD'||IDX,'STARTED',SYSDATE)
            RETURNING JOB_ID INTO v_job_id;

            COMMIT;

            INSERT /*+ Enable_Parallel_Dml Parallel */
              INTO Emrs_D_Client_Hist_Extn
                   (client_number, case_number, extendeddefaultpathtriggerdate,  aidcodemandatoryexpirationdate,  cmceligibilitydefaultpathresetdate,
                    mltsseligibilitydefaultpathresetdate,  denbbmaildate,  medbbmaildate,  medrlmaildate,  denrlmaildate, ialettersentdate,  idlettersentdate,
                    dialettersentdate,  didlettersenddate,  didlettersentdate,  mcalmvltrsentdate,  dtlmvltrsentdate,  firstspecialdlmaildate,
                    secspecialdlmaildate,  thirdspecialdlmaildate,  ondisenrlpath,  medicalbbasent,  dentalbbasent, dexemplettersenddate,  mexemptlettersenddate,
                    campaigncompleted,  mincompletesentdate,  incompletechoiceformcounter,
                    recordcreatedate,   recordcreatename, namelastmodified, datelastmodified, record_start_Date,   record_end_Date)

            SELECT
                    s.client_number, s.case_number, s.extendeddefaultpathtriggerdate,  s.aidcodemandatoryexpirationdate,  s.cmceligibilitydefaultpathresetdate,
                    s.mltsseligibilitydefaultpathresetdate,  s.denbbmaildate,  s.medbbmaildate,  s.medrlmaildate,  s.denrlmaildate, s.ialettersentdate,  s.idlettersentdate,
                    s.dialettersentdate,  s.didlettersenddate,  s.didlettersentdate,  s.mcalmvltrsentdate,  s.dtlmvltrsentdate,  s.firstspecialdlmaildate,
                    s.secspecialdlmaildate,  s.thirdspecialdlmaildate,  s.ondisenrlpath,  s.medicalbbasent,  s.dentalbbasent, s.dexemplettersenddate,  s.mexemptlettersenddate,
                    s.campaigncompleted,  s.mincompletesentdate,  s.incompletechoiceformcounter, s.recordcreatedate,  s.recordcreatename,  s.namelastmodified,
                    case when s.datelastmodified > s.be_modifiedon then s.datelastmodified else s.be_modifiedon end as modifiedon,
                    case when s.datelastmodified > s.be_modifiedon then s.datelastmodified else s.be_modifiedon end as record_start_Date,
                    to_date('12312050','MMDDYYYY') as record_end_Date

               FROM EMRS_D_CLIENT D, EMRS_S_CLIENT_STG S
              WHERE D.CLIENT_NUMBER = S.CLIENT_NUMBER AND S.PARTITIONIDX = IDX
                AND (
                      NVL(d.case_number,-1) != NVL(s.case_number,-1) OR
                      NVL(d.extendeddefaultpathtriggerdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.extendeddefaultpathtriggerdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                      NVL(d.aidcodemandatoryexpirationdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.aidcodemandatoryexpirationdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                      NVL(d.cmceligibilitydefaultpathresetdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.cmceligibilitydefaultpathresetdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                      NVL(d.mltsseligibilitydefaultpathresetdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.mltsseligibilitydefaultpathresetdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                      NVL(d.denbbmaildate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.denbbmaildate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                      NVL(d.medbbmaildate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.medbbmaildate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                      NVL(d.medrlmaildate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.medrlmaildate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                      NVL(d.denrlmaildate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.denrlmaildate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                      NVL(d.ialettersentdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.ialettersentdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                      NVL(d.idlettersentdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.idlettersentdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                      NVL(d.dialettersentdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.dialettersentdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                      NVL(d.didlettersenddate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.didlettersenddate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                      NVL(d.didlettersentdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.didlettersentdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                      NVL(d.mcalmvltrsentdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.mcalmvltrsentdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                      NVL(d.dtlmvltrsentdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.dtlmvltrsentdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                      NVL(d.firstspecialdlmaildate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.firstspecialdlmaildate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                      NVL(d.secspecialdlmaildate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.secspecialdlmaildate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                      NVL(d.thirdspecialdlmaildate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.thirdspecialdlmaildate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                      NVL(d.ondisenrlpath,'*') != NVL(s.ondisenrlpath,'*') OR
                      NVL(d.medicalbbasent,'*') != NVL(s.medicalbbasent,'*') OR
                      NVL(d.dentalbbasent,'*') != NVL(s.dentalbbasent,'*') OR
                      NVL(d.dexemplettersenddate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.dexemplettersenddate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                      NVL(d.mexemptlettersenddate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.mexemptlettersenddate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                      NVL(d.campaigncompleted,'*') != NVL(s.campaigncompleted,'*') OR
                      NVL(d.mincompletesentdate,  to_date('07/07/7777','mm/dd/yyyy')) != NVL(s.mincompletesentdate,  to_date('07/07/7777','mm/dd/yyyy')) OR
                      NVL(d.incompletechoiceformcounter,'*') != NVL(s.incompletechoiceformcounter,'*')  )
           Log Errors INTO Errlog_Client ('CLIENT_HIST_EXTN_UPD') Reject Limit Unlimited;

            v_upd_cnt := SQL%RowCount;

            UPDATE CORP_ETL_JOB_STATISTICS
               SET Job_end_date = SYSDATE
                 , RECORD_COUNT = v_upd_cnt
                 , PROCESSED_COUNT = v_upd_cnt
                 , RECORD_UPDATED_COUNT = v_upd_cnt
                 , JOB_STATUS_CD = 'COMPLETED'
             WHERE JOB_ID =  v_job_id;

            COMMIT;

            Maxdat_Statistics.TABLE_STATS('CLIENT_PROCESS');

             MERGE /*+ Enable_Parallel_Dml Parallel */
              INTO  EMRS_D_CLIENT_HIST_EXTN D
             USING ( SELECT P.MODIFIED_ON, P.CLIENT_NUMBER, D.DP_CLIENT_EXTN_ID
                       FROM EMRS_D_CLIENT_HIST_EXTN D, CLIENT_PROCESS P
                      WHERE D.CLIENT_NUMBER = P.CLIENT_NUMBER
                        AND P.CODE = 'EXTN'
                        AND D.DP_CLIENT_EXTN_ID != P.PK_ID
                        AND D.RECORD_END_DATE = TO_DATE('12312050','MMDDYYYY')
                    ) C ON (D.DP_CLIENT_EXTN_ID = C.DP_CLIENT_EXTN_ID )
              WHEN MATCHED THEN UPDATE
               SET D.RECORD_END_DATE = C.MODIFIED_ON - c_one_sec
                 , D.CURRENT_FLAG = 'N'
               Log Errors INTO Errlog_Client ('CLIENT_HIST_EXTN_OLDREC_UPD') Reject Limit Unlimited;

            INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name,driver_key_number)
            SELECT c_critical, con_pkg, 'CAHCO_ETL_PKG.CLIENT_HIST_EXTN_UPD', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_CLIENT_HIST_EXTN', Client_Number
              FROM Errlog_Client
             WHERE Ora_Err_Tag$ IN ('CLIENT_HIST_EXTN_UPD','CLIENT_HIST_EXTN_OLDREC_UPD') ;

            v_err_cnt := SQL%RowCount;

            UPDATE CORP_ETL_JOB_STATISTICS
               SET ERROR_COUNT = v_err_cnt
                 , RECORD_COUNT = v_upd_cnt + v_err_cnt
                 , PROCESSED_COUNT = v_upd_cnt + v_err_cnt
             WHERE JOB_ID =  v_job_id;

            COMMIT;

       END LOOP;

    END IF;

    -- Maxdat_Statistics.TABLE_STATS('EMRS_D_CLIENT_HIST_EXTN');

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, 'CAHCO_ETL_PKG.CLIENT_HIST_EXTN_UPD', 1, v_desc, v_code, 'EMRS_D_CLIENT_HIST_EXTN');

      COMMIT;
END CLIENT_HIST_EXTN_UPD;

PROCEDURE OB_CALLS_PRE_LOAD
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_Enrl_cnt number(2);
    v_cntr number := 0;
BEGIN

      INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
      VALUES (SEQ_JOB_ID.Nextval, 'OB_CALLS_PRE_LOAD','STARTED',SYSDATE)
      RETURNING JOB_ID INTO v_job_id;

      COMMIT;

      -- Delete duplicate bene detail with same disposition code
      DELETE FROM HCO_S_OB_TRANSACTIONS_STG
       WHERE ROWID IN ( SELECT rid
                          FROM (SELECT rowid rid, row_number() over (partition by s.ob_call_id, s.dtl_bene, s.disposition_code order by rowid) rn
                                from HCO_S_OB_TRANSACTIONS_STG s )
                         WHERE rn <> 1 );

      COMMIT;

      -- Update Bene Cnt column

      Update HCO_S_OB_TRANSACTIONS_STG m
         set Bene_Cnt = (Select COUNT(distinct dtl_bene) from HCO_S_OB_TRANSACTIONS_STG s where s.ob_call_id = m.ob_call_id)
       Where ob_call_id in ( select ob_call_id
                               from HCO_S_OB_TRANSACTIONS_STG s
                              group by ob_call_id
                             having count(distinct dtl_bene) > 1) ;

      v_upd_cnt := SQL%RowCount;

      COMMIT;

      -- Update Enroll Cnt
      -- even if one detail bene had phone enrollment during call campaign

      For I in ( select ob_call_id, dtl_bene, record_date, modified_date
                   from hco_s_ob_transactions_stg s )
      Loop

           Select count(1) into v_Enrl_cnt from emrs_d_selection_trans t
            where t.client_number = I.dtl_bene
              and Selection_source_code ='Phone'
              and Transaction_type_cd = '1'
              and disregard_trans_ind = 'N'
              and Transaction_Date between I.record_date and I.modified_date ;

           IF v_Enrl_cnt != 0 Then

              v_cntr := v_cntr + 1;

              Update hco_s_ob_transactions_stg set Enroll_cnt = v_Enrl_cnt
               Where ob_call_id = I.ob_call_id;

           End if;

      End loop;

      v_upd_cnt := v_upd_cnt + v_cntr;

      COMMIT;

      -- Rank calls based on disposition

       MERGE /*+ Enable_Parallel_Dml Parallel */
        INTO  HCO_S_OB_TRANSACTIONS_STG O
       USING ( SELECT S.OB_CALL_ID, S.DTL_BENE
                    , ROW_NUMBER() over (partition by ob_call_id order by (case When disposition_desc = 'Call Expired' Then 90
                                                                                When disposition_desc = 'Campaign Expired' Then 91
                                                                                When disposition_desc like 'Cancelled%' Then 92
                                                                                else to_number(disposition_code) end ) ) RN_DTL
                 FROM HCO_S_OB_TRANSACTIONS_STG S
              ) C ON (O.OB_CALL_ID = C.OB_CALL_ID AND O.DTL_BENE = C.DTL_BENE )
        WHEN MATCHED THEN UPDATE
         SET O.RANK_DTL = C.RN_DTL
         Log Errors INTO Errlog_OBCalls ('OB_CALLS_STG_UPD') Reject Limit Unlimited;

      UPDATE CORP_ETL_JOB_STATISTICS
         SET Job_end_date = SYSDATE
           , RECORD_COUNT = v_upd_cnt
           , PROCESSED_COUNT = v_upd_cnt
           , RECORD_UPDATED_COUNT = v_upd_cnt
           , JOB_STATUS_CD = 'COMPLETED'
       WHERE JOB_ID =  v_job_id;

      COMMIT;

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, 'CAHCO_ETL_PKG.OB_CALLS_PRE_LOAD', 1, v_desc, v_code, 'HCO_S_OB_TRANSACTIONS_STG');

      COMMIT;
END OB_CALLS_PRE_LOAD;

PROCEDURE OB_CALLS_INS
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_ins_cnt number;
    v_err_cnt number;
BEGIN

      DELETE FROM Errlog_OBCalls WHERE ora_err_tag$ = 'OB_CALLS_INS';

      INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
      VALUES (SEQ_JOB_ID.Nextval, 'OB_CALLS_INS','STARTED',SYSDATE)
      RETURNING JOB_ID INTO v_job_id;

      Maxdat_Statistics.TABLE_STATS('HCO_S_OB_TRANSACTIONS_STG');

      COMMIT;

      INSERT /*+ Enable_Parallel_Dml Parallel */
        INTO HCO_OB_TRANSACTIONS
            (ob_call_id, ob_call_type, client_number, case_number, case_id, phone_number, call_guid, activity_id,
             agent_name, disposition_date, disposition_code, disposition_desc, first_name, last_name, middle_name,
             sent_to_crm_date, sent_to_csr_date, enroll_cnt, bene_cnt, record_date, modified_date )
      SELECT DISTINCT ob_call_id, ob_call_type, client_number, case_number, case_id, phone_number, call_guid,
             activity_id, agent_name, disposition_date, disposition_code, disposition_desc, first_name, last_name,
             middle_name, sent_to_crm_date, sent_to_csr_date, enroll_cnt, bene_cnt, record_date, modified_date
        FROM HCO_S_OB_TRANSACTIONS_STG s
       WHERE S.RANK_DTL = 1
         AND NOT EXISTS (SELECT 1 FROM HCO_OB_TRANSACTIONS O WHERE O.ob_call_id = S.ob_call_id)
         Log Errors INTO Errlog_OBCalls ('OB_CALLS_INS') Reject Limit Unlimited;

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
      SELECT c_critical, con_pkg, 'CAHCO_ETL_PKG.OB_CALLS_INS', 1, Ora_Err_Mesg$, ora_err_number$, 'HCO_OB_TRANSACTIONS', OB_CALL_ID
        FROM Errlog_OBCalls
       WHERE Ora_Err_Tag$ = 'OB_CALLS_INS';

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
      VALUES( c_critical, con_pkg, 'CAHCO_ETL_PKG.OB_CALLS_INS', 1, v_desc, v_code, 'HCO_OB_TRANSACTIONS');

      COMMIT;
END OB_CALLS_INS;

PROCEDURE OB_CALLS_UPD
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

     DELETE FROM Errlog_OBCalls WHERE ora_err_tag$ = 'OB_CALLS_UPD';

     INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
     VALUES (SEQ_JOB_ID.Nextval, 'OB_CALLS_UPD','STARTED',SYSDATE)
     RETURNING JOB_ID INTO v_job_id;

     COMMIT;

     -- Maxdat_Statistics.TABLE_STATS('HCO_OB_TRANSACTIONS');

     MERGE /*+ Enable_Parallel_Dml Parallel */
      INTO  HCO_OB_TRANSACTIONS O
     USING ( SELECT DISTINCT S.OB_CALL_ID, S.OB_CALL_TYPE, S.CLIENT_NUMBER, S.CASE_NUMBER, S.CASE_ID, S.PHONE_NUMBER,
                    S.CALL_GUID, S.ACTIVITY_ID, S.AGENT_NAME, S.DISPOSITION_DATE, S.DISPOSITION_CODE, S.DISPOSITION_DESC,
                    S.FIRST_NAME, S.LAST_NAME, S.MIDDLE_NAME, S.SENT_TO_CRM_DATE, S.SENT_TO_CSR_DATE, S.ENROLL_CNT,
                    S.BENE_CNT, S.RECORD_DATE, S.MODIFIED_DATE
               FROM HCO_OB_TRANSACTIONS D, HCO_S_OB_TRANSACTIONS_STG S
              WHERE D.OB_CALL_ID = S.OB_CALL_ID AND S.RANK_DTL = 1
                AND ( (NVL(D.OB_CALL_TYPE, '*') != NVL(S.OB_CALL_TYPE, '*')) OR
                      (NVL(D.CLIENT_NUMBER, -1) != NVL(S.CLIENT_NUMBER, -1)) OR
                      (NVL(D.CASE_NUMBER, -1)   != NVL(S.CASE_NUMBER, -1)) OR
                      (NVL(D.CASE_ID, -1)       != NVL(S.CASE_ID, -1)) OR
                      (NVL(D.PHONE_NUMBER, -1)  != NVL(S.PHONE_NUMBER, -1)) OR
                      (NVL(D.CALL_GUID , '*')   != NVL(S.CALL_GUID , '*')) OR
                      (NVL(D.ACTIVITY_ID , '*') != NVL(S.ACTIVITY_ID , '*')) OR
                      (NVL(D.AGENT_NAME , '*')  != NVL(S.AGENT_NAME , '*')) OR
                      (NVL(D.DISPOSITION_DATE ,  TO_DATE('07/07/7777','MM/DD/YYYY')) != NVL(S.DISPOSITION_DATE ,  TO_DATE('07/07/7777','MM/DD/YYYY'))) OR
                      (NVL(D.DISPOSITION_CODE , '*') != NVL(S.DISPOSITION_CODE , '*')) OR
                      (NVL(D.DISPOSITION_DESC , '*') != NVL(S.DISPOSITION_DESC , '*')) OR
                      (NVL(D.FIRST_NAME , '*') != NVL(S.FIRST_NAME , '*')) OR
                      (NVL(D.LAST_NAME , '*') != NVL(S.LAST_NAME , '*')) OR
                      (NVL(D.MIDDLE_NAME , '*')    != NVL(S.MIDDLE_NAME , '*')) OR
                      (NVL(D.SENT_TO_CRM_DATE ,  TO_DATE('07/07/7777','MM/DD/YYYY')) != NVL(S.SENT_TO_CRM_DATE ,  TO_DATE('07/07/7777','MM/DD/YYYY'))) OR
                      (NVL(D.SENT_TO_CSR_DATE ,  TO_DATE('07/07/7777','MM/DD/YYYY')) != NVL(S.SENT_TO_CSR_DATE ,  TO_DATE('07/07/7777','MM/DD/YYYY'))) OR
                      (NVL(D.ENROLL_CNT, -1)  != NVL(S.ENROLL_CNT, -1)) OR
                      (NVL(D.BENE_CNT, -1)    != NVL(S.BENE_CNT, -1)) OR
                      (NVL(D.RECORD_DATE , TO_DATE('07/07/7777','MM/DD/YYYY')) != NVL(S.RECORD_DATE , TO_DATE('07/07/7777','MM/DD/YYYY'))) OR
                      (NVL(D.MODIFIED_DATE , TO_DATE('07/07/7777','MM/DD/YYYY')) != NVL(S.MODIFIED_DATE , TO_DATE('07/07/7777','MM/DD/YYYY'))))
            ) C ON (O.OB_CALL_ID = C.OB_CALL_ID)
      WHEN MATCHED THEN UPDATE
       SET O.OB_CALL_TYPE       = C.OB_CALL_TYPE
         , O.CLIENT_NUMBER     = C.CLIENT_NUMBER
         , O.CASE_NUMBER       = C.CASE_NUMBER
         , O.CASE_ID           = C.CASE_ID
         , O.PHONE_NUMBER       = C.PHONE_NUMBER
         , O.CALL_GUID         = C.CALL_GUID
         , O.ACTIVITY_ID       = C.ACTIVITY_ID
         , O.AGENT_NAME         = C.AGENT_NAME
         , O.DISPOSITION_DATE  = C.DISPOSITION_DATE
         , O.DISPOSITION_CODE  = C.DISPOSITION_CODE
         , O.DISPOSITION_DESC  = C.DISPOSITION_DESC
         , O.FIRST_NAME         = C.FIRST_NAME
         , O.LAST_NAME         = C.LAST_NAME
         , O.MIDDLE_NAME       = C.MIDDLE_NAME
         , O.SENT_TO_CRM_DATE  = C.SENT_TO_CRM_DATE
         , O.SENT_TO_CSR_DATE  = C.SENT_TO_CSR_DATE
         , O.ENROLL_CNT         = C.ENROLL_CNT
         , O.BENE_CNT           = C.BENE_CNT
         , O.RECORD_DATE       = C.RECORD_DATE
         , O.MODIFIED_DATE     = C.MODIFIED_DATE
       Log Errors INTO Errlog_OBCalls ('OB_CALLS_UPD') Reject Limit Unlimited;

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
      SELECT c_critical, con_pkg, 'CAHCO_ETL_PKG.OB_CALLS_UPD', 1, Ora_Err_Mesg$, ora_err_number$, 'HCO_OB_TRANSACTIONS', OB_CALL_ID
        FROM Errlog_OBCalls
       WHERE Ora_Err_Tag$ = 'OB_CALLS_UPD';

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
      VALUES( c_critical, con_pkg, 'CAHCO_ETL_PKG.OB_CALLS_UPD', 1, v_desc, v_code, 'HCO_OB_TRANSACTIONS');

      COMMIT;
END OB_CALLS_UPD;

PROCEDURE IVR_CALLS_PRE_LOAD
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number := 0;
BEGIN

      INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
      VALUES (SEQ_JOB_ID.Nextval, 'IVR_CALLS_PRE_LOAD','STARTED',SYSDATE)
      RETURNING JOB_ID INTO v_job_id;

      COMMIT;

      -- Delete duplicate bene detail
      DELETE FROM HCO_S_IVR_TRANSACTIONS_STG
       WHERE ROWID IN ( SELECT rid
                          FROM (SELECT rowid rid, row_number() over (partition by s.ivr_transaction_id order by s.client_number desc) rn
                                from HCO_S_IVR_TRANSACTIONS_STG s )
                         WHERE rn <> 1 ) ;

      v_upd_cnt := v_upd_cnt + SQL%RowCount;

      COMMIT;

      -- Update Enroll Cnt
      -- even if one detail bene had phone enrollment during call campaign

      Update HCO_S_IVR_TRANSACTIONS_STG m
         set Enroll_Cnt = 1
       Where m.Ivr_transaction_id in ( select Ivr_transaction_id from HCO_S_IVR_TRANSACTIONS_STG s
                                where s.Ivr_transaction_id = m.Ivr_transaction_id
                                  and exists (select 1 from emrs_d_selection_trans t
                                              where t.client_number = s.client_number
                                                and Selection_source_code ='Phone'
                                                and Transaction_type_cd = 1
                                                and disregard_trans_ind = 'N'
                                                and trunc(Transaction_Date) = trunc(m.Request_Date) )) ;

      v_upd_cnt := v_upd_cnt + SQL%RowCount;

      COMMIT;

      UPDATE CORP_ETL_JOB_STATISTICS
         SET Job_end_date = SYSDATE
           , RECORD_COUNT = v_upd_cnt
           , PROCESSED_COUNT = v_upd_cnt
           , RECORD_UPDATED_COUNT = v_upd_cnt
           , JOB_STATUS_CD = 'COMPLETED'
       WHERE JOB_ID =  v_job_id;

      COMMIT;

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, 'CAHCO_ETL_PKG.IVR_CALLS_PRE_LOAD', 1, v_desc, v_code, 'HCO_S_IVR_TRANSACTIONS_STG');

      COMMIT;
END IVR_CALLS_PRE_LOAD;

PROCEDURE IVR_CALLS_INS
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_ins_cnt number;
    v_err_cnt number;
BEGIN

      DELETE FROM Errlog_IVRCalls WHERE ora_err_tag$ = 'IVR_CALLS_INS';

      INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
      VALUES (SEQ_JOB_ID.Nextval, 'IVR_CALLS_INS','STARTED',SYSDATE)
      RETURNING JOB_ID INTO v_job_id;

      COMMIT;

      Maxdat_Statistics.TABLE_STATS('HCO_S_IVR_TRANSACTIONS_STG');

      INSERT /*+ Enable_Parallel_Dml Parallel */
        INTO HCO_IVR_TRANSACTIONS (IVR_Transaction_ID,Client_Number,Request_Date,Response_Date,Call_GUID,Activity_ID,Activity_Date,First_Name,
                                   Last_Name,Middle_Name,Fax_Doc_Type,Fax_Request_Date,Fax_Number,Fax_Mail_ID,Fax_Response_Date,Fax_Time_In_Mins,
                                   Packet_Request_Date,Packet_Mail_ID,Packet_Response_Date,Enroll_Cnt)
      SELECT IVR_Transaction_ID,Client_Number,Request_Date,Response_Date,Call_GUID,Activity_ID,Activity_Date,First_Name,
             Last_Name,Middle_Name,Fax_Doc_Type,Fax_Request_Date,Fax_Number,Fax_Mail_ID,Fax_Response_Date,Fax_Time_In_Mins,
             Packet_Request_Date,Packet_Mail_ID,Packet_Response_Date,Enroll_Cnt
        FROM HCO_S_IVR_TRANSACTIONS_STG s
       WHERE NOT EXISTS (SELECT 1 FROM HCO_IVR_TRANSACTIONS I WHERE I.IVR_Transaction_ID = S.IVR_Transaction_ID)
         Log Errors INTO Errlog_IVRCalls('IVR_CALLS_INS') Reject Limit Unlimited;

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
      SELECT c_critical, con_pkg, 'CAHCO_ETL_PKG.IVR_CALLS_INS', 1, Ora_Err_Mesg$, ora_err_number$, 'HCO_IVR_TRANSACTIONS', IVR_Transaction_ID
        FROM Errlog_IVRCalls
       WHERE Ora_Err_Tag$ = 'IVR_CALLS_INS';

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
      VALUES( c_critical, con_pkg, 'CAHCO_ETL_PKG.IVR_CALLS_INS', 1, v_desc, v_code, 'HCO_IVR_TRANSACTIONS');

      COMMIT;
END IVR_CALLS_INS;

PROCEDURE IVR_CALLS_UPD
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

    DELETE FROM Errlog_IVRCalls WHERE ora_err_tag$ = 'IVR_CALLS_UPD';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'IVR_CALLS_UPD','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;

    COMMIT;

    -- Maxdat_Statistics.TABLE_STATS('HCO_IVR_TRANSACTIONS');

    MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  HCO_IVR_TRANSACTIONS I
    USING (SELECT S.IVR_TRANSACTION_ID, S.CLIENT_NUMBER, S.CALL_GUID, S.ACTIVITY_ID, S.FIRST_NAME
                , S.LAST_NAME, S.MIDDLE_NAME, S.FAX_DOC_TYPE, S.FAX_NUMBER, S.FAX_MAIL_ID, S.FAX_TIME_IN_MINS
                , S.PACKET_MAIL_ID, S.ENROLL_CNT, S.REQUEST_DATE, S.RESPONSE_DATE, S.ACTIVITY_DATE, S.FAX_REQUEST_DATE
                , S.FAX_RESPONSE_DATE, S.PACKET_REQUEST_DATE, S.PACKET_RESPONSE_DATE
             FROM HCO_IVR_TRANSACTIONS D, HCO_S_IVR_TRANSACTIONS_STG S
            WHERE D.IVR_TRANSACTION_ID = S.IVR_TRANSACTION_ID
              AND ( (NVL(S.CLIENT_NUMBER       ,'-1') != NVL(D.CLIENT_NUMBER         ,'-1')) OR
                    (NVL(S.CALL_GUID           ,'-1') != NVL(D.CALL_GUID             ,'-1')) OR
                    (NVL(S.ACTIVITY_ID         ,'-1') != NVL(D.ACTIVITY_ID           ,'-1')) OR
                    (NVL(S.FIRST_NAME          ,'-1') != NVL(D.FIRST_NAME            ,'-1')) OR
                    (NVL(S.LAST_NAME           ,'-1') != NVL(D.LAST_NAME             ,'-1')) OR
                    (NVL(S.MIDDLE_NAME         ,'-1') != NVL(D.MIDDLE_NAME           ,'-1')) OR
                    (NVL(S.FAX_DOC_TYPE        ,'-1') != NVL(D.FAX_DOC_TYPE          ,'-1')) OR
                    (NVL(S.FAX_NUMBER          ,'-1') != NVL(D.FAX_NUMBER            ,'-1')) OR
                    (NVL(S.FAX_MAIL_ID         ,'-1') != NVL(D.FAX_MAIL_ID           ,'-1')) OR
                    (NVL(S.FAX_TIME_IN_MINS    ,'-1') != NVL(D.FAX_TIME_IN_MINS      ,'-1')) OR
                    (NVL(S.PACKET_MAIL_ID      ,'-1') != NVL(D.PACKET_MAIL_ID        ,'-1')) OR
                    (NVL(S.ENROLL_CNT          ,'-1') != NVL(D.ENROLL_CNT            ,'-1')) OR
                    (NVL(S.REQUEST_DATE        ,TO_DATE('07-JUL-7777','DD-MON-YYYY')) != NVL(D.REQUEST_DATE          ,TO_DATE('07-JUL-7777','DD-MON-YYYY'))) OR
                    (NVL(S.RESPONSE_DATE       ,TO_DATE('07-JUL-7777','DD-MON-YYYY')) != NVL(D.RESPONSE_DATE         ,TO_DATE('07-JUL-7777','DD-MON-YYYY'))) OR
                    (NVL(S.ACTIVITY_DATE       ,TO_DATE('07-JUL-7777','DD-MON-YYYY')) != NVL(D.ACTIVITY_DATE         ,TO_DATE('07-JUL-7777','DD-MON-YYYY'))) OR
                    (NVL(S.FAX_REQUEST_DATE    ,TO_DATE('07-JUL-7777','DD-MON-YYYY')) != NVL(D.FAX_REQUEST_DATE      ,TO_DATE('07-JUL-7777','DD-MON-YYYY'))) OR
                    (NVL(S.FAX_RESPONSE_DATE   ,TO_DATE('07-JUL-7777','DD-MON-YYYY')) != NVL(D.FAX_RESPONSE_DATE     ,TO_DATE('07-JUL-7777','DD-MON-YYYY'))) OR
                    (NVL(S.PACKET_REQUEST_DATE ,TO_DATE('07-JUL-7777','DD-MON-YYYY')) != NVL(D.PACKET_REQUEST_DATE   ,TO_DATE('07-JUL-7777','DD-MON-YYYY'))) OR
                    (NVL(S.PACKET_RESPONSE_DATE,TO_DATE('07-JUL-7777','DD-MON-YYYY')) != NVL(D.PACKET_RESPONSE_DATE  ,TO_DATE('07-JUL-7777','DD-MON-YYYY'))))
          ) C ON (I.IVR_TRANSACTION_ID = C.IVR_TRANSACTION_ID)
      WHEN MATCHED THEN UPDATE
       SET I.CLIENT_NUMBER        = C.CLIENT_NUMBER
         , I.CALL_GUID            = C.CALL_GUID
         , I.ACTIVITY_ID          = C.ACTIVITY_ID
         , I.FIRST_NAME           = C.FIRST_NAME
         , I.LAST_NAME            = C.LAST_NAME
         , I.MIDDLE_NAME          = C.MIDDLE_NAME
         , I.FAX_DOC_TYPE         = C.FAX_DOC_TYPE
         , I.FAX_NUMBER           = C.FAX_NUMBER
         , I.FAX_MAIL_ID          = C.FAX_MAIL_ID
         , I.FAX_TIME_IN_MINS     = C.FAX_TIME_IN_MINS
         , I.PACKET_MAIL_ID       = C.PACKET_MAIL_ID
         , I.ENROLL_CNT           = C.ENROLL_CNT
         , I.REQUEST_DATE         = C.REQUEST_DATE
         , I.RESPONSE_DATE        = C.RESPONSE_DATE
         , I.ACTIVITY_DATE        = C.ACTIVITY_DATE
         , I.FAX_REQUEST_DATE     = C.FAX_REQUEST_DATE
         , I.FAX_RESPONSE_DATE    = C.FAX_RESPONSE_DATE
         , I.PACKET_REQUEST_DATE  = C.PACKET_REQUEST_DATE
         , I.PACKET_RESPONSE_DATE = C.PACKET_RESPONSE_DATE
       Log Errors INTO Errlog_IVRCalls ('IVR_CALLS_UPD') Reject Limit Unlimited;

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
    SELECT c_critical, con_pkg, 'CAHCO_ETL_PKG.IVR_CALLS_UPD', 1, Ora_Err_Mesg$, ora_err_number$, 'HCO_IVR_TRANSACTIONS', IVR_Transaction_ID
      FROM Errlog_IVRCalls
     WHERE Ora_Err_Tag$ = 'IVR_CALLS_UPD';

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
      VALUES( c_critical, con_pkg, 'CAHCO_ETL_PKG.IVR_CALLS_UPD', 1, v_desc, v_code, 'HCO_IVR_TRANSACTIONS');

      COMMIT;
 END IVR_CALLS_UPD;

PROCEDURE PROCESS_OB_CALLS
IS
BEGIN

     cahco_etl_pkg.OB_CALLS_PRE_LOAD;
     cahco_etl_pkg.OB_CALLS_INS;
     cahco_etl_pkg.OB_CALLS_UPD;

END PROCESS_OB_CALLS;

PROCEDURE PROCESS_IVR_CALLS
IS
BEGIN

     cahco_etl_pkg.IVR_CALLS_PRE_LOAD;
     cahco_etl_pkg.IVR_CALLS_INS;
     cahco_etl_pkg.IVR_CALLS_UPD;

END PROCESS_IVR_CALLS;

PROCEDURE PROCESS_CRM_INCIDENTS
IS
BEGIN
    Maxdat_Statistics.TABLE_STATS('HCO_S_CRM_INCIDENTS_STG');

    INSERT
      INTO HCO_CRM_INCIDENTS (incidentid , beneficiaryid , subjectid, subjectidname, statecode, activity_id, record_date, modified_date, createdby, createdbyname)
    SELECT incidentid , beneficiaryid , subjectid, subjectidname, statecode, activity_id, record_date, modified_date, createdby, createdbyname
      FROM HCO_S_CRM_INCIDENTS_STG s
     WHERE NOT EXISTS (SELECT 1 FROM HCO_CRM_INCIDENTS I WHERE I.incidentid = S.incidentid and NVL(I.ACTIVITY_ID   ,'-1') = NVL(S.ACTIVITY_ID   ,'-1'));

    COMMIT;

    For I in ( SELECT S.INCIDENTID , S.BENEFICIARYID , S.SUBJECTID, S.SUBJECTIDNAME, S.STATECODE, S.ACTIVITY_ID, S.RECORD_DATE, S.MODIFIED_DATE, S.CREATEDBY, S.CREATEDBYNAME
                 FROM HCO_CRM_INCIDENTS D, HCO_S_CRM_INCIDENTS_STG S
                WHERE D.INCIDENTID = S.INCIDENTID
                  AND ( (NVL(D.BENEFICIARYID ,'-1') != NVL(S.BENEFICIARYID ,'-1')) OR
                        (NVL(D.SUBJECTID     ,'-1') != NVL(S.SUBJECTID     ,'-1')) OR
                        (NVL(D.SUBJECTIDNAME ,'-1') != NVL(S.SUBJECTIDNAME ,'-1')) OR
                        (NVL(D.STATECODE     ,'-1') != NVL(S.STATECODE     ,'-1')) OR
                        (NVL(D.ACTIVITY_ID   ,'-1') != NVL(S.ACTIVITY_ID   ,'-1')) )
             )
    Loop

         UPDATE HCO_CRM_INCIDENTS M
            SET M.BENEFICIARYID	  =  I.BENEFICIARYID
              , M.SUBJECTID    	  =  I.SUBJECTID
              , M.SUBJECTIDNAME	  =  I.SUBJECTIDNAME
              , M.STATECODE    	  =  I.STATECODE
              , M.ACTIVITY_ID  	  =  I.ACTIVITY_ID
              , M.RECORD_DATE  	  =  I.RECORD_DATE
              , M.MODIFIED_DATE	  =  I.MODIFIED_DATE
              , M.CREATEDBY    	  =  I.CREATEDBY
              , M.CREATEDBYNAME	  =  I.CREATEDBYNAME
          WHERE M.INCIDENTID = I.INCIDENTID;


    End Loop;

    COMMIT;

  END PROCESS_CRM_INCIDENTS;

PROCEDURE PROCESS_CRM_ACTIVITY
IS
BEGIN

    Maxdat_Statistics.TABLE_STATS('HCO_S_CRM_ACTIVITY_STG');

    INSERT
      INTO HCO_CRM_ACTIVITY (Activity_id, HCO_Externalid, BeneficiaryID,SubjectIDName, RegardingObjectId, RegardingObjectIdName
                           , RegardingObjectTypeCode, Record_date, Modified_date, CreatedBy, CreatedbyName)
    SELECT Activity_id, HCO_Externalid, BeneficiaryID,SubjectIDName, RegardingObjectId, RegardingObjectIdName, RegardingObjectTypeCode, Record_date, Modified_date,
           CreatedBy, CreatedbyName
      FROM HCO_S_CRM_ACTIVITY_STG S
     WHERE NOT EXISTS (SELECT 1 FROM HCO_CRM_ACTIVITY A WHERE A.Activity_id = S.Activity_id );

    COMMIT;

    For I in ( SELECT S.ACTIVITY_ID, S.BENEFICIARYID, S.HCO_EXTERNALID, S.SUBJECTIDNAME, S.REGARDINGOBJECTID, S.REGARDINGOBJECTIDNAME
                    , S.REGARDINGOBJECTTYPECODE, S.RECORD_DATE, S.MODIFIED_DATE, S.CREATEDBY, S.CREATEDBYNAME
                 FROM HCO_CRM_ACTIVITY D, HCO_S_CRM_ACTIVITY_STG S
                WHERE D.ACTIVITY_ID = S.ACTIVITY_ID
                  AND ( (NVL(D.BENEFICIARYID ,'-1') != NVL(S.BENEFICIARYID ,'-1')) OR
                        (NVL(D.HCO_EXTERNALID ,'-1') != NVL(S.HCO_EXTERNALID     ,'-1')) OR
                        (NVL(D.SUBJECTIDNAME ,'-1') != NVL(S.SUBJECTIDNAME ,'-1')) OR
                        (NVL(D.REGARDINGOBJECTID     ,'-1') != NVL(S.REGARDINGOBJECTID     ,'-1')) OR
                        (NVL(D.REGARDINGOBJECTIDNAME ,'-1') != NVL(S.REGARDINGOBJECTIDNAME     ,'-1')) OR
                        (NVL(D.REGARDINGOBJECTTYPECODE ,'-1') != NVL(S.REGARDINGOBJECTTYPECODE     ,'-1')) )
             )
    Loop

         UPDATE HCO_CRM_ACTIVITY M
            SET M.BENEFICIARYID	  =  I.BENEFICIARYID
              , M.HCO_EXTERNALID  =  I.HCO_EXTERNALID
              , M.SUBJECTIDNAME	  =  I.SUBJECTIDNAME
              , M.REGARDINGOBJECTID    	  = I.REGARDINGOBJECTID
              , M.REGARDINGOBJECTIDNAME  	= I.REGARDINGOBJECTIDNAME
              , M.REGARDINGOBJECTTYPECODE = I.REGARDINGOBJECTTYPECODE
              , M.RECORD_DATE  	  =  I.RECORD_DATE
              , M.MODIFIED_DATE	  =  I.MODIFIED_DATE
              , M.CREATEDBY    	  =  I.CREATEDBY
              , M.CREATEDBYNAME	  =  I.CREATEDBYNAME
          WHERE M.ACTIVITY_ID = I.ACTIVITY_ID;


    End Loop;

    COMMIT;

  END PROCESS_CRM_ACTIVITY;

END;


/


grant execute on CAHCO_ETL_PKG to MAXDAT_READ_ONLY;

alter session set plsql_code_type = interpreted;