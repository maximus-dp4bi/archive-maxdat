--------------------------------------------------------
--  File created - Wednesday-June-25-2014   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for View D_PROCESS_BPM_QUEUE_JOB_BAT_SV
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "D_PROCESS_BPM_QUEUE_JOB_BAT_SV" ("PBQJB_ID", "PBQJ_ID", "BATCH_ID", "PROCESS_BUEQ_ID", "BATCH_START_DATE", "BATCH_END_DATE", "LOCKING_START_DATE", "LOCKING_END_DATE", "RESERVE_START_DATE", "RESERVE_END_DATE", "PROC_XML_START_DATE", "PROC_XML_END_DATE", "NUM_SLEEP_SECONDS", "NUM_QUEUE_ROWS_IN_BATCH", "NUM_BPM_EVENT_INSERT", "NUM_BPM_EVENT_UPDATE", "NUM_BPM_SEMANTIC_INSERT", "NUM_BPM_SEMANTIC_UPDATE", "STATUS_DATE") AS 
  select
  PBQJB_ID,
  PBQJ_ID,
  BATCH_ID,
  PROCESS_BUEQ_ID,
  BATCH_START_DATE,
  BATCH_END_DATE,
  LOCKING_START_DATE,
  LOCKING_END_DATE,
  RESERVE_START_DATE,
  RESERVE_END_DATE,
  PROC_XML_START_DATE,
  PROC_XML_END_DATE,
  NUM_SLEEP_SECONDS,
  NUM_QUEUE_ROWS_IN_BATCH,
  NUM_BPM_EVENT_INSERT,
  NUM_BPM_EVENT_UPDATE,
  NUM_BPM_SEMANTIC_INSERT,
  NUM_BPM_SEMANTIC_UPDATE,
  STATUS_DATE
from PROCESS_BPM_QUEUE_JOB_BATCH
with read only;
--------------------------------------------------------
--  DDL for View F_MFB_BY_HOUR_SV
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "F_MFB_BY_HOUR_SV" ("FMFBBH_ID", "D_DATE_HOUR", "MFB_BI_ID", "CREATION_COUNT", "INVENTORY_COUNT", "COMPLETION_COUNT") AS 
  select
  FMFBBH_ID,
  BUCKET_START_DATE d_date_hour,
  MFB_BI_ID, 
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT
from F_MFB_BY_HOUR
where
  D_DATE >= (select min(D_DATE) from BPM_D_DATES)
  and CREATION_COUNT = 1
union all
(
-- First hour (again) and all hours with interpolated hours in-between, except completion hour.
select
  FMFBBH_ID,
  bdh.D_DATE_HOUR,
  MFB_BI_ID, 
  0 CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT
from
  F_MFB_BY_HOUR,
  BPM_D_DATE_HOUR_SV bdh
where
  bdh.D_DATE_HOUR >= BUCKET_START_DATE
  and bdh.D_DATE_HOUR < BUCKET_END_DATE
minus
-- Remove duplicate first day.
select
  FMFBBH_ID,
  bdh.D_DATE_HOUR,
  MFB_BI_ID, 
  0 CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT
from
  F_MFB_BY_HOUR,
  BPM_D_DATE_HOUR_SV bdh
where
  bdh.D_DATE_HOUR = BUCKET_START_DATE
  and CREATION_COUNT = 1
)
union all
-- Completion hour when not completed on the first hour.
select
  FMFBBH_ID,
  bdh.D_DATE_HOUR,
  MFB_BI_ID, 
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT
from
  F_MFB_BY_HOUR,
  BPM_D_DATE_HOUR_SV bdh
where
  bdh.D_DATE_HOUR >= BUCKET_START_DATE
  and bdh.D_DATE_HOUR = BUCKET_END_DATE
  and CREATION_COUNT = 0
  and COMPLETION_COUNT = 1
with read only;
--------------------------------------------------------
--  DDL for View D_MFBBATCH_EVENTS_CURMOD_SV
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "D_MFBBATCH_EVENTS_CURMOD_SV" ("CURRENT_BATCH_MODULE_ID", "BATCH_GUID", "MODULE_LAUNCH_ID", "MODULE_UNIQUE_ID", "MODULE_NAME", "MODULE_CLOSE_UNIQUE_ID", "MODULE_CLOSE_NAME", "BATCH_STATUS", "MODULE_START_DT", "MODULE_END_DT", "MODULE_LAUNCH_USER_NAME", "STATION_ID", "SITE_NAME", "SITE_ID", "BATCH_DELETED", "PAGES_PER_DOCUMENT", "PAGES_SCANNED", "PAGES_DELETED", "DOCUMENTS_CREATED", "DOCUMENTS_DELETED", "PAGES_REPLACED", "SOURCE_SERVER") AS 
  SELECT c.CURRENT_BATCH_MODULE_ID, 
  c.BATCH_GUID, 
  e.MODULE_LAUNCH_ID, 
  e.MODULE_UNIQUE_ID, 
  e.MODULE_NAME, 
  e.MODULE_CLOSE_ID AS MODULE_CLOSE_UNIQUE_ID, 
  e.MODULE_CLOSE_NAME, 
  e.BATCH_STATUS, 
  e.MODULE_START_DT, 
  e.MODULE_END_DT, 
  e.USER_NAME AS MODULE_LAUNCH_USER_NAME, 
  e.STATION_ID, 
  e.SITE_NAME, 
  e.SITE_ID, 
  e.BATCH_DELETED, 
  e.DOC_PAGES AS PAGES_PER_DOCUMENT, 
  e.PAGES_SCANNED, 
  e.PAGES_DELETED, 
  e.DOCS_CREATED AS DOCUMENTS_CREATED, 
  e.DOCS_DELETED AS DOCUMENTS_DELETED, 
  e.PAGES_REPLACED ,e.SOURCE_SERVER
FROM CORP_ETL_MFB_BATCH_EVENTS e, D_MFB_CURRENT c 
WHERE e.BATCH_MODULE_ID = c.CURRENT_BATCH_MODULE_ID 
WITH READ ONLY;
--------------------------------------------------------
--  DDL for View D_MFBBATCH_EVENTS_CURRENT_SV
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "D_MFBBATCH_EVENTS_CURRENT_SV" ("BATCH_MODULE_ID", "BATCH_GUID", "MODULE_LAUNCH_ID", "MODULE_UNIQUE_ID", "MODULE_NAME", "MODULE_CLOSE_UNIQUE_ID", "MODULE_CLOSE_NAME", "BATCH_STATUS", "MODULE_START_DT", "MODULE_END_DT", "MODULE_LAUNCH_USER_NAME", "STATION_ID", "SITE_NAME", "SITE_ID", "BATCH_DELETED", "PAGES_PER_DOCUMENT", "PAGES_SCANNED", "PAGES_DELETED", "DOCUMENTS_CREATED", "DOCUMENTS_DELETED", "PAGES_REPLACED", "SOURCE_SERVER") AS 
  select 
  BATCH_MODULE_ID,
  BATCH_GUID,
  MODULE_LAUNCH_ID,
  MODULE_UNIQUE_ID,
  MODULE_NAME,
  MODULE_CLOSE_ID as MODULE_CLOSE_UNIQUE_ID,
  MODULE_CLOSE_NAME,
  BATCH_STATUS,
  MODULE_START_DT,
  MODULE_END_DT,
  USER_NAME as MODULE_LAUNCH_USER_NAME,
  STATION_ID,
  SITE_NAME,
  SITE_ID,
  BATCH_DELETED,
  DOC_PAGES as PAGES_PER_DOCUMENT,
  PAGES_SCANNED,
  PAGES_DELETED,
  DOCS_CREATED as DOCUMENTS_CREATED,
  DOCS_DELETED as DOCUMENTS_DELETED,
  PAGES_REPLACED,
  SOURCE_SERVER
from CORP_ETL_MFB_BATCH_EVENTS
with read only;
--------------------------------------------------------
--  DDL for View D_PROCESS_BPM_QUEUE_JOB_SV
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "D_PROCESS_BPM_QUEUE_JOB_SV" ("PBQJ_ID", "JOB_NAME", "BSL_ID", "BDM_ID", "BATCH_SIZE", "START_DATE", "END_DATE", "STATUS", "STATUS_DATE", "ENABLED", "START_REASON_ID", "STOP_REASON_ID") AS 
  select
  PBQJ_ID,
  JOB_NAME,
  BSL_ID,
  BDM_ID,
  BATCH_SIZE,
  START_DATE,
  END_DATE,
  STATUS,
  STATUS_DATE,
  ENABLED,
  START_REASON_ID,
  STOP_REASON_ID
from PROCESS_BPM_QUEUE_JOB
with read only;
--------------------------------------------------------
--  DDL for View SVN_REVISION_DEPLOYED
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "SVN_REVISION_DEPLOYED" ("OWNER", "PACKAGE_NAME", "PLSQL_CODE_TYPE", "SVN_REVISION", "SVN_REVISION_DATE", "SVN_REVISION_AUTHOR", "SVN_FILE_URL") AS 
  select
  ao.OWNER,
  ao.OBJECT_NAME "PACKAGE_NAME",
  apos.PLSQL_CODE_TYPE,
  SVN_REVISION_KEYWORD.GET_SVN_REVISION(ao.OBJECT_NAME) "SVN_REVISION",
  SVN_REVISION_KEYWORD.GET_SVN_REVISION_DATE(ao.OBJECT_NAME) "SVN_REVISION_DATE",
  SVN_REVISION_KEYWORD.GET_SVN_REVISION_AUTHOR(ao.OBJECT_NAME) "SVN_REVISION_AUTHOR",
  SVN_REVISION_KEYWORD.GET_SVN_FILE_URL(ao.OBJECT_NAME) "SVN_FILE_URL"
from ALL_OBJECTS ao
inner join ALL_PLSQL_OBJECT_SETTINGS apos on (
  ao.OWNER = 'MAXDAT'
  and ao.OBJECT_TYPE = 'PACKAGE' 
  and ao.OBJECT_NAME not like 'BIN$%' 
  and ao.OBJECT_NAME not like 'CG$%' 
  and ao.OBJECT_NAME = apos.NAME
  and apos.OWNER = 'MAXDAT'
  and apos.TYPE = 'PACKAGE')
with read only;
--------------------------------------------------------
--  DDL for View D_MFB_CURRENT_SV
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "D_MFB_CURRENT_SV" ("MFB_BI_ID", "BATCH_GUID", "BATCH_ID", "BATCH_NAME", "CREATION_STATION_ID", "BATCH_CREATED_BY", "CREATION_USER_ID", "BATCH_CLASS", "BATCH_CLASS_DESCRIPTION", "BATCH_TYPE", "CREATE_DT", "COMPLETE_DT", "INSTANCE_STATUS", "INSTANCE_STATUS_DT", "BATCH_PAGE_COUNT", "BATCH_DOC_COUNT", "BATCH_ENVELOPE_COUNT", "CANCEL_DT", "CANCEL_BY", "CANCEL_REASON", "CANCEL_METHOD", "SCAN_BATCH_FLAG", "PERFORM_SCAN_START", "PERFORM_SCAN_END", "PERFORM_SCAN_PERFORMED_BY", "PERFORM_QC_FLAG", "PERFORM_QC_START", "PERFORM_QC_END", "PERFORM_QC_PERFORMED_BY", "KOFAX_QC_REASON", "CLASSIFICATION_FLAG", "CLASSIFICATION_START", "CLASSIFICATION_END", "CLASSIFICATION_DT", "RECOGNITION_FLAG", "RECOGNITION_START", "RECOGNITION_END", "RECOGNITION_DT", "VALIDATE_DATA_FLAG", "VALIDATE_DATA_START", "VALIDATE_DATA_END", "VALIDATE_DATA_PERFORMED_BY", "VALIDATION_DT", "CREATE_PDF_FLAG", "CREATE_PDFS_START", "CREATE_PDFS_END", "POPULATE_REPORTS_DATA_FLAG", "POPULATE_REPORTS_DATA_START", "POPULATE_REPORTS_DATA_END", "RELEASE_TO_DMS_FLAG", "RELEASE_TO_DMS_START", "RELEASE_TO_DMS_END", "BATCH_PRIORITY", "BATCH_DELETED", "PAGES_SCANNED", "DOCUMENTS_CREATED", "DOCUMENTS_DELETED", "PAGES_REPLACED_FLAG", "PAGES_DELETED_FLAG", "AGE_IN_BUSINESS_DAYS", "AGE_IN_CALENDAR_DAYS", "TIMELINESS_STATUS", "TIMELINESS_DAYS", "TIMELINESS_DAYS_TYPE", "TIMELINESS_DT", "JEOPARDY_FLAG", "JEOPARDY_DAYS", "JEOPARDY_DAYS_TYPE", "JEOPARDY_DT", "TARGET_DAYS", "BATCH_COMPLETE_DT", "CURRENT_BATCH_MODULE_ID", "GWF_QC_REQUIRED", "CURRENT_STEP", "SOURCE_SERVER") AS 
  select "MFB_BI_ID","BATCH_GUID","BATCH_ID","BATCH_NAME","CREATION_STATION_ID","BATCH_CREATED_BY","CREATION_USER_ID","BATCH_CLASS","BATCH_CLASS_DESCRIPTION","BATCH_TYPE","CREATE_DT","COMPLETE_DT","INSTANCE_STATUS","INSTANCE_STATUS_DT","BATCH_PAGE_COUNT","BATCH_DOC_COUNT","BATCH_ENVELOPE_COUNT","CANCEL_DT","CANCEL_BY","CANCEL_REASON","CANCEL_METHOD","SCAN_BATCH_FLAG","PERFORM_SCAN_START","PERFORM_SCAN_END","PERFORM_SCAN_PERFORMED_BY","PERFORM_QC_FLAG","PERFORM_QC_START","PERFORM_QC_END","PERFORM_QC_PERFORMED_BY","KOFAX_QC_REASON","CLASSIFICATION_FLAG","CLASSIFICATION_START","CLASSIFICATION_END","CLASSIFICATION_DT","RECOGNITION_FLAG","RECOGNITION_START","RECOGNITION_END","RECOGNITION_DT","VALIDATE_DATA_FLAG","VALIDATE_DATA_START","VALIDATE_DATA_END","VALIDATE_DATA_PERFORMED_BY","VALIDATION_DT","CREATE_PDF_FLAG","CREATE_PDFS_START","CREATE_PDFS_END","POPULATE_REPORTS_DATA_FLAG","POPULATE_REPORTS_DATA_START","POPULATE_REPORTS_DATA_END","RELEASE_TO_DMS_FLAG","RELEASE_TO_DMS_START","RELEASE_TO_DMS_END","BATCH_PRIORITY","BATCH_DELETED","PAGES_SCANNED","DOCUMENTS_CREATED","DOCUMENTS_DELETED","PAGES_REPLACED_FLAG","PAGES_DELETED_FLAG","AGE_IN_BUSINESS_DAYS","AGE_IN_CALENDAR_DAYS","TIMELINESS_STATUS","TIMELINESS_DAYS","TIMELINESS_DAYS_TYPE","TIMELINESS_DT","JEOPARDY_FLAG","JEOPARDY_DAYS","JEOPARDY_DAYS_TYPE","JEOPARDY_DT","TARGET_DAYS","BATCH_COMPLETE_DT","CURRENT_BATCH_MODULE_ID","GWF_QC_REQUIRED","CURRENT_STEP","SOURCE_SERVER" from D_MFB_CURRENT
with read only;
--------------------------------------------------------
--  DDL for View D_BPM_UPDATE_EVENT_QUEUE_SV
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "D_BPM_UPDATE_EVENT_QUEUE_SV" ("BUEQ_ID", "BSL_ID", "BIL_ID", "IDENTIFIER", "EVENT_DATE", "QUEUE_DATE", "PROCESS_BUEQ_ID", "WROTE_BPM_SEMANTIC_DATE", "DATA_VERSION", "OLD_DATA", "NEW_DATA") AS 
  select "BUEQ_ID","BSL_ID","BIL_ID","IDENTIFIER","EVENT_DATE","QUEUE_DATE","PROCESS_BUEQ_ID","WROTE_BPM_SEMANTIC_DATE","DATA_VERSION","OLD_DATA","NEW_DATA"
from BPM_UPDATE_EVENT_QUEUE
with read only;
--------------------------------------------------------
--  DDL for View D_BPM_SOURCE_LKUP_SV
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "D_BPM_SOURCE_LKUP_SV" ("BSL_ID", "NAME", "BSTL_ID") AS 
  select 
  BSL_ID,
  name,
  BSTL_ID
from BPM_SOURCE_LKUP
with read only;
--------------------------------------------------------
--  DDL for View D_BPM_DATA_MODEL_SV
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "D_BPM_DATA_MODEL_SV" ("BDM_ID", "CODE", "NAME") AS 
  select 
  BDM_ID,
  CODE,
  name
from BPM_DATA_MODEL
with read only;
--------------------------------------------------------
--  DDL for View BPM_D_DATE_HOUR_SV
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "BPM_D_DATE_HOUR_SV" ("D_DATE_HOUR") AS 
  select bdd.D_DATE + (bdh.D_HOUR/24) D_DATE_HOUR
from 
  BPM_D_DATES bdd,
  BPM_D_HOURS bdh
where bdd.D_DATE <= sysdate - (bdh.D_HOUR/24)
with read only;
--------------------------------------------------------
--  DDL for View D_MFBDOC_CURRENT_SV
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "D_MFBDOC_CURRENT_SV" ("ECN", "BATCH_GUID", "DOCUMENT_ID", "DCN", "DOC_ORDER_NUMBER", "TYPE_NAME", "DOCUMENT_CLASS", "DOCUMENT_RECEIPT_DT", "DOCUMENT_CREATION_DT", "DOCUMENT_PAGE_COUNT", "CLASSIFIED_DOCUMENT", "DELETED", "CONFIDENCE", "CONFIDENT") AS 
  select
  ECN,
  BATCH_GUID,
  DOC_ID as DOCUMENT_ID,
  DCN,
  DOC_ORDER_NUMBER,
  TYPE_NAME,
  DOC_CLASS as DOCUMENT_CLASS,
  DOC_RECEIPT_DT as DOCUMENT_RECEIPT_DT,
  DOC_CREATION_DT as DOCUMENT_CREATION_DT,
  DOC_PAGE_COUNT as DOCUMENT_PAGE_COUNT,
  CLASSIFIED_DOC as CLASSIFIED_DOCUMENT,
  DELETED,
  CONFIDENCE,
  CONFIDENT
from CORP_ETL_MFB_DOCUMENT
with read only;
