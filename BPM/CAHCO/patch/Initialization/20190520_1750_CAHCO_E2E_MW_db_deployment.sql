/*********************************************

    ALTER HCO_ENROLLMENT_EXT

**********************************************/
ALTER TABLE HCO_ENROLLMENT_EXT ADD
(
    RESEARCH_IND                        VARCHAR2(1),
    ERROR_REASON_ACTION                 VARCHAR2(10)
);
/*********************************************

    ALTER STEP_INSTANCE

**********************************************/
DROP INDEX STEP_INSTANCE_UK1;

CREATE UNIQUE INDEX STEP_INSTANCE_UK1 ON STEP_INSTANCE (REF_TYPE, REF_ID, STEP_DEFINITION_ID, PROCESS_ID, PROCESS_INSTANCE_ID, CREATE_TS, STEP_SEQUENCE);

CREATE INDEX STEP_INSTANCE_I001 ON STEP_INSTANCE (STEP_DEFINITION_ID, STATUS);
/*********************************************

    CORP_ETL_CONTROL

**********************************************/
-- Pend Enrollment Days

INSERT
  INTO  corp_etl_control        (   NAME,                               value_type,     VALUE,                  DESCRIPTION )
VALUES                          (   'MW_PEND_ENROLLMENT_DAYS',          'N',            '120',                  'The maximum number of days an enrollment can be pended before being closed');

-- Returned Mail Outbound Transactions

INSERT
  INTO  CORP_ETL_CONTROL        (   NAME,                               VALUE_TYPE,     VALUE,                  DESCRIPTION )
VALUES                          (   'MW_RM_OB_TRANS_PROC_DATE',         'D',            '1900/01/01 00:00:00',  'The last modified date of the Returned Mail OB Transactions');

COMMIT;
/*********************************************

    CREATE CAHCO_ETL_MW_LOG

**********************************************/
CREATE TABLE CAHCO_ETL_MW_LOG
(
    CAHCO_ETL_MW_LOG_ID                             NUMBER                                          NOT NULL,
    CONTEXT                                         VARCHAR2(300)       DEFAULT '?'                 NOT NULL,
    MESSAGE                                         VARCHAR2(4000)      DEFAULT '?'                 NOT NULL,
    MESSAGE_TYPE                                    VARCHAR2(1)         DEFAULT 'I'                 NOT NULL,
    RECORD_DATE                                     DATE                DEFAULT SYSDATE             NOT NULL,
    RECORD_NAME                                     VARCHAR2(100)       DEFAULT USER                NOT NULL,
    MODIFIED_DATE                                   DATE                DEFAULT SYSDATE             NOT NULL,
    MODIFIED_NAME                                   VARCHAR2(100)       DEFAULT USER                NOT NULL,    
    CONSTRAINT CAHCO_ETL_MW_LOG_PK PRIMARY KEY 
    (
        CAHCO_ETL_MW_LOG_ID
    )
    ENABLE,
    CONSTRAINT CAHCO_ETL_MW_LOG_CK001 
    CHECK (MESSAGE_TYPE IN ('I', 'W', 'E'))    
    ENABLE
)
TABLESPACE MAXDAT_DATA;

CREATE INDEX CAHCO_ETL_MW_LOG_I001 ON CAHCO_ETL_MW_LOG (CONTEXT)
TABLESPACE MAXDAT_INDX;

CREATE INDEX CAHCO_ETL_MW_LOG_I002 ON CAHCO_ETL_MW_LOG (MESSAGE)
TABLESPACE MAXDAT_INDX;

CREATE INDEX CAHCO_ETL_MW_LOG_I003 ON CAHCO_ETL_MW_LOG (RECORD_DATE, RECORD_NAME)
TABLESPACE MAXDAT_INDX;

CREATE INDEX CAHCO_ETL_MW_LOG_I004 ON CAHCO_ETL_MW_LOG (MODIFIED_DATE, MODIFIED_NAME)
TABLESPACE MAXDAT_INDX;

CREATE INDEX CAHCO_ETL_MW_LOG_I005 ON CAHCO_ETL_MW_LOG (MESSAGE_TYPE)
TABLESPACE MAXDAT_INDX;

CREATE SEQUENCE SEQ_CAHCO_ETL_MW_LOG_ID MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL;

create or replace TRIGGER TRG_CAHCO_ETL_MW_LOG_BIUR
    BEFORE INSERT OR UPDATE
    ON CAHCO_ETL_MW_LOG
    FOR EACH ROW
BEGIN

    IF INSERTING THEN        
        :NEW.CAHCO_ETL_MW_LOG_ID    :=  SEQ_CAHCO_ETL_MW_LOG_ID.NEXTVAL;        
        :NEW.RECORD_DATE    :=  SYSDATE;
        :NEW.RECORD_NAME    :=  USER;
    END IF;
    
    :NEW.MESSAGE_TYPE       :=  UPPER(:NEW.MESSAGE_TYPE);
    :NEW.MODIFIED_DATE      :=  SYSDATE;
    :NEW.MODIFIED_NAME      :=  USER;

END TRG_CAHCO_ETL_MW_LOG_BIUR;
/

GRANT SELECT ON CAHCO_ETL_MW_LOG TO MAXDAT_READ_ONLY;
/*********************************************

    ALTER HCO_BATCH_DCN

**********************************************/
ALTER TABLE HCO_BATCH_DCN DROP CONSTRAINT HCO_BATCH_DCN_PK;

CREATE UNIQUE INDEX HCO_BATCH_DCN_UK1 ON HCO_BATCH_DCN(DB_RECORD_NUM, DCN);





