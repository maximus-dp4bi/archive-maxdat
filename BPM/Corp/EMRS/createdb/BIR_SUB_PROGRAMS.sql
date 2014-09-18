--------------------------------------------------------
--  DDL for Trigger BIR_SUB_PROGRAMS
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "BIR_SUB_PROGRAMS" 
 BEFORE INSERT
 ON emrs_d_sub_program
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_SUB_PROGRAM.sub_program_id%TYPE;
BEGIN
  IF :NEW.sub_program_id IS NULL THEN
    SElECT EMRS_SEQ_SUB_PROGRAM_ID.NEXTVAL
    INTO v_seq_id
    FROM dual;

    :NEW.sub_program_id       := v_seq_id;
  END IF;
END BIR_SUB_PROGRAMS;
/
ALTER TRIGGER "BIR_SUB_PROGRAMS" ENABLE;
/
