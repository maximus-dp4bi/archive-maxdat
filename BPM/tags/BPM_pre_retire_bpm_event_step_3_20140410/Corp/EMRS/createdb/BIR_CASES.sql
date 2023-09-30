--------------------------------------------------------
--  DDL for Trigger BIR_CASES
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "BIR_CASES" 
 BEFORE INSERT
 ON emrs_d_case
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_CASE.case_id%TYPE;
BEGIN
  IF :NEW.case_id IS NULL THEN
    SElECT EMRS_SEQ_CASES_ID.NEXTVAL
    INTO v_seq_id
    FROM dual;

    :NEW.case_id       := v_seq_id;
 END IF;
 IF :NEW.current_flag IS NULL THEN
   :NEW.current_flag := 'Y';
   :NEW.date_of_validity_start := :NEW.record_date;
   :NEW.date_of_validity_end := TO_DATE('12/31/2050','MM/DD/YYYY');
   :NEW.version := 1;
 END IF;
 :NEW.created_by := user;
 :NEW.date_created := sysdate;
END BIR_CASES;
/
ALTER TRIGGER "BIR_CASES" ENABLE;
/

 CREATE OR REPLACE TRIGGER "BUR_CASES" 
 BEFORE UPDATE
 ON emrs_d_case
 FOR EACH ROW
BEGIN
 :NEW.updated_by := user;
 :NEW.date_updated := sysdate;
END BUR_CASES;
/
ALTER TRIGGER "BUR_CASES" ENABLE;
/
