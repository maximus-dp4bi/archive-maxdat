CREATE SEQUENCE  "EMRS_SEQ_PROGRAM_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 581 CACHE 5 NOORDER  NOCYCLE ;

GRANT SELECT ON "EMRS_SEQ_PROGRAM_ID" TO &role_name;

CREATE TABLE EMRS_D_PROGRAM
  (PROGRAM_ID NUMBER NOT NULL,
   PROGRAM_CODE VARCHAR2(32), 
   PROGRAM_NAME VARCHAR2(240), 
   PROGRAM_DESCRIPTION VARCHAR2(240),
   PROGRAM_CATEGORY VARCHAR2(240), 	  
   ACTIVE_INACTIVE VARCHAR2(1) ,
   START_DATE DATE, 
   END_DATE DATE ) TABLESPACE &tablespace_name ;


ALTER TABLE "EMRS_D_PROGRAM" ADD CONSTRAINT "PROGTYPE_TYPOFPROG_COMB_UK" UNIQUE ("PROGRAM_CODE")  USING INDEX TABLESPACE &tablespace_name  ENABLE;
ALTER TABLE "EMRS_D_PROGRAM" ADD CONSTRAINT "PROGTYPE_PK" PRIMARY KEY ("PROGRAM_ID")  USING INDEX TABLESPACE &tablespace_name  ENABLE;
  
GRANT SELECT ON "EMRS_D_PROGRAM" TO &role_name;

CREATE OR REPLACE TRIGGER "BIR_PROGRAMS" 
 BEFORE INSERT
 ON emrs_d_program
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_PROGRAM.program_id%TYPE;
BEGIN
  IF :NEW.program_id IS NULL THEN
    SElECT EMRS_SEQ_PROGRAM_ID.NEXTVAL
    INTO v_seq_id
    FROM dual;

    :NEW.program_id       := v_seq_id;
  END IF;
END BIR_PROGRAMS;
/
ALTER TRIGGER "BIR_PROGRAMS" ENABLE;
/

CREATE OR REPLACE VIEW EMRS_D_PROGRAM_SV
AS
SELECT program_code
       ,program_name
       ,program_category
       ,active_inactive       
       ,start_date
       ,end_date
FROM emrs_d_program;

CREATE OR REPLACE VIEW EMRS_D_PROGRAM_TYPE_SV
AS
SELECT program_code program_type_cd
       ,program_description program_type       
FROM emrs_d_program;

GRANT SELECT ON "EMRS_D_PROGRAM_SV" TO &role_name;
