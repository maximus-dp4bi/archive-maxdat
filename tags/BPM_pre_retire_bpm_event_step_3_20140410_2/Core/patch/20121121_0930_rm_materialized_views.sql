-- MV Refresh Group
drop view MV_REFRESH_GROUP;
drop package BPM_EVENTS_MV;
execute dbms_refresh.destroy('MANAGE_WORK');

-- MV Logs
drop materialized view log on BPM_ATTRIBUTE;
drop materialized view log on BPM_ATTRIBUTE_LKUP;
drop materialized view log on BPM_D_DATES;

-- MV Views
drop view F_BPM_INSTANCE_BY_DATE;
drop view F_BPM_INSTANCE_CMPLT_BY_DATE;
drop view F_BPM_INSTANCE_CREATE_BY_DATE;
drop view F_BPM_INSTANCE_CURRENT;
drop view F_BPM_INSTANCE_INV_BY_DATE;
drop view D_AGE_IN_BUSINESS_DAYS;
drop view D_AGE_IN_CALENDAR_DAYS;
drop view D_CANCEL_WORK_DATE;
drop view D_CANCEL_WORK_FLAG;
drop view D_COMPLETE_DATE;
drop view D_COMPLETE_FLAG;
drop view D_CREATED_BY_NAME;
drop view D_CREATE_DATE;
drop view D_ESCALATED_FLAG;
drop view D_ESCALATED_TO_NAME;
drop view D_FORWARDED_BY_NAME;
drop view D_FORWARDED_FLAG;
drop view D_GROUP_NAME;
drop view D_GROUP_PARENT_NAME;
drop view D_GROUP_SUPERVISOR_NAME;
drop view D_IDENTIFIER_TYPE;
drop view D_JEOPARDY_FLAG;
drop view D_LAST_UPDATE_BY_NAME;
drop view D_LAST_UPDATE_DATE;
drop view D_OWNER_NAME;
drop view D_SLA_DAYS;
drop view D_SLA_DAYS_TYPE;
drop view D_SLA_JEOPARDY_DAYS;
drop view D_SLA_TARGET_DAYS;
drop view D_SOURCE_REFERENCE_ID;
drop view D_SOURCE_REFERENCE_TYPE;
drop view D_SOURCE_TYPE;
drop view D_STATUS_AGE_IN_BUSINESS_DAYS;
drop view D_STATUS_AGE_IN_CALENDAR_DAYS;
drop view D_STATUS_DATE;
drop view D_TASK_ID;
drop view D_TASK_STATUS;
drop view D_TASK_TYPE;
drop view D_TEAM_NAME;
drop view D_TEAM_PARENT_NAME;
drop view D_TEAM_SUPERVISOR_NAME;
drop view D_TIMELINESS_STATUS;
drop view D_UNIT_OF_WORK;

-- Materialized Views
/*
select 'drop materialized view ' || NAME || ';' 
from ALL_SNAPSHOTS
where 
  OWNER = 'MAXDAT'
  and (NAME like 'V_D_%' or NAME like 'V_F_%')
order by NAME asc;
*/
drop materialized view V_F_BPM_INSTANCE_BY_DATE;
drop materialized view V_D_AGE_IN_BUSINESS_DAYS;
drop materialized view V_D_CANCEL_WORK_DATE;
drop materialized view V_D_COMPLETE_DATE;
drop materialized view V_D_CREATED_BY_NAME;
drop materialized view V_D_CREATE_DATE;
drop materialized view V_D_ESCALATED_FLAG;
drop materialized view V_D_ESCALATED_TO_NAME;
drop materialized view V_D_FORWARDED_BY_NAME;
drop materialized view V_D_FORWARDED_FLAG;
drop materialized view V_D_GROUP_NAME;
drop materialized view V_D_GROUP_PARENT_NAME;
drop materialized view V_D_GROUP_SUPERVISOR_NAME;
drop materialized view V_D_LAST_UPDATE_BY_NAME;
drop materialized view V_D_LAST_UPDATE_DATE;
drop materialized view V_D_OWNER_NAME;
drop materialized view V_D_SLA_DAYS;
drop materialized view V_D_SLA_DAYS_TYPE;
drop materialized view V_D_SLA_JEOPARDY_DAYS;
drop materialized view V_D_SLA_TARGET_DAYS;
drop materialized view V_D_SOURCE_REFERENCE_ID;
drop materialized view V_D_SOURCE_REFERENCE_TYPE;
drop materialized view V_D_STATUS_AGE_IN_BUS_DAYS;
drop materialized view V_D_STATUS_DATE;
drop materialized view V_D_TASK_ID;
drop materialized view V_D_TASK_STATUS;
drop materialized view V_D_TASK_TYPE;
drop materialized view V_D_TEAM_NAME;
drop materialized view V_D_TEAM_PARENT_NAME;
drop materialized view V_D_TEAM_SUPERVISOR_NAME;
drop materialized view V_D_UNIT_OF_WORK;