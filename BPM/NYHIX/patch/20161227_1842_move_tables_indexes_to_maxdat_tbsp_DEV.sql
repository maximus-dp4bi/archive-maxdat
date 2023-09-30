/*
Created on 12/27/2016 by Raj A.
Description: MAXDAT-1314
*/
/*
select * from ALL_TABLES where OWNER = 'MAXDAT' and TABLESPACE_NAME != 'MAXDAT_DATA';
*/
--Tables are in the correct tablespace, MAXDAT_DATA.

/*
select * from ALL_INDEXES where OWNER = 'MAXDAT' and TABLESPACE_NAME != 'MAXDAT_INDX';
select * from ALL_IND_PARTITIONS where INDEX_OWNER = 'MAXDAT' and TABLESPACE_NAME != 'MAXDAT_INDX';

select 'alter index ' || INDEX_NAME || ' rebuild tablespace MAXDAT_INDX online;' from ALL_INDEXES where OWNER = 'MAXDAT' and TABLESPACE_NAME != 'MAXDAT_INDX';
*/
alter index PP_WFM_ACTUALS_PK rebuild tablespace MAXDAT_INDX online;
alter index MEDIA_PK rebuild tablespace MAXDAT_INDX online;
alter index I_SNAP$_D_YEARS rebuild tablespace MAXDAT_INDX online;
alter index I_SNAP$_D_MONTHS rebuild tablespace MAXDAT_INDX online;
alter index SYS_C00105161 rebuild tablespace MAXDAT_INDX online;
alter index SYS_C00104696 rebuild tablespace MAXDAT_INDX online;
alter index PPBO_SCPT_STAFF_ID rebuild tablespace MAXDAT_INDX online;
alter index SYS_C00104695 rebuild tablespace MAXDAT_INDX online;
alter index SYS_C00104694 rebuild tablespace MAXDAT_INDX online;
alter index PPBO_SCCA_STAFF_ID rebuild tablespace MAXDAT_INDX online;
alter index SYS_C00104693 rebuild tablespace MAXDAT_INDX online;
alter index PPBO_SC_STAFF_ID rebuild tablespace MAXDAT_INDX online;
alter index SYS_C00101100 rebuild tablespace MAXDAT_INDX online;
alter index SYS_C00101099 rebuild tablespace MAXDAT_INDX online;
alter index DOC_PK rebuild tablespace MAXDAT_INDX online;
alter index BATCH_PK rebuild tablespace MAXDAT_INDX online;
alter index XPKCASE rebuild tablespace MAXDAT_INDX online;
alter index CC_F_ACD_AGENT_INTERVAL__UN rebuild tablespace MAXDAT_INDX online;
alter index CC_F_ACD_AGENT_INTERVAL_PK rebuild tablespace MAXDAT_INDX online;
alter index CC_S_ACD_A_INTERVAL__UN rebuild tablespace MAXDAT_INDX online;
alter index CC_F_ACD_Q_INTERVAL__UN rebuild tablespace MAXDAT_INDX online;
alter index CC_F_ACD_QUEUE_INTERVAL_PK rebuild tablespace MAXDAT_INDX online;
alter index CC_S_ACD_Q_INTERVAL__UN rebuild tablespace MAXDAT_INDX online;
alter index DLY_DOC_NOTIF_STG_PK rebuild tablespace MAXDAT_INDX online;
alter index DLY_AP_DOC_STG_PK rebuild tablespace MAXDAT_INDX online;
alter index PP_WFM_EVENT_TYPE_PK rebuild tablespace MAXDAT_INDX online;
alter index PP_WFM_EVENT_TYPE_GROUP_PK rebuild tablespace MAXDAT_INDX online;
alter index PP_WFM_EVENT_PK rebuild tablespace MAXDAT_INDX online;
alter index PP_WFM_SUPERVISOR_TO_STAFF_PK rebuild tablespace MAXDAT_INDX online;
alter index PP_WFM_STAFF_GROUP_TO_STAF_PK rebuild tablespace MAXDAT_INDX online;
alter index PP_WFM_STAFF_GROUP_PK rebuild tablespace MAXDAT_INDX online;
alter index PP_WFM_SCHEDULE_MONITOR_PK rebuild tablespace MAXDAT_INDX online;
alter index PP_WFM_SUPERVISOR_PK rebuild tablespace MAXDAT_INDX online;
alter index PP_WFM_TASK_PK rebuild tablespace MAXDAT_INDX online;
alter index PP_WFM_TASK_CATEGORY_PK rebuild tablespace MAXDAT_INDX online;
alter index PP_WFM_STAFF_PK rebuild tablespace MAXDAT_INDX online;
alter index CC_S_ACD_NEW_QUEUES_PK rebuild tablespace MAXDAT_INDX online;
alter index PK_NOTE rebuild tablespace MAXDAT_INDX online;
alter index PP_BO_SUPERVISOR_TO_STAFF_PK rebuild tablespace MAXDAT_INDX online;
alter index IDX4_DOC_ID rebuild tablespace MAXDAT_INDX online;
alter index F_PROCESS_METRIC_UN rebuild tablespace MAXDAT_INDX online;
alter index F_PROCESS_METRIC_PK rebuild tablespace MAXDAT_INDX online;
alter index D_PROCESS_METRIC_UN rebuild tablespace MAXDAT_INDX online;
alter index D_PROCESS_GROUP_DETAIL_UN rebuild tablespace MAXDAT_INDX online;
alter index D_PROCESS_GROUP_UN rebuild tablespace MAXDAT_INDX online;
alter index D_PROCESS_DEFINITION_UN rebuild tablespace MAXDAT_INDX online;
alter index D_METRIC_DEFINITION_NAME_UN rebuild tablespace MAXDAT_INDX online;
alter index D_REPORTING_PERIOD__UN rebuild tablespace MAXDAT_INDX online;
alter index D_REPORTING_PERIOD_PK rebuild tablespace MAXDAT_INDX online;
alter index CORP_ETL_PROC_LET_PK rebuild tablespace MAXDAT_INDX online;
alter index SYS_C0028968 rebuild tablespace MAXDAT_INDX online;
alter index SYS_C0028967 rebuild tablespace MAXDAT_INDX online;
alter index NYHIX_ETL_MAIL_FAX_DOC_APP_PK rebuild tablespace MAXDAT_INDX online;
alter index PP_A_SCHEDULED_JOB__UN rebuild tablespace MAXDAT_INDX online;
alter index PP_A_ADHOC_JOBV1_PK rebuild tablespace MAXDAT_INDX online;
alter index PP_A_SCHEDULE__UN rebuild tablespace MAXDAT_INDX online;
alter index PP_A_SCHEDULE_PK rebuild tablespace MAXDAT_INDX online;
alter index PP_A_ADHOC_JOB_PK rebuild tablespace MAXDAT_INDX online;
alter index CD_ID_PK rebuild tablespace MAXDAT_INDX online;
alter index PP_STG_EVENTS__UN rebuild tablespace MAXDAT_INDX online;
alter index PP_STG_EVENTS_PK rebuild tablespace MAXDAT_INDX online;
alter index CC_D_CONTACT_QUEUE__UN rebuild tablespace MAXDAT_INDX online;
alter index LETTER_REQ_ON_IDX rebuild tablespace MAXDAT_INDX online;
alter index LETTER_CASE_ID_IDX rebuild tablespace MAXDAT_INDX online;
alter index LETTERS_TYPE_CD_STG_IDX rebuild tablespace MAXDAT_INDX online;
alter index LETTERS_STG_IDX rebuild tablespace MAXDAT_INDX online;
alter index LETTERS_SENT_ON_STG_IDX rebuild tablespace MAXDAT_INDX online;
alter index LETTERS_REQUEST_TYPE_STG_IDX rebuild tablespace MAXDAT_INDX online;
alter index LETTERS_ID_STG_IDX rebuild tablespace MAXDAT_INDX online;
alter index CORP_LET_OLTP_MAT_REQ_ID rebuild tablespace MAXDAT_INDX online;
alter index TEMP_PK rebuild tablespace MAXDAT_INDX online;
alter index TEMP_D_WEEK_OF_MONTH_IX rebuild tablespace MAXDAT_INDX online;
alter index TEMP_MONTH_NAME_IX rebuild tablespace MAXDAT_INDX online;
alter index PP_D_UOW_SOURCE_REF_UN1 rebuild tablespace MAXDAT_INDX online;
alter index PP_D_UOW_SOURCE_REF_UN rebuild tablespace MAXDAT_INDX online;
alter index FCMPLBD_IXL6 rebuild tablespace MAXDAT_INDX online;
alter index FCMPLBD_IXL5 rebuild tablespace MAXDAT_INDX online;
alter index PP_BO_STAFF_GROUP_TO_STAF_PK rebuild tablespace MAXDAT_INDX online;
alter index PP_BO_STAFF_GROUP_PK rebuild tablespace MAXDAT_INDX online;
alter index STAFF_ID rebuild tablespace MAXDAT_INDX online;
alter index PP_BO_SCHEDULE_MONITOR_PK rebuild tablespace MAXDAT_INDX online;
alter index PP_BO_SUPERVISOR_PK rebuild tablespace MAXDAT_INDX online;
alter index PP_BO_TASK_PK rebuild tablespace MAXDAT_INDX online;
alter index PP_BO_TASK_CATEGORY_PK rebuild tablespace MAXDAT_INDX online;
alter index PP_BO_STAFF_PK rebuild tablespace MAXDAT_INDX online;
alter index P_BO_ACTUALS_PK rebuild tablespace MAXDAT_INDX online;