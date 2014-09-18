--------------------------------------------------------
--  DDL for Trigger BIR_REJECTION_ERROR_REASONS
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "BIR_REJECTION_ERROR_REASONS" 
 BEFORE INSERT
 ON emrs_d_rejection_error_reason
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_REJECTION_ERROR_REASON.rejection_error_reason_id%TYPE;
BEGIN
  IF :NEW.rejection_error_reason_id IS NULL THEN
    SElECT EMRS_SEQ_REJECTN_ERR_REASON_ID.NEXTVAL
    INTO v_seq_id
    FROM dual;

    :NEW.rejection_error_reason_id       := v_seq_id;
  END IF;
END BIR_REJECTION_ERROR_REASONS;
/
ALTER TRIGGER "BIR_REJECTION_ERROR_REASONS" ENABLE;
/
