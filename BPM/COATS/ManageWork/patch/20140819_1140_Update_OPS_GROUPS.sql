/*
Created on 19-Aug-2014 by Raj A. for COEESMAP-2000
Ops Group changes and adhoc script to update SLA days attributes for Active instances only. Only 134 Active instances will be updated.
*/
--------'Alternate Document Processing'
update bpm_d_ops_group_task
  set ops_group = 'Missing Information'
  where task_type = 'Alternate Document Processing';
  
update   CORP_ETL_LIST_LKUP
set out_var = 15
where 1=1
and list_type = 'TASK_TYPE'
and value = 'Alternate Document Processing'
and name = 'ManageWork_SLA_Days'
and ref_type = 'STEP_DEFINITION_ID'
and ref_id = 3035;

update   CORP_ETL_LIST_LKUP
set out_var = 15
where 1=1
and list_type = 'TASK_TYPE'
and value = 'Alternate Document Processing'
and name = 'ManageWork_SLA_Jeopardy_Days'
and ref_type = 'STEP_DEFINITION_ID'
and ref_id = 3035;

update   CORP_ETL_LIST_LKUP
set out_var = 15
where 1=1
and list_type = 'TASK_TYPE'
and value = 'Alternate Document Processing'
and name = 'ManageWork_SLA_Target_Days'
and ref_type = 'STEP_DEFINITION_ID'
and ref_id = 3035;

--------'Process Enrollment Fee'
update bpm_d_ops_group_task
  set ops_group = 'CM-Enrollment Fee'
  where task_type = 'Process Enrollment Fee';

--------'Process Enrollment Fee - Lockbox'
update bpm_d_ops_group_task
  set ops_group = 'CM-Enrollment Fee'
  where task_type = 'Process Enrollment Fee - Lockbox';
  
--------'Process Medicaid Buy-In Premium'
update bpm_d_ops_group_task
  set ops_group = 'CM-Fee'
  where task_type = 'Process Medicaid Buy-In Premium';
  
--------'Process NSF'
update bpm_d_ops_group_task
  set ops_group = 'CM-Enrollment Fee'
  where task_type = 'Process NSF';
  
--------'Process Refund'
update bpm_d_ops_group_task
  set ops_group = 'CM-Enrollment Fee'
  where task_type = 'Process Refund';
  
commit;


update corp_etl_manage_work
  set sla_days = 15,
      sla_jeopardy_days = 15,
      sla_target_days = 15
where 1=1
and task_type = 'Alternate Document Processing'
and complete_date is null;
commit;

update D_MW_CURRENT
    set
      "Age in Business Days" = MANAGE_WORK.GET_AGE_IN_BUSINESS_DAYS("Create Date","Complete Date"),
      "Age in Calendar Days" = MANAGE_WORK.GET_AGE_IN_CALENDAR_DAYS("Create Date","Complete Date"),
      "Jeopardy Flag" = MANAGE_WORK.GET_JEOPARDY_FLAG("SLA Days Type","Age in Business Days","Age in Calendar Days","SLA Jeopardy Days","Jeopardy Flag"),
      "Status Age in Business Days" = MANAGE_WORK.GET_STATUS_AGE_IN_BUS_DAYS("Current Status Date","Complete Date"),
      "Status Age in Calendar Days" = MANAGE_WORK.GET_STATUS_AGE_IN_CAL_DAYS("Current Status Date","Complete Date"),
      "Timeliness Status" = MANAGE_WORK.GET_TIMELINESS_STATUS("Complete Date","SLA Days Type","Age in Business Days","Age in Calendar Days","SLA Days")
    where 1=1
    and "Current Task Type" = 'Alternate Document Processing'
    and "Complete Date" is null
    and "Cancel Work Date" is null;
commit;