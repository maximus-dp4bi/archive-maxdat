/*
Created on 07/21/2016 by Raj A.
Description: MAXDAT-3712. Fix for CADRMXDD tables.

alter session set current_schema = MAXDAT;

select 'alter table ' || TABLE_NAME || ' noparallel;' alterCommand
from ALL_TABLES
where OWNER = 'MAXDAT'
order by TABLE_NAME asc;

-- Then edit commands to set parallel degree based on the Table size, table type i.e., if it is a fact or current_schema 
dimension table and which database.

svn://rcmxapp1d.maximus.com/maxdat/BPM/Core/patch/20160701_1340_create_invisible_index_HOLIDAYS_UK1.sql 
*/
alter table ACTS_APPEAL_CASE noparallel;
alter table ACTS_CASE_QUEUE noparallel;
alter table ACTS_CONSULTANT_REF noparallel;
alter table ACTS_CONSULTANT_REF_HISTORY noparallel;
alter table ACTS_CRED_CONSULTANT noparallel;
alter table ACTS_CRED_LICENSES noparallel;
alter table ACTS_PM_RESPONSE noparallel;
alter table ACTS_PM_RESPONSE_DETAILS noparallel;
alter table ACTS_PROGRAM noparallel;
alter table ACTS_REFUSAL_REASON noparallel;
alter table ACTS_REVIEW_DECISION noparallel;
alter table ACTS_SPECIALITY noparallel;
alter table ACTS_USERS noparallel;
alter table ASSGINED_DT_FIX_09032014 noparallel;
alter table BPM_ACTIVITY_ATTRIBUTE noparallel;
alter table BPM_ACTIVITY_EVENTS noparallel;
alter table BPM_ACTIVITY_EVENT_TYPE_LKUP noparallel;
alter table BPM_ACTIVITY_LKUP noparallel;
alter table BPM_ACTIVITY_TYPE_LKUP noparallel;
alter table BPM_ATTRIBUTE noparallel;
alter table BPM_ATTRIBUTE_LKUP noparallel;
alter table BPM_ATTRIBUTE_STAGING_TABLE noparallel;
alter table BPM_DATATYPE_LKUP noparallel;
alter table BPM_DATA_MODEL noparallel;
alter table BPM_D_CONTROL_CHART_PARAMETERS noparallel;
alter table BPM_D_CONTROL_CHART_PARM_LG noparallel;
alter table BPM_D_DATES noparallel;
alter table BPM_D_HOURS noparallel;
alter table BPM_D_METRIC_DEFINITION noparallel;
alter table BPM_D_OPS_GROUP_TASK noparallel;
alter table BPM_D_PROCESS_DEFINITION noparallel;
alter table BPM_D_PROCESS_GROUP noparallel;
alter table BPM_D_PROCESS_GROUP_DETAIL noparallel;
alter table BPM_D_PROCESS_GROUP_METRIC noparallel;
alter table BPM_D_PROCESS_GROUP_METRIC_LG noparallel;
alter table BPM_D_REPORTING_PERIOD noparallel;
alter table BPM_EVENT_MASTER noparallel;
alter table BPM_F_PROCESS_METRIC noparallel;
alter table BPM_F_PROCESS_METRIC_LG noparallel;
alter table BPM_IDENTIFIER_TYPE_LKUP noparallel;
alter table BPM_LOGGING noparallel;
alter table BPM_PROCESS_FLOW noparallel;
alter table BPM_PROCESS_LKUP noparallel;
alter table BPM_PROGRAM_LKUP noparallel;
alter table BPM_PROJECT_LKUP noparallel;
alter table BPM_REGION_LKUP noparallel;
alter table BPM_SOURCE_LKUP noparallel;
alter table BPM_SOURCE_TYPE_LKUP noparallel;
alter table BPM_UPDATE_EVENT_QUEUE parallel 2;
alter table BPM_UPDATE_EVENT_QUEUE_ARCHIVE noparallel;
alter table BPM_UPDATE_TYPE_LKUP noparallel;
alter table CADIR_CLAIM_TYPE_STG noparallel;
alter table CADIR_MANAGEWORK_LOGGING noparallel;
alter table CADIR_MAXDAT_STG noparallel;
alter table CADIR_MAXDAT_STG_BACKUP noparallel;
alter table CADIR_MAXDAT_STG_BKUP_10272014 noparallel;
alter table CADIR_ROLE_STG noparallel;
alter table CADIR_USER_STG noparallel;
alter table CLIENT_ELIG_STATUS_STG noparallel;
alter table CLIENT_SUPPLEMENTARY_INFO_STG noparallel;
alter table CORP_ETL_CLEAN_TABLE noparallel;
alter table CORP_ETL_CLEAN_TABLE_HS noparallel;
alter table CORP_ETL_CONTROL noparallel;
alter table CORP_ETL_ERROR_LOG noparallel;
alter table CORP_ETL_JOB_STATISTICS noparallel;
alter table CORP_ETL_LIST_LKUP noparallel;
alter table CORP_ETL_LIST_LKUP_HIST noparallel;
alter table CORP_ETL_MANAGE_WORK noparallel;
alter table CORP_ETL_MANAGE_WORK_TMP noparallel;
alter table CORP_INSTANCE_CLEANUP_TABLE noparallel;
alter table DEV_TMP noparallel;
alter table D_BONUS_SCORES noparallel;
alter table D_BONUS_STANDARDS noparallel;
alter table D_CRS_CLAIM_PRIORITIES noparallel;
alter table D_CRS_CLOSED_REASONS noparallel;
alter table D_CRS_DATA_PROVIDED noparallel;
alter table D_CRS_DECISION_TYPES noparallel;
alter table D_CRS_DISPOSITION noparallel;
alter table D_CRS_DRUG_CLASS noparallel;
alter table D_CRS_DRUG_SERVICE_NAME noparallel;
alter table D_CRS_DRUG_TYPE noparallel;
alter table D_CRS_EDI_CONTRIBUTORS noparallel;
alter table D_CRS_EXPERTS noparallel;
alter table D_CRS_EXPERT_LICENSES noparallel;
alter table D_CRS_EXPERT_SPECIALTIES noparallel;
alter table D_CRS_EXPERT_TYPES noparallel;
alter table D_CRS_IMR_EXPERT_SUBSPECIALTY noparallel;
alter table D_CRS_INELIGIBILITY_LETTER noparallel;
alter table D_CRS_INELIGIBLE_REASONS noparallel;
alter table D_CRS_ISSUE_TYPES noparallel;
alter table D_CRS_STATES noparallel;
alter table D_CRS_STATUS noparallel;
alter table D_CRS_SUB_CLASS_CATEGORY noparallel;
alter table D_CRS_SUB_SUB_CLASS_CATEGORY noparallel;
alter table D_CRS_TERMINATION_REASONS noparallel;
alter table D_DELTEK_HOURS noparallel;
alter table D_DELTEK_HOURS_TMP noparallel;
alter table D_MW_CURRENT noparallel;
alter table D_MW_ESCALATED noparallel;
alter table D_MW_FORWARDED noparallel;
alter table D_MW_LAST_UPDATE_BY_NAME noparallel;
alter table D_MW_OWNER noparallel;
alter table D_MW_TASK_STATUS noparallel;
alter table D_MW_TASK_TYPE noparallel;
alter table D_PERSON noparallel;
alter table D_QA_CATEGORIES noparallel;
alter table D_QA_CHECKSHEETS noparallel;
alter table D_QA_CHECKSHEET_GROUPS noparallel;
alter table D_QA_ERROR_REASONS noparallel;
alter table D_QA_MONTHLY_GOAL noparallel;
alter table D_QA_OUTCOMES noparallel;
alter table D_QA_QUESTIONS noparallel;
alter table D_QA_STAFF noparallel;
alter table D_QA_STAFF_ROLES noparallel;
alter table D_QA_SUBCATEGORIES noparallel;
alter table D_STAFF noparallel;
alter table D_SUPERVISOR noparallel;
alter table D_ZIP_COUNTY noparallel;
alter table ETK_ASSIGNMENT noparallel;
alter table ETK_PERSON noparallel;
alter table ETK_ROLE noparallel;
alter table ETK_USER noparallel;
alter table FAR_TEMP noparallel;
alter table F_AVG_DAYS_IN_QUEUE_STG noparallel;
alter table F_AVG_DAYS_IN_QUEUE_TMP noparallel;
alter table F_MW_BY_DATE noparallel;
alter table F_QUEUE_NUM_BY_DAY_STG noparallel;
alter table GATHER_STATS_TABLE_CONFIG noparallel;
alter table GROUPS_STG noparallel;
alter table GROUP_STEP_DEFINITION_STG noparallel;
alter table GROUP_STEP_DEFN_DEFAULT_STG noparallel;
alter table HOLIDAYS noparallel;
alter table HOLIDAYS_2015 noparallel;
alter table IA_SQL1 noparallel;
alter table LETTERS_STG noparallel;
alter table LG_TEST noparallel;
alter table LG_TEST1 noparallel;
alter table MAXDAT_ADMIN_AUDIT_LOGGING noparallel;
alter table MY_USERS noparallel;
alter table PBQJ_ADJUST_REASON_LKUP noparallel;
alter table PP_CFG_ACTUALS_FILE_CONTROL noparallel;
alter table PP_CFG_FORECAST_FILE_CONTROL noparallel;
alter table PP_CFG_GEOGRAPHY_CONFIG noparallel;
alter table PP_CFG_HORIZON noparallel;
alter table PP_CFG_PRODUCTION_PLAN noparallel;
alter table PP_CFG_PROGRAM_CONFIG noparallel;
alter table PP_CFG_PROJECT_CONFIG noparallel;
alter table PP_CFG_SOURCE_CONFIG noparallel;
alter table PP_CFG_UNIT_OF_WORK noparallel;
alter table PP_D_ACTUAL_DETAILS noparallel;
alter table PP_D_COUNTRY noparallel;
alter table PP_D_DATES noparallel;
alter table PP_D_DISTRICT noparallel;
alter table PP_D_GEOGRAPHY_MASTER noparallel;
alter table PP_D_HOURS noparallel;
alter table PP_D_PRODUCTION_PLAN noparallel;
alter table PP_D_PRODUCTION_PLAN_HORIZON noparallel;
alter table PP_D_PROGRAM noparallel;
alter table PP_D_PROJECT noparallel;
alter table PP_D_PROVINCE noparallel;
alter table PP_D_REGION noparallel;
alter table PP_D_SEGMENT noparallel;
alter table PP_D_SITE noparallel;
alter table PP_D_SOURCE noparallel;
alter table PP_D_SOURCE_REF_TYPE noparallel;
alter table PP_D_STATE noparallel;
alter table PP_D_UNIT_OF_WORK noparallel;
alter table PP_D_UOW_SOURCE_REF noparallel;
alter table PP_FORECAST_NOTES noparallel;
alter table PP_F_ACTUALS noparallel;
alter table PP_F_FORECAST noparallel;
alter table PP_STG_ACTUALS noparallel;
alter table PP_STG_ACTUALS_IMPORT noparallel;
alter table PP_STG_FCST_BY_INV_AGE noparallel;
alter table PP_STG_FCST_VOLUME noparallel;
alter table PP_STG_FORECAST noparallel;
alter table PP_STG_LOG noparallel;
alter table PROCESS_BPM_CALC_JOB_CONFIG noparallel;
alter table PROCESS_BPM_QUEUE_JOB noparallel;
alter table PROCESS_BPM_QUEUE_JOB_BATCH noparallel;
alter table PROCESS_BPM_QUEUE_JOB_CONFIG noparallel;
alter table PROCESS_BPM_QUEUE_JOB_CTRL_CFG noparallel;
alter table RA_EXPERT_NAME_QUERIES noparallel;
alter table RA_EXPERT_SPECIALTY_QUEURIES noparallel;
alter table RA_IMR_DAYS_IN_EXPERT_QUEUE noparallel;
alter table RA_IMR_DAYS_WITH_EXPERT noparallel;
alter table RA_IMR_MONTHLY_REPORT noparallel;
alter table SQID_TASK_HIST_STG noparallel;
alter table SQID_USER_ROLE_STG noparallel;
alter table STEP_DEFINITION_STG noparallel;
alter table STEP_INSTANCE_STG noparallel;
alter table S_CRS_IMR noparallel;
alter table S_CRS_IMR_AUDIT_STAGE noparallel;
alter table S_CRS_IMR_CERT_SPECIALTY noparallel;
alter table S_CRS_IMR_DECISIONS noparallel;
alter table S_CRS_IMR_EXPERT_LICENSE_STATE noparallel;
alter table S_CRS_IMR_EXPERT_REVIEW noparallel;
alter table S_CRS_IMR_EXP_REVIEW_HIST noparallel;
alter table S_CRS_IMR_ISSUES_IN_DISPUTE noparallel;
alter table S_CRS_IMR_PRELIMINARY_REVIEW noparallel;
alter table S_CRS_SARA noparallel;
alter table S_FORECASTED_FDL noparallel;
alter table S_MW_TASK_GOAL noparallel;
alter table S_QA_AUDIT_RESULTS noparallel;
alter table S_QA_AUDIT_RESULT_DETAILS noparallel;
alter table S_QA_STAFF_ORGANIZATION noparallel;
alter table T0QUWKIWLMD006 noparallel;
alter table T2Y14N2SLMQ002 noparallel;
alter table T4A4OYAQDMD004 noparallel;
alter table T8QUWN04LMQ001 noparallel;
alter table T9I6WVR9HMD003 noparallel;
alter table TABLE_A noparallel;
alter table TABLE_B noparallel;
alter table TABLE_C noparallel;
alter table TABLE_D noparallel;
alter table TEST_A noparallel;
alter table TEST_B noparallel;
alter table TOQDK881XMD005 noparallel;
alter table TU294MQBPAM000 noparallel;
alter table T_CLAIM_TYPE noparallel;
alter table T_IMR noparallel;
alter table T_MAXDAT_DATA noparallel;