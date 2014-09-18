--------------------------------------------------------
--  DDL for Trigger BIR_CITIZENSHIP_STATUS
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "BIR_CITIZENSHIP_STATUS" 
 BEFORE INSERT
 ON emrs_d_citizenship_status
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_CITIZENSHIP_STATUS.citizenship_id%TYPE;
BEGIN
  IF :NEW.citizenship_id IS NULL THEN
    SElECT EMRS_SEQ_CITIZENSHIP_ID.NEXTVAL
    INTO v_seq_id
    FROM dual;

    :NEW.citizenship_id       := v_seq_id;
  END IF;
END BIR_CITIZENSHIP_STATUS;
/
ALTER TRIGGER "BIR_CITIZENSHIP_STATUS" ENABLE;
/
