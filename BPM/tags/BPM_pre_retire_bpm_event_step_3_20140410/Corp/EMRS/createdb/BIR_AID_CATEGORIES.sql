--------------------------------------------------------
--  DDL for Trigger BIR_AID_CATEGORIES
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "BIR_AID_CATEGORIES" 
 BEFORE INSERT
 ON emrs_d_aid_category
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_AID_CATEGORY.aid_category_id%TYPE;
BEGIN
  IF :NEW.aid_category_id IS NULL THEN
    SElECT EMRS_SEQ_AID_CATEGORY_ID.NEXTVAL
    INTO v_seq_id
    FROM dual;

    :NEW.aid_category_id       := v_seq_id;
  END IF;
END BIR_AID_CATEGORIES;
/
ALTER TRIGGER "BIR_AID_CATEGORIES" ENABLE;
/
