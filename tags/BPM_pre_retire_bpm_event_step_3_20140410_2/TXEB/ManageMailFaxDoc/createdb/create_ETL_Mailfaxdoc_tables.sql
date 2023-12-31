--------------------------------------------------------
--  File created - Thursday-June-06-2013   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table CORP_ETL_MAILFAXDOC
--------------------------------------------------------

  CREATE TABLE "CORP_ETL_MAILFAXDOC" 
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
  "STAGE_DONE_DT" DATE, 
	"STG_EXTRACT_DATE" DATE, 
	"STG_LAST_UPDATE_DATE" DATE, 
	"CANCEL_METHOD" VARCHAR2(50 BYTE), 
	"CANCEL_REASON" VARCHAR2(256 BYTE), 
	"CANCEL_BY" VARCHAR2(50 BYTE),
  "DOCUMENT_SET_ID" NUMBER,
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
--  Constraints for Table CORP_ETL_MAILFAXDOC
--------------------------------------------------------

  ALTER TABLE "CORP_ETL_MAILFAXDOC" MODIFY ("DCN_TIMELINESS_STATUS" NOT NULL ENABLE);
  ALTER TABLE "CORP_ETL_MAILFAXDOC" MODIFY ("DCN_JEOPARDY_STATUS_DT" NOT NULL ENABLE);
  ALTER TABLE "CORP_ETL_MAILFAXDOC" MODIFY ("DCN_JEOPARDY_STATUS" NOT NULL ENABLE);
  ALTER TABLE "CORP_ETL_MAILFAXDOC" MODIFY ("DOCUMENT_STATUS_DT" NOT NULL ENABLE);
  ALTER TABLE "CORP_ETL_MAILFAXDOC" MODIFY ("DOCUMENT_STATUS" NOT NULL ENABLE);
  ALTER TABLE "CORP_ETL_MAILFAXDOC" MODIFY ("RESCANNED" NOT NULL ENABLE);
  ALTER TABLE "CORP_ETL_MAILFAXDOC" MODIFY ("BATCH_CHANNEL" NOT NULL ENABLE);
  ALTER TABLE "CORP_ETL_MAILFAXDOC" MODIFY ("BATCH_NAME" NOT NULL ENABLE);
  ALTER TABLE "CORP_ETL_MAILFAXDOC" MODIFY ("INSTANCE_STATUS" NOT NULL ENABLE);
  ALTER TABLE "CORP_ETL_MAILFAXDOC" MODIFY ("DCN_CREATE_DT" NOT NULL ENABLE);
  ALTER TABLE "CORP_ETL_MAILFAXDOC" MODIFY ("DCN" NOT NULL ENABLE);
   ALTER TABLE "CORP_ETL_MAILFAXDOC" MODIFY ("DOCUMENT_ID" NOT NULL ENABLE);
  ALTER TABLE "CORP_ETL_MAILFAXDOC" MODIFY ("CEMFD_ID" NOT NULL ENABLE);

create or replace public synonym CORP_ETL_MAILFAXDOC for CORP_ETL_MAILFAXDOC;
grant select on CORP_ETL_MAILFAXDOC to MAXDAT_READ_ONLY;


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

create or replace public synonym CORP_ETL_MAILFAXDOC_OLTP for CORP_ETL_MAILFAXDOC_OLTP;
grant select on CORP_ETL_MAILFAXDOC_OLTP to MAXDAT_READ_ONLY;


  CREATE TABLE "CORP_ETL_MAILFAXDOC_WIP_BPM" 
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
	"DOCUMENT_STATUS" VARCHAR2(64 BYTE), 
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
	"UPDATED" VARCHAR2(1 BYTE), 
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


ALTER TABLE corp_etl_mailfaxdoc ADD CONSTRAINT corp_etl_mailfaxdoc_pk
  PRIMARY KEY ( cemfd_id ) USING INDEX TABLESPACE MAXDAT_INDX;

ALTER TABLE corp_etl_mailfaxdoc_wip_bpm ADD CONSTRAINT corp_etl_mailfaxdoc_wip_bpm_pk
  PRIMARY KEY ( cemfd_id ) USING INDEX TABLESPACE MAXDAT_INDX;

ALTER TABLE corp_etl_mailfaxdoc_oltp ADD CONSTRAINT corp_etl_mailfaxdoc_oltp_pk
  PRIMARY KEY ( cemfd_id ) USING INDEX TABLESPACE MAXDAT_INDX;

CREATE INDEX  IX_MAILFAX_STG_DT ON  corp_etl_mailfaxdoc (stage_done_dt)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX  IX_MAILFAX_DCN ON  corp_etl_mailfaxdoc (DCN)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX  IX_MAILFAX_INS_STATUS ON  corp_etl_mailfaxdoc (INSTANCE_STATUS)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX  IX_MAILFAX_BARCODED ON  corp_etl_mailfaxdoc (gwf_document_barcoded)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX  IX_MAILFAX_DOC_STAT ON  corp_etl_mailfaxdoc (document_status)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX  IX_MAILFAX_DOC_type ON  corp_etl_mailfaxdoc (document_type)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX  IX_MAILFAX_AUTOLINK ON  corp_etl_mailfaxdoc (gwf_autolink_outcome)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX  IX_MAILFAX_IA_TASK ON  corp_etl_mailfaxdoc ( IA_MANUAL_LINK_TASK_ID)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX  IX_MAILFAX_CLASS_TASK ON  corp_etl_mailfaxdoc ( IA_MANUAL_CLASSIFY_TASK_ID)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX  IX_MAILFAX_RESCAN ON  corp_etl_mailfaxdoc ( GWF_RESCAN_REQUIRED)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX  IX_MAILFAX_DOC_CLASS ON  corp_etl_mailfaxdoc ( GWF_DOC_CLASS_PRESENT)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX  IX_MAILFAX_WORK ON  corp_etl_mailfaxdoc ( GWF_WORK_IDENTIFIED)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX  IX_MAILFAX_CANCEL ON  corp_etl_mailfaxdoc (CANCEL_DT)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX  IX_MAILFAX_DOCUMENT_ID ON  corp_etl_mailfaxdoc (DOCUMENT_ID)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX  IX_MAILFAX_TRASHED_DOC_IND ON  corp_etl_mailfaxdoc (TRASHED_DOC_IND)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX  IX_MAILFAX_LINK_METHOD ON  corp_etl_mailfaxdoc (LINK_METHOD)TABLESPACE  MAXDAT_INDX ;

CREATE INDEX  IX_MAILFAX_STG_DT2 ON  corp_etl_mailfaxdoc_oltp (stage_done_dt)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX  IX_MAILFAX_DCN2 ON  corp_etl_mailfaxdoc_oltp (DCN)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX  IX_MAILFAX_INS_STATUS2 ON  corp_etl_mailfaxdoc_oltp (INSTANCE_STATUS)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX  IX_MAILFAX_BARCODED2 ON  corp_etl_mailfaxdoc_oltp (gwf_document_barcoded)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX  IX_MAILFAX_DOC_STAT2 ON  corp_etl_mailfaxdoc_oltp (document_status)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX  IX_MAILFAX_DOC_type2 ON  corp_etl_mailfaxdoc_oltp (document_type)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX  IX_MAILFAX_AUTOLINK2 ON  corp_etl_mailfaxdoc_oltp (gwf_autolink_outcome)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX  IX_MAILFAX_IA_TASK2 ON  corp_etl_mailfaxdoc_oltp ( IA_MANUAL_LINK_TASK_ID)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX  IX_MAILFAX_CLASS_TASK2 ON  corp_etl_mailfaxdoc_oltp ( IA_MANUAL_CLASSIFY_TASK_ID)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX  IX_MAILFAX_RESCAN2 ON  corp_etl_mailfaxdoc_oltp ( GWF_RESCAN_REQUIRED)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX  IX_MAILFAX_DOC_CLASS2 ON  corp_etl_mailfaxdoc_oltp ( GWF_DOC_CLASS_PRESENT)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX  IX_MAILFAX_WORK2 ON  corp_etl_mailfaxdoc_oltp ( GWF_WORK_IDENTIFIED)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX  IX_MAILFAX_CANCEL2 ON  corp_etl_mailfaxdoc_oltp (CANCEL_DT)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX  IX_MAILFAX_DOCUMENT_ID2 ON  corp_etl_mailfaxdoc_oltp (DOCUMENT_ID)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX  IX_MAILFAX_TRASHED_DOC_IND2 ON  corp_etl_mailfaxdoc_oltp (TRASHED_DOC_IND)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX  IX_MAILFAX_LINK_METHOD2 ON  corp_etl_mailfaxdoc_oltp (LINK_METHOD)TABLESPACE  MAXDAT_INDX ;

CREATE INDEX  IX_MAILFAX_STG_DT3 ON  corp_etl_mailfaxdoc_wip_bpm (stage_done_dt)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX  IX_MAILFAX_DCN3 ON  corp_etl_mailfaxdoc_wip_bpm (DCN)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX  IX_MAILFAX_INS_STATUS3 ON  corp_etl_mailfaxdoc_wip_bpm (INSTANCE_STATUS)TABLESPACE  MAXDAT_INDX;
CREATE INDEX  IX_MAILFAX_BARCODED3 ON  corp_etl_mailfaxdoc_wip_bpm(gwf_document_barcoded)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX  IX_MAILFAX_DOC_STAT3 ON  corp_etl_mailfaxdoc_wip_bpm (document_status)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX  IX_MAILFAX_DOC_type3 ON  corp_etl_mailfaxdoc_wip_bpm (document_type)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX  IX_MAILFAX_AUTOLINK3 ON  corp_etl_mailfaxdoc_wip_bpm (gwf_autolink_outcome)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX  IX_MAILFAX_IA_TASK3 ON  corp_etl_mailfaxdoc_wip_bpm ( IA_MANUAL_LINK_TASK_ID)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX  IX_MAILFAX_CLASS_TASK3 ON  corp_etl_mailfaxdoc_wip_bpm ( IA_MANUAL_CLASSIFY_TASK_ID)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX  IX_MAILFAX_RESCAN3 ON  corp_etl_mailfaxdoc_wip_bpm ( GWF_RESCAN_REQUIRED)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX  IX_MAILFAX_DOC_CLASS3 ON  corp_etl_mailfaxdoc_wip_bpm ( GWF_DOC_CLASS_PRESENT)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX  IX_MAILFAX_WORK3 ON  corp_etl_mailfaxdoc_wip_bpm ( GWF_WORK_IDENTIFIED)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX  IX_MAILFAX_CANCEL3 ON  corp_etl_mailfaxdoc_wip_bpm (CANCEL_DT)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX  IX_MAILFAX_DOCUMENT_ID3 ON  corp_etl_mailfaxdoc_wip_bpm (DOCUMENT_ID)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX  IX_MAILFAX_TRASHED_DOC_IND3 ON  corp_etl_mailfaxdoc_wip_bpm (TRASHED_DOC_IND)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX  IX_MAILFAX_LINK_METHOD3 ON  corp_etl_mailfaxdoc_wip_bpm (LINK_METHOD)TABLESPACE  MAXDAT_INDX ;

create or replace public synonym CORP_ETL_MAILFAXDOC_WIP_BPM for CORP_ETL_MAILFAXDOC_WIP_BPM;
grant select on CORP_ETL_MAILFAXDOC_WIP_BPM to MAXDAT_READ_ONLY;




