CREATE TABLE D_LETTER_REQUEST 
(
  DP_LETTER_REQUEST_ID NUMBER NOT NULL 
, LETTER_REQUEST_ID NUMBER(18, 0) 
, CASE_ID NUMBER(18, 0) 
, LMDEF_ID NUMBER(18, 0) 
, REQUESTED_ON DATE 
, REQUEST_TYPE VARCHAR2(2 BYTE) 
, PRODUCED_BY VARCHAR2(2 BYTE) 
, LANGUAGE_CD VARCHAR2(32 BYTE) 
, DRIVER_TYPE VARCHAR2(4 BYTE) 
, STATUS_CD VARCHAR2(32 BYTE) 
, REP_LMREQ_ID NUMBER(18, 0) 
, SENT_ON DATE 
, CREATED_BY VARCHAR2(80 BYTE) 
, CREATE_TS DATE 
, UPDATED_BY VARCHAR2(80 BYTE) 
, UPDATE_TS DATE 
, PRINTED_ON DATE 
, STAFF_ID_PRINTED_BY NUMBER(18, 0) 
, NOTE_REFID NUMBER(18, 0) 
, RETURN_DATE DATE 
, RETURN_REASON_CD VARCHAR2(32 BYTE) 
, PARENT_LMREQ_ID NUMBER(18, 0) 
, REPRINT_PARENT_LMREQ_ID NUMBER(18, 0) 
, LMACT_CD VARCHAR2(32 BYTE) 
, LDIS_CD VARCHAR2(32 BYTE) 
, AUTHORIZED_LMREQ_ID NUMBER(18, 0) 
, ERROR_CODES VARCHAR2(4000 BYTE) 
, NMBR_REQUESTED NUMBER(18, 0) 
, PROGRAM_TYPE_CD VARCHAR2(32 BYTE) 
, MATERIAL_REQUEST_ID NUMBER(18, 0) 
, MAILING_ADDRESS_ID NUMBER(18, 0) 
, RESPONSE_DUE_DATE DATE 
, MAILED_DATE DATE 
, REJECT_REASON_CD VARCHAR2(32 BYTE) 
, STATUS_ERR_SRC VARCHAR2(32 BYTE) 
, LETTER_OUT_GENERATION_NUM NUMBER(38, 0) 
, PORTAL_VIEW_IND NUMBER(1, 0) 
, IS_DIGITAL_IND NUMBER(1, 0) 
, DP_UPDATED_BY VARCHAR2(80 BYTE) 
, DP_DATE_UPDATED DATE 
, DP_CREATED_BY VARCHAR2(80 BYTE) 
, DP_DATE_CREATED DATE 
) 
TABLESPACE MAXDAT_MIEB_DATA;

CREATE UNIQUE INDEX D_LETTER_REQUEST_PK ON D_LETTER_REQUEST  (DP_LETTER_REQUEST_ID ASC) TABLESPACE MAXDAT_MIEB_DATA;
ALTER TABLE D_LETTER_REQUEST ADD CONSTRAINT D_LETTER_REQUEST_PK PRIMARY KEY (DP_LETTER_REQUEST_ID) USING INDEX D_LETTER_REQUEST_PK ENABLE;

CREATE UNIQUE INDEX D_LETTER_REQUEST_UK ON D_LETTER_REQUEST (LETTER_REQUEST_ID ASC) TABLESPACE MAXDAT_MIEB_DATA;

CREATE SEQUENCE D_SEQ_LETTER_ID INCREMENT BY 1 MAXVALUE 9999999999999999999999999999 MINVALUE 1 CACHE 20;

create or replace trigger BUIR_LETTERREQ
 BEFORE INSERT OR UPDATE
 ON d_letter_request
 FOR EACH ROW
DECLARE
    v_seq_id     D_LETTER_REQUEST.dp_letter_request_id%TYPE;
BEGIN

  IF INSERTING THEN

      IF :NEW.dp_letter_request_id IS NULL THEN
        SElECT D_SEQ_LETTER_ID.NEXTVAL
        INTO v_seq_id
        FROM dual;

        :NEW.dp_letter_request_id       := v_seq_id;
      END IF;

    :NEW.dp_created_by := user;
    :NEW.dp_date_created := sysdate;

  END IF;

  :NEW.dp_updated_by := user;
  :NEW.dp_date_updated := sysdate;
  
END BUIR_LETTERREQ;
/

GRANT SELECT ON D_LETTER_REQUEST TO MAXDAT_MIEB_READ_ONLY;