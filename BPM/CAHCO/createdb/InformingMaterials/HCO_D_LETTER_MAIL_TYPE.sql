CREATE SEQUENCE  "HCO_SEQ_LTRMAILTYPE_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 582 CACHE 5 NOORDER  NOCYCLE ;

GRANT SELECT ON "HCO_SEQ_LTRMAILTYPE_ID" TO "MAXDAT_READ_ONLY";

CREATE TABLE HCO_D_LETTER_MAIL_TYPE(
DP_MAIL_TYPE_ID NUMBER(10),
MATERIAL_TYPE VARCHAR2(255),
TYPE_DESCRIPTION VARCHAR2(255),
TYPE_CODE VARCHAR2(255),
MANDATORY_VOLUNTARY VARCHAR2(255),
SPD_FLAG VARCHAR2(1)) TABLESPACE MAXDAT_DATA;

ALTER TABLE "HCO_D_LETTER_MAIL_TYPE" ADD CONSTRAINT "MT_MAILTYPEID_PK" PRIMARY KEY ("DP_MAIL_TYPE_ID") USING INDEX TABLESPACE "MAXDAT_INDX"  ENABLE;
CREATE INDEX HCODLTRMAILTYPE_IDX01 ON HCO_D_LETTER_MAIL_TYPE(MATERIAL_TYPE) TABLESPACE MAXDAT_INDX; 
CREATE INDEX HCODLTRMAILTYPE_IDX02 ON HCO_D_LETTER_MAIL_TYPE(SPD_FLAG) TABLESPACE MAXDAT_INDX; 
CREATE INDEX HCODLTRMAILTYPE_IDX03 ON HCO_D_LETTER_MAIL_TYPE(TYPE_CODE) TABLESPACE MAXDAT_INDX; 

GRANT SELECT ON "HCO_D_LETTER_MAIL_TYPE" TO "MAXDAT_READ_ONLY";

CREATE OR REPLACE TRIGGER "BIR_HCO_D_LTRMAILTYPE" 
 BEFORE INSERT
 ON hco_d_letter_mail_type
 FOR EACH ROW
DECLARE
    v_seq_id     HCO_D_LETTER_MAIL_TYPE.dp_mail_type_id%TYPE;
BEGIN
  IF :NEW.dp_mail_type_id IS NULL THEN
      SElECT HCO_SEQ_MAILTYPE_ID.NEXTVAL
      INTO v_seq_id
      FROM dual;

      :NEW.dp_mail_type_id   := v_seq_id;
  END IF;

END BIR_HCO_D_LTRMAILTYPE;
/
ALTER TRIGGER "BIR_HCO_D_LTRMAILTYPE" ENABLE;
/