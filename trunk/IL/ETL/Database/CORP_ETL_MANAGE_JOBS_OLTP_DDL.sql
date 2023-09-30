
  CREATE TABLE "MAXDAT"."CORP_ETL_MANAGE_JOBS_OLTP" 
   (	"CEMFR_ID" NUMBER NOT NULL ENABLE, 
	"JOB_ID" NUMBER NOT NULL ENABLE, 
	"CREATE_DT" DATE, 
	"CREATED_BY" VARCHAR2(80 BYTE), 
	"JOB_NAME" VARCHAR2(500 BYTE), 
	"JOB_DETAIL" VARCHAR2(500 BYTE), 
	"JOB_GROUP" VARCHAR2(80 BYTE), 
	"JOB_TYPE" VARCHAR2(32 BYTE), 
	"JOB_START_DT" DATE, 
	"JOB_END_DT" DATE, 
	"JOB_STATUS" VARCHAR2(100 BYTE), 
	"FILE_NAME" VARCHAR2(50 BYTE), 
	"RECEIPT_DT" DATE, 
	"TRANSMIT_DT" DATE, 
	"FILE_TYPE" VARCHAR2(50 BYTE), 
	"FILE_SOURCE" VARCHAR2(50 BYTE), 
	"FILE_DESTINATION" VARCHAR2(50 BYTE), 
	"PLAN_NAME" VARCHAR2(50 BYTE), 
	"RESPONSE_FILE_REQ" VARCHAR2(50 BYTE), 
	"RECORD_COUNT" NUMBER, 
	"RECORD_ERROR_COUNT" NUMBER, 
	"RESPONSE_FILE_NAME" VARCHAR2(50 BYTE), 
	"LAST_UPDATE_BY_NAME" VARCHAR2(50 BYTE), 
	"LAST_UPDATE_BY_DT" DATE, 
	"ASSD_IDENTIFY_JOB" DATE, 
	"ASED_IDENTIFY_JOB" DATE, 
	"ASSD_PROCESS_JOB" DATE, 
	"ASED_PROCESS_JOB" DATE, 
	"ASSD_CREATE_RESPONSE_FILE" DATE, 
	"ASED_CREATE_RESPONSE_FILE" DATE, 
	"ASSD_CREATE_OUTBOUND_FILE" DATE, 
	"ASED_CREATE_OUTBOUND_FILE" DATE, 
	"ASF_IDENTIFY_JOB" VARCHAR2(1 BYTE) DEFAULT 'N' NOT NULL ENABLE, 
	"ASF_PROCESS_JOB" VARCHAR2(1 BYTE) DEFAULT 'N' NOT NULL ENABLE, 
	"ASF_CREATE_RESPONSE_FILE" VARCHAR2(1 BYTE) DEFAULT 'N' NOT NULL ENABLE, 
	"ASF_CREATE_OUTBOUND_FILE" VARCHAR2(1 BYTE) DEFAULT 'N' NOT NULL ENABLE, 
	"GWF_PROCESSED_OK" VARCHAR2(1 BYTE), 
	"GWF_JOB_TYPE" VARCHAR2(1 BYTE), 
	"GWF_RESPONSE_FILE" VARCHAR2(1 BYTE), 
	"COMPLETE_DT" DATE, 
	"INSTANCE_STATUS" VARCHAR2(10 BYTE) NOT NULL ENABLE, 
	"CANCEL_DT" DATE, 
	"STG_EXTRACT_DATE" DATE NOT NULL ENABLE, 
	"STG_LAST_UPDATE_DATE" DATE NOT NULL ENABLE, 
	"STAGE_DONE_DATE" DATE, 
	"RESPONSE_DT" DATE, 
	"JOB_STATUS_LABEL" VARCHAR2(100 BYTE), 
	 CONSTRAINT "CORP_ETL_MANAGE_JOBS_OLTP_PK" PRIMARY KEY ("CEMFR_ID")
    );

  CREATE UNIQUE INDEX "MAXDAT"."XPKCORP_ETL_MANAGE_JOBS_OLTP" ON "MAXDAT"."CORP_ETL_MANAGE_JOBS_OLTP" ("CEMFR_ID", "JOB_ID") 
  TABLESPACE "MAXDAT_DATA" ;
