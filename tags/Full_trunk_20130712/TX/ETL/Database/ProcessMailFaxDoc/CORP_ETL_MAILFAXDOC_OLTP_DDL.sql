--------------------------------------------------------
--  File created - Thursday-June-06-2013   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table CORP_ETL_MAILFAXDOC_OLTP
--------------------------------------------------------

  CREATE TABLE  "CORP_ETL_MAILFAXDOC_OLTP" 
   (	"CEMFD_ID" NUMBER, 
   "DOCUMENT_ID" NUMBER,
	"DCN" VARCHAR2(256 BYTE), 
	"DCN_CREATE_DT" DATE, 
	"INSTANCE_STATUS" VARCHAR2(50 BYTE), 
	"INSTANCE_COMPLETE_DT" DATE, 
	"BATCH_NAME" VARCHAR2(255 BYTE), 
	"BATCH_CHANNEL" VARCHAR2(15 BYTE), 
	"ECN" VARCHAR2(256 BYTE), 
	"ORIGINAL_DCN" NUMBER, 
	"RESCANNED" VARCHAR2(1 BYTE), 
	"DOCUMENT_PAGE_COUNT" NUMBER, 
	"DOCUMENT_STATUS" VARCHAR2(32 BYTE), 
	"DOCUMENT_STATUS_DT" DATE, 
	"DCN_COUNT" NUMBER, 
	"GWF_DOCUMENT_BARCODED" VARCHAR2(1 BYTE), 
	"FORM_TYPE" VARCHAR2(255 BYTE), 
	"DOCUMENT_TYPE" VARCHAR2(64 BYTE), 
	"GWF_AUTOLINK_OUTCOME" VARCHAR2(50 BYTE), 
	"AUTOLINK_FAILURE_REASON" VARCHAR2(256 BYTE), 
	"ASSD_CREATE_IA_TASK" DATE, 
	"ASED_CREATE_IA_TASK" DATE, 
	"ASF_CREATE_IA_TASK" VARCHAR2(1 BYTE), 
	"IA_MANUAL_CLASSIFY_TASK_ID" NUMBER, 
	"IA_MANUAL_LINK_TASK_ID" NUMBER, 
	"GWF_RESCAN_REQUIRED" VARCHAR2(1 BYTE), 
	"GWF_DOC_CLASS_PRESENT" VARCHAR2(1 BYTE), 
	"ASSD_LINK_IMAGES_MANUAL" DATE, 
	"ASED_LINK_IMAGES_MANUAL" DATE, 
	"ASF_LINK_IMAGES_MANUAL" VARCHAR2(1 BYTE), 
	"ASSD_CLASSIFY_FORM_DOC_MANUAL" DATE, 
	"ASED_CLASSIFY_FORM_DOC_MANUAL" DATE, 
	"ASF_CLASSIFY_FORM_DOC_MANUAL" VARCHAR2(1 BYTE), 
	"ASSD_CREATE_AND_ROUTE_WORK" DATE, 
	"ASED_CREATE_AND_ROUTE_WORK" DATE, 
	"ASF_CREATE_AND_ROUTE_WORK" VARCHAR2(1 BYTE), 
	"GWF_WORK_IDENTIFIED" VARCHAR2(1 BYTE), 
	"WORK_TASK_ID" NUMBER, 
	"WORK_TASK_TYPE_CREATED" VARCHAR2(50 BYTE), 
	"CANCEL_DT" DATE, 
	"LINK_METHOD" VARCHAR2(15 BYTE), 
	"LINK_VIA" VARCHAR2(32 BYTE), 
	"LINK_NUMBER" NUMBER, 
	"AGE_BUS_DAYS" NUMBER, 
	"AGE_CAL_DAYS" NUMBER, 
	"DCN_JEOPARDY_STATUS" VARCHAR2(30 BYTE), 
	"DCN_JEOPARDY_STATUS_DT" DATE, 
	"DCN_TIMELINESS_STATUS" VARCHAR2(30 BYTE), 
	"DOCUMENT_SET_ID" NUMBER, 
	"STAGE_DONE_DT" DATE, 
	"STG_EXTRACT_DATE" DATE, 
	"STG_LAST_UPDATE_DATE" DATE, 
	"CANCEL_METHOD" VARCHAR2(50 BYTE), 
	"CANCEL_REASON" VARCHAR2(256 BYTE), 
	"CANCEL_BY" VARCHAR2(50 BYTE), 
	"TRASHED_DOC_IND" VARCHAR2(1 BYTE), 
	"TRASHED_DATE" DATE,
  "DOC_AUTOLINK_DATE" DATE, 
	"DOC_RESCAN_REQUEST_DATE" DATE 

   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "MAXDAT_DATA" ;
--------------------------------------------------------
--  DDL for Trigger TRG_R_corp_etl_mailfaxdoc_oltp
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER  "TRG_R_corp_etl_mailfaxdoc_oltp" BEFORE
  INSERT OR
  UPDATE ON corp_etl_mailfaxdoc_oltp FOR EACH ROW
BEGIN
  IF Inserting THEN
    IF :NEW.stg_extract_date IS NULL THEN
      :NEW.stg_extract_date  := SYSDATE;
    END IF;
  END IF;
  :NEW.STG_LAST_UPDATE_DATE := SYSDATE;
END;
/
ALTER TRIGGER  "TRG_R_corp_etl_mailfaxdoc_oltp" ENABLE;
