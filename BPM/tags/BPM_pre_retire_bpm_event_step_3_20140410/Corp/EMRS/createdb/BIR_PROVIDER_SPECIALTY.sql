--------------------------------------------------------
--  DDL for Trigger BIR_PROVIDER_SPECIALTY
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "BIR_PROVIDER_SPECIALTY" 
 BEFORE INSERT
 ON emrs_d_provider_specialty
 FOR EACH ROW
BEGIN 
 :NEW.created_by := user;
 :NEW.date_created := sysdate;  
END BIR_PROVIDER_SPECIALTY; 
/
ALTER TRIGGER "BIR_PROVIDER_SPECIALTY" ENABLE;
/
