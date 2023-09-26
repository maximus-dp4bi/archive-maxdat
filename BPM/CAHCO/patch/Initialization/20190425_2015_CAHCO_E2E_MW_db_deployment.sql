/*********************************************

    CREATE Error Log Tables

**********************************************/
exec dbms_errlog.create_error_log(dml_table_name => 'hco_activity_queue', err_log_table_name => 'errlog_hco_activity_queue', err_log_table_owner => 'maxdat', err_log_table_space => 'maxdat_data');
exec dbms_errlog.create_error_log(dml_table_name => 'step_instance', err_log_table_name => 'errlog_step_instance', err_log_table_owner => 'maxdat', err_log_table_space => 'maxdat_data');
exec dbms_errlog.create_error_log(dml_table_name => 'step_instance_stg', err_log_table_name => 'errlog_step_instance_stg', err_log_table_owner => 'maxdat', err_log_table_space => 'maxdat_data');
exec dbms_errlog.create_error_log(dml_table_name => 'd_hco_process_instance', err_log_table_name => 'errlog_d_hco_process_instance', err_log_table_owner => 'maxdat', err_log_table_space => 'maxdat_data');

grant select on errlog_hco_activity_queue to maxdat_read_only; 
grant select on errlog_step_instance to maxdat_read_only; 
grant select on errlog_step_instance_stg to maxdat_read_only; 
grant select on errlog_d_hco_process_instance to maxdat_read_only; 
/*********************************************

    CREATE HCO_D_MAIL_RETURNED

**********************************************/
CREATE TABLE HCO_D_MAIL_RETURNED
(
    MAIL_RETURNED_ID                                    NUMBER,
    MAIL_RETURNED_OUTCOME_ID                            NUMBER,
    INPUT_FILE_NAME                                     VARCHAR2(100),
    INPUT_STRING                                        VARCHAR2(100),
    DCIN                                                VARCHAR2(20),
    MAIL_TYPE_ID                                        NUMBER,
    MAIL_TYPE                                           VARCHAR2(10),
    MAIL_SUBTYPE                                        VARCHAR2(2),
    DATE_IN_BARCODE                                     VARCHAR2(10),
    CASE_ADDRESS_SNAPSHOT                               VARCHAR2(200),
    NOTES                                               VARCHAR2(4000),
    CASE_HEAD_CLIENT_NUMBER                             NUMBER,
    CASE_ID                                             VARCHAR2(20),
    CASE_NUMBER                                         NUMBER,
    RECORD_DATE                                         DATE,
    RECORD_NAME                                         VARCHAR2(100),
    MODIFIED_DATE                                       DATE,
    MODIFIED_NAME                                       VARCHAR2(100),
    CONSTRAINT HCO_D_MAIL_RETURNED_PK PRIMARY KEY 
    (
        MAIL_RETURNED_ID
    )
    ENABLE 
)
TABLESPACE MAXDAT_DATA;

CREATE INDEX HCO_D_MAIL_RETURNED_I001 ON HCO_D_MAIL_RETURNED(DCIN)
TABLESPACE MAXDAT_INDX;

GRANT SELECT ON HCO_D_MAIL_RETURNED TO MAXDAT_READ_ONLY;
/*********************************************

    CREATE CORP_ETL_CONTROL VARIABLES

**********************************************/
INSERT 
  INTO  CORP_ETL_CONTROL    (   NAME,                               VALUE_TYPE,     VALUE,                  DESCRIPTION                                         )
VALUES                      (   'MW_MAIL_RETURNED_CREATE_DATE',     'D',            '1900/01/01 00:00:00',  'The create date of the latest returned mail record');

INSERT 
  INTO  CORP_ETL_CONTROL    (   NAME,                               VALUE_TYPE,     VALUE,                  DESCRIPTION                                         )
VALUES                      (   'MW_MAIL_RETURNED_UPDATE_DATE',     'D',            '1900/01/01 00:00:00',  'The update date of the latest returned mail record');

INSERT 
  INTO  CORP_ETL_CONTROL    (   NAME,                               VALUE_TYPE,     VALUE,                  DESCRIPTION                                         )
VALUES                      (   'MW_MAIL_RETURNED_PROC_DATE',       'D',            '1900/01/01 00:00:00',  'The date of the last processed returned mail record');

DELETE
  FROM  CORP_ETL_CONTROL
 WHERE  name                    =   'MW_RETURN_MAIL_PROC_DATE';

COMMIT;
/*********************************************

    MODIFY HCO_MAIL_CLIENT_TRANS

**********************************************/
CREATE INDEX HCO_MAIL_CLIENT_TRANS_I004 ON HCO_MAIL_CLIENT_TRANS (ENROLLMENT_ID)
TABLESPACE MAXDAT_INDX;

CREATE INDEX HCO_MAIL_CLIENT_TRANS_I005 ON HCO_MAIL_CLIENT_TRANS (EXEMPTION_ID)
TABLESPACE MAXDAT_INDX;

CREATE INDEX HCO_MAIL_CLIENT_TRANS_I006 ON HCO_MAIL_CLIENT_TRANS (MT_RECORD_DATE)
TABLESPACE MAXDAT_INDX;
/*********************************************

    MODIFY D_HCO_PROCESS_INSTANCE

**********************************************/
ALTER TABLE D_HCO_PROCESS_INSTANCE ADD
(
    CASE_NUMBER                 NUMBER
);
/*********************************************

    MODIFY HCO_OB_TRANSACTIONS

**********************************************/
CREATE INDEX HCO_OB_TRANSACTIONS_I001 ON HCO_OB_TRANSACTIONS (MODIFIED_DATE)
TABLESPACE MAXDAT_INDX;

CREATE INDEX HCO_OB_TRANSACTIONS_I002 ON HCO_OB_TRANSACTIONS (RECORD_DATE)
TABLESPACE MAXDAT_INDX;
/*********************************************

    MODIFY EMRS_F_ENROLLMENT

**********************************************/
CREATE INDEX EMRSFENROLLMENT_IDX07 ON EMRS_F_ENROLLMENT (RECORD_DATE)
TABLESPACE MAXDAT_INDX;

CREATE INDEX EMRSFENROLLMENT_IDX08 ON EMRS_F_ENROLLMENT (MODIFIED_DATE)
TABLESPACE MAXDAT_INDX;
/*********************************************

    MODIFY EMRS_D_EMRGCY_DISENROLL

**********************************************/
CREATE INDEX EMRGCYDENR_DISENROLLID_I001 ON EMRS_D_EMRGCY_DISENROLL (RECORD_DATE)
TABLESPACE MAXDAT_INDX;

CREATE INDEX EMRGCYDENR_DISENROLLID_I002 ON EMRS_D_EMRGCY_DISENROLL (MODIFIED_DATE)
TABLESPACE MAXDAT_INDX;
/*********************************************

    MODIFY EMRS_D_EMRGCY_DENR_HIST

**********************************************/
CREATE INDEX EMRGCYDENR_EDHISTID_I001 ON EMRS_D_EMRGCY_DENR_HIST (RECORD_DATE)
TABLESPACE MAXDAT_INDX;
/*********************************************

    MODIFY EMRS_D_EXEMPTION_REQ

**********************************************/
CREATE INDEX IDX04_EMRSDEXEMPT ON EMRS_D_EXEMPTION_REQ (RECORD_DATE)
TABLESPACE MAXDAT_INDX;

CREATE INDEX IDX05_EMRSDEXEMPT ON EMRS_D_EXEMPTION_REQ (MODIFIED_DATE)
TABLESPACE MAXDAT_INDX;
/*********************************************

    MODIFY EMRS_D_EXEMPT_STATUS_HIST 

**********************************************/
CREATE INDEX EXEMPTHIST_EXEMPTHISTID_I001 ON EMRS_D_EXEMPT_STATUS_HIST (RECORD_DATE)
TABLESPACE MAXDAT_INDX;
/*********************************************

    MODIFY HCO_D_LETTER_MAILING

**********************************************/
CREATE INDEX HCOLTRMAIL_IDX03 ON HCO_D_LETTER_MAILING (RECORD_DATE)
TABLESPACE MAXDAT_INDX;

CREATE INDEX HCOLTRMAIL_IDX04 ON HCO_D_LETTER_MAILING (MODIFIED_DATE)
TABLESPACE MAXDAT_INDX;
/*********************************************

    MODIFY HCO_D_PACKET_MAILING

**********************************************/
CREATE INDEX PM_PACKETMAILING_I001 ON HCO_D_PACKET_MAILING (RECORD_DATE)
TABLESPACE MAXDAT_INDX;

CREATE INDEX PM_PACKETMAILING_I002 ON HCO_D_PACKET_MAILING (MODIFIED_DATE)
TABLESPACE MAXDAT_INDX;
/*********************************************

    MODIFY D_HCO_PROCESS_INSTANCE

**********************************************/
DROP INDEX D_HCO_PROCESS_INSTANCE_U001;
CREATE INDEX D_HCO_PROCESS_INSTANCE_U001 ON D_HCO_PROCESS_INSTANCE (HCO_PROCESS_ID, DCN, CLIENT_NUMBER, CASE_NUMBER, REF_TYPE, REF_ID)
TABLESPACE MAXDAT_INDX;

