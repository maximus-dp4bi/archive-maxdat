/*
Created on 12/28/2016 by Raj A.
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
alter index XPKCASE rebuild tablespace MAXDAT_INDX online;
alter index DLY_DOC_NOTIF_STG_PK rebuild tablespace MAXDAT_INDX online;
alter index DLY_AP_DOC_STG_PK rebuild tablespace MAXDAT_INDX online;
alter index TPSQL_IDX rebuild tablespace MAXDAT_INDX online;
alter index CC_F_ACD_AGENT_INTERVAL_PK rebuild tablespace MAXDAT_INDX online;
alter index CC_S_ACD_A_INTERVAL__UN rebuild tablespace MAXDAT_INDX online;
alter index CC_F_ACD_QUEUE_INTERVAL_PK rebuild tablespace MAXDAT_INDX online;
alter index CC_S_ACD_Q_INTERVAL__UN rebuild tablespace MAXDAT_INDX online;
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
alter index DDNCU_IX4 rebuild tablespace MAXDAT_INDX online;
alter index PP_BO_SUPERVISOR_TO_STAFF_PK rebuild tablespace MAXDAT_INDX online;
alter index F_PROCESS_METRIC_UN rebuild tablespace MAXDAT_INDX online;
alter index F_PROCESS_METRIC_PK rebuild tablespace MAXDAT_INDX online;
alter index D_PROCESS_METRIC_UN rebuild tablespace MAXDAT_INDX online;
alter index D_PROCESS_GROUP_DETAIL_UN rebuild tablespace MAXDAT_INDX online;
alter index D_PROCESS_GROUP_UN rebuild tablespace MAXDAT_INDX online;
alter index D_PROCESS_DEFINITION_UN rebuild tablespace MAXDAT_INDX online;
alter index D_METRIC_DEFINITION_NAME_UN rebuild tablespace MAXDAT_INDX online;
alter index D_REPORTING_PERIOD__UN rebuild tablespace MAXDAT_INDX online;
alter index D_REPORTING_PERIOD_PK rebuild tablespace MAXDAT_INDX online;
alter index PP_A_ADHOC_JOB_PK rebuild tablespace MAXDAT_INDX online;
alter index ADD_ID_PK rebuild tablespace MAXDAT_INDX online;
alter index CD_ID_PK rebuild tablespace MAXDAT_INDX online;
alter index DCN_PK2 rebuild tablespace MAXDAT_INDX online;
alter index DCN_PK1 rebuild tablespace MAXDAT_INDX online;
alter index DCN_PK rebuild tablespace MAXDAT_INDX online;
alter index CORP_ETL_PROC_LET_PK rebuild tablespace MAXDAT_INDX online;
alter index PP_BO_STAFF_GROUP_TO_STAF_PK rebuild tablespace MAXDAT_INDX online;
alter index PP_BO_STAFF_GROUP_PK rebuild tablespace MAXDAT_INDX online;
alter index PP_BO_SCHEDULE_MONITOR_PK rebuild tablespace MAXDAT_INDX online;
alter index PP_BO_SUPERVISOR_PK rebuild tablespace MAXDAT_INDX online;
alter index PP_BO_TASK_PK rebuild tablespace MAXDAT_INDX online;
alter index PP_BO_TASK_CATEGORY_PK rebuild tablespace MAXDAT_INDX online;
alter index PP_BO_STAFF_PK rebuild tablespace MAXDAT_INDX online;
alter index P_BO_ACTUALS_PK rebuild tablespace MAXDAT_INDX online;
alter index DOC_PK rebuild tablespace MAXDAT_INDX online;
alter index BATCH_PK rebuild tablespace MAXDAT_INDX online;
alter index I_SNAP$_D_YEARS rebuild tablespace MAXDAT_INDX online;
alter index I_SNAP$_D_MONTHS rebuild tablespace MAXDAT_INDX online;
alter index MEDIA_PK rebuild tablespace MAXDAT_INDX online;
alter index HTEST_UK1 rebuild tablespace MAXDAT_INDX online;
alter index PP_WFM_ACTUALS_PK rebuild tablespace MAXDAT_INDX online;
alter index CC_F_IVR_SELF_SVC_USAGE__UN rebuild tablespace MAXDAT_INDX online;
alter index CC_F_IVR_SELF_SERVICE_USAGE_PK rebuild tablespace MAXDAT_INDX online;
alter index CC_F_FCST_INTERVAL__UN rebuild tablespace MAXDAT_INDX online;
alter index CC_F_FORECAST_INTERVAL_PK rebuild tablespace MAXDAT_INDX online;
alter index CC_F_AGENT_BY_DATE__UN rebuild tablespace MAXDAT_INDX online;
alter index F_AGENT_ACT_BY_DATE__UN rebuild tablespace MAXDAT_INDX online;
alter index CC_F_ACTUALS_Q_INTERVAL__UN rebuild tablespace MAXDAT_INDX online;
alter index CC_F_ACTUALS_QUEUE_INTERVAL_PK rebuild tablespace MAXDAT_INDX online;
alter index CC_F_ACTUALS_IVR_INTERVAL__UN rebuild tablespace MAXDAT_INDX online;
alter index CC_F_ACTUALS_IVR_INTERVAL_PK rebuild tablespace MAXDAT_INDX online;
alter index CC_D_UNIT_OF_WORK_UK1 rebuild tablespace MAXDAT_INDX online;
alter index CC_D_UNIT_OF_WORK_PK rebuild tablespace MAXDAT_INDX online;
alter index CC_D_TARGET_PK rebuild tablespace MAXDAT_INDX online;
alter index CC_D_STATE__UN rebuild tablespace MAXDAT_INDX online;
alter index CC_D_STATE_PK rebuild tablespace MAXDAT_INDX online;
alter index CC_D_SITE__UN rebuild tablespace MAXDAT_INDX online;
alter index CC_D_REGION_UNK rebuild tablespace MAXDAT_INDX online;
alter index CC_D_REGION_PK rebuild tablespace MAXDAT_INDX online;
alter index CC_D_PROVINCE_NAME_UK rebuild tablespace MAXDAT_INDX online;
alter index CC_D_PROVINCE_PK rebuild tablespace MAXDAT_INDX online;
alter index CC_D_PROJECT_TARGETS__UN rebuild tablespace MAXDAT_INDX online;
alter index CC_D_PROJECT_TARGETS_PK rebuild tablespace MAXDAT_INDX online;
alter index CC_D_PROJECT_UNK rebuild tablespace MAXDAT_INDX online;
alter index CC_D_PROJECT_PK rebuild tablespace MAXDAT_INDX online;
alter index CC_D_PROGRAM_PK rebuild tablespace MAXDAT_INDX online;
alter index CC_D_PROGRAM_UNK rebuild tablespace MAXDAT_INDX online;
alter index CC_D_PROD_PLANNING_TARGET__UN rebuild tablespace MAXDAT_INDX online;
alter index CC_D_PROD_PLANNING_TARGET_PK rebuild tablespace MAXDAT_INDX online;
alter index CC_D_PRODUCTION_PLAN_HRZN__UN rebuild tablespace MAXDAT_INDX online;
alter index CC_D_PRODUCTION_PLAN_HRZN_PK rebuild tablespace MAXDAT_INDX online;
alter index CC_D_PRODUCTION_PLAN__UN rebuild tablespace MAXDAT_INDX online;
alter index CC_D_PRODUCTION_PLAN_PK rebuild tablespace MAXDAT_INDX online;
alter index CC_D_SELF_SERVICE_PATH__UN rebuild tablespace MAXDAT_INDX online;
alter index CC_D_SELF_SERVICE_PATH_PK rebuild tablespace MAXDAT_INDX online;
alter index CC_D_INTERVAL__UN rebuild tablespace MAXDAT_INDX online;
alter index CC_D_INTERVAL_PK rebuild tablespace MAXDAT_INDX online;
alter index CC_D_GROUP__UN rebuild tablespace MAXDAT_INDX online;
alter index CC_D_GEOGRAPHY_LKUP_NAME_UN rebuild tablespace MAXDAT_INDX online;
alter index CC_D_GEOGRAPHY_MASTER_PK rebuild tablespace MAXDAT_INDX online;
alter index CC_D_GEOGRAPHY_MASTER__UN rebuild tablespace MAXDAT_INDX online;
alter index CC_D_FORECAST_NOTES_PK rebuild tablespace MAXDAT_INDX online;
alter index CC_D_DISTRICT_NAME_UN rebuild tablespace MAXDAT_INDX online;
alter index CC_D_DISTRICT_PK rebuild tablespace MAXDAT_INDX online;
alter index CC_D_DATES__UNV2 rebuild tablespace MAXDAT_INDX online;
alter index CC_D_DATES__UN rebuild tablespace MAXDAT_INDX online;
alter index CC_D_DATES_PK rebuild tablespace MAXDAT_INDX online;
alter index CC_D_COUNTRY_NAME_UN rebuild tablespace MAXDAT_INDX online;
alter index CC_D_COUNTRY_PK rebuild tablespace MAXDAT_INDX online;
alter index CC_D_CONTACT_QUEUE__UN rebuild tablespace MAXDAT_INDX online;
alter index CC_D_CONTACT_QUEUE_PK rebuild tablespace MAXDAT_INDX online;
alter index CC_D_AGENT__UN rebuild tablespace MAXDAT_INDX online;
alter index CC_D_ACTIVITY_TYPE__UN rebuild tablespace MAXDAT_INDX online;
alter index CC_S_VM_IN_QUEUE_PK rebuild tablespace MAXDAT_INDX online;
alter index CC_S_VM_IN_QUEUE_IDX rebuild tablespace MAXDAT_INDX online;
alter index CC_S_WFM_INTERVAL__UN rebuild tablespace MAXDAT_INDX online;
alter index CC_S_WFM_INTERVAL_PK rebuild tablespace MAXDAT_INDX online;
alter index CC_S_TMP_INTERVAL_UN rebuild tablespace MAXDAT_INDX online;
alter index CC_S_TMP_INTERVAL_PK rebuild tablespace MAXDAT_INDX online;
alter index CC_S_TMP_AVY_APPLICATION_PK rebuild tablespace MAXDAT_INDX online;
alter index CC_S_TMP_AVY_AGENT_PK rebuild tablespace MAXDAT_INDX online;
alter index CC_S_TMP_ACTUALEVENTTIMELIN_PK rebuild tablespace MAXDAT_INDX online;
alter index CC_S_TIMEZONEAM_PK rebuild tablespace MAXDAT_INDX online;
alter index CC_C_HORIZON__UN rebuild tablespace MAXDAT_INDX online;
alter index CC_C_HORIZON_PK rebuild tablespace MAXDAT_INDX online;
alter index CC_S_PRODUCTION_PLAN__UN rebuild tablespace MAXDAT_INDX online;
alter index CC_C_PRODUCTION_PLAN_PK rebuild tablespace MAXDAT_INDX online;
alter index CC_S_IVR_SELF_SVC_USAGE__UN rebuild tablespace MAXDAT_INDX online;
alter index CC_S_IVR_SELF_SERVICE_USAGE_PK rebuild tablespace MAXDAT_INDX online;
alter index CC_S_SELF_SERVICE_PATH__UN rebuild tablespace MAXDAT_INDX online;
alter index CC_S_SELF_SERVICE_PATH_PK rebuild tablespace MAXDAT_INDX online;
alter index CC_S_IVR_INTERVAL__UN rebuild tablespace MAXDAT_INDX online;
alter index CC_S_ACD_INTERVALV1_PK rebuild tablespace MAXDAT_INDX online;
alter index CC_S_INTERVAL__UN rebuild tablespace MAXDAT_INDX online;
alter index CC_S_INTERVAL_PK rebuild tablespace MAXDAT_INDX online;
alter index CC_S_FCST_INTERVAL__UN rebuild tablespace MAXDAT_INDX online;
alter index CC_S_FCST_INTERVAL_PK rebuild tablespace MAXDAT_INDX online;
alter index CC_S_CONTACT_QUEUE__UN rebuild tablespace MAXDAT_INDX online;
alter index CC_S_CONTACT_QUEUE_PK rebuild tablespace MAXDAT_INDX online;
alter index CC_S_CALL_DETAIL__UN rebuild tablespace MAXDAT_INDX online;
alter index CC_S_CALL_DETAIL_PK rebuild tablespace MAXDAT_INDX online;
alter index CC_S_AGENT_WORK_DAY__UN rebuild tablespace MAXDAT_INDX online;
alter index CC_S_AGENT_WORK_DAY_PK rebuild tablespace MAXDAT_INDX online;
alter index CC_S_AGENT_SUPERVISOR_UN rebuild tablespace MAXDAT_INDX online;
alter index CC_S_AGENT_ABSENCES__UN rebuild tablespace MAXDAT_INDX online;
alter index CC_S_AGENT_UN rebuild tablespace MAXDAT_INDX online;
alter index CC_S_ACD_INTERVAL_PERIOD_PK rebuild tablespace MAXDAT_INDX online;
alter index CC_S_INTERVAL_PERIOD__UN rebuild tablespace MAXDAT_INDX online;
alter index CC_S_ACD_INTERVAL__UN rebuild tablespace MAXDAT_INDX online;
alter index CC_S_ACD_AGENT_ACTIVITY_UN rebuild tablespace MAXDAT_INDX online;
alter index CC_L_PATCH_LOG__UNV1 rebuild tablespace MAXDAT_INDX online;
alter index CC_L_PATCH_LOG__UN rebuild tablespace MAXDAT_INDX online;
alter index CC_L_PATCH_LOG_PK rebuild tablespace MAXDAT_INDX online;
alter index CC_L_ERROR_PK rebuild tablespace MAXDAT_INDX online;
alter index CC_C_UNIT_OF_WORK_PK rebuild tablespace MAXDAT_INDX online;
alter index CC_S_PROJECT_SITE_CONFIG__UN rebuild tablespace MAXDAT_INDX online;
alter index CC_C_PROJECT_CONFIG_PK rebuild tablespace MAXDAT_INDX online;
alter index CC_C_LOOKUP_PK rebuild tablespace MAXDAT_INDX online;
alter index CC_C_LOOKUP__UN rebuild tablespace MAXDAT_INDX online;
alter index CC_C_FILTER_PK rebuild tablespace MAXDAT_INDX online;
alter index CC_C_FILTER__UN rebuild tablespace MAXDAT_INDX online;
alter index CC_C_CONTACT_QUEUEV1_PK rebuild tablespace MAXDAT_INDX online;
alter index CC_C_ACTIVITY_TYPE__UN rebuild tablespace MAXDAT_INDX online;
alter index CC_C_ACTIVITY_TYPE_PK rebuild tablespace MAXDAT_INDX online;
alter index CC_A_SCHEDULED_JOB__UN rebuild tablespace MAXDAT_INDX online;
alter index CC_A_ADHOC_JOBV1_PK rebuild tablespace MAXDAT_INDX online;
alter index CC_A_SCHEDULE__UN rebuild tablespace MAXDAT_INDX online;
alter index CC_A_SCHEDULE_PK rebuild tablespace MAXDAT_INDX online;
alter index CC_A_ADHOC_JOB_PK rebuild tablespace MAXDAT_INDX online;
alter index IDX4_DOC_ID rebuild tablespace MAXDAT_INDX online;
alter index PP_D_UOW_SOURCE_REF_UN1 rebuild tablespace MAXDAT_INDX online;
alter index PP_D_UOW_SOURCE_REF_UN rebuild tablespace MAXDAT_INDX online;
alter index LETTER_REQ_ON_IDX rebuild tablespace MAXDAT_INDX online;
alter index LETTER_CASE_ID_IDX rebuild tablespace MAXDAT_INDX online;