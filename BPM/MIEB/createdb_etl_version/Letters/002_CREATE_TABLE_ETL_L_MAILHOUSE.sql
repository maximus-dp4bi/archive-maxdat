DROP TABLE ETL_L_MAILHOUSE;

CREATE TABLE ETL_L_MAILHOUSE 
(
  JOB_CTRL_ID NUMBER(18, 0) NOT NULL 
, ROW_NUM NUMBER(18, 0) NOT NULL
, FILENAME VARCHAR2(1000)
, SOURCE_SYSTEM VARCHAR2(32)
, SOURCE_FILENAME VARCHAR2(200)
, RECORD_NUMBER VARCHAR2(200)
, LETTER_TYPE VARCHAR2(100)
, LETTER_REQUEST_ID VARCHAR2(100)
, PRINTED_DATE VARCHAR2(20)
, MAILED_DATE VARCHAR2(20)
, ERROR_DATE VARCHAR2(20)
, ERROR_CODE VARCHAR2(32)
, RECORD_CONTENT VARCHAR2(4000 BYTE) 
, ERROR_CHECK_RESULTS VARCHAR2(4000 BYTE) 
, PROCESSED_IND NUMBER(1, 0) DEFAULT 0 
, PROCESS_TS DATE 
, CREATE_TS DATE 
, CREATED_BY VARCHAR2(80 BYTE) 
, UPDATE_TS DATE 
, UPDATED_BY VARCHAR2(80 BYTE) 
) 
TABLESPACE MAXDAT_MIEB_DATA;

ALTER TABLE ETL_L_MAILHOUSE
ADD CONSTRAINT ETL_L_MAILHOUSE_PK PRIMARY KEY
(
  JOB_CTRL_ID 
, ROW_NUM 
);

create or replace TRIGGER BUIR_ETL_L_MAILHOUSE
 BEFORE INSERT OR UPDATE
 ON ETL_L_MAILHOUSE
 FOR EACH ROW
BEGIN

  IF INSERTING THEN

    mieb_letters_etl_pkg.get_letter_job_ctrl_id
    (
        p_job_name              =>  'LOAD_EYR_DATA'
        ,p_filepath             =>  :NEW.filename
        ,p_job_ctrl_id          =>  :NEW.job_ctrl_id
        ,p_row_num              =>  :NEW.row_num
    );

    :NEW.record_content :=  
    
    :NEW.source_system || ',' || 
    :NEW.source_filename || ',' || 
    :NEW.record_number || ',' || 
    :NEW.letter_type || ',' || 
    :NEW.letter_request_id || ',' ||
    :NEW.printed_date || ',' ||
    :NEW.mailed_date || ',' || 
    :NEW.error_date || ',' ||
    :NEW.error_code;

    :NEW.created_by := user;
    :NEW.create_ts := sysdate;

  END IF;

  :NEW.updated_by := user;
  :NEW.update_ts := sysdate;

END BUIR_ETL_L_MAILHOUSE;
/