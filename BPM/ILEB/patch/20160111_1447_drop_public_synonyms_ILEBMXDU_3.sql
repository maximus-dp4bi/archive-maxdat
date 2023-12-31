/*
select 'drop public synonym "' || SYNONYM_NAME || '";'
from ALL_SYNONYMS  
where 
  TABLE_OWNER like 'MAXDAT%'
  and OWNER = 'PUBLIC'
order by 
  OWNER asc,
  SYNONYM_NAME asc;
*/
drop public synonym "BIR_AA_CONTRACT";
drop public synonym "BIR_AA_COUNTYCONTRACT";
drop public synonym "BIR_AA_PLAN_PERCENTAGE";
drop public synonym "BIR_ADDRESS";
drop public synonym "BIR_AID_CATEGORIES";
drop public synonym "BIR_ALERT";
drop public synonym "BIR_CARE_SERV_DELIV_AREAS";
drop public synonym "BIR_CASES";
drop public synonym "BIR_CASE_CLIENTS";
drop public synonym "BIR_CHANGE_REASONS";
drop public synonym "BIR_CITIZENSHIP_STATUS";
drop public synonym "BIR_CLIENTS";
drop public synonym "BIR_CLIENT_PLAN_ELIGIBILITY";
drop public synonym "BIR_CLIENT_PLAN_ENRL_STATUS";
drop public synonym "BIR_COUNTIES";
drop public synonym "BIR_COVERAGE_CATEGORIES";
drop public synonym "BIR_ENRL_ACTION_STATU";
drop public synonym "BIR_ENROLLMENT_ERROR_CODE";
drop public synonym "BIR_ENROLLMENT_STATUS";
drop public synonym "BIR_FEDERAL_POVERTY_LEVELS";
drop public synonym "BIR_F_ENROLLMENTS";
drop public synonym "BIR_LANGUAGES";
drop public synonym "BIR_NOTIFICATIONS";
drop public synonym "BIR_PLANS";
drop public synonym "BIR_PLAN_TYPES";
drop public synonym "BIR_PROGRAMS";
drop public synonym "BIR_PROVIDERS";
drop public synonym "BIR_PROVIDER_SPECIALTY";
drop public synonym "BIR_PROVIDER_SPECIALTY_CODE";
drop public synonym "BIR_PROVIDER_TYPES";
drop public synonym "BIR_RACES";
drop public synonym "BIR_REJECTION_ERROR_REASONS";
drop public synonym "BIR_RISK_GROUPS";
drop public synonym "BIR_SELECTION_MISSING_INFO";
drop public synonym "BIR_SELECTION_REASONS";
drop public synonym "BIR_SELECTION_SOURCES";
drop public synonym "BIR_SELECTION_STATUS";
drop public synonym "BIR_SELECTION_TRANSACTION";
drop public synonym "BIR_SELECTION_TRANS_HISTORY";
drop public synonym "BIR_STAFF_PEOPLE";
drop public synonym "BIR_STATUS_IN_GROUPS";
drop public synonym "BIR_SUB_PROGRAMS";
drop public synonym "BIR_TERMINATION_REASONS";
drop public synonym "BIR_ZIPCODE";
drop public synonym "BIU_CC_A_ADHOC_JOB";
drop public synonym "BIU_CC_A_SCHEDULE";
drop public synonym "BIU_CC_A_SCHEDULED_JOB";
drop public synonym "BIU_CC_C_ACTIVITY_TYPE";
drop public synonym "BIU_CC_C_CONTACT_QUEUE";
drop public synonym "BIU_CC_C_FILTER";
drop public synonym "BIU_CC_C_LOOKUP";
drop public synonym "BIU_CC_C_PROJECT_CONFIG";
drop public synonym "BIU_CC_C_UNIT_OF_WORK";
drop public synonym "BIU_CC_D_PRODUCTION_PLAN_HRZN";
drop public synonym "BIU_CC_F_AGENT_ACTVTY_BY_DATE";
drop public synonym "BIU_CC_F_AGENT_BY_DATE";
drop public synonym "BIU_CC_L_PATCH_LOG";
drop public synonym "BIU_CC_S_ACD_AGENT_ACTIVITY";
drop public synonym "BIU_CC_S_ACD_A_INTERVAL";
drop public synonym "BIU_CC_S_ACD_INTERVAL";
drop public synonym "BIU_CC_S_ACD_INTERVAL_PERIOD";
drop public synonym "BIU_CC_S_ACD_NEW_QUEUES";
drop public synonym "BIU_CC_S_ACD_Q_INTERVAL";
drop public synonym "BIU_CC_S_AGENT";
drop public synonym "BIU_CC_S_AGENT_ABSENCE";
drop public synonym "BIU_CC_S_AGENT_GROUP";
drop public synonym "BIU_CC_S_AGENT_SUPERVISOR";
drop public synonym "BIU_CC_S_AGENT_WORK_DAY";
drop public synonym "BIU_CC_S_CALL_DETAIL";
drop public synonym "BIU_CC_S_CONTACT_QUEUE";
drop public synonym "BIU_CC_S_FCST_INTERVAL";
drop public synonym "BIU_CC_S_INTERVAL";
drop public synonym "BIU_CC_S_IVR_INTERVAL";
drop public synonym "BIU_CC_S_PP_HORIZON";
drop public synonym "BIU_CC_S_PRODUCTION_PLAN";
drop public synonym "BIU_CC_S_WFM_AGENT_ACTIVITY";
drop public synonym "BIU_CC_S_WFM_INTERVAL";
drop public synonym "BIU_D_REPORTING_PERIOD";
drop public synonym "BIU_PP_WFM_EVENT";
drop public synonym "BIU_PP_WFM_EVENT_TYPE";
drop public synonym "BIU_PP_WFM_EVENT_TYPE_GROUP";
drop public synonym "BIU_PP_WFM_SCHEDULE_MONITOR";
drop public synonym "BIU_PP_WFM_STAFF";
drop public synonym "BIU_PP_WFM_STAFF_GROUP";
drop public synonym "BIU_PP_WFM_STAFF_GRP_TO_STAFF";
drop public synonym "BIU_PP_WFM_SUPERVISOR";
drop public synonym "BIU_PP_WFM_SUPERVISOR_TO_STAFF";
drop public synonym "BIU_PP_WFM_TASK";
drop public synonym "BIU_PP_WFM_TASK_CATEGORY";
drop public synonym "BI_CC_D_ACTIVITY_TYPE";
drop public synonym "BI_CC_D_AGENT";
drop public synonym "BI_CC_D_CONTACT_QUEUE";
drop public synonym "BI_CC_D_DATES";
drop public synonym "BI_CC_D_FORECAST_NOTES";
drop public synonym "BI_CC_D_GROUP";
drop public synonym "BI_CC_D_INTERVAL";
drop public synonym "BI_CC_D_IVR_SELF_SVC_PATH";
drop public synonym "BI_CC_D_PRODUCTION_PLAN";
drop public synonym "BI_CC_D_PROJECT_TARGETS";
drop public synonym "BI_CC_D_SITE";
drop public synonym "BI_CC_D_UNIT_OF_WORK";
drop public synonym "BI_CC_F_ACD_A_INTERVAL";
drop public synonym "BI_CC_F_ACD_Q_INTERVAL";
drop public synonym "BI_CC_F_ACTUALS_IVR_INTERVAL";
drop public synonym "BI_CC_F_ACTUALS_Q_INTERVAL";
drop public synonym "BI_CC_F_AGENT_ACTVTY_BY_DATE";
drop public synonym "BI_CC_F_AGENT_BY_DATE";
drop public synonym "BI_CC_F_FORECAST_INTERVAL";
drop public synonym "BI_CC_F_IVR_SELF_SVC_USAGE";
drop public synonym "BI_CC_L_ERROR";
drop public synonym "BUR_AA_CONTRACT";
drop public synonym "BUR_AA_COUNTYCONTRACT";
drop public synonym "BUR_AA_PLAN_PERCENTAGE";
drop public synonym "BUR_ALERT";
drop public synonym "BUR_CASES";
drop public synonym "BUR_CASE_CLIENTS";
drop public synonym "BUR_CLIENTS";
drop public synonym "BUR_CLIENT_PLAN_ELIGIBILITY";
drop public synonym "BUR_CLIENT_PLAN_ENRL_STATUS";
drop public synonym "BUR_F_ENROLLMENTS";
drop public synonym "BUR_PROVIDERS";
drop public synonym "BUR_SELECTION_TRANSACTION";
drop public synonym "STEP_INSTANCE_STG_TRG";
drop public synonym "TRG_ADIU_CORP_ETL_LIST_LKUP";
drop public synonym "TRG_ADIU_HOLIDAYS";
drop public synonym "TRG_AI_CORP_ETL_CLNT_INQRY_Q";
drop public synonym "TRG_AI_CORP_ETL_MAILFAXDOC_Q";
drop public synonym "TRG_AI_CORP_ETL_MANAGE_ENRL_Q";
drop public synonym "TRG_AI_CORP_ETL_MANAGE_JOBS_Q";
drop public synonym "TRG_AI_CORP_ETL_MANAGE_WORK_Q";
drop public synonym "TRG_AI_CORP_ETL_PROC_INCDNTS_Q";
drop public synonym "TRG_AI_CORP_ETL_PROC_LETTERS_Q";
drop public synonym "TRG_AI_CORP_ETL_PROC_OC_Q";
drop public synonym "TRG_AI_CORP_ETL_PROC_ON_INF_Q";
drop public synonym "TRG_AU_CORP_ETL_CLNT_INQRY_Q";
drop public synonym "TRG_AU_CORP_ETL_MAILFAXDOC_Q";
drop public synonym "TRG_AU_CORP_ETL_MANAGE_ENRL_Q";
drop public synonym "TRG_AU_CORP_ETL_MANAGE_JOBS_Q";
drop public synonym "TRG_AU_CORP_ETL_MANAGE_WORK_Q";
drop public synonym "TRG_AU_CORP_ETL_PROC_INCDNTS_Q";
drop public synonym "TRG_AU_CORP_ETL_PROC_LETTERS_Q";
drop public synonym "TRG_AU_CORP_ETL_PROC_OC_Q";
drop public synonym "TRG_AU_CORP_ETL_PROC_ON_INF_Q";
drop public synonym "TRG_BIU_BPM_ACTIVITY_EVENTS";
drop public synonym "TRG_BIU_BPM_ATTRIBUTE";
drop public synonym "TRG_BIU_BPM_INSTANCE";
drop public synonym "TRG_BIU_BPM_INSTANCE_ATTR";
drop public synonym "TRG_BIU_BPM_UPDATE_EVENT";
drop public synonym "TRG_BIU_CORP_ETL_CONTROL";
drop public synonym "TRG_BIU_CORP_ETL_ERROR_LOG";
drop public synonym "TRG_BIU_CORP_ETL_LIST_LKUP";
drop public synonym "TRG_BIU_CORP_ETL_MANAGE_JOBS";
drop public synonym "TRG_BIU_CORP_ETL_MANAGE_WORK";
drop public synonym "TRG_BIU_CORP_ETL_PROC_INCDNTS";
drop public synonym "TRG_BIU_CORP_ETL_PROC_OC";
drop public synonym "TRG_BIU_CORP_ETL_PROC_OC_DTL";
drop public synonym "TRG_BIU_CORP_ETL_PROC_ONL_INFO";
drop public synonym "TRG_BIU_CORP_INSTANCE_CLEANUP";
drop public synonym "TRG_BIU_ETL_CLIENT_INQRY_EVENT";
drop public synonym "TRG_BIU_ETL_CLIENT_INQUIRY";
drop public synonym "TRG_BIU_ETL_CLIENT_INQUIRY_DTL";
drop public synonym "TRG_BIU_ETL_CLNT_INQRY_EVE_WIP";
drop public synonym "TRG_BIU_ETL_CLNT_INQRY_WIP";
drop public synonym "TRG_BIU_ETL_E_DIALER_RUN_STG";
drop public synonym "TRG_BIU_R_HOLIDAYS";
drop public synonym "TRG_BIU_STEP_INSTANCE_STG";
drop public synonym "TRG_CORP_ETL_MANAGE_ENRL";
drop public synonym "TRG_R_CORP_ETL_MAILFAXDOC";
drop public synonym "TRG_R_CORP_ETL_MAILFAXDOC_OLTP";
drop public synonym "TRG_R_CORP_ETL_MAIL_WIP_BPM";
drop public synonym "TRG_R_CORP_ETL_MANAGE_JOBS";
drop public synonym "TRG_R_CORP_ETL_MANAGE_WORK";
drop public synonym "TRG_R_CORP_ETL_PROCES_INCDENTS";
drop public synonym "TRG_R_CORP_ETL_PROC_LETTER";
drop public synonym "TRG_R_CORP_ETL_PROC_LTR_OLTP";
drop public synonym "TRG_R_CORP_ETL_PROC_LTR_WIP";