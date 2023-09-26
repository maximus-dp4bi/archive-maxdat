--insert new task type
insert into d_task_types (TASK_TYPE_ID, TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS, SLA_DAYS_TYPE, SLA_TARGET_DAYS, SLA_JEOPARDY_DAYS,UNIT_OF_WORK) values (14203062,'Ready for Triage','Ready for Triage','Adjudicator or Precheck',10,'C',10,8,null);
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('Adjudicator or Precheck','Ready for Triage');
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days_Type','TASK_TYPE','Ready for Triage','C','STEP_DEFINITION_ID',14203062,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days','TASK_TYPE','Ready for Triage','10','STEP_DEFINITION_ID',14203062,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Jeopardy_Days','TASK_TYPE','Ready for Triage','8','STEP_DEFINITION_ID',14203062,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Target_Days','TASK_TYPE','Ready for Triage','10','STEP_DEFINITION_ID',14203062,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'TASK_MONITOR_TYPE','LIST','Ready for Triage','not used','STEP_DEFINITION_ID',14203062,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
--update task type 44
update maxdat.d_task_types 
set sla_days = 15, sla_jeopardy_days = 13, sla_target_days = 15
where task_type_id = 44;
--sla days
update maxdat.corp_etl_list_lkup
set out_var = '15'
where name = 'ManageWork_SLA_Days'
and list_type = 'TASK_TYPE'
and ref_id = 44
and value = 'Ready for Appeal Review';
--sla jeopardy days
update maxdat.corp_etl_list_lkup
set out_var = '13'
where name = 'ManageWork_SLA_Jeopardy_Days'
and list_type = 'TASK_TYPE'
and ref_id = 44
and value = 'Ready for Appeal Review';
--sla target days
update maxdat.corp_etl_list_lkup
set out_var = '15'
where name = 'ManageWork_SLA_Target_Days'
and list_type = 'TASK_TYPE'
and ref_id = 44
and value = 'Ready for Appeal Review';