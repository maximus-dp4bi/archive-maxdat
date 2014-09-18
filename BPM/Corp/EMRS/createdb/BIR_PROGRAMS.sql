--------------------------------------------------------
--  DDL for Trigger BIR_PROGRAMS
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "BIR_PROGRAMS" 
 BEFORE INSERT
 ON emrs_d_program
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_PROGRAM.program_id%TYPE;
BEGIN
  IF :NEW.program_id IS NULL THEN
    SElECT EMRS_SEQ_PROGRAM_ID.NEXTVAL
    INTO v_seq_id
    FROM dual;

    :NEW.program_id       := v_seq_id;
  END IF;
END BIR_PROGRAMS;
/
ALTER TRIGGER "BIR_PROGRAMS" ENABLE;
/
