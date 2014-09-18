--------------------------------------------------------
--  DDL for Trigger BIR_CLIENTS
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "BIR_CLIENTS" 
 BEFORE INSERT
 ON emrs_d_client
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_CLIENT.client_id%TYPE;
BEGIN
  IF :NEW.client_id IS NULL THEN
    SElECT EMRS_SEQ_CLIENT_ID.NEXTVAL
    INTO v_seq_id
    FROM dual;

    :NEW.client_id       := v_seq_id;
  END IF;
  :NEW.created_by := user;
  :NEW.date_created := sysdate;
END BIR_CLIENTS;
/
ALTER TRIGGER "BIR_CLIENTS" ENABLE;
/

  CREATE OR REPLACE TRIGGER "BUR_CLIENTS" 
 BEFORE UPDATE
 ON emrs_d_client
 FOR EACH ROW
BEGIN
  :NEW.updated_by := user;
  :NEW.date_updated := sysdate;
END BUR_CLIENTS;
/
ALTER TRIGGER "BUR_CLIENTS" ENABLE;
/
