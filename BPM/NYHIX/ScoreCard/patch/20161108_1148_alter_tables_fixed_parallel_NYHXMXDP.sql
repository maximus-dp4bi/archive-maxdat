/*
Created by Raj A. on 11/08/2016 for MAXDAT-4842.
alter session set current_schema = MAXDAT;

select 'alter table ' || TABLE_NAME || ' noparallel;'
from ALL_TABLES
where OWNER = 'DP_SCORECARD'
order by TABLE_NAME asc;

*/
alter table ENGAGE_ACTUALS noparallel;
alter table ENGAGE_ACTUALS_QC_EVAL noparallel;
alter table ENGAGE_ACTUALS_STG noparallel;
alter table ENGAGE_ACTUALS_SUP noparallel;
alter table ENGAGE_FORM_TYPE noparallel;
alter table PP_WFM_DEPARTMENT noparallel;
alter table PP_WFM_JOB_CLASSIFICATION noparallel;
alter table PP_WFM_JOB_CLASSIFICATION_CODE noparallel;
alter table PP_WFM_OFFICE noparallel;
alter table PP_WFM_STAFF_TO_DEPARTMENT noparallel;
alter table PP_WFM_STAFF_TO_OFFICE noparallel;
alter table PP_WFM_TASK_BO parallel 4;
alter table SCORECARD_ATTENDANCE_MTHLY noparallel;
alter table SCORECARD_HIERARCHY noparallel;
alter table SCORECARD_HIERARCHY_UM noparallel;
alter table SC_AGENT_STAT noparallel;
alter table SC_ATTENDANCE noparallel;
alter table SC_ATTENDANCE_ABSENCE_LKUP noparallel;
alter table SC_ATTENDANCE_INITIAL_SCORE noparallel;
alter table SC_CORRECTIVE_ACTION noparallel;
alter table SC_CORRECTIVE_ACTION_LKUP noparallel;
alter table SC_DISCUSSION_LKUP noparallel;
alter table SC_EXCLUSION noparallel;
alter table SC_GOAL noparallel;
alter table SC_GOAL_TYPE_LKUP noparallel;
alter table SC_LAG_TIME noparallel;
alter table SC_NON_STD_USE noparallel;
alter table SC_PERFORMANCE_TRACKER noparallel;
alter table SC_PRODUCTION_BO noparallel;
alter table SC_SUMMARY_BO noparallel;
alter table SC_SUMMARY_CC noparallel;
alter table SC_WRAP_UP_ERROR noparallel;