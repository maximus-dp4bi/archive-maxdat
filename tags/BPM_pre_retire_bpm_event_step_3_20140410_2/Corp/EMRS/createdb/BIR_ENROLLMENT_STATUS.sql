--------------------------------------------------------
--  DDL for Trigger BIR_ENROLLMENT_STATUS
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "BIR_ENROLLMENT_STATUS" 
 BEFORE INSERT
 ON emrs_d_enrollment_status
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_ENROLLMENT_STATUS.enrollment_status_id%TYPE;
BEGIN
  IF :NEW.enrollment_status_id IS NULL THEN
    SElECT EMRS_SEQ_ENROLLMENT_STATUS_ID.NEXTVAL
    INTO v_seq_id
    FROM dual;

    :NEW.enrollment_status_id   := v_seq_id;
  END IF;
END BIR_ENROLLMENT_STATUS;
/
ALTER TRIGGER "BIR_ENROLLMENT_STATUS" ENABLE;
/
