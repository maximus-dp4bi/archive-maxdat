/*
select 'drop public synonym "' || SYNONYM_NAME || '";'
from ALL_SYNONYMS  
where 
  TABLE_OWNER like '%MAXDAT%'
  and OWNER = 'PUBLIC'
order by 
  OWNER asc,
  SYNONYM_NAME asc;
*/
drop public synonym "/f3e59263_CC_D_PRODUCTION_PLAN";
drop public synonym "CC_D_ACTIVITY_TYPE_SV";
drop public synonym "CC_D_AGENT_SV";
drop public synonym "CC_D_CONTACT_QUEUE_SV";
drop public synonym "CC_D_DATES_SV";
drop public synonym "CC_D_GEOGRAPHY_MASTER_SV";
drop public synonym "CC_D_INTERVAL_SV";
drop public synonym "CC_D_IVR_SELF_SERVICE_PATH_SV";
drop public synonym "CC_D_MANAGER_SV";
drop public synonym "CC_D_PRODUCTION_PLAN_SV";
drop public synonym "CC_D_PROD_PLANNING_TARGET_SV";
drop public synonym "CC_D_PROGRAM_SV";
drop public synonym "CC_D_PROJECT_SV";
drop public synonym "CC_D_PROJECT_TARGETS_SV";
drop public synonym "CC_D_SITE_SV";
drop public synonym "CC_D_SUPERVISOR_SV";
drop public synonym "CC_D_TARGET_SV";
drop public synonym "CC_D_UNIT_OF_WORK_SV";
drop public synonym "CC_F_ACTUALS_IVR_INTERVAL_SV";
drop public synonym "CC_F_ACTUALS_QUEUE_INTERVAL_SV";
drop public synonym "CC_F_AGENT_ACTIVITY_BY_DATE_SV";
drop public synonym "CC_F_AGENT_BY_DATE_SV";
drop public synonym "CC_F_FORECAST_INTERVAL_SV";
drop public synonym "CC_F_IVR_SELF_SERVICE_USAGE_SV";
drop public synonym "GROUPS_STG";
drop public synonym "HOLIDAYS";
drop public synonym "SEQ_EDDB_ID";
drop public synonym "STAFF_STG";
drop public synonym "STEP_DEFINITION_STG";
drop public synonym "STEP_INSTANCE_STG";
drop public synonym "TEST_RBK";