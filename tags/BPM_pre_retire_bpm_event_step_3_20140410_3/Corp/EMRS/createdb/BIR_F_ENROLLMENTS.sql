--------------------------------------------------------
--  DDL for Trigger BIR_F_ENROLLMENTS
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "BIR_F_ENROLLMENTS" 
 BEFORE INSERT
 ON emrs_f_enrollment
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_F_ENROLLMENT.enrollment_id%TYPE;
BEGIN
  IF :NEW.enrollment_id IS NULL THEN
    SElECT EMRS_SEQ_ENROLLMENT_ID.NEXTVAL
    INTO v_seq_id
    FROM dual;

    :NEW.enrollment_id       := v_seq_id;
  END IF;

  IF :NEW.enrollment_group_id IS NULL THEN
    :NEW.enrollment_group_id  := :NEW.enrollment_id;
  END IF;
  :NEW.date_created := sysdate;
  :NEW.created_by := user;
  :NEW.date_updated := sysdate;
  :NEW.updated_by := user;
END BIR_F_ENROLLMENTS;
/
ALTER TRIGGER "BIR_F_ENROLLMENTS" ENABLE;
/
 
 CREATE OR REPLACE TRIGGER "BUR_F_ENROLLMENTS" 
 BEFORE UPDATE
 ON emrs_f_enrollment
 FOR EACH ROW
BEGIN
  :NEW.date_updated := sysdate;
  :NEW.updated_by := user;
END BUR_F_ENROLLMENTS;
/
ALTER TRIGGER "BUR_F_ENROLLMENTS" ENABLE;
/
