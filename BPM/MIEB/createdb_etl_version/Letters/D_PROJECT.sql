
CREATE TABLE D_PROJECT
  (PROJECT_CODE VARCHAR2(32), 
   PROJECT_NAME VARCHAR2(240), 
   REPORT_LABEL VARCHAR2(100),
   PROJECT_CATEGORY VARCHAR2(240), 	  
   ACTIVE_INACTIVE VARCHAR2(1) ,
   START_DATE DATE, 
   END_DATE DATE ) TABLESPACE &tablespace_name ;


ALTER TABLE "D_PROJECT" ADD CONSTRAINT "PROJTYPE_PK" PRIMARY KEY ("PROJECT_CODE")  USING INDEX TABLESPACE &tablespace_name  ENABLE;
  
GRANT SELECT ON "D_PROJECT" TO &role_name;

CREATE OR REPLACE VIEW D_PROJECT_SV
AS
SELECT PROJECT_code
       ,PROJECT_name
       ,REPORT_LABEL
       ,active_inactive       
       ,start_date
       ,end_date
FROM d_PROJECT;

GRANT SELECT ON "D_PROJECT_SV" TO &role_name;
grant select, insert, update, delete on corp_etl_control to sr18956;
