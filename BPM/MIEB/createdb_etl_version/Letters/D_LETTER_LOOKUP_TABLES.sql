CREATE TABLE D_LETTER_STATUS(
LETTER_STATUS_CODE	VARCHAR2(32)	,
LETTER_STATUS_DESC	VARCHAR2(256)	,
LETTER_STATUS	VARCHAR2(64)	,
ORDER_BY_DEFAULT	NUMBER(10,0)	,
EFFECTIVE_START_DATE	DATE	,
EFFECTIVE_END_DATE	DATE	) TABLESPACE &tablespace_name;

CREATE UNIQUE INDEX IDX1_LETTER_STATUS ON D_LETTER_STATUS(LETTER_STATUS_CODE) TABLESPACE &tablespace_name;

GRANT SELECT ON D_LETTER_STATUS TO &role_name;

CREATE OR REPLACE VIEW D_LETTER_STATUS_SV AS
SELECT letter_status_code
       ,letter_status_desc
       ,letter_status
       ,order_by_default
       ,effective_start_date
       ,effective_end_date
FROM d_letter_status;

GRANT SELECT ON D_LETTER_STATUS_SV TO &role_name;

CREATE TABLE D_LETTER_REJECT_REASON(
REJECT_REASON_CODE	VARCHAR2(32)	,
REJECT_REASON_DESC	VARCHAR2(256)	,
REJECT_REASON	VARCHAR2(64)	,
EFFECTIVE_START_DATE	DATE	,
EFFECTIVE_END_DATE	DATE) 	TABLESPACE &tablespace_name;

CREATE UNIQUE INDEX IDX1_LETTER_REJRSN ON D_LETTER_REJECT_REASON(REJECT_REASON_CODE) TABLESPACE &tablespace_name;

GRANT SELECT ON D_LETTER_REJECT_REASON TO &role_name;

CREATE OR REPLACE VIEW D_LETTER_REJECT_REASON_SV AS
SELECT reject_reason_code
      ,reject_reason_desc
      ,reject_reason
      ,effective_start_date
      ,effective_end_date
FROM d_letter_reject_reason;

GRANT SELECT ON D_LETTER_REJECT_REASON_SV TO &role_name;

CREATE TABLE D_LETTER_SOURCE(
LETTER_SOURCE_CODE	VARCHAR2(32)	,
LETTER_SOURCE_NAME  VARCHAR2(100),
DESCRIPTION         VARCHAR2(240),
REPORT_LABEL        VARCHAR2(100),
EFFECTIVE_FROM_DATE	DATE	,
EFFECTIVE_THRU_DATE	DATE) 	TABLESPACE &tablespace_name;

ALTER TABLE D_LETTER_SOURCE ADD CONSTRAINT D_LETTER_SOURCE_PK PRIMARY KEY (LETTER_SOURCE_CODE)  USING INDEX TABLESPACE &tablespace_name;

CREATE OR REPLACE VIEW D_LETTER_SOURCE_SV AS 
SELECT LETTER_SOURCE_CODE
, LETTER_SOURCE_NAME
, DESCRIPTION
, REPORT_LABEL
, EFFECTIVE_FROM_DATE
, EFFECTIVE_THRU_DATE
FROM D_LETTER_SOURCE
;

GRANT SELECT ON D_LETTER_SOURCE_SV TO &role_name;

---******************
--DROP TABLE D_LETTER_INVOICE_GROUP;
CREATE TABLE D_LETTER_INVOICE_GROUP(
LETTER_INVOICE_GROUP_CODE	VARCHAR2(32)	,
LETTER_INVOICE_GROUP_NAME  VARCHAR2(100),
DESCRIPTION         VARCHAR2(240),
REPORT_LABEL        VARCHAR2(100),
EFFECTIVE_FROM_DATE	DATE	,
EFFECTIVE_THRU_DATE	DATE) 	TABLESPACE &tablespace_name;

ALTER TABLE D_LETTER_INVOICE_GROUP ADD CONSTRAINT D_LETTER_INVOICE_GROUP_PK PRIMARY KEY (LETTER_INVOICE_GROUP_CODE)  USING INDEX TABLESPACE &tablespace_name;

CREATE OR REPLACE VIEW D_LETTER_INVOICE_GROUP_SV AS 
SELECT LETTER_INVOICE_GROUP_CODE
, LETTER_INVOICE_GROUP_NAME
, DESCRIPTION
, REPORT_LABEL
, EFFECTIVE_FROM_DATE
, EFFECTIVE_THRU_DATE
FROM D_LETTER_INVOICE_GROUP
;

GRANT SELECT ON D_LETTER_INVOICE_GROUP_SV TO &role_name;
---********************

CREATE SEQUENCE  "D_SEQ_LMDEF_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;

GRANT SELECT ON "D_SEQ_LMDEF_ID" TO &role_name;

CREATE TABLE D_LETTER_DEFINITION(
LMDEF_ID NUMBER(18,0),
NAME VARCHAR2(40),
DESCRIPTION VARCHAR2(4000),
REPORT_LABEL VARCHAR2(100),
DRIVER_TYPE VARCHAR2(32),
LETTER_OR_FORM VARCHAR2(1),
LOAD_IMAGE_IND NUMBER(1,0),
DRIVER_PRIMARY_KEY VARCHAR2(38),
DRIVER_TABLE_NAME VARCHAR2(40),
PRODUCED_BY VARCHAR2(2),
TRIGERRING_METHOD VARCHAR2(2),
EFFECTIVE_FROM_DATE DATE,
EFFECTIVE_THRU_DATE DATE,
CONTRACT_REFERENCE VARCHAR2(40),
POSTMARK_DELAY NUMBER(2,0),
RESPOND_BY_DELAY NUMBER(2,0),
RESPOND_BY_WORKDAY_IND NUMBER(1,0),
CREATED_BY VARCHAR2(80),
CREATE_TS DATE,
UPDATED_BY VARCHAR2(80),
UPDATE_TS DATE,
FORM_IND NUMBER(1,0),
ALERT_IND NUMBER(1,0),
ALERT_MESSAGE_KEY VARCHAR2(255),
ALLOW_BAD_ADDR_IND NUMBER(1,0),
PROCESS_IND NUMBER(1,0),
MAX_NUMBER_DAYS_4_RSND NUMBER(19,0),
SCOPE VARCHAR2(128),
MAX_LETTERS_PROCESSED NUMBER(18,0),
CONTACT_METHOD_MAIL_IND NUMBER(1,0), 
LETTER_SOURCE_CODE VARCHAR2(32)
) TABLESPACE &tablespace_name;

ALTER TABLE D_LETTER_DEFINITION ADD (
LETTER_INVOICE_GROUP_CODE VARCHAR2(32),
LETTER_PROGRAM_GROUP VARCHAR2(100)
);

ALTER TABLE D_LETTER_DEFINITION ADD (
SOURCE_TABLE_NAME VARCHAR2(32),
SOURCE_TABLE_ID NUMBER(32),
SOURCE_TABLE_CODE VARCHAR2(32)
);

ALTER TABLE D_LETTER_DEFINITION ADD (
PROJECT_CODE VARCHAR2(32),
PROGRAM_CODE VARCHAR2(32)
);

ALTER TABLE D_LETTER_DEFINITION ADD CONSTRAINT D_LETTERDEF_PK PRIMARY KEY (LMDEF_ID)  USING INDEX TABLESPACE &tablespace_name;
ALTER TABLE D_LETTER_DEFINITION ADD CONSTRAINT D_LETTERDEF_FK FOREIGN KEY (LETTER_SOURCE_CODE) REFERENCES D_LETTER_SOURCE(LETTER_SOURCE_CODE);
ALTER TABLE D_LETTER_DEFINITION ADD CONSTRAINT D_LETTERDEF_FK_2 FOREIGN KEY (LETTER_INVOICE_GROUP_CODE) REFERENCES D_LETTER_INVOICE_GROUP(LETTER_INVOICE_GROUP_CODE);
ALTER TABLE D_LETTER_DEFINITION ADD CONSTRAINT D_LETTERDEF_FK_3 FOREIGN KEY (PROJECT_CODE) REFERENCES D_PROJECT(PROJECT_CODE);
ALTER TABLE D_LETTER_DEFINITION ADD CONSTRAINT D_LETTERDEF_FK_4 FOREIGN KEY (PROGRAM_CODE) REFERENCES D_PROGRAM(PROGRAM_CODE);

CREATE OR REPLACE TRIGGER "BUIR_LMDEF"
 BEFORE INSERT OR UPDATE
 ON d_letter_definition
 FOR EACH ROW
DECLARE
    v_seq_id     D_LETTER_definition.lmdef_id%TYPE;
BEGIN

  IF INSERTING THEN

      IF :NEW.lmdef_id IS NULL THEN
        SElECT D_SEQ_LMDEF_ID.NEXTVAL
        INTO v_seq_id
        FROM dual;

        :NEW.lmdef_id       := v_seq_id;
      END IF;

    :NEW.created_by := user;
    :NEW.create_ts := sysdate;

  END IF;

  :NEW.updated_by := user;
  :NEW.update_ts := sysdate;
  
END BUIR_LMDEF;
/

ALTER TRIGGER "BUIR_LMDEF" ENABLE;
/

GRANT SELECT ON D_LETTER_DEFINITION TO &role_name;

CREATE OR REPLACE VIEW D_LETTER_DEFINITION_SV AS
SELECT lmdef_id letter_definition_id
      ,name letter_name
      ,description description
      , report_label report_label
      , LETTER_OR_FORM letter_type
      , EFFECTIVE_FROM_DATE
      , EFFECTIVE_THRU_DATE
      , LETTER_SOURCE_CODE
      , LETTER_INVOICE_GROUP_CODE
      , LETTER_PROGRAM_GROUP
      , PROJECT_CODE
      , PROGRAM_CODE
FROM d_letter_definition;

GRANT SELECT ON D_LETTER_DEFINITION_SV TO &role_name;
