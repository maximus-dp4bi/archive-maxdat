-- Fix for missing operations groups

insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('Eligibility B','DOH Good Cause');
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('Eligibility B','DOH Absent Parent');
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('Eligibility B','Newborn Request');

insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days_Type','TASK_TYPE','DOH Good Cause','B','STEP_DEFINITION_ID',20137018,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days_Type','TASK_TYPE','DOH Absent Parent','B','STEP_DEFINITION_ID',20137023,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days_Type','TASK_TYPE','Newborn Request','B','STEP_DEFINITION_ID',20137030,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);

insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days','TASK_TYPE','DOH Good Cause','5','STEP_DEFINITION_ID',20137018,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days','TASK_TYPE','DOH Absent Parent','5','STEP_DEFINITION_ID',20137023,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days','TASK_TYPE','Newborn Request','5','STEP_DEFINITION_ID',20137030,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);

insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Jeopardy_Days','TASK_TYPE','DOH Good Cause','3','STEP_DEFINITION_ID',20137018,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Jeopardy_Days','TASK_TYPE','DOH Absent Parent','3','STEP_DEFINITION_ID',20137023,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Jeopardy_Days','TASK_TYPE','Newborn Request','3','STEP_DEFINITION_ID',20137030,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);

insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Target_Days','TASK_TYPE','DOH Good Cause','','STEP_DEFINITION_ID',20137018,trunc(sysdate-1),to_date('0707777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Target_Days','TASK_TYPE','DOH Absent Parent','','STEP_DEFINITION_ID',20137023,trunc(sysdate-1),to_date('0707777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Target_Days','TASK_TYPE','Newborn Request','','STEP_DEFINITION_ID',20137030,trunc(sysdate-1),to_date('0707777','mmddyyyy'),'Initial Load',sysdate,sysdate);

Update D_TASK_TYPES
set OPERATIONS_GROUP = 'Eligibility B',
    SLA_JEOPARDY_DAYS = '3',
	SLA_DAYS_TYPE = 'B',
	SLA_DAYS = '5'
where TASK_TYPE_ID in 
(20137018,
20137023,
20137030);

