--------------------------------------------------------
--  DDL for Trigger BIR_AA_CLIENT
--------------------------------------------------------

 CREATE OR REPLACE TRIGGER "BIR_AA_CLIENT" 
 BEFORE INSERT
 ON emrs_d_aa_client
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_AA_CLIENT.aa_client_id%TYPE;
BEGIN
  IF :NEW.aa_client_id IS NULL THEN
    SElECT EMRS_SEQ_AA_CLIENT_ID.NEXTVAL
    INTO v_seq_id
    FROM dual;
  
    :NEW.aa_client_id   := v_seq_id;    
  END IF;
 :NEW.created_by := user;
 :NEW.date_created := sysdate;  
 :NEW.updated_by := user;
 :NEW.date_updated := sysdate;  
END BIR_AA_CLIENT; 
/
ALTER TRIGGER "BIR_AA_CLIENT" ENABLE;
/
