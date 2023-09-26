/*
Created on 11/17/2014 by Raj A.
Description: Created per NYHIX-11699
*/
--'Personal Injury Form Task'
update d_task_types
   set sla_days = null,
       sla_days_type = null
where task_type_id = 2016214;

-- 'Document-Account Review'
update d_task_types
   set operations_group = 'Eligibility C'
where task_type_id = 2016255;

--'Incarceration Proof'
update d_task_types
   set 
       operations_group = 'Research',
	   sla_days = 5,
       sla_days_type = 'B',
       sla_jeopardy_days = 3
where task_type_id = 2016254;

--'Complaint Follow-up Required Task', 'Complaint Sent in Error Task', 'Referral Follow-up Required Task', 'Referral Sent in Error Task'
update d_task_types
   set operations_group = 'Call Center'
where task_type_id in (20137000, 20137001, 20137002, 20137003);

------Update MW v1
update   CORP_ETL_LIST_LKUP
set out_var = null
where 1=1
and list_type = 'TASK_TYPE'
and value = 'Personal Injury Form Task'
and name = 'ManageWork_SLA_Days_Type'
and ref_type = 'STEP_DEFINITION_ID'
and ref_id = 2016214;

update   CORP_ETL_LIST_LKUP
set out_var = null
where 1=1
and list_type = 'TASK_TYPE'
and value = 'Personal Injury Form Task'
and name = 'ManageWork_SLA_Days'
and ref_type = 'STEP_DEFINITION_ID'
and ref_id = 2016214;

update bpm_d_ops_group_task
  set ops_group = 'Eligibility C'
  where task_type = 'Document-Account Review';
  
update   CORP_ETL_LIST_LKUP
set ref_id = 2016254
where 1=1
and list_type = 'TASK_TYPE'
and value = 'Incarceration Proof'
and ref_type = 'STEP_DEFINITION_ID'
and ref_id = 2016274
and name in ('ManageWork_SLA_Days_Type','ManageWork_SLA_Days','ManageWork_SLA_Jeopardy_Days');

insert into BPM_D_OPS_GROUP_TASK  values ('Call Center', 'Complaint Follow-up Required Task');
insert into BPM_D_OPS_GROUP_TASK  values ('Call Center', 'Complaint Sent in Error Task');
insert into BPM_D_OPS_GROUP_TASK  values ('Call Center', 'Referral Follow-up Required Task');
insert into BPM_D_OPS_GROUP_TASK  values ('Call Center', 'Referral Sent in Error Task');
 
commit;