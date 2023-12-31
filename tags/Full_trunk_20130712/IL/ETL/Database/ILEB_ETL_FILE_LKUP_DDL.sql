CREATE TABLE "MAXDAT"."CORP_MJ_ETL_FILE_LKUP" 
   (	"FILE_NAME" VARCHAR2(50 BYTE), 
	"FILE_TYPE" VARCHAR2(50 BYTE), 
	"FILE_SOURCE" VARCHAR2(50 BYTE), 
	"PLAN_ID" VARCHAR2(32 BYTE), 
	"FILE_DESTINATION" VARCHAR2(50 BYTE), 
	"RESPONSE_FILE_REQ" VARCHAR2(50 BYTE), 
	"RESPONSE_FILE_NAME" VARCHAR2(50 BYTE)
   );
   
CREATE UNIQUE INDEX "MAXDAT"."XPKILEB_ETL_FILE_LKUP" ON "MAXDAT"."CORP_MJ_ETL_FILE_LKUP" ("FILE_NAME") 
   TABLESPACE "MAXDAT_DATA" ;