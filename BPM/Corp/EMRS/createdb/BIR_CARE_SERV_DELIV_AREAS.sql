--------------------------------------------------------
--  DDL for Trigger BIR_CARE_SERV_DELIV_AREAS
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "BIR_CARE_SERV_DELIV_AREAS" 
 BEFORE INSERT
 ON emrs_d_care_serv_deliv_area
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_CARE_SERV_DELIV_AREA.csda_id%TYPE;
BEGIN
  IF :NEW.csda_id IS NULL THEN
    SElECT EMRS_SEQ_CARE_SERV_DELIV_AREA.NEXTVAL
    INTO v_seq_id
    FROM dual;

    :NEW.csda_id       := v_seq_id;
  END IF;
END BIR_CARE_SERV_DELIV_AREAS;
/
ALTER TRIGGER "BIR_CARE_SERV_DELIV_AREAS" ENABLE;
/
