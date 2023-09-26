CREATE SEQUENCE  "EMRS_SEQ_INC_REF_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 2 NOORDER  NOCYCLE ;

GRANT SELECT ON "EMRS_SEQ_INC_REF_ID" TO "MAXDAT_READ_ONLY";

CREATE TABLE HCO_D_INCIDENT_REFERRAL
  (Inc_Ref_id NUMBER NOT NULL, 
   Subject VARCHAR2(250), 
   Referral VARCHAR2(1) Default 'N', 
   Referral_Type VARCHAR2(250), 
   Issue_Type VARCHAR2(250)) TABLESPACE MAXDAT_DATA ;

grant select on HCO_D_INCIDENT_REFERRAL to MAXDAT_READ_ONLY;
grant select, insert, update on HCO_D_INCIDENT_REFERRAL to MAXDAT_OLTP_SIU;
grant select, insert, update, delete on HCO_D_INCIDENT_REFERRAL to MAXDAT_OLTP_SIUD;

CREATE OR REPLACE TRIGGER "BIR_INCIDENT_REFERRAL" 
 BEFORE INSERT
 ON HCO_D_INCIDENT_REFERRAL
 FOR EACH ROW
DECLARE
    v_seq_id     HCO_D_INCIDENT_REFERRAL.Inc_Ref_id%TYPE;
BEGIN
  IF :NEW.Inc_Ref_id IS NULL THEN
    SElECT EMRS_SEQ_INC_REF_ID.NEXTVAL
    INTO v_seq_id
    FROM dual;

    :NEW.Inc_Ref_id       := v_seq_id;
  END IF;
END BIR_INCIDENT_REFERRAL;
/

ALTER TRIGGER "BIR_INCIDENT_REFERRAL" ENABLE;
/

CREATE OR REPLACE VIEW HCO_D_INCIDENT_REFERRAL_SV
AS
SELECT  Inc_Ref_id
       ,Subject
       ,Referral
       ,Referral_Type
       ,Issue_Type
FROM HCO_D_INCIDENT_REFERRAL;

GRANT SELECT ON "HCO_D_INCIDENT_REFERRAL_SV" TO "MAXDAT_READ_ONLY";



  
