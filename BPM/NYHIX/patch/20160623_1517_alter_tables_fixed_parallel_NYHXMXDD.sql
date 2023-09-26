-- MAXDAT-3713 - Sweep through all MAXDat tables and determine and set which tables that should be parallel. 
-- NYHXMXDD

/*
alter session set current_schema = MAXDAT;

select 'alter table ' || TABLE_NAME || ' noparallel;' alterCommand
from ALL_TABLES
where 
  OWNER = 'MAXDAT'
  and DEGREE like '%DEFAULT'
order by TABLE_NAME asc;

-- Then edit commands to set parallel degree.
*/
alter table APP_DOC_DATA_EXT_STG noparallel;
alter table APP_DOC_DATA_STG noparallel;
alter table APP_DOC_TRACKER_STG noparallel;
alter table BPM_ATTRIBUTE_STAGING_TABLE noparallel;
alter table BPM_INSTANCE_ATTRIBUTE_RETIRE noparallel;
alter table BPM_INSTANCE_RETIRE noparallel;
alter table BPM_LOGGING noparallel;
alter table BPM_UPDATE_EVENT_QUEUE parallel 2;
alter table BPM_UPDATE_EVENT_QUEUE_ARCHIVE noparallel;
alter table CASES_STG noparallel;
alter table CORP_ETL_MFB_FORM noparallel;
alter table CORP_ETL_MFB_FORM_STG noparallel;
alter table CORP_ETL_PROC_LET_MATERIAL_CHD noparallel;
alter table DOCUMENT_NOTIFICATION_STG noparallel;
alter table DOCUMENT_SET_STG noparallel;
alter table DOCUMENT_STG noparallel;
alter table DOC_LINK_STG noparallel;
alter table D_APPEALS_ACTION_COMMENTS noparallel;
alter table D_APPEALS_CURRENT noparallel;
alter table D_APPEALS_INCIDENT_ABOUT noparallel;
alter table D_APPEALS_INCIDENT_DESC noparallel;
alter table D_APPEALS_INCIDENT_STATUS noparallel;
alter table D_APPEALS_INSTANCE_STATUS noparallel;
alter table D_BATCHES noparallel;
alter table D_COMPLAINT_CURRENT parallel 2;
alter table D_COMPLAINT_ENROLLMENT_STATUS noparallel;
alter table D_DOCUMENTS noparallel;
alter table D_IDR_ACTION_COMMENTS noparallel;
alter table D_IDR_ENROLLMENT_STATUS noparallel;
alter table D_IDR_INCIDENT_ABOUT noparallel;
alter table D_IDR_INCIDENT_DESCRIPTION noparallel;
alter table D_IDR_INCIDENT_STATUS noparallel;
alter table D_IDR_INSTANCE_STATUS noparallel;
alter table D_IDR_LAST_UPDATED_BY noparallel;
alter table D_IDR_LAST_UPDATE_BY_NAME noparallel;
alter table D_IDR_RESOLUTION_DESCRIPTION noparallel;
alter table D_IDR_RESOLUTION_TYPE noparallel;
alter table D_MFB_CURRENT parallel 2;
alter table D_MW_CURRENT parallel 2;
alter table D_MW_V2_CURRENT parallel 2;
alter table D_MW_V2_HISTORY parallel 2;
alter table D_NYHIX_DOC_NOTIF_CURRENT noparallel;
alter table D_NYHIX_DOC_NOTIF_HISTORY noparallel;
alter table D_NYHIX_MFD_CURRENT parallel 2;
alter table D_NYHIX_MFD_CURRENT_V2 parallel 2;
alter table D_NYHIX_MFD_HISTORY_V2 parallel 2;
alter table D_PL_CURRENT noparallel;
alter table D_PL_MEDIA_CD noparallel;
alter table F_APPEALS_BY_DATE noparallel;
alter table F_COMPLAINT_BY_DATE parallel 2;
alter table F_IDR_BY_DATE noparallel;
alter table F_MFB_BY_HOUR parallel 2;
alter table F_MW_BY_DATE parallel 2;
alter table F_NYHIX_MFD_BY_DATE parallel 2;
alter table F_PL_BY_DATE parallel 2;
alter table INCIDENT_HEADER_STG noparallel;
alter table INCIDENT_HEADER_TEMP noparallel;
alter table MFD_COMPLETE_DT_TMP noparallel;
alter table MFD_DOC_COMPLETE_DT_TMP noparallel;
alter table NYHIX_ETL_DOC_NOTIFICATIONS noparallel;
alter table NYHIX_ETL_DOC_NOTIF_OLTP noparallel;
alter table NYHIX_ETL_DOC_NOTIF_WIP_BPM noparallel;
alter table NYHIX_ETL_MAIL_FAX_DOC noparallel;
alter table NYHIX_ETL_MAIL_FAX_DOC_OLTP noparallel;
alter table NYHIX_ETL_MAIL_FAX_DOC_WIP_BPM noparallel;
alter table NYHX_ETL_IDR_INCIDENT_RSN noparallel;
alter table PROCESS_BPM_QUEUE_JOB noparallel;
alter table PROCESS_BPM_QUEUE_JOB_BATCH noparallel;