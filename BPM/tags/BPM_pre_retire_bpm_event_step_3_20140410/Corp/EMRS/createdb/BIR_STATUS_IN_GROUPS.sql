--------------------------------------------------------
--  DDL for Trigger BIR_STATUS_IN_GROUPS
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "BIR_STATUS_IN_GROUPS" 
 BEFORE INSERT
 ON emrs_d_status_in_group
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_STATUS_IN_GROUP.status_in_group_id%TYPE;
BEGIN
  IF :NEW.status_in_group_id IS NULL THEN
    SElECT EMRS_SEQ_STAT_IN_GRP_ID.NEXTVAL
    INTO v_seq_id
    FROM dual;

    :NEW.status_in_group_id       := v_seq_id;
  END IF;
END BIR_STATUS_IN_GROUPS;
/
ALTER TRIGGER "BIR_STATUS_IN_GROUPS" ENABLE;
/
