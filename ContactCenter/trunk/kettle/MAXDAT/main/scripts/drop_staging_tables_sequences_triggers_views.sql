
DROP VIEW CC_S_AGENT_SV ;
DROP VIEW CC_S_CALL_DETAIL_SV ;
DROP VIEW CC_S_TMP_IVR_STEP_SV ;

DROP TABLE CC_A_ADHOC_JOB CASCADE CONSTRAINTS;
DROP TABLE CC_A_SCHEDULE CASCADE CONSTRAINTS;
DROP TABLE CC_A_SCHEDULED_JOB CASCADE CONSTRAINTS;
DROP TABLE CC_C_ACTIVITY_TYPE CASCADE CONSTRAINTS;
DROP TABLE CC_C_CONTACT_QUEUE CASCADE CONSTRAINTS;
DROP TABLE CC_C_FILTER CASCADE CONSTRAINTS;
DROP TABLE CC_C_LOOKUP CASCADE CONSTRAINTS;
DROP TABLE CC_C_PROJECT_CONFIG CASCADE CONSTRAINTS;
DROP TABLE CC_C_UNIT_OF_WORK CASCADE CONSTRAINTS;
DROP TABLE CC_L_ERROR CASCADE CONSTRAINTS;
DROP TABLE CC_L_PATCH_LOG CASCADE CONSTRAINTS;
DROP TABLE CC_L_TRANSFORMATION CASCADE CONSTRAINTS;
DROP TABLE CC_S_ACD_AGENT_ACTIVITY CASCADE CONSTRAINTS;
DROP TABLE CC_S_ACD_INTERVAL CASCADE CONSTRAINTS;
DROP TABLE CC_S_ACD_INTERVAL_PERIOD CASCADE CONSTRAINTS;
DROP TABLE CC_S_AGENT CASCADE CONSTRAINTS;
DROP TABLE CC_S_AGENT_ABSENCE CASCADE CONSTRAINTS;
DROP TABLE CC_S_AGENT_SUPERVISOR CASCADE CONSTRAINTS;
DROP TABLE CC_S_AGENT_WORK_DAY CASCADE CONSTRAINTS;
DROP TABLE CC_S_CALL_DETAIL CASCADE CONSTRAINTS;
DROP TABLE CC_S_CONTACT_QUEUE CASCADE CONSTRAINTS;
DROP TABLE CC_S_FCST_INTERVAL CASCADE CONSTRAINTS;
DROP TABLE CC_S_INTERVAL CASCADE CONSTRAINTS;
DROP TABLE CC_S_IVR_INTERVAL CASCADE CONSTRAINTS;
DROP TABLE CC_S_IVR_SELF_SERVICE_PATH CASCADE CONSTRAINTS;
DROP TABLE CC_S_IVR_SELF_SERVICE_USAGE CASCADE CONSTRAINTS;
DROP TABLE CC_S_PRODUCTION_PLAN CASCADE CONSTRAINTS;
DROP TABLE CC_S_PRODUCTION_PLAN_HORIZON CASCADE CONSTRAINTS;
DROP TABLE CC_S_TIMEZONEAM CASCADE CONSTRAINTS;
DROP TABLE CC_S_TMP_ACTUALEVENTTIMELINE CASCADE CONSTRAINTS;
DROP TABLE CC_S_TMP_AGENT_SKILL_GROUP CASCADE CONSTRAINTS;
DROP TABLE CC_S_TMP_AVY_AGENT CASCADE CONSTRAINTS;
DROP TABLE CC_S_TMP_AVY_AGENTBYAPP CASCADE CONSTRAINTS;
DROP TABLE CC_S_TMP_AVY_APPLICATION CASCADE CONSTRAINTS;
DROP TABLE CC_S_TMP_AVY_DAGENTPERFORMANCE CASCADE CONSTRAINTS;
DROP TABLE CC_S_TMP_AVY_ECSRSTAT CASCADE CONSTRAINTS;
DROP TABLE CC_S_TMP_AVY_IAPPLICATION CASCADE CONSTRAINTS;
DROP TABLE CC_S_TMP_CISCO_AGENT_INTERVAL CASCADE CONSTRAINTS;
DROP TABLE CC_S_TMP_CISCO_AGENT_LOGOUT CASCADE CONSTRAINTS;
DROP TABLE CC_S_TMP_CISCO_A_SG_INTERVAL CASCADE CONSTRAINTS;
DROP TABLE CC_S_TMP_CISCO_C_T_INTERVAL CASCADE CONSTRAINTS;
DROP TABLE CC_S_TMP_INTERVAL CASCADE CONSTRAINTS;
DROP TABLE CC_S_TMP_IVR_STEP CASCADE CONSTRAINTS;
DROP TABLE CC_S_TMP_PIPKINS_EVENT CASCADE CONSTRAINTS;
DROP TABLE CC_S_TMP_PIPKINS_OFFICE CASCADE CONSTRAINTS;
DROP TABLE CC_S_TMP_PIPKINS_STAFF CASCADE CONSTRAINTS;
DROP TABLE CC_S_TMP_PIPKINS_STF_TO_OFFICE CASCADE CONSTRAINTS;
DROP TABLE CC_S_TMP_PIPKINS_SUP_TO_STAFF CASCADE CONSTRAINTS;
DROP TABLE CC_S_TMP_PIPKINS_TASK CASCADE CONSTRAINTS;
DROP TABLE CC_S_TMP_PIPKINS_TIMEZONE CASCADE CONSTRAINTS;
DROP TABLE CC_S_WFM_AGENT_ACTIVITY CASCADE CONSTRAINTS;
DROP TABLE CC_S_WFM_INTERVAL CASCADE CONSTRAINTS;

DROP SEQUENCE SEQ_CC_A_ADHOC_JOB;
DROP SEQUENCE SEQ_CC_A_SCHEDULE;
DROP SEQUENCE SEQ_CC_A_SCHEDULED_JOB;
DROP SEQUENCE SEQ_CC_C_ACTIVITY_TYPE;
DROP SEQUENCE SEQ_CC_C_CONTACT_QUEUE;
DROP SEQUENCE SEQ_CC_C_FILTER;
DROP SEQUENCE SEQ_CC_C_LOOKUP;
DROP SEQUENCE SEQ_CC_C_PROJECT_CONFIG;
DROP SEQUENCE SEQ_CC_C_UNIT_OF_WORK;
DROP SEQUENCE SEQ_CC_L_ERROR;
DROP SEQUENCE SEQ_CC_L_PATCH_LOG;
DROP SEQUENCE SEQ_CC_S_ACD_AGENT_ACTIVITY;
DROP SEQUENCE SEQ_CC_S_ACD_INTERVAL;
DROP SEQUENCE SEQ_CC_S_ACD_INTERVAL_PERIOD;
DROP SEQUENCE SEQ_CC_S_AGENT;
DROP SEQUENCE SEQ_CC_S_AGENT_ABSENCE;
DROP SEQUENCE SEQ_CC_S_AGENT_SUPERVISOR;
DROP SEQUENCE SEQ_CC_S_AGENT_WORK_DAY;
DROP SEQUENCE SEQ_CC_S_APPRVD_EXCPTN;
DROP SEQUENCE SEQ_CC_S_ATTENDANCE;
DROP SEQUENCE SEQ_CC_S_CALL_DETAIL;
DROP SEQUENCE SEQ_CC_S_CONTACT_QUEUE;
DROP SEQUENCE SEQ_CC_S_FCST_INTERVAL;
DROP SEQUENCE SEQ_CC_S_GROUP;
DROP SEQUENCE SEQ_CC_S_INTERVAL;
DROP SEQUENCE SEQ_CC_S_IVR_INTERVAL;
DROP SEQUENCE SEQ_CC_S_IVR_SELF_SERVICE_PATH;
DROP SEQUENCE SEQ_CC_S_IVR_SS_USAGE;
DROP SEQUENCE SEQ_CC_S_PRODUCTION_PLAN;
DROP SEQUENCE SEQ_CC_S_PP_HORIZON;
DROP SEQUENCE SEQ_CC_S_PROJECT;
DROP SEQUENCE SEQ_CC_S_READINESS;
DROP SEQUENCE SEQ_CC_S_SITE;
DROP SEQUENCE SEQ_CC_S_WFM_AGENT_ACTIVITY;
DROP SEQUENCE SEQ_CC_S_WFM_INTERVAL;