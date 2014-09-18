--------------------------------------------------------
--  DDL for Trigger BIR_STAFF_PEOPLE
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "BIR_STAFF_PEOPLE" 
 BEFORE INSERT
 ON emrs_d_staff_people
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_STAFF_PEOPLE.staff_id%TYPE;
BEGIN
  IF :NEW.staff_id IS NULL THEN
    SElECT EMRS_SEQ_STAFF_ID.NEXTVAL
    INTO v_seq_id
    FROM dual;

    :NEW.staff_id       := v_seq_id;
  END IF;
END BIR_STAFF_PEOPLE;
/
ALTER TRIGGER "BIR_STAFF_PEOPLE" ENABLE;
/
