--------------------------------------------------------
--  DDL for Trigger BIR_RACES
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "BIR_RACES" 
 BEFORE INSERT
 ON emrs_d_race
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_RACE.race_id%TYPE;
BEGIN
  IF :NEW.race_id IS NULL THEN
    SElECT EMRS_SEQ_RACE_ID.NEXTVAL
    INTO v_seq_id
    FROM dual;

    :NEW.race_id       := v_seq_id;
  END IF;
END BIR_RACES;
/
ALTER TRIGGER "BIR_RACES" ENABLE;
/
