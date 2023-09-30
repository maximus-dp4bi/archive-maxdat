CREATE OR REPLACE TRIGGER "BIU_LETTER_ADJUST_FORM_HIST"
 BEFORE INSERT
 ON LETTER_ADJUSTMENT_FORM_HIST
 FOR EACH ROW
DECLARE
    v_seq_id     LETTER_ADJUSTMENT_FORM_HIST.LETTER_ADJUSTMENT_FORM_HIST_ID%TYPE;
BEGIN
  IF INSERTING THEN
    IF :NEW.LETTER_ADJUSTMENT_FORM_HIST_ID IS NULL THEN
      SElECT SEQ_LAFORM_HIST_ID.NEXTVAL
      INTO v_seq_id
      FROM dual;

      :NEW.LETTER_ADJUSTMENT_FORM_HIST_ID       := v_seq_id;
      :NEW.HIST_CREATION_DATE := SYSDATE;
    END IF;
  END IF;

END BIU_LETTER_ADJUST_FORM;
/
