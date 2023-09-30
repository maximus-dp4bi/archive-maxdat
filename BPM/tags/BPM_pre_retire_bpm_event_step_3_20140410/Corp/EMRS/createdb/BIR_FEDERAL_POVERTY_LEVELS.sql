--------------------------------------------------------
--  DDL for Trigger BIR_FEDERAL_POVERTY_LEVELS
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "BIR_FEDERAL_POVERTY_LEVELS" 
 BEFORE INSERT
 ON emrs_d_federal_poverty_level
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_FEDERAL_POVERTY_LEVEL.fpl_id%TYPE;
BEGIN
  IF :NEW.fpl_id IS NULL THEN
    SElECT EMRS_SEQ_FPL_ID.NEXTVAL
    INTO v_seq_id
    FROM dual;

    :NEW.fpl_id       := v_seq_id;
  END IF;
END BIR_FEDERAL_POVERTY_LEVELS;
/
ALTER TRIGGER "BIR_FEDERAL_POVERTY_LEVELS" ENABLE;
/
