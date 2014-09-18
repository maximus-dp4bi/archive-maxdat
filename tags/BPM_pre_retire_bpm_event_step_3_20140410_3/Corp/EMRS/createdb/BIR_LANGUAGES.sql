--------------------------------------------------------
--  DDL for Trigger BIR_LANGUAGES
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "BIR_LANGUAGES" 
 BEFORE INSERT
 ON emrs_d_language
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_LANGUAGE.language_code_id%TYPE;
BEGIN
  IF :NEW.language_code_id IS NULL THEN
    SElECT EMRS_SEQ_LANGUAGE_CODE_ID.NEXTVAL
    INTO v_seq_id
    FROM dual;

    :NEW.language_code_id       := v_seq_id;
  END IF;
END BIR_LANGUAGES;
/
ALTER TRIGGER "BIR_LANGUAGES" ENABLE;
/
