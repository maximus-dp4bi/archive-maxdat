--------------------------------------------------------
--  DDL for Trigger BIR_PROVIDERS
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "BIR_PROVIDERS" 
 BEFORE INSERT
 ON emrs_d_provider
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_PROVIDER.provider_id%TYPE;
BEGIN
  IF :NEW.provider_id IS NULL THEN
    SElECT EMRS_SEQ_PROVIDER_ID.NEXTVAL
    INTO v_seq_id
    FROM dual;

    :NEW.provider_id       := v_seq_id;
  END IF;
  :NEW.created_by := user;
  :NEW.date_created := sysdate;
END BIR_PROVIDERS;
/
ALTER TRIGGER "BIR_PROVIDERS" ENABLE;
/
  CREATE OR REPLACE TRIGGER "BUR_PROVIDERS" 
 BEFORE UPDATE
 ON emrs_d_provider
 FOR EACH ROW
BEGIN
  :NEW.updated_by := user;
  :NEW.date_updated := sysdate;
END BUR_PROVIDERS;
/
ALTER TRIGGER "BUR_PROVIDERS" ENABLE;
/
