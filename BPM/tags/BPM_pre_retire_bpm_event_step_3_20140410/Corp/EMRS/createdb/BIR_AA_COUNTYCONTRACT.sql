--------------------------------------------------------
--  DDL for Trigger BIR_AA_COUNTYCONTRACT
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "BIR_AA_COUNTYCONTRACT" 
 BEFORE INSERT
 ON emrs_d_aa_countycontract
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_AA_COUNTYCONTRACT.aa_countycontract_id%TYPE;
BEGIN
  IF :NEW.aa_countycontract_id IS NULL THEN
    SElECT EMRS_SEQ_AA_COUNTYCONTRACT_ID.NEXTVAL
    INTO v_seq_id
    FROM dual;
  
    :NEW.aa_countycontract_id   := v_seq_id;    
  END IF;
 :NEW.created_by := user;
 :NEW.date_created := sysdate;  
 :NEW.updated_by := user;
 :NEW.date_updated := sysdate;  
END BIR_AA_COUNTYCONTRACT; 
/
ALTER TRIGGER "BIR_AA_COUNTYCONTRACT" ENABLE;
/
