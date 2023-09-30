/*
Created on 04-Sep-2014 by Raj A. for NYHIX-10544
*/
update bpm_d_ops_group_task
  set ops_group = 'DOH'
  where task_type = 'State Complaints';
------  
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('Eligibility C','DERT-Existing Appeal');
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) 
VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days_Type','TASK_TYPE','DERT-Existing Appeal','B','STEP_DEFINITION_ID',2013051,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);	
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) 
VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days','TASK_TYPE','DERT-Existing Appeal','3','STEP_DEFINITION_ID',2013051,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);	
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) 
VALUES (seq_cell_id.nextval,'ManageWork_SLA_Jeopardy_Days','TASK_TYPE','DERT-Existing Appeal','2','STEP_DEFINITION_ID',2013051,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);	
-------
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('Research','DPR - Authorized Representative');
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) 
VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days_Type','TASK_TYPE','DPR - Authorized Representative','B','STEP_DEFINITION_ID',2013053,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);	
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) 
VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days','TASK_TYPE','DPR - Authorized Representative','3','STEP_DEFINITION_ID',2013053,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);	
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) 
VALUES (seq_cell_id.nextval,'ManageWork_SLA_Jeopardy_Days','TASK_TYPE','DPR - Authorized Representative','2','STEP_DEFINITION_ID',2013053,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);	
------
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('Research','DERT-Authorized Representative');
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) 
VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days_Type','TASK_TYPE','DERT-Authorized Representative','B','STEP_DEFINITION_ID',2013054,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);	
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) 
VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days','TASK_TYPE','DERT-Authorized Representative','3','STEP_DEFINITION_ID',2013054,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);	
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) 
VALUES (seq_cell_id.nextval,'ManageWork_SLA_Jeopardy_Days','TASK_TYPE','DERT-Authorized Representative','2','STEP_DEFINITION_ID',2013054,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);	
------
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('Research','Incarceration Proof');
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) 
VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days_Type','TASK_TYPE','Incarceration Proof','B','STEP_DEFINITION_ID',2016274,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);	
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) 
VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days','TASK_TYPE','Incarceration Proof','5','STEP_DEFINITION_ID',2016274,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);	
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) 
VALUES (seq_cell_id.nextval,'ManageWork_SLA_Jeopardy_Days','TASK_TYPE','Incarceration Proof','3','STEP_DEFINITION_ID',2016274,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);	
------
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('Research','DPR - Application-Missing Data');
commit;