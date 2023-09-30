CREATE SEQUENCE  "EMRS_SEQ_EMRGCYDENR_HIST_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 341 CACHE 20 NOORDER  NOCYCLE ;

GRANT SELECT ON "EMRS_SEQ_EMRGCYDENR_HIST_ID" TO "MAXDAT_READ_ONLY";

CREATE TABLE MAXDAT.EMRS_D_EMRGCY_DENR_HIST
    (
      EMRGCY_DENR_HIST_ID     INTEGER
    , EMRGCY_DENR_ID          INTEGER
    , EMRGCY_DENR_STATUS_CODE VARCHAR2 (2)
    , DATE_OF_VALIDITY_START  DATE
    , DATE_OF_VALIDITY_END    DATE
    , RECORD_DATE             DATE
    , RECORD_NAME             VARCHAR2 (50)
    , CREATED_BY              VARCHAR2 (80)
    , DATE_CREATED            DATE
    , UPDATED_BY              VARCHAR2 (80)
    , DATE_UPDATED            DATE
    , DP_EMRGCY_DENR_HIST_ID  NUMBER NOT NULL
    , EMRGCY_DENR_REASON_CODE VARCHAR2 (2),
    CONSTRAINT EMRGCYDENR_EDHISTIDPK PRIMARY KEY (DP_EMRGCY_DENR_HIST_ID),
    CONSTRAINT EMRGCYDENR_EDHISTID_UK UNIQUE (EMRGCY_DENR_HIST_ID)
    )
    TABLESPACE MAXDAT_DATA
    STORAGE (BUFFER_POOL DEFAULT);
  
GRANT SELECT ON "EMRS_D_EMRGCY_DENR_HIST" TO "MAXDAT_READ_ONLY";

CREATE OR REPLACE TRIGGER "BUIR_EMRGCY_DENR_HIST" 
 BEFORE INSERT OR UPDATE
 ON emrs_d_emrgcy_denr_hist
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_EMRGCY_DENR_HIST.dp_emrgcy_denr_hist_id%TYPE;
BEGIN
  IF INSERTING THEN  
    IF :NEW.dp_emrgcy_denr_hist_id IS NULL THEN
      SElECT EMRS_SEQ_EMRGCYDENR_HIST_ID.NEXTVAL
      INTO v_seq_id
      FROM dual;

      :NEW.dp_emrgcy_denr_hist_id       := v_seq_id;
    END IF;
    :NEW.created_by := user;
    :NEW.date_created := sysdate;
  END IF;  
  :NEW.updated_by := user;
  :NEW.date_updated := sysdate;
END BUIR_EMRGCY_DENR_HIST;
/
ALTER TRIGGER "BUIR_EMRGCY_DENR_HIST" ENABLE;
/

CREATE OR REPLACE VIEW MAXDAT.EMRS_D_EMRGCY_DENR_HIST_SV
AS
SELECT emrgcy_denr_hist_id,
emrgcy_denr_id,
emrgcy_denr_status_code,
date_of_validity_start,
date_of_validity_end,
record_date,
record_name,
created_by,
date_created,
updated_by,
date_updated,
dp_emrgcy_denr_hist_id,
EMRGCY_DENR_REASON_CODE
FROM emrs_d_emrgcy_denr_hist;

GRANT SELECT ON "EMRS_D_EMRGCY_DENR_HIST_SV" TO "MAXDAT_READ_ONLY";