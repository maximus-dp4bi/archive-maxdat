--------------------------------------------------------
--  DDL for Trigger BIR_COUNTIES
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "BIR_COUNTIES" 
 BEFORE INSERT
 ON emrs_d_county
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_COUNTY.county_id%TYPE;
BEGIN
  IF :NEW.county_id IS NULL THEN
    SElECT EMRS_SEQ_COUNTIES_ID.NEXTVAL
    INTO v_seq_id
    FROM dual;

    :NEW.county_id       := v_seq_id;
  END IF;
END BIR_COUNTIES;
/
ALTER TRIGGER "BIR_COUNTIES" ENABLE;
/
