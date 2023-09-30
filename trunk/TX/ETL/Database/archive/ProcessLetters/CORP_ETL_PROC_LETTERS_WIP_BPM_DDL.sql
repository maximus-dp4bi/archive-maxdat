
  CREATE TABLE "CORP_ETL_PROC_LETTERS_WIP_BPM" 
   (	"CEPN_ID" NUMBER NOT NULL ENABLE, 
	"LETTER_REQUEST_ID" NUMBER NOT NULL ENABLE, 
	"CREATE_DT" DATE NOT NULL ENABLE, 
	"CREATE_BY" VARCHAR2(50 BYTE), 
	"REQUEST_DT" DATE, 
	"LETTER_TYPE" VARCHAR2(100 BYTE), 
	"PROGRAM" VARCHAR2(50 BYTE), 
	"CASE_ID" NUMBER, 
	"COUNTY_CODE" VARCHAR2(10 BYTE), 
	"ZIP_CODE" NUMBER, 
	"LANGUAGE" VARCHAR2(32 BYTE), 
	"REPRINT" VARCHAR2(1 BYTE), 
	"REQUEST_DRIVER_TYPE" VARCHAR2(10 BYTE), 
	"REQUEST_DRIVER_TABLE" VARCHAR2(32 BYTE), 
	"STATUS" VARCHAR2(32 BYTE) NOT NULL ENABLE, 
	"STATUS_DT" DATE NOT NULL ENABLE, 
	"SENT_DT" DATE, 
	"PRINT_DT" DATE, 
	"MAILED_DT" DATE, 
	"RETURN_DT" DATE, 
	"RETURN_REASON" VARCHAR2(100 BYTE), 
	"REJECT_REASON" VARCHAR2(100 BYTE), 
	"ERROR_REASON" VARCHAR2(4000 BYTE), 
	"TRANSMIT_FILE_NAME" VARCHAR2(100 BYTE), 
	"TRANSMIT_FILE_DT" DATE, 
	"LETTER_RESP_FILE_NAME" VARCHAR2(100 BYTE), 
	"LETTER_RESP_FILE_DT" DATE, 
	"LAST_UPDATE_DT" DATE, 
	"LAST_UPDATE_BY_NAME" VARCHAR2(50 BYTE), 
	"NEWBORN_FLAG" VARCHAR2(1 BYTE), 
	"TASK_ID" NUMBER, 
	"CANCEL_DT" DATE, 
	"CANCEL_BY" VARCHAR2(50 BYTE), 
  "CANCEL_REASON" VARCHAR2(50 BYTE), 
  "CANCEL_METHOD" VARCHAR2(50 BYTE), 
	"COMPLETE_DT" DATE, 
	"INSTANCE_STATUS" VARCHAR2(10 BYTE) NOT NULL ENABLE, 
	"ASSD_PROCESS_LETTER_REQ" DATE, 
	"ASED_PROCESS_LETTER_REQ" DATE, 
	"ASSD_TRANSMIT" DATE, 
	"ASED_TRANSMIT" DATE, 
	"ASSD_RECEIVE_CONFIRMATION" DATE, 
	"ASED_RECEIVE_CONFIRMATION" DATE, 
	"ASSD_CREATE_ROUTE_WORK" DATE, 
	"ASED_CREATE_ROUTE_WORK" DATE, 
	"ASF_PROCESS_LETTER_REQ" VARCHAR2(1 BYTE) NOT NULL ENABLE, 
	"ASF_TRANSMIT" VARCHAR2(1 BYTE) NOT NULL ENABLE, 
	"ASF_RECEIVE_CONFIRMATION" VARCHAR2(1 BYTE) NOT NULL ENABLE, 
	"ASF_CREATE_ROUTE_WORK" VARCHAR2(1 BYTE) NOT NULL ENABLE, 
	"GWF_VALID" VARCHAR2(1 BYTE), 
	"GWF_OUTCOME" VARCHAR2(1 BYTE), 
	"GWF_WORK_REQUIRED" VARCHAR2(1 BYTE), 
	"STG_EXTRACT_DATE" DATE NOT NULL ENABLE, 
	"STG_LAST_UPDATE_DATE" DATE NOT NULL ENABLE, 
	"STAGE_DONE_DATE" DATE, 
	"UPDATED" VARCHAR2(1 BYTE), 
	 CONSTRAINT "CORP_ETL_PROC_LETTERS_WIP_PK" PRIMARY KEY ("CEPN_ID"), 
	 CONSTRAINT "CORP_ETL_PROC_LTR_BPM_ID" UNIQUE ("LETTER_REQUEST_ID")
   ) ;

