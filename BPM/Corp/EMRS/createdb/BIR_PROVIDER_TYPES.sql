--------------------------------------------------------
--  DDL for Trigger BIR_PROVIDER_TYPES
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "BIR_PROVIDER_TYPES" 
 BEFORE INSERT
 ON emrs_d_provider_type
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_PROVIDER_TYPE.provider_type_id%TYPE;
BEGIN
  IF :NEW.provider_type_id IS NULL THEN
    SElECT EMRS_SEQ_PROVIDER_TYPE_CODE_ID.NEXTVAL
    INTO v_seq_id
    FROM dual;

    :NEW.provider_type_id       := v_seq_id;
  END IF;
END BIR_PROVIDER_TYPES;
/
ALTER TRIGGER "BIR_PROVIDER_TYPES" ENABLE;
/
