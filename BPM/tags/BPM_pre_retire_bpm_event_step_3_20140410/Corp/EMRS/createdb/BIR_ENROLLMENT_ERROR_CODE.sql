--------------------------------------------------------
--  DDL for Trigger BIR_ENROLLMENT_ERROR_CODE
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "BIR_ENROLLMENT_ERROR_CODE" 
 BEFORE INSERT
 ON emrs_d_enrollment_error_code
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_ENROLLMENT_ERROR_CODE.enrollment_error_code_id%TYPE;
BEGIN
  IF :NEW.enrollment_error_code_id IS NULL THEN
    SElECT EMRS_SEQ_ENRL_ERROR_CODE_ID.NEXTVAL
    INTO v_seq_id
    FROM dual;

    :NEW.enrollment_error_code_id   := v_seq_id;
  END IF;
END BIR_ENROLLMENT_ERROR_CODE;
/
ALTER TRIGGER "BIR_ENROLLMENT_ERROR_CODE" ENABLE;
/
