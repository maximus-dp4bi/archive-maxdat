
CREATE TABLE D_PROGRAM
  (PROGRAM_CODE VARCHAR2(32), 
   PROGRAM_NAME VARCHAR2(240), 
   REPORT_LABEL VARCHAR2(100),
   PROGRAM_CATEGORY VARCHAR2(240), 	  
   ACTIVE_INACTIVE VARCHAR2(1) ,
   START_DATE DATE, 
   END_DATE DATE ) TABLESPACE &tablespace_name ;


ALTER TABLE "D_PROGRAM" ADD CONSTRAINT "PROGTYPE_PK" PRIMARY KEY ("PROGRAM_CODE")  USING INDEX TABLESPACE &tablespace_name  ENABLE;
  
GRANT SELECT ON "D_PROGRAM" TO &role_name;

CREATE OR REPLACE VIEW D_PROGRAM_SV
AS
SELECT program_code
       ,program_name
       ,REPORT_LABEL
       ,active_inactive       
       ,start_date
       ,end_date
FROM d_program;

GRANT SELECT ON "D_PROGRAM_SV" TO &role_name;
