--------------------------------------------------------
--  DDL for Trigger BIR_SELECTION_MISSING_INFO
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "BIR_SELECTION_MISSING_INFO" 
 BEFORE INSERT
 ON emrs_d_selection_missing_info
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_SELECTION_MISSING_INFO.selection_missing_info_id%TYPE;
BEGIN
  IF :NEW.selection_missing_info_id IS NULL THEN
    SElECT EMRS_SEQ_SELECTION_MI_ID.NEXTVAL
    INTO v_seq_id
    FROM dual;

    :NEW.selection_missing_info_id   := v_seq_id;
  END IF;
  :NEW.created_by := user;
  :NEW.date_created := sysdate;
END BIR_SELECTION_MISSING_INFO;
/
ALTER TRIGGER "BIR_SELECTION_MISSING_INFO" ENABLE;
/
