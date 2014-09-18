--------------------------------------------------------
--  DDL for Trigger BIR_COVERAGE_CATEGORIES
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "BIR_COVERAGE_CATEGORIES" 
 BEFORE INSERT
 ON emrs_d_coverage_category
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_COVERAGE_CATEGORY.coverage_category_id%TYPE;
BEGIN
  IF :NEW.coverage_category_id IS NULL THEN
    SElECT EMRS_SEQ_COVERAGE_CATEGORY_ID.NEXTVAL
    INTO v_seq_id
    FROM dual;

    :NEW.coverage_category_id       := v_seq_id;
  END IF;
END BIR_COVERAGE_CATEGORIES;
/
ALTER TRIGGER "BIR_COVERAGE_CATEGORIES" ENABLE;
/
