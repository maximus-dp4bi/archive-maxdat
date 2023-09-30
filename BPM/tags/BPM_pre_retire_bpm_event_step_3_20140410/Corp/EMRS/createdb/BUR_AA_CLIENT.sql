--------------------------------------------------------
--  DDL for Trigger BUR_AA_CLIENT
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "BUR_AA_CLIENT" 
 BEFORE UPDATE
 ON emrs_d_aa_client
 FOR EACH ROW
BEGIN
 :NEW.updated_by := user;
 :NEW.date_updated := sysdate;  
END BUR_AA_CLIENT; 
/
ALTER TRIGGER "BUR_AA_CLIENT" ENABLE;
/
