--------------------------------------------------------
--  DDL for Trigger BUR_AA_COUNTYCONTRACT
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "BUR_AA_COUNTYCONTRACT" 
 BEFORE UPDATE
 ON emrs_d_aa_countycontract
 FOR EACH ROW
BEGIN
 :NEW.updated_by := user;
 :NEW.date_updated := sysdate;  
END BUR_AA_COUNTYCONTRACT; 
/
ALTER TRIGGER "BUR_AA_COUNTYCONTRACT" ENABLE;
/
