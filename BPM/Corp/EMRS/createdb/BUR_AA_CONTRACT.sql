--------------------------------------------------------
--  DDL for Trigger BUR_AA_CONTRACT
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "BUR_AA_CONTRACT" 
 BEFORE UPDATE
 ON emrs_d_aa_contract
 FOR EACH ROW
BEGIN
 :NEW.updated_by := user;
 :NEW.date_updated := sysdate;  
END BUR_AA_CONTRACT; 
/
ALTER TRIGGER "BUR_AA_CONTRACT" ENABLE;
/
