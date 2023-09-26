CREATE SEQUENCE  "EMRS_SEQ_EMRGCY_DENR_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 341 CACHE 20 NOORDER  NOCYCLE ;

GRANT SELECT ON "EMRS_SEQ_EMRGCY_DENR_ID" TO "MAXDAT_READ_ONLY";

CREATE TABLE MAXDAT.EMRS_D_EMRGCY_DISENROLL
    (
      EMRGCY_DISENROLL_ID     INTEGER
    , CLIENT_NUMBER           INTEGER
    , SELECTION_SOURCE_CODE   VARCHAR2(50)
    , EMRGCY_DENR_REASON_CODE VARCHAR2 (2)
    , RETRO_DISENROLL         VARCHAR2 (1)
    , PLAN_ID                 VARCHAR2 (3)
    , PLAN_TYPE               VARCHAR2 (1)
    , EMRGCY_DENR_SOURCE_CODE VARCHAR2 (10)
    , DCN                     VARCHAR2 (11)
    , RECORD_DATE             DATE
    , RECORD_NAME             VARCHAR2 (50)
    , MODIFIED_BY             VARCHAR2 (50)
    , MODIFIED_DATE           DATE
    , SOURCE_NAME             VARCHAR2 (100)
    , SOURCE_CONTACT          VARCHAR2 (50)
    , SOURCE_PHONE            VARCHAR2 (10)
    , SOURCE_FAX              VARCHAR2 (10)
    , FACILITY_NAME           VARCHAR2 (100)
    , FACILITY_ADDRESS_LINE_1 VARCHAR2 (50)
    , FACILITY_ADDRESS_LINE_2 VARCHAR2 (50)
    , FACILITY_CITY           VARCHAR2 (35)
    , FACILITY_STATE          VARCHAR2 (2)
    , FACILITY_ZIP            VARCHAR2 (9)
    , FACILITY_PHONE          VARCHAR2 (10)
    , FACILITY_FAX            VARCHAR2 (10)
    , FACILITY_ADMIT_DATE     DATE
    , DATE_MOVED              DATE
    , NEW_ADDRESS             VARCHAR2 (50)
    , NEW_CITY                VARCHAR2 (35)
    , NEW_STATE               VARCHAR2 (2)
    , NEW_ZIP                 VARCHAR2 (9)
    , REQUEST_DATE            DATE
    , LAST_DOS                DATE
    , EFFECTIVE_DATE          DATE
    , AUTH_ATTACHED           VARCHAR2 (1)
    , DECEASED_DATE           DATE
    , PREAPPROVED             VARCHAR2 (1)
    , COMMENTS                VARCHAR2 (4000)
    , CHANGE_REASON_CODE      VARCHAR2 (10)
    , CREATED_BY              VARCHAR2 (80)
    , DATE_CREATED            DATE
    , UPDATED_BY              VARCHAR2 (80)
    , DATE_UPDATED            DATE
    , NEW_STATUS_DATE         DATE
    , PENDING_STATUS_DATE     DATE
    , APPROVED_STATUS_DATE    DATE
    , DENIAL_STATUS_DATE      DATE
    , DP_EMRGCY_DENR_ID       NUMBER NOT NULL
    , EMRGCY_DENR_STATUS_CODE VARCHAR2 (1)
    , DISENROLLMENT_ID        INTEGER,
    CONSTRAINT EMRGCYDENR_DISENROLLIDPK PRIMARY KEY (DP_EMRGCY_DENR_ID),
    CONSTRAINT EMRGCYDENR_DISENROLLID_UK UNIQUE (EMRGCY_DISENROLL_ID)
    )
    TABLESPACE MAXDAT_DATA
    STORAGE (BUFFER_POOL DEFAULT);
	
GRANT SELECT ON "EMRS_D_EMRGCY_DISENROLL" TO "MAXDAT_READ_ONLY";

CREATE OR REPLACE TRIGGER "BUIR_EMRGCY_DISENROLL" 
 BEFORE INSERT OR UPDATE
 ON emrs_d_emrgcy_disenroll
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_EMRGCY_DISENROLL.dp_emrgcy_denr_id%TYPE;
BEGIN
  IF INSERTING THEN  
    IF :NEW.dp_emrgcy_denr_id IS NULL THEN
      SElECT EMRS_SEQ_EMRGCY_DENR_ID.NEXTVAL
      INTO v_seq_id
      FROM dual;

      :NEW.dp_emrgcy_denr_id   := v_seq_id;
    END IF;
    :NEW.created_by := user;
    :NEW.date_created := sysdate;
  END IF;  
  :NEW.updated_by := user;
  :NEW.date_updated := sysdate;
END BUIR_EMRGCY_DISENROLL;
/
ALTER TRIGGER "BUIR_EMRGCY_DISENROLL" ENABLE;
/

CREATE OR REPLACE VIEW EMRS_D_EMRGCY_DISENROLL_SV
AS
SELECT emrgcy_disenroll_id,
client_number,
selection_source_code,
emrgcy_denr_reason_code,
emrgcy_denr_status_code,
retro_disenroll,
plan_id,
plan_type,
emrgcy_denr_source_code,
dcn,
record_date,
record_name,
modified_by,
modified_date,
source_name,
source_contact,
source_phone,
source_fax,
facility_name,
facility_address_line_1,
facility_address_line_2,
facility_city,
facility_state,
facility_zip,
facility_phone,
facility_fax,
facility_admit_date,
date_moved,
new_address,
new_city,
new_state,
new_zip,
request_date,
last_dos,
effective_date,
auth_attached,
deceased_date,
preapproved,
comments,
change_reason_code,
created_by,
date_created,
updated_by,
date_updated,
dp_emrgcy_denr_id,
new_status_date,
pending_status_date,
approved_status_date,
denial_status_date,
DISENROLLMENT_ID
FROM emrs_d_emrgcy_disenroll;

GRANT SELECT ON "EMRS_D_EMRGCY_DISENROLL_SV" TO "MAXDAT_READ_ONLY";

