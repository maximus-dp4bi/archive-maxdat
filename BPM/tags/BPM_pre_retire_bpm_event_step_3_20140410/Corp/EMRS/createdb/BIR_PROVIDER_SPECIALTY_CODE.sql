--------------------------------------------------------
--  DDL for Trigger BIR_PROVIDER_SPECIALTY_CODE
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "BIR_PROVIDER_SPECIALTY_CODE" 
 BEFORE INSERT
 ON emrs_d_provider_specialty_code
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_PROVIDER_SPECIALTY_CODE.provider_specialty_code_id%TYPE;
BEGIN
  IF :NEW.provider_specialty_code_id IS NULL THEN
    SElECT EMRS_SEQ_PROVDR_SPECTY_CODE_ID.NEXTVAL
    INTO v_seq_id
    FROM dual;

    :NEW.provider_specialty_code_id       := v_seq_id;
  END IF;
END BIR_PROVIDER_SPECIALTY_CODE;
/
ALTER TRIGGER "BIR_PROVIDER_SPECIALTY_CODE" ENABLE;
/
