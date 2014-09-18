--------------------------------------------------------
--  DDL for Trigger BUR_AA_PLAN_PERCENTAGE
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "BUR_AA_PLAN_PERCENTAGE" 
 BEFORE UPDATE
 ON emrs_d_plan_percentage
 FOR EACH ROW
BEGIN  
 :NEW.updated_by := user;
 :NEW.date_updated := sysdate;  
END BUR_AA_PLAN_PERCENTAGE; 
/
ALTER TRIGGER "BUR_AA_PLAN_PERCENTAGE" ENABLE;
/
