use maxdat
go

DELETE FROM CC_F_ACTUALS_IVR_INTERVAL; 
DELETE FROM CC_F_ACTUALS_QUEUE_INTERVAL; 
DELETE FROM CC_F_AGENT_ACTIVITY_BY_DATE;
DELETE FROM CC_F_AGENT_BY_DATE; 
DELETE FROM CC_F_FORECAST_INTERVAL; 
DELETE FROM CC_F_IVR_SELF_SERVICE_USAGE; 
DELETE FROM CC_D_ACTIVITY_TYPE; 
DELETE FROM CC_D_AGENT; 
DELETE FROM CC_D_CONTACT_QUEUE; 
DELETE FROM CC_D_PRODUCTION_PLAN_HORIZON; 
DELETE FROM CC_D_PRODUCTION_PLAN; 
DELETE FROM CC_D_GEOGRAPHY_MASTER; 
DELETE FROM CC_D_COUNTRY; 
DELETE FROM CC_D_DATES; 
DELETE FROM CC_D_DISTRICT; 
DELETE FROM CC_D_FORECAST_NOTES; 
DELETE FROM CC_D_GROUP; 
DELETE FROM CC_D_INTERVAL; 
DELETE FROM CC_D_IVR_SELF_SERVICE_PATH; 
DELETE FROM CC_D_PROD_PLANNING_TARGET; 
DELETE FROM CC_D_PROGRAM; 
DELETE FROM CC_D_PROJECT_TARGETS; 
DELETE FROM CC_D_PROJECT; 
DELETE FROM CC_D_PROVINCE; 
DELETE FROM CC_D_REGION; 
DELETE FROM CC_D_SITE; 
DELETE FROM CC_D_STATE; 
DELETE FROM CC_D_TARGET; 
DELETE FROM CC_D_UNIT_OF_WORK;

DELETE FROM CC_L_ERROR;
DELETE FROM CC_L_TRANSFORMATION;
DELETE FROM CC_L_PATCH_LOG;
DELETE FROM CC_S_TMP_ACTUALEVENTTIMELINE;
DELETE FROM CC_S_TMP_CISCO_AGENT_INTERVAL;
DELETE FROM CC_S_TMP_CISCO_AGENT_LOGOUT;
DELETE FROM CC_S_TMP_CISCO_A_SG_INTERVAL;
DELETE FROM CC_S_TMP_CISCO_C_T_INTERVAL;
DELETE FROM CC_S_AGENT_ABSENCE;
DELETE FROM CC_S_AGENT_SUPERVISOR;
DELETE FROM CC_S_AGENT_WORK_DAY;
DELETE FROM CC_S_ACD_AGENT_ACTIVITY;
DELETE FROM CC_S_ACD_INTERVAL;
DELETE FROM CC_S_WFM_INTERVAL;
DELETE FROM CC_S_CONTACT_QUEUE;
DELETE FROM CC_S_ACD_INTERVAL_PERIOD;
DELETE FROM CC_S_CALL_DETAIL;
DELETE FROM CC_S_FCST_INTERVAL;
DELETE FROM CC_S_IVR_INTERVAL;
DELETE FROM CC_S_IVR_SELF_SERVICE_USAGE;
DELETE FROM CC_S_IVR_SELF_SERVICE_PATH;
DELETE FROM CC_S_INTERVAL;
DELETE FROM CC_S_PRODUCTION_PLAN_HORIZON;
DELETE FROM CC_S_TIMEZONEAM;
DELETE FROM CC_S_TMP_INTERVAL;
DELETE FROM CC_S_WFM_AGENT_ACTIVITY;
DELETE FROM CC_S_AGENT;
DELETE FROM CC_S_PRODUCTION_PLAN;
DELETE FROM CC_C_ACTIVITY_TYPE;
DELETE FROM CC_C_PROJECT_CONFIG;
DELETE FROM CC_C_CONTACT_QUEUE;
DELETE FROM CC_C_FILTER;
DELETE FROM CC_C_LOOKUP;
DELETE FROM CC_C_UNIT_OF_WORK;


delete from cc_a_adhoc_job;

