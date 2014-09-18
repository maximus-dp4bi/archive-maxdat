--------------------------------------------------------
--  DDL for Trigger BIR_TERMINATION_REASONS
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "BIR_TERMINATION_REASONS" 
 BEFORE INSERT
 ON emrs_d_termination_reason
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_TERMINATION_REASON.term_reason_code_id%TYPE;
BEGIN
  IF :NEW.term_reason_code_id IS NULL THEN
    SElECT EMRS_SEQ_TERM_REASON_CODE_ID.NEXTVAL
    INTO v_seq_id
    FROM dual;

    :NEW.term_reason_code_id       := v_seq_id;
  END IF;
END BIR_TERMINATION_REASONS;
/
ALTER TRIGGER "BIR_TERMINATION_REASONS" ENABLE;
/
