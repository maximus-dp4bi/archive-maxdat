--------------------------------------------------------
--  DDL for Trigger BIR_AA_CONTRACT
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "BIR_AA_CONTRACT" 
 BEFORE INSERT
 ON emrs_d_aa_contract
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_AA_CONTRACT.aa_contract_id%TYPE;
BEGIN
  IF :NEW.aa_contract_id IS NULL THEN
    SElECT EMRS_SEQ_AA_CONTRACT_ID.NEXTVAL
    INTO v_seq_id
    FROM dual;
  
    :NEW.aa_contract_id   := v_seq_id;    
  END IF;
 :NEW.created_by := user;
 :NEW.date_created := sysdate;  
 :NEW.updated_by := user;
 :NEW.date_updated := sysdate;  
END BIR_AA_CONTRACT; 
/
ALTER TRIGGER "BIR_AA_CONTRACT" ENABLE;
/
