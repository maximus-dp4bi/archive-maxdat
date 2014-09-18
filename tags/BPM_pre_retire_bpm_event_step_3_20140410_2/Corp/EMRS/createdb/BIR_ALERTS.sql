--------------------------------------------------------
--  DDL for Trigger BIR_AA_CLIENT
--------------------------------------------------------

 CREATE OR REPLACE TRIGGER "BIR_ALERT" 
 BEFORE INSERT
 ON emrs_d_alert
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_ALERT.alert_id%TYPE;
BEGIN
  IF :NEW.alert_id IS NULL THEN
    SElECT EMRS_SEQ_ALERT_ID.NEXTVAL
    INTO v_seq_id
    FROM dual;
  
    :NEW.alert_id   := v_seq_id;    
  END IF;
 :NEW.created_by := user;
 :NEW.date_created := sysdate;  
 :NEW.updated_by := user;
 :NEW.date_updated := sysdate;  
END BIR_ALERT; 
/
ALTER TRIGGER "BIR_ALERT" ENABLE;
/

  CREATE OR REPLACE TRIGGER "BUR_ALERT" 
 BEFORE UPDATE
 ON emrs_d_alert
 FOR EACH ROW
BEGIN
 :NEW.updated_by := user;
 :NEW.date_updated := sysdate;  
END BUR_ALERT; 
/
ALTER TRIGGER "BUR_ALERT" ENABLE;
/
