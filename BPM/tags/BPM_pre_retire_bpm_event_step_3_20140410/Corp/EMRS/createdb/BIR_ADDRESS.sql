--------------------------------------------------------
--  DDL for Trigger BIR_ADDRESS
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "BIR_ADDRESS" 
 BEFORE INSERT
 ON emrs_d_address
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_ADDRESS.address_id%TYPE;
BEGIN
  IF :NEW.address_id IS NULL THEN
    SElECT EMRS_SEQ_ADDRESS_ID.NEXTVAL
    INTO v_seq_id
    FROM dual;

    :NEW.address_id   := v_seq_id;
  END IF;
  :NEW.created_by := user;
  :NEW.date_created := sysdate;
END BIR_ADDRESS;
/
ALTER TRIGGER "BIR_ADDRESS" ENABLE;
/
