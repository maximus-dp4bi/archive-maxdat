--------------------------------------------------------
--  File created - Tuesday-May-28-2013   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table FLHK_ETL_PROCESS_APP
--------------------------------------------------------

  CREATE TABLE "FLCST0_MAXDAT"."FLHK_ETL_PROCESS_APP" 
   (	"APP_ID" NUMBER, 
	"APP_TYPE" VARCHAR2(100 BYTE), 
	"APP_STATUS" VARCHAR2(100 BYTE), 
	"APP_STATUS_DATE" DATE, 
	"CHANNEL" VARCHAR2(100 BYTE), 
	"CREATE_DATE" DATE, 
	"RECEIPT_DATE" DATE, 
	"COMPLETE_DATE" DATE, 
	"PROGRAM_TYPE" VARCHAR2(100 BYTE), 
	"APP_COMPLETE_RESULT" VARCHAR2(100 BYTE), 
	"APP_CLEARANCE_DATE" DATE, 
	"RENEWAL_DATE" DATE, 
	"ACCOUNT_ID" NUMBER, 
	"ASSD_ACCOUNT_CREATE_UPDATE" DATE, 
	"ASED_ACCOUNT_CREATE_UPDATE" DATE, 
	"ZIP_CODE_APP" NUMBER, 
	"APPLICANT_ID" NUMBER, 
	"NUM_CHILDREN_APP" VARCHAR2(1 BYTE), 
	"CURRENT_TASK_ID" NUMBER, 
	"TIMEOUT_NOTIF_ID" NUMBER, 
	"ASED_TIMEOUT_NOTIF" DATE, 
	"CANCEL_DATE" DATE, 
	"INCOMPLETE_REASON" VARCHAR2(100 BYTE), 
	"CONFLICT_REASON" VARCHAR2(100 BYTE), 
	"DATA_ENTRY_TASK" NUMBER, 
	"ASSD_DATA_ENTRY" DATE, 
	"ASED_DATA_ENTRY" DATE, 
	"DATA_ENTRY_ORG" VARCHAR2(100 BYTE), 
	"ASSD_RECEIVE_PROCESS_MI" DATE, 
	"ASED_RECEIVE_PROCESS_MI" DATE, 
	"ALL_MI_SATISFIED" VARCHAR2(1 BYTE), 
	"TIMEOUT_DATE" DATE, 
	"ASSD_TIME_OUT_NOTIF" DATE, 
	"ASED_TIME_OUT_NOTIF" DATE, 
	"ASF_CANCEL_APP" VARCHAR2(1 BYTE), 
	"ASF_DATA_ENTRY" VARCHAR2(1 BYTE), 
	"ASF_RECEIVE_PROCESS_MI" VARCHAR2(1 BYTE), 
	"ASF_CORRECT_ERRORS" VARCHAR2(1 BYTE), 
	"ASF_TIME_OUT_NOTIF" VARCHAR2(1 BYTE), 
	"ASF_UPDATE_ACCOUNT" VARCHAR2(1 BYTE), 
	"GWF_CHANNEL" VARCHAR2(1 BYTE), 
	"GWF_MISSING_INFO" VARCHAR2(1 BYTE), 
	"GWF_CONFLICT" VARCHAR2(1 BYTE), 
	"GWF_TIME_OUT" VARCHAR2(1 BYTE), 
	"STAGE_DONE_DATE" DATE, 
	"STG_EXTRACT_DATE" DATE, 
	"STG_LAST_UPDATE_DATE" DATE, 
	"INSTANCE_STATUS" VARCHAR2(10 BYTE), 
	"ACCOUNT_STATE" VARCHAR2(255 BYTE), 
	"ACCOUNT_COUNTY" VARCHAR2(255 BYTE), 
	"HEAD_HOUSEHOLD_ID" NUMBER(10,0), 
	"GWF_PEND_NOTIFY_RQRD" VARCHAR2(10 BYTE)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "SCHIP_DATA" ;
