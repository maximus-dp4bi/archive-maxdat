--------------------------------------------------------
--  DDL for Trigger BIR_SELECTION_SOURCES
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "BIR_SELECTION_SOURCES" 
 BEFORE INSERT
 ON emrs_d_selection_source
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_SELECTION_SOURCE.selection_source_id%TYPE;
BEGIN
  IF :NEW.selection_source_id IS NULL THEN
    SElECT EMRS_SEQ_SELECTION_SOURCE_ID.NEXTVAL
    INTO v_seq_id
    FROM dual;

    :NEW.selection_source_id       := v_seq_id;
  END IF;
END BIR_SELECTION_SOURCES;
/
ALTER TRIGGER "BIR_SELECTION_SOURCES" ENABLE;
/
