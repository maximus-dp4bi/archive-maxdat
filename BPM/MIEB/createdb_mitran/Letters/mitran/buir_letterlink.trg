create or replace trigger BUIR_LETTERLINK
 BEFORE INSERT OR UPDATE
 ON d_letter_request_link
 FOR EACH ROW
DECLARE
    v_seq_id     D_LETTER_REQUEST_LINK.dp_letter_link_id%TYPE;
BEGIN

  IF INSERTING THEN

      IF :NEW.dp_letter_link_id IS NULL THEN
        SElECT D_SEQ_LETTERLINK_ID.NEXTVAL
        INTO v_seq_id
        FROM dual;

        :NEW.dp_letter_link_id       := v_seq_id;
      END IF;

    :NEW.dp_created_by := user;
    :NEW.dp_date_created := sysdate;

  END IF;

  :NEW.dp_updated_by := user;
  :NEW.dp_date_updated := sysdate;

END BUIR_LETTERLINK;
/

