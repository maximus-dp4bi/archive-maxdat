
CREATE OR REPLACE FORCE EDITIONABLE VIEW "MAXDAT"."D_CAHCO_CORP_ETL_JOB_STATISTICS_SV" ("JOB_ID", "JOB_NAME", "JOB_STATUS_CD", "FILE_NAME", "RECORD_COUNT", "PROCESSED_COUNT", "ERROR_COUNT", "WARNING_COUNT", "RECORD_INSERTED_COUNT", "RECORD_UPDATED_COUNT", "JOB_START_DATE", "JOB_END_DATE") AS 
  select
 JOB_ID
,JOB_NAME
,JOB_STATUS_CD
,FILE_NAME
,RECORD_COUNT
,PROCESSED_COUNT
,ERROR_COUNT
,WARNING_COUNT
,RECORD_INSERTED_COUNT
,RECORD_UPDATED_COUNT
,JOB_START_DATE
,JOB_END_DATE
 from MAXDAT.CORP_ETL_JOB_STATISTICS;
 
---GRANT SELECT	to MAXDAT_READ_ONLY ON "MAXDAT"."D_CAHCO_CORP_ETL_JOB_STATISTICS_SV";
--GRANT SELECT	to DP_REPORTS ON "MAXDAT"."D_CAHCO_CORP_ETL_JOB_STATISTICS_SV";
---
GRANT select on  "MAXDAT"."D_CAHCO_CORP_ETL_JOB_STATISTICS_SV" to MAXDAT_READ_ONLY;
GRANT SELECT ON "MAXDAT"."D_CAHCO_CORP_ETL_JOB_STATISTICS_SV"	to DP_REPORTS;
---

 CREATE OR REPLACE FORCE EDITIONABLE VIEW "MAXDAT"."D_CAHCO_ERROR_LOG_SV" 
 ("CEEL_ID", "ERR_DATE", "ERR_LEVEL", "PROCESS_NAME", "JOB_NAME", "NR_OF_ERROR", "ERROR_DESC", "ERROR_FIELD", "ERROR_CODES", "CREATE_TS", "UPDATE_TS", "DRIVER_TABLE_NAME", "DRIVER_KEY_NUMBER") 
 AS 
  select "CEEL_ID","ERR_DATE","ERR_LEVEL","PROCESS_NAME","JOB_NAME","NR_OF_ERROR","ERROR_DESC","ERROR_FIELD","ERROR_CODES","CREATE_TS","UPDATE_TS","DRIVER_TABLE_NAME","DRIVER_KEY_NUMBER" 
  from 
  MAXDAT.corp_etl_error_log;
  
----GRANT SELECT	to MAXDAT_READ_ONLY ON "MAXDAT"."D_CAHCO_ERROR_LOG_SV";
----GRANT SELECT	to DP_REPORTS ON "MAXDAT"."D_CAHCO_ERROR_LOG_SV";
GRANT select on  "MAXDAT"."D_CAHCO_ERROR_LOG_SV" to MAXDAT_READ_ONLY;
GRANT SELECT ON "MAXDAT"."D_CAHCO_ERROR_LOG_SV"	to DP_REPORTS;
---
