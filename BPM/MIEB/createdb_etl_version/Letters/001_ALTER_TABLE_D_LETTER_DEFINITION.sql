ALTER TABLE D_LETTER_DEFINITION ADD
(
    job_ctrl_id                 number(38,0)
);

DROP SEQUENCE D_SEQ_LMDEF_ID;
CREATE SEQUENCE  D_SEQ_LMDEF_ID  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 99999 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL;

ALTER TABLE D_LETTER_DEFINITION ADD CONSTRAINT D_LETTER_DEFINITION_UK UNIQUE
(
    LETTER_SOURCE_CODE,
    NAME
);


create or replace TRIGGER "BUIR_LMDEF"
 BEFORE INSERT OR UPDATE
 ON d_letter_definition
 FOR EACH ROW
DECLARE
    v_seq_id     D_LETTER_definition.lmdef_id%TYPE;
BEGIN

  IF INSERTING THEN

      IF :NEW.lmdef_id IS NULL THEN
        SElECT D_SEQ_LMDEF_ID.NEXTVAL
        INTO v_seq_id
        FROM dual;

        :NEW.lmdef_id       := v_seq_id;
      END IF;

    :NEW.created_by := user;
    :NEW.create_ts := sysdate;

  END IF;

  :NEW.effective_from_date    :=  NVL(:NEW.effective_from_date, TO_DATE(TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - 1 || '-01-01', 'YYYY-MM-DD'));
  :NEW.effective_thru_date    :=  NVL(:NEW.effective_thru_date, TO_DATE('7777-01-01', 'YYYY-MM-DD'));

  :NEW.updated_by := user;
  :NEW.update_ts := sysdate;

END BUIR_LMDEF;
/
