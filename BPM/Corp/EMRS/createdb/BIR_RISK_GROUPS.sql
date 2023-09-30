--------------------------------------------------------
--  DDL for Trigger BIR_RISK_GROUPS
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "BIR_RISK_GROUPS" 
 BEFORE INSERT
 ON emrs_d_risk_group
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_RISK_GROUP.risk_group_id%TYPE;
BEGIN
  IF :NEW.risk_group_id IS NULL THEN
    SElECT EMRS_SEQ_RISK_GROUP_ID.NEXTVAL
    INTO v_seq_id
    FROM dual;

    :NEW.risk_group_id       := v_seq_id;
  END IF;
END BIR_RISK_GROUPS;
/
ALTER TRIGGER "BIR_RISK_GROUPS" ENABLE;
/
