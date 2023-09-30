/*
Created on 12/15/2014 by Raj A. for NYHIX-12358.

SQLs to use to check/analyze:
select * from d_task_types
where task_name in (
'Expired Clock Document'
,'Data Entry Research Task'
,'Multiple Applications'
);

select * from bpm_d_ops_group_task
where task_type in (
'NYHBE Verification Doc Research Task'
,'DPR - Multiple Applications'
,'Expired Clock Document'
);
select * from d_task_types where task_type_id in (2013025, 2013026, 20137008);
select * from step_definition_stg where step_definition_id in (2013025, 2013026, 20137008);
*/
-- Name: 'NYHBE Verification Doc Research Task'. Display_Name: 'Data Entry Research Task'; 
update bpm_d_ops_group_task
  set ops_group = 'Eligibility B'
  where task_type = 'NYHBE Verification Doc Research Task';
update d_task_types
   set operations_group = 'Eligibility B'
where task_type_id = 2013025;

--; Display_Name:Multiple Applications . Name: DPR - Multiple Applications.
update bpm_d_ops_group_task
  set ops_group = 'Research'
  where task_type = 'DPR - Multiple Applications';  
update d_task_types
   set operations_group = 'Research'
where task_type_id = 2013026;

--Display_Name: 'Expired Clock Document'. Name: 'Expired Clock Document'
insert into BPM_D_OPS_GROUP_TASK  values ('Eligibility C','Expired Clock Document'); 
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) 
VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days_Type','TASK_TYPE','Expired Clock Document','B','STEP_DEFINITION_ID',20137008,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);	
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) 
VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days','TASK_TYPE','Expired Clock Document','3','STEP_DEFINITION_ID',20137008,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);	
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) 
VALUES (seq_cell_id.nextval,'ManageWork_SLA_Jeopardy_Days','TASK_TYPE','Expired Clock Document','2','STEP_DEFINITION_ID',20137008,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
update d_task_types
   set operations_group = 'Eligibility C',
       sla_days = 3,
       sla_days_type = 'B',
       sla_jeopardy_days = 2
where task_type_id = 20137008;
commit;
commit;