--------------------------------------------------------
--  DDL for Trigger BIR_ZIPCODE
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "BIR_ZIPCODE" 
 BEFORE INSERT
 ON emrs_d_zipcode
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_ZIPCODE.zipcode_id%TYPE;
BEGIN
  IF :NEW.zipcode_id IS NULL THEN
    SElECT EMRS_SEQ_ZIPCODE_ID.NEXTVAL
    INTO v_seq_id
    FROM dual;

    :NEW.zipcode_id   := v_seq_id;
  END IF;
END BIR_ZIPCODE;
/
ALTER TRIGGER "BIR_ZIPCODE" ENABLE;
/
