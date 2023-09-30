--------------------------------------------------------
--  DDL for Trigger BIR_NOTIFICATIONS
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "BIR_NOTIFICATIONS" 
 BEFORE INSERT
 ON emrs_d_notification
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_NOTIFICATION.notification_id%TYPE;
BEGIN
  IF :NEW.notification_id IS NULL THEN
    SElECT EMRS_SEQ_NOTIFICATION_ID.NEXTVAL
    INTO v_seq_id
    FROM dual;

    :NEW.notification_id   := v_seq_id;
  END IF;
  :NEW.created_by := user;
  :NEW.date_created := sysdate;
END BIR_NOTIFICATIONS;
/
ALTER TRIGGER "BIR_NOTIFICATIONS" ENABLE;
/
