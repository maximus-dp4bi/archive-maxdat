CREATE OR REPLACE PACKAGE MI_LETTERS_PKG AS

  SVN_FILE_URL varchar2(200) := '$URL: svn://svn-staging.maximus.com/dev1d/maxdat/BPM/MIEB/createdb_etl_version/Letters/create_mi_letters_pkg.sql $';
  SVN_REVISION varchar2(20) := '$Revision: 17631 $';
  SVN_REVISION_DATE varchar2(60) := '$Date: 2020-12-03 $';
  SVN_REVISION_AUTHOR varchar2(20) := '$Author: sr18956 $';

  PROCEDURE INS_ERROR_LOG(P_JOB_NAME IN VARCHAR2, P_ERROR_CODE IN VARCHAR2, P_ERROR_MSG IN VARCHAR2, P_TABLE_NAME IN VARCHAR2, P_TABLE_ID IN VARCHAR2);
  PROCEDURE PROC_MATCH_CON_LETTER;
  PROCEDURE UPD_CHECKSUM_STG;
  PROCEDURE INS_LETTER_REQUEST;
  PROCEDURE UPD_LETTER_REQUEST;
  PROCEDURE LETTERS_IU;
  PROCEDURE INS_MATERIAL_REQUEST;
  PROCEDURE UPD_MATERIAL_REQUEST;

END;
/
grant execute on MI_LETTERS_PKG to MAXDAT_MITRAN_OLTP_SIUD;
grant execute on MI_LETTERS_PKG to MAXDAT_MIEB_PFP_E;


CREATE OR REPLACE PACKAGE BODY MI_LETTERS_PKG aS


PROCEDURE INS_ERROR_LOG(P_JOB_NAME IN VARCHAR2, P_ERROR_CODE IN VARCHAR2, P_ERROR_MSG IN VARCHAR2, P_TABLE_NAME IN VARCHAR2, P_TABLE_ID in varchar2) IS
  BEGIN
        INSERT INTO  CORP_ETL_ERROR_LOG(ERR_DATE
          ,ERR_LEVEL
          ,PROCESS_NAME
          ,JOB_NAME
          ,NR_OF_ERROR
          ,ERROR_DESC
          ,ERROR_CODES
          ,DRIVER_TABLE_NAME
          ,DRIVER_KEY_NUMBER
      ) VALUES (
          SYSDATE
          , 'CRITICAL'
          , 'MI_LETTERS_PKG'
          , P_JOB_NAME
          , 1
          , P_ERROR_MSG
          , P_ERROR_CODE
          , P_TABLE_NAME
          , P_TABLE_ID
      );
  EXCEPTION WHEN OTHERS THEN
  DECLARE
    V_CODE VARCHAR2(30);
    V_ERROR VARCHAR2(200);
  BEGIN
      V_CODE := SQLCODE;
      V_ERROR := SUBSTR(SQLERRM,1,200);
            INSERT INTO  CORP_ETL_ERROR_LOG(ERR_DATE
          ,ERR_LEVEL
          ,PROCESS_NAME
          ,JOB_NAME
          ,NR_OF_ERROR
          ,ERROR_DESC
          ,ERROR_CODES
          ,DRIVER_TABLE_NAME
          ,DRIVER_KEY_NUMBER
      ) VALUES (
          SYSDATE
          , 'CRITICAL'
          , 'MI_LETTERS_PKG'
          , 'INS_ERROR_LOG'
          , 1
          , SUBSTR(V_ERROR,1,200)
          , V_CODE
          , NULL
          , NULL
      );
  END;
  END;


PROCEDURE PROC_MATCH_CON_LETTER
IS
TYPE TCONTable IS TABLE OF ETL_INIT_MIHC_CON%ROWTYPE
     INDEX BY BINARY_INTEGER;
CONTAB_EMPTY TCONTABLE;

CONTABUpd TCONTable;

P_JOB_CTRL_ID NUMBER;
v_exists number := 0;

CURSOR c_data IS
SELECT * FROM ETL_INIT_MIHC_CON WHERE LETTER_REQ_ID >= (SELECT to_number(value) from corp_etl_control where name = 'MIN_MATCH_REQUEST_ID');

BEGIN

  select count(1)
  into v_exists
  from mi_job_ctrl
  where job_name = 'MATCH_CON_LETTER'
  and status in ('PEND','WORK');

  if v_exists = 0
    then

  BEGIN
  INSERT INTO MI_JOB_CTRL (JOB_NAME, STATUS, status_dt) VALUES ('MATCH_CON_LETTER', 'WORK', sysdate) RETURNING JOB_CTRL_ID INTO P_JOB_CTRL_ID;

  BEGIN
    OPEN c_data;
    LOOP
      CONTABUPD := CONTAB_EMPTY;
      FETCH c_data
      BULK COLLECT INTO CONTABUpd LIMIT 10000;

      BEGIN
        FORALL x in CONTABUpd.First..CONTABUpd.Last SAVE EXCEPTIONS
       UPDATE D_LETTER_REQUEST LR SET
         CON_FILE_NAME    = null 
        ,CON_FILE_CREATION_DATE    = CONTABUPD(X).process_ts    
        ,CON_FILE_LOAD_DATE  = CONTABUPD(X).process_ts    
        ,CON_CARD_REQUEST_FILE_NAME      = NULL
        ,CON_RECIPIENT_FIRST_NAME    = null --CONTABUPD(X).clnt_fname    
        ,CON_RECIPIENT_LAST_NAME   = null --CONTABUPD(X).clnt_lname    
        ,CON_RECIPIENT_MI    = null --CONTABUPD(X).clnt_mname    
        ,CON_ATTENTION_LINE    = CONTABUPD(X).attention_line
        ,CON_STREET_ADDRESS    = null --trim(CONTABUPD(X).house_no || ', ' || nvl(CONTABUPD(X).street1,' '))
        ,CON_CITY    = null --CONTABUPD(X).city          
        ,CON_STATE   = null --CONTABUPD(X).state         
        ,CON_ZIP_CODE    = null --CONTABUPD(X).zip           
        ,CON_STATUS_CODE   = CONTABUPD(X).status_code   
        ,CON_UPDATE_CODE   = CONTABUPD(X).update_code   
        ,CON_CASE_ID   = null --CONTABUPD(X).case_cin      
        ,CON_MAILING_DATE    = CONTABUPD(X).mail_ts       
        ,CON_CONTROL_NUMBER    = CONTABUPD(X).control_num   
        ,CON_RECIPIENT_ID    = null --CONTABUPD(X).recipient_id  
        ,CON_MI_CARD_ID    = CONTABUPD(X).micrd_id      
        ,CON_JOB_CTRL_ID   = CONTABUPD(X).job_ctrl_id   
        ,CON_SOURCE_JOB_ID   = CONTABUPD(X).job_id        
        ,CON_SOURCE_ROW_NUM  = CONTABUPD(X).row_num       
        ,CON_ERROR_COUNT   = CONTABUPD(X).error_count   
        ,CON_ERROR_TEXT    = CONTABUPD(X).error_text    
        ,CON_ERROR_FIELDS    = CONTABUPD(X).error_fields  
        ,CON_LETTER_REQ_ID   = CONTABUPD(X).letter_req_id 
        ,PROGRAM_CON_XWALK_CODE = (SELECT SC.PROGRAM_CON_xWALK_CODE FROM D_SUBPROGRAM_CON_XWALK SC WHERE SC.LMDEF_ID = LR.LMDEF_ID AND SC.CON_STATUS_CODE = CONTABUPD(X).status_code AND SC.CON_UPDATE_CODE = CONTABUPD(X).update_code AND SYSDATE BETWEEN SC.EFFECTIVE_DATE AND SC.END_DATE AND ROWNUM = 1)
       WHERE LETTER_REQUEST_ID = CONTABUPD(X).LETTER_REQ_ID;
  EXCEPTION
     WHEN OTHERS
     THEN
     FOR indx IN 1 .. SQL%BULK_EXCEPTIONS.COUNT
     LOOP
          DECLARE
          V_CODE VARCHAR2(30);
          V_ERROR VARCHAR2(200);
          V_ID    NUMBER;
          BEGIN
          V_CODE := SQL%BULK_EXCEPTIONS (indx).ERROR_CODE;
          V_ERROR := SUBSTR(SQLERRM(V_CODE),1,200);
          V_ID := SQL%BULK_EXCEPTIONS(INDX).ERROR_INDEX;
          INS_ERROR_LOG(p_job_name=>'MATCH_CON_LETTER',P_ERROR_MSG=> V_ERROR, P_ERROR_CODE =>V_CODE
                      , P_TABLE_NAME=>'ETL_INIT_MIHC_CON', P_TABLE_ID=> CONTABUpd(V_ID).LETTER_REQ_ID);
          END;
     END LOOP;
  END;
      commit;
      EXIT WHEN c_data%NOTFOUND;
    END LOOP;
    CLOSE c_data;
  END;

  UPDATE MI_JOB_CTRL SET STATUS = 'DONE' WHERE JOB_CTRL_ID = P_JOB_CTRL_ID;
  commit;

  EXCEPTION WHEN OTHERS THEN
      DECLARE
        V_CODE VARCHAR2(30);
        V_ERROR VARCHAR2(200);
      BEGIN
      V_CODE := SQLCODE;
      V_ERROR := SUBSTR(SQLERRM,1,200);
          INS_ERROR_LOG(p_job_name=>'MATCH_CON_LETTER',P_ERROR_MSG=> V_ERROR, P_ERROR_CODE =>V_CODE
                      , P_TABLE_NAME=>'MI_JOB_CTRL', P_TABLE_ID=> P_JOB_CTRL_ID);

        UPDATE MI_JOB_CTRL SET STATUS = 'ERROR' WHERE JOB_CTRL_ID = P_JOB_CTRL_ID;
        COMMIT;
        end;
  END;
  else

      INS_ERROR_LOG(p_job_name=>'MATCH_CON_LETTER',P_ERROR_MSG=> 'Job with PEND/WORK status already exists', P_ERROR_CODE =>'TOP001'
                  , P_TABLE_NAME=>'MI_JOB_CTRL', P_TABLE_ID=> '0');
    commit;
  end if;

END;

PROCEDURE UPD_CHECKSUM_sTG IS

P_JOB_CTRL_ID NUMBER;
v_exists number := 0;

CURSOR c_data IS
SELECT lmreq_id, ora_hash(lmreq_id
 || ',' || case_id
 || ',' || lmdef_id
 || ',' || TO_CHAR(requested_on,'YYYYMMDD')
 || ',' || request_type
 || ',' || produced_by
 || ',' || language_cd
 || ',' || driver_type
 || ',' || status_cd
 || ',' || rep_lmreq_id
 || ',' ||   TO_CHAR(sent_on,'YYYYMMDD')
 || ',' || created_by
 || ',' ||   TO_CHAR(create_ts,'YYYYMMDD')
 || ',' || updated_by
 || ',' ||   TO_CHAR(update_ts,'YYYYMMDD')
 || ',' ||   TO_CHAR(printed_on,'YYYYMMDD')
 || ',' || staff_id_printed_by
 || ',' || note_refid
 || ',' ||   TO_CHAR(return_date,'YYYYMMDD')
 || ',' || return_reason_cd
 || ',' || parent_lmreq_id
 || ',' || reprint_parent_lmreq_id
 || ',' || lmact_cd
 || ',' || ldis_cd
 || ',' || authorized_lmreq_id
 || ',' || error_codes
 || ',' || nmbr_requested
 || ',' || program_type_cd
 || ',' || material_request_id
 || ',' || mailing_address_id
 || ',' ||   TO_CHAR(response_due_date,'YYYYMMDD')
 || ',' ||   TO_CHAR(mailed_date,'YYYYMMDD')
 || ',' || reject_reason_cd
 || ',' || status_err_src
 || ',' || letter_out_generation_num
 || ',' || portal_view_ind
 || ',' || is_digital_ind
 ) orahash_checksum
 FROM S_LETTER_REQUEST_STG;

TYPE TCHECKTable IS TABLE OF C_DATA%ROWTYPE;
CHECKTAB_EMPTY TCHECKTABLE;

CHECKTABUpd TCHECKTable;
V_REC_COUNT NUMBER := 0;
V_ERR_COUNT NUMBER := 0;
BEGIN

  select count(1)
  into v_exists
  from mi_job_ctrl
  where job_name = 'UPDATE_CHECKSUM_STG'
  and status in ('PEND','WORK');

  if v_exists = 0
    then

  BEGIN
  INSERT INTO MI_JOB_CTRL (JOB_NAME) VALUES ('UPDATE_CHECKSUM_STG') RETURNING JOB_CTRL_ID INTO P_JOB_CTRL_ID;

  BEGIN
    OPEN c_data;
    LOOP
      CHECKTABUPD := CHECKTAB_EMPTY;
      FETCH c_data
      BULK COLLECT INTO CHECKTABUpd LIMIT 10000;
      V_REC_COUNT := V_REC_COUNT + CHECKTABUPD.COUNT;

      BEGIN
        FORALL x in CHECKTABUpd.First..CHECKTABUpd.Last SAVE EXCEPTIONS
       UPDATE S_LETTER_REQUEST_STG STG SET
       CHECKSUM = CHECKTABUPD(X).ORAHASH_CHECKSUM
       WHERE LMREQ_ID = CHECKTABUPD(X).LMREQ_ID;

  EXCEPTION
     WHEN OTHERS
     THEN
       V_ERR_COUNT := V_ERR_COUNT + SQL%BULK_EXCEPTIONS.COUNT;
     FOR indx IN 1 .. SQL%BULK_EXCEPTIONS.COUNT
     LOOP
          DECLARE
          V_CODE VARCHAR2(30);
          V_ERROR VARCHAR2(200);
          V_ID    NUMBER;
          BEGIN
          V_CODE := SQL%BULK_EXCEPTIONS (indx).ERROR_CODE;
          V_ERROR := SUBSTR(SQLERRM(V_CODE),1,200);
          V_ID := SQL%BULK_EXCEPTIONS(INDX).ERROR_INDEX;
          INS_ERROR_LOG(p_job_name=>'UPDATE_CHECKSUM_STG',P_ERROR_MSG=> V_ERROR, P_ERROR_CODE =>V_CODE
                      , P_TABLE_NAME=>'S_LETTER_REQUEST_STG', P_TABLE_ID=> CHECKTABUpd(V_ID).LMREQ_ID);
          END;
     END LOOP;
  END;
      commit;
      EXIT WHEN c_data%NOTFOUND;
    END LOOP;
    CLOSE c_data;
  END;

  UPDATE MI_JOB_CTRL SET STATUS = 'DONE' , STAT_COMMENT = 'RECCOUNT = ' || V_REC_COUNT || ' ;ERRCOUNT = ' || V_ERR_COUNT WHERE JOB_CTRL_ID = P_JOB_CTRL_ID;
  commit;

  EXCEPTION WHEN OTHERS THEN
      DECLARE
        V_CODE VARCHAR2(30);
        V_ERROR VARCHAR2(200);
      BEGIN
      V_CODE := SQLCODE;
      V_ERROR := SUBSTR(SQLERRM,1,200);
          INS_ERROR_LOG(p_job_name=>'UPDATE_CHECKSUM_STG',P_ERROR_MSG=> V_ERROR, P_ERROR_CODE =>V_CODE
                      , P_TABLE_NAME=>'MI_JOB_CTRL', P_TABLE_ID=> P_JOB_CTRL_ID);
        UPDATE MI_JOB_CTRL SET STATUS = 'ERROR', STAT_COMMENT = 'RECCOUNT = ' || V_REC_COUNT || ' ;ERRCOUNT = ' || V_ERR_COUNT WHERE JOB_CTRL_ID = P_JOB_CTRL_ID;
        COMMIT;
        end;
  END;
  else

      INS_ERROR_LOG(p_job_name=>'UPDATE_CHECKSUM_STG',P_ERROR_MSG=> 'Job with PEND/WORK status already exists', P_ERROR_CODE =>'TOP001'
                  , P_TABLE_NAME=>'MI_JOB_CTRL', P_TABLE_ID=> '0');
    commit;
  end if;

  END;


PROCEDURE INS_LETTER_REQUEST IS

P_JOB_CTRL_ID NUMBER;
v_exists number := 0;

CURSOR c_data IS
SELECT S.*, etl_common.GET_BUS_DATE(s.sent_on,0) sent_next_bus_date FROM S_LETTER_REQUEST_STG S
LEFT JOIN D_LETTER_REQUEST LMREQ ON LMREQ.LETTER_REQUEST_ID = S.LMREQ_ID
JOIN D_LETTER_DEFINITION LMDEF ON LMDEF.LMDEF_ID = S.LMDEF_ID AND LMDEF.NAME <> 'XX'
WHERE LMREQ.LETTER_REQUEST_ID IS NULL

;

TYPE TLTRTable IS TABLE OF C_DATA%ROWTYPE;
LTRTAB_EMPTY TLTRTABLE;

LTRTABUpd TLTRTable;
V_REC_COUNT NUMBER := 0;
V_ERR_COUNT NUMBER := 0;

BEGIN

  select count(1)
  into v_exists
  from mi_job_ctrl
  where job_name = 'INS_LETTER_REQUEST'
  and status in ('PEND','WORK');

  if v_exists = 0
    then

  BEGIN
  INSERT INTO MI_JOB_CTRL (JOB_NAME) VALUES ('INS_LETTER_REQUEST') RETURNING JOB_CTRL_ID INTO P_JOB_CTRL_ID;

  BEGIN
    OPEN c_data;
    LOOP
      LTRTABUPD := LTRTAB_EMPTY;
      FETCH c_data
      BULK COLLECT INTO LTRTABUpd LIMIT 10000;
      V_REC_COUNT := V_REC_COUNT + LTRTABUPD.COUNT;

      BEGIN
        FORALL x in LTRTABUpd.First..LTRTABUpd.Last SAVE EXCEPTIONS
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
                is_digital_ind,
                stg_checksum,
                sent_next_bus_date)
        values (LTRTABUpd(X).lmreq_id,
                LTRTABUpd(X).case_id,
                LTRTABUpd(X).lmdef_id,
                LTRTABUpd(X).requested_on,
                LTRTABUpd(X).request_type,
                LTRTABUpd(X).produced_by,
                LTRTABUpd(X).language_cd,
                LTRTABUpd(X).driver_type,
                LTRTABUpd(X).status_cd,
                LTRTABUpd(X).rep_lmreq_id,
                LTRTABUpd(X).sent_on,
                LTRTABUpd(X).created_by,
                LTRTABUpd(X).create_ts,
                LTRTABUpd(X).updated_by,
                LTRTABUpd(X).update_ts,
                LTRTABUpd(X).printed_on,
                LTRTABUpd(X).staff_id_printed_by,
                LTRTABUpd(X).note_refid,
                LTRTABUpd(X).return_date,
                LTRTABUpd(X).return_reason_cd,
                LTRTABUpd(X).parent_lmreq_id,
                LTRTABUpd(X).reprint_parent_lmreq_id,
                LTRTABUpd(X).lmact_cd,
                LTRTABUpd(X).ldis_cd,
                LTRTABUpd(X).authorized_lmreq_id,
                LTRTABUpd(X).error_codes,
                LTRTABUpd(X).nmbr_requested,
                LTRTABUpd(X).program_type_cd,
                LTRTABUpd(X).material_request_id,
                LTRTABUpd(X).mailing_address_id,
                LTRTABUpd(X).response_due_date,
                LTRTABUpd(X).mailed_date,
                LTRTABUpd(X).reject_reason_cd,
                LTRTABUpd(X).status_err_src,
                LTRTABUpd(X).letter_out_generation_num,
                LTRTABUpd(X).portal_view_ind,
                LTRTABUpd(X).is_digital_ind,
                LTRTABUpd(X).checksum
                ,LTRTABUpd(X).sent_next_bus_Date
                );
  EXCEPTION
     WHEN OTHERS
     THEN
       V_ERR_COUNT := V_ERR_COUNT + SQL%BULK_EXCEPTIONS.COUNT;
     FOR J IN 1 .. SQL%BULK_EXCEPTIONS.COUNT
     LOOP
          DECLARE
          V_CODE VARCHAR2(30);
          V_ERROR VARCHAR2(200);
          V_ID    NUMBER;
          BEGIN
          V_CODE := SQL%BULK_EXCEPTIONS (J).ERROR_CODE;
          V_ERROR := SUBSTR(SQLERRM('-' || V_CODE),1,200);
          V_ID := SQL%BULK_EXCEPTIONS(J).ERROR_INDEX;
          INS_ERROR_LOG(p_job_name=>'INS_LETTER_REQUEST',P_ERROR_MSG=> V_ERROR, P_ERROR_CODE =>V_CODE
                      , P_TABLE_NAME=>'S_LETTER_REQUEST_STG', P_TABLE_ID=> LTRTABUpd(V_ID).LMREQ_ID);
          END;
     END LOOP;
  END;
      commit;
      EXIT WHEN c_data%NOTFOUND;
    END LOOP;
    CLOSE c_data;
  END;

  UPDATE MI_JOB_CTRL SET STATUS = 'DONE', STAT_COMMENT = 'RECCOUNT = ' || V_REC_COUNT || ' ;ERRCOUNT = ' || V_ERR_COUNT WHERE JOB_CTRL_ID = P_JOB_CTRL_ID;
  commit;

  EXCEPTION WHEN OTHERS THEN
      DECLARE
        V_CODE VARCHAR2(30);
        V_ERROR VARCHAR2(200);
      BEGIN
      V_CODE := SQLCODE;
      V_ERROR := SUBSTR(SQLERRM,1,200);
          INS_ERROR_LOG(p_job_name=>'INS_LETTER_REQUEST',P_ERROR_MSG=> V_ERROR, P_ERROR_CODE =>V_CODE
                      , P_TABLE_NAME=>'MI_JOB_CTRL', P_TABLE_ID=> P_JOB_CTRL_ID);
        UPDATE MI_JOB_CTRL SET STATUS = 'ERROR', STAT_COMMENT = 'RECCOUNT = ' || V_REC_COUNT || ' ;ERRCOUNT = ' || V_ERR_COUNT WHERE JOB_CTRL_ID = P_JOB_CTRL_ID;
        COMMIT;
        end; 
  END;
  else

      INS_ERROR_LOG(p_job_name=>'INS_LETTER_REQUEST',P_ERROR_MSG=> 'Job with PEND/WORK status already exists', P_ERROR_CODE =>'TOP001'
                  , P_TABLE_NAME=>'MI_JOB_CTRL', P_TABLE_ID=> '0');
    commit;
  end if;

  END;

PROCEDURE UPD_LETTER_REQUEST IS

P_JOB_CTRL_ID NUMBER;
v_exists number := 0;

CURSOR c_data IS
SELECT S.*, etl_common.get_bus_Date(s.sent_on,0) sent_next_bus_date FROM S_LETTER_REQUEST_STG S
JOIN D_LETTER_REQUEST LMREQ ON LMREQ.LETTER_REQUEST_ID = S.LMREQ_ID
JOIN D_LETTER_DEFINITION LMDEF ON LMDEF.LMDEF_ID = S.LMDEF_ID AND LMDEF.NAME <> 'XX'
WHERE LMREQ.STG_CHECKSUM <> S.CHECKSUM;


TYPE TLTRTable IS TABLE OF C_DATA%ROWTYPE;
LTRTAB_EMPTY TLTRTABLE;

LTRTABUpd TLTRTable;

V_REC_COUNT NUMBER := 0;
V_ERR_COUNT NUMBER := 0;

BEGIN

  select count(1)
  into v_exists
  from mi_job_ctrl
  where job_name = 'UPD_LETTER_REQUEST'
  and status in ('PEND','WORK');

  if v_exists = 0
    then

  BEGIN
  INSERT INTO MI_JOB_CTRL (JOB_NAME) VALUES ('UPD_LETTER_REQUEST') RETURNING JOB_CTRL_ID INTO P_JOB_CTRL_ID;

  BEGIN
    OPEN c_data;
    LOOP
      LTRTABUPD := LTRTAB_EMPTY;
      FETCH c_data
      BULK COLLECT INTO LTRTABUpd LIMIT 10000;
      V_REC_COUNT := V_REC_COUNT + LTRTABUPD.COUNT;

      BEGIN
        FORALL x in LTRTABUpd.First..LTRTABUpd.Last SAVE EXCEPTIONS
            UPDATE /*+ Enable_Parallel_Dml Parallel */ D_LETTER_REQUEST SET
                   case_id                  =   LTRTABUpd(X).case_id
                ,  lmdef_id                 =   LTRTABUpd(X).lmdef_id
                ,  requested_on                 =   LTRTABUpd(X).requested_on
                ,  request_type                 =   LTRTABUpd(X).request_type
                ,  produced_by                  =   LTRTABUpd(X).produced_by
                ,  language_cd                  =   LTRTABUpd(X).language_cd
                ,  driver_type                  =   LTRTABUpd(X).driver_type
                ,  status_cd                  =   LTRTABUpd(X).status_cd
                ,  rep_lmreq_id                 =   LTRTABUpd(X).rep_lmreq_id
                ,  sent_on                  =   LTRTABUpd(X).sent_on
                ,  created_by                 =   LTRTABUpd(X).created_by
                ,  create_ts                  =   LTRTABUpd(X).create_ts
                ,  updated_by                 =   LTRTABUpd(X).updated_by
                ,  update_ts                  =   LTRTABUpd(X).update_ts
                ,  printed_on                 =   LTRTABUpd(X).printed_on
                ,  staff_id_printed_by                  =   LTRTABUpd(X).staff_id_printed_by
                ,  note_refid                 =   LTRTABUpd(X).note_refid
                ,  return_date                  =   LTRTABUpd(X).return_date
                ,  return_reason_cd                 =   LTRTABUpd(X).return_reason_cd
                ,  parent_lmreq_id                  =   LTRTABUpd(X).parent_lmreq_id
                ,  reprint_parent_lmreq_id                  =   LTRTABUpd(X).reprint_parent_lmreq_id
                ,  lmact_cd                 =   LTRTABUpd(X).lmact_cd
                ,  ldis_cd                  =   LTRTABUpd(X).ldis_cd
                ,  authorized_lmreq_id                  =   LTRTABUpd(X).authorized_lmreq_id
                ,  error_codes                  =   LTRTABUpd(X).error_codes
                ,  nmbr_requested                 =   LTRTABUpd(X).nmbr_requested
                ,  program_type_cd                  =   LTRTABUpd(X).program_type_cd
                ,  material_request_id                  =   LTRTABUpd(X).material_request_id
                ,  mailing_address_id                 =   LTRTABUpd(X).mailing_address_id
                ,  response_due_date                  =   LTRTABUpd(X).response_due_date
                ,  mailed_date                  =   LTRTABUpd(X).mailed_date
                ,  reject_reason_cd                 =   LTRTABUpd(X).reject_reason_cd
                ,  status_err_src                 =   LTRTABUpd(X).status_err_src
                ,  letter_out_generation_num                  =   LTRTABUpd(X).letter_out_generation_num
                ,  portal_view_ind                  =   LTRTABUpd(X).portal_view_ind
                ,  is_digital_ind                 =   LTRTABUpd(X).is_digital_ind
                ,  stg_checksum                 =   LTRTABUpd(X).checksum
                ,  sent_next_bus_date           =   LTRTABUpd(X).sent_next_bus_Date
                WHERE letter_request_id  =   LTRTABUpd(X).lmreq_id;

 EXCEPTION
     WHEN OTHERS
     THEN
       V_ERR_COUNT := V_ERR_COUNT + SQL%BULK_EXCEPTIONS.COUNT;
     FOR indx IN 1 .. SQL%BULK_EXCEPTIONS.COUNT
     LOOP
          DECLARE
          V_CODE VARCHAR2(30);
          V_ERROR VARCHAR2(200);
          V_ID    NUMBER;
          BEGIN
          V_CODE := SQL%BULK_EXCEPTIONS (indx).ERROR_CODE;
          V_ERROR := SUBSTR(SQLERRM(V_CODE),1,200);
          V_ID := SQL%BULK_EXCEPTIONS(INDX).ERROR_INDEX;
          INS_ERROR_LOG(p_job_name=>'UPD_LETTER_REQUEST',P_ERROR_MSG=> V_ERROR, P_ERROR_CODE =>V_CODE
                      , P_TABLE_NAME=>'S_LETTER_REQUEST_STG', P_TABLE_ID=> LTRTABUpd(V_ID).LMREQ_ID);
          END;
     END LOOP;
  END;
      commit;
      EXIT WHEN c_data%NOTFOUND;
    END LOOP;
    CLOSE c_data;
  END;

  UPDATE MI_JOB_CTRL SET STATUS = 'DONE',STAT_COMMENT = 'RECCOUNT = ' || V_REC_COUNT || ' ;ERRCOUNT = ' || V_ERR_COUNT WHERE JOB_CTRL_ID = P_JOB_CTRL_ID;
  commit;

  EXCEPTION WHEN OTHERS THEN
      DECLARE
        V_CODE VARCHAR2(30);
        V_ERROR VARCHAR2(200);
      BEGIN
      V_CODE := SQLCODE;
      V_ERROR := SUBSTR(SQLERRM,1,200);
          INS_ERROR_LOG(p_job_name=>'UPD_LETTER_REQUEST',P_ERROR_MSG=> V_ERROR, P_ERROR_CODE =>V_CODE
                      , P_TABLE_NAME=>'MI_JOB_CTRL', P_TABLE_ID=> P_JOB_CTRL_ID);
        UPDATE MI_JOB_CTRL SET STATUS = 'ERROR', STAT_COMMENT = 'RECCOUNT = ' || V_REC_COUNT || ' ;ERRCOUNT = ' || V_ERR_COUNT WHERE JOB_CTRL_ID = P_JOB_CTRL_ID;
        COMMIT;
        end;
  END;
  else

      INS_ERROR_LOG(p_job_name=>'UPD_LETTER_REQUEST',P_ERROR_MSG=> 'Job with PEND/WORK status already exists', P_ERROR_CODE =>'TOP001'
                  , P_TABLE_NAME=>'MI_JOB_CTRL', P_TABLE_ID=> '0');
    commit;
  end if;

  END;

PROCEDURE INS_MATERIAL_REQUEST IS

P_JOB_CTRL_ID NUMBER;
v_exists number := 0;

CURSOR c_data IS
SELECT
S.lmreq_ID,
S.CASE_ID,
LMDEFM.LMDEF_ID,
S.REQUESTED_ON,
S.REQUEST_TYPE,
S.PRODUCED_BY,
S.LANGUAGE_CD,
S.DRIVER_TYPE,
S.STATUS_CD,
S.REP_LMREQ_ID,
S.SENT_ON,
S.CREATED_BY,
S.CREATE_TS,
S.UPDATED_BY,
S.UPDATE_TS,
S.PRINTED_ON,
S.STAFF_ID_PRINTED_BY,
S.NOTE_REFID,
S.RETURN_DATE,
S.RETURN_REASON_CD,
S.PARENT_LMREQ_ID,
S.REPRINT_PARENT_LMREQ_ID,
S.LMACT_CD,
S.LDIS_CD,
S.AUTHORIZED_LMREQ_ID,
S.ERROR_CODES,
S.NMBR_REQUESTED,
S.PROGRAM_TYPE_CD,
S.MATERIAL_REQUEST_ID,
S.MAILING_ADDRESS_ID,
S.RESPONSE_DUE_DATE,
S.MAILED_DATE,
S.REJECT_REASON_CD,
S.STATUS_ERR_SRC,
S.LETTER_OUT_GENERATION_NUM,
S.PORTAL_VIEW_IND,
S.IS_DIGITAL_IND,
S.CHECKSUM,
etl_common.GET_BUS_DATE(s.sent_on,0) sent_next_bus_Date
FROM S_LETTER_REQUEST_STG S
JOIN D_LETTER_DEFINITION LMDEFX ON LMDEFX.LMDEF_ID = S.LMDEF_ID AND LMDEFX.NAME = 'XX'
JOIN S_MATERIAL_REQUEST_DETAILS_STG SM ON SM.MATERIAL_REQUEST_ID = S.MATERIAL_REQUEST_ID
JOIN D_LETTER_DEFINITION LMDEFM ON LMDEFM.NAME = SM.MATERIAL_CD
LEFT JOIN D_LETTER_REQUEST LMREQ ON LMREQ.LETTER_REQUEST_ID = S.LMREQ_ID
WHERE LMREQ.LETTER_REQUEST_ID IS NULL
;

TYPE TLTRTable IS TABLE OF C_DATA%ROWTYPE;
LTRTAB_EMPTY TLTRTABLE;

LTRTABUpd TLTRTable;
V_REC_COUNT NUMBER := 0;
V_ERR_COUNT NUMBER := 0;

BEGIN

  select count(1)
  into v_exists
  from mi_job_ctrl
  where job_name = 'INS_MATERIAL_REQUEST'
  and status in ('PEND','WORK');

  if v_exists = 0
    then

  BEGIN
  INSERT INTO MI_JOB_CTRL (JOB_NAME) VALUES ('INS_MATERIAL_REQUEST') RETURNING JOB_CTRL_ID INTO P_JOB_CTRL_ID;

  BEGIN
    OPEN c_data;
    LOOP
      LTRTABUPD := LTRTAB_EMPTY;
      FETCH c_data
      BULK COLLECT INTO LTRTABUpd LIMIT 10000;
      V_REC_COUNT := V_REC_COUNT + LTRTABUPD.COUNT;

      BEGIN
        FORALL x in LTRTABUpd.First..LTRTABUpd.Last SAVE EXCEPTIONS
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
                is_digital_ind,
                stg_checksum
                , sent_next_bus_date)
        values (LTRTABUpd(X).lmreq_id,
                LTRTABUpd(X).case_id,
                LTRTABUpd(X).lmdef_id,
                LTRTABUpd(X).requested_on,
                LTRTABUpd(X).request_type,
                LTRTABUpd(X).produced_by,
                LTRTABUpd(X).language_cd,
                LTRTABUpd(X).driver_type,
                LTRTABUpd(X).status_cd,
                LTRTABUpd(X).rep_lmreq_id,
                LTRTABUpd(X).sent_on,
                LTRTABUpd(X).created_by,
                LTRTABUpd(X).create_ts,
                LTRTABUpd(X).updated_by,
                LTRTABUpd(X).update_ts,
                LTRTABUpd(X).printed_on,
                LTRTABUpd(X).staff_id_printed_by,
                LTRTABUpd(X).note_refid,
                LTRTABUpd(X).return_date,
                LTRTABUpd(X).return_reason_cd,
                LTRTABUpd(X).parent_lmreq_id,
                LTRTABUpd(X).reprint_parent_lmreq_id,
                LTRTABUpd(X).lmact_cd,
                LTRTABUpd(X).ldis_cd,
                LTRTABUpd(X).authorized_lmreq_id,
                LTRTABUpd(X).error_codes,
                LTRTABUpd(X).nmbr_requested,
                LTRTABUpd(X).program_type_cd,
                LTRTABUpd(X).material_request_id,
                LTRTABUpd(X).mailing_address_id,
                LTRTABUpd(X).response_due_date,
                LTRTABUpd(X).mailed_date,
                LTRTABUpd(X).reject_reason_cd,
                LTRTABUpd(X).status_err_src,
                LTRTABUpd(X).letter_out_generation_num,
                LTRTABUpd(X).portal_view_ind,
                LTRTABUpd(X).is_digital_ind,
                LTRTABUpd(X).checksum
                ,LTRTABUpd(X).sent_next_bus_date);
  EXCEPTION
     WHEN OTHERS
     THEN
       V_ERR_COUNT := V_ERR_COUNT + SQL%BULK_EXCEPTIONS.COUNT;
     FOR indx IN 1 .. SQL%BULK_EXCEPTIONS.COUNT
     LOOP
          DECLARE
          V_CODE VARCHAR2(30);
          V_ERROR VARCHAR2(200);
          V_ID    NUMBER;
          BEGIN
          V_CODE := SQL%BULK_EXCEPTIONS (indx).ERROR_CODE;
          V_ERROR := SUBSTR(SQLERRM(V_CODE),1,200);
          V_ID := SQL%BULK_EXCEPTIONS(INDX).ERROR_INDEX;
          INS_ERROR_LOG(p_job_name=>'INS_MATERIAL_REQUEST',P_ERROR_MSG=> V_ERROR, P_ERROR_CODE =>V_CODE
                      , P_TABLE_NAME=>'S_LETTER_REQUEST_STG', P_TABLE_ID=> LTRTABUpd(V_ID).LMREQ_ID);
      END;
     END LOOP;
  END;
      commit;
      EXIT WHEN c_data%NOTFOUND;
    END LOOP;
    CLOSE c_data;
  END;

  UPDATE MI_JOB_CTRL SET STATUS = 'DONE', STAT_COMMENT = 'RECCOUNT = ' || V_REC_COUNT || ' ;ERRCOUNT = ' || V_ERR_COUNT WHERE JOB_CTRL_ID = P_JOB_CTRL_ID;
  commit;

  EXCEPTION WHEN OTHERS THEN
      DECLARE
        V_CODE VARCHAR2(30);
        V_ERROR VARCHAR2(200);
      BEGIN
      V_CODE := SQLCODE;
      V_ERROR := SUBSTR(SQLERRM,1,200);
          INS_ERROR_LOG(p_job_name=>'INS_MATERIAL_REQUEST',P_ERROR_MSG=> V_ERROR, P_ERROR_CODE =>V_CODE
                      , P_TABLE_NAME=>'MI_JOB_CTRL', P_TABLE_ID=> P_JOB_CTRL_ID);
        UPDATE MI_JOB_CTRL SET STATUS = 'ERROR', STAT_COMMENT = 'RECCOUNT = ' || V_REC_COUNT || ' ;ERRCOUNT = ' || V_ERR_COUNT WHERE JOB_CTRL_ID = P_JOB_CTRL_ID;
        COMMIT;
        end;
  END;
  else

      INS_ERROR_LOG(p_job_name=>'INS_MATERIAL_REQUEST',P_ERROR_MSG=> 'Job with PEND/WORK status already exists', P_ERROR_CODE =>'TOP001'
                  , P_TABLE_NAME=>'MI_JOB_CTRL', P_TABLE_ID=> '0');
    commit;
  end if;

  END;


PROCEDURE UPD_MATERIAL_REQUEST IS

P_JOB_CTRL_ID NUMBER;
v_exists number := 0;

CURSOR c_data IS
SELECT
S.LMREQ_ID,
S.CASE_ID,
LMDEFM.LMDEF_ID,
S.REQUESTED_ON,
S.REQUEST_TYPE,
S.PRODUCED_BY,
S.LANGUAGE_CD,
S.DRIVER_TYPE,
S.STATUS_CD,
S.REP_LMREQ_ID,
S.SENT_ON,
S.CREATED_BY,
S.CREATE_TS,
S.UPDATED_BY,
S.UPDATE_TS,
S.PRINTED_ON,
S.STAFF_ID_PRINTED_BY,
S.NOTE_REFID,
S.RETURN_DATE,
S.RETURN_REASON_CD,
S.PARENT_LMREQ_ID,
S.REPRINT_PARENT_LMREQ_ID,
S.LMACT_CD,
S.LDIS_CD,
S.AUTHORIZED_LMREQ_ID,
S.ERROR_CODES,
S.NMBR_REQUESTED,
S.PROGRAM_TYPE_CD,
S.MATERIAL_REQUEST_ID,
S.MAILING_ADDRESS_ID,
S.RESPONSE_DUE_DATE,
S.MAILED_DATE,
S.REJECT_REASON_CD,
S.STATUS_ERR_SRC,
S.LETTER_OUT_GENERATION_NUM,
S.PORTAL_VIEW_IND,
S.IS_DIGITAL_IND,
S.CHECKSUM
, etl_common.GET_BUS_DATE(s.sent_on,0) sent_next_bus_date
FROM S_LETTER_REQUEST_STG S
JOIN D_LETTER_DEFINITION LMDEFX ON LMDEFX.LMDEF_ID = S.LMDEF_ID AND LMDEFX.NAME = 'XX'
JOIN S_MATERIAL_REQUEST_DETAILS_STG SM ON SM.MATERIAL_REQUEST_ID = S.MATERIAL_REQUEST_ID
JOIN D_LETTER_DEFINITION LMDEFM ON LMDEFM.NAME = SM.MATERIAL_CD
JOIN D_LETTER_REQUEST LMREQ ON LMREQ.LETTER_REQUEST_ID = S.LMREQ_ID AND LMREQ.MATERIAL_REQUEST_ID = S.MATERIAL_REQUEST_ID AND LMREQ.LMDEF_ID = LMDEFM.LMDEF_ID
WHERE LMREQ.STG_CHECKSUM <> S.CHECKSUM;


TYPE TLTRTable IS TABLE OF C_DATA%ROWTYPE;
LTRTAB_EMPTY TLTRTABLE;

LTRTABUpd TLTRTable;

V_REC_COUNT NUMBER := 0;
V_ERR_COUNT NUMBER := 0;

BEGIN

  select count(1)
  into v_exists
  from mi_job_ctrl
  where job_name = 'UPD_MATERIAL_REQUEST'
  and status in ('PEND','WORK');

  if v_exists = 0
    then

  BEGIN
  INSERT INTO MI_JOB_CTRL (JOB_NAME) VALUES ('UPD_MATERIAL_REQUEST') RETURNING JOB_CTRL_ID INTO P_JOB_CTRL_ID;

  BEGIN
    OPEN c_data;
    LOOP
      LTRTABUPD := LTRTAB_EMPTY;
      FETCH c_data
      BULK COLLECT INTO LTRTABUpd LIMIT 10000;
      V_REC_COUNT := V_REC_COUNT + LTRTABUPD.COUNT;

      BEGIN
        FORALL x in LTRTABUpd.First..LTRTABUpd.Last SAVE EXCEPTIONS
            UPDATE /*+ Enable_Parallel_Dml Parallel */ D_LETTER_REQUEST SET
                   case_id                  =   LTRTABUpd(X).case_id
                ,  lmdef_id                 =   LTRTABUpd(X).lmdef_id
                ,  requested_on                 =   LTRTABUpd(X).requested_on
                ,  request_type                 =   LTRTABUpd(X).request_type
                ,  produced_by                  =   LTRTABUpd(X).produced_by
                ,  language_cd                  =   LTRTABUpd(X).language_cd
                ,  driver_type                  =   LTRTABUpd(X).driver_type
                ,  status_cd                  =   LTRTABUpd(X).status_cd
                ,  rep_lmreq_id                 =   LTRTABUpd(X).rep_lmreq_id
                ,  sent_on                  =   LTRTABUpd(X).sent_on
                ,  created_by                 =   LTRTABUpd(X).created_by
                ,  create_ts                  =   LTRTABUpd(X).create_ts
                ,  updated_by                 =   LTRTABUpd(X).updated_by
                ,  update_ts                  =   LTRTABUpd(X).update_ts
                ,  printed_on                 =   LTRTABUpd(X).printed_on
                ,  staff_id_printed_by                  =   LTRTABUpd(X).staff_id_printed_by
                ,  note_refid                 =   LTRTABUpd(X).note_refid
                ,  return_date                  =   LTRTABUpd(X).return_date
                ,  return_reason_cd                 =   LTRTABUpd(X).return_reason_cd
                ,  parent_lmreq_id                  =   LTRTABUpd(X).parent_lmreq_id
                ,  reprint_parent_lmreq_id                  =   LTRTABUpd(X).reprint_parent_lmreq_id
                ,  lmact_cd                 =   LTRTABUpd(X).lmact_cd
                ,  ldis_cd                  =   LTRTABUpd(X).ldis_cd
                ,  authorized_lmreq_id                  =   LTRTABUpd(X).authorized_lmreq_id
                ,  error_codes                  =   LTRTABUpd(X).error_codes
                ,  nmbr_requested                 =   LTRTABUpd(X).nmbr_requested
                ,  program_type_cd                  =   LTRTABUpd(X).program_type_cd
                ,  material_request_id                  =   LTRTABUpd(X).material_request_id
                ,  mailing_address_id                 =   LTRTABUpd(X).mailing_address_id
                ,  response_due_date                  =   LTRTABUpd(X).response_due_date
                ,  mailed_date                  =   LTRTABUpd(X).mailed_date
                ,  reject_reason_cd                 =   LTRTABUpd(X).reject_reason_cd
                ,  status_err_src                 =   LTRTABUpd(X).status_err_src
                ,  letter_out_generation_num                  =   LTRTABUpd(X).letter_out_generation_num
                ,  portal_view_ind                  =   LTRTABUpd(X).portal_view_ind
                ,  is_digital_ind                 =   LTRTABUpd(X).is_digital_ind
                ,  stg_checksum                 =   LTRTABUpd(X).checksum
                ,  sent_next_bus_Date           =  LTRTABUpd(X).sent_next_bus_Date
                WHERE letter_request_id  =   LTRTABUpd(X).lmreq_id;

 EXCEPTION
     WHEN OTHERS
     THEN
       V_ERR_COUNT := V_ERR_COUNT + SQL%BULK_EXCEPTIONS.COUNT;
     FOR indx IN 1 .. SQL%BULK_EXCEPTIONS.COUNT
     LOOP
          DECLARE
          V_CODE VARCHAR2(30);
          V_ERROR VARCHAR2(200);
          V_ID    NUMBER;
          BEGIN
          V_CODE := SQL%BULK_EXCEPTIONS (indx).ERROR_CODE;
          V_ERROR := SUBSTR(SQLERRM(V_CODE),1,200);
          V_ID := SQL%BULK_EXCEPTIONS(INDX).ERROR_INDEX;
          INS_ERROR_LOG(p_job_name=>'UPD_MATERIAL_REQUEST',P_ERROR_MSG=> V_ERROR, P_ERROR_CODE =>V_CODE
                      , P_TABLE_NAME=>'S_LETTER_REQUEST_STG', P_TABLE_ID=> LTRTABUpd(V_ID).LMREQ_ID);
          END;
     END LOOP;
  END;
      commit;
      EXIT WHEN c_data%NOTFOUND;
    END LOOP;
    CLOSE c_data;
  END;

  UPDATE MI_JOB_CTRL SET STATUS = 'DONE',STAT_COMMENT = 'RECCOUNT = ' || V_REC_COUNT || ' ;ERRCOUNT = ' || V_ERR_COUNT WHERE JOB_CTRL_ID = P_JOB_CTRL_ID;
  commit;

  EXCEPTION WHEN OTHERS THEN
      DECLARE
        V_CODE VARCHAR2(30);
        V_ERROR VARCHAR2(200);
      BEGIN
      V_CODE := SQLCODE;
      V_ERROR := SUBSTR(SQLERRM,1,200);
          INS_ERROR_LOG(p_job_name=>'UPD_MATERIAL_REQUEST',P_ERROR_MSG=> V_ERROR, P_ERROR_CODE =>V_CODE
                      , P_TABLE_NAME=>'MI_JOB_CTRL', P_TABLE_ID=> P_JOB_CTRL_ID);
        UPDATE MI_JOB_CTRL SET STATUS = 'ERROR', STAT_COMMENT = 'RECCOUNT = ' || V_REC_COUNT || ' ;ERRCOUNT = ' || V_ERR_COUNT WHERE JOB_CTRL_ID = P_JOB_CTRL_ID;
        COMMIT;
        end;
  END;
  else

      INS_ERROR_LOG(p_job_name=>'UPD_MATERIAL_REQUEST',P_ERROR_MSG=> 'Job with PEND/WORK status already exists', P_ERROR_CODE =>'TOP001'
                  , P_TABLE_NAME=>'MI_JOB_CTRL', P_TABLE_ID=> '0');
    commit;
  end if;

  END;

PROCEDURE LETTERS_IU IS
  BEGIN
    UPD_CHECKSUM_STG;
    INS_LETTER_REQUEST;
    UPD_LETTER_REQUEST;
    INS_MATERIAL_REQUEST;
    UPD_MATERIAL_REQUEST;
  END;

end;
/
grant execute on MI_LETTERS_PKG to MAXDAT_MITRAN_OLTP_SIUD;
grant execute on MI_LETTERS_PKG to MAXDAT_MIEB_PFP_E;


