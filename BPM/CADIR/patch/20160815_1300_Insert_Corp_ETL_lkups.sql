BEGIN

Update bpm_d_ops_group_task SET ops_group = 'Document Review' where ops_group like '%MRT%';


insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('Preliminary Review','Preliminary Review Specialty Queue');  
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts)
 VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days_Type','TASK_TYPE','Preliminary Review Specialty Queue','B','STEP_DEFINITION_ID',83705416,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) 
 VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days','TASK_TYPE','Preliminary Review Specialty Queue','2','STEP_DEFINITION_ID',83705416,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);	
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) 
 VALUES (seq_cell_id.nextval,'ManageWork_SLA_Jeopardy_Days','TASK_TYPE','Preliminary Review Specialty Queue','1','STEP_DEFINITION_ID',83705416,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);	
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) 
 VALUES (seq_cell_id.nextval,'ManageWork_SLA_Target_Days','TASK_TYPE','Preliminary Review Specialty Queue','3','STEP_DEFINITION_ID',83705416,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);	

insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('Document Review','Document Review Specialty Queue');	
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) 
 VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days_Type','TASK_TYPE','Document Review Specialty Queue','B','STEP_DEFINITION_ID',83705278,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);	
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) 
 VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days','TASK_TYPE','Document Review Specialty Queue','2','STEP_DEFINITION_ID',83705278,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);	
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) 
 VALUES (seq_cell_id.nextval,'ManageWork_SLA_Jeopardy_Days','TASK_TYPE','Document Review Specialty Queue','1','STEP_DEFINITION_ID',83705278,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);	
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) 
 VALUES (seq_cell_id.nextval,'ManageWork_SLA_Target_Days','TASK_TYPE','Document Review Specialty Queue','4','STEP_DEFINITION_ID',83705278,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);

insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('System','FDL Generation Queue');	
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) 
VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days_Type','TASK_TYPE','FDL Generation Queue','B','STEP_DEFINITION_ID',81237599,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);	
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) 
VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days','TASK_TYPE','FDL Generation Queue','2','STEP_DEFINITION_ID',81237599,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);	
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) 
VALUES (seq_cell_id.nextval,'ManageWork_SLA_Jeopardy_Days','TASK_TYPE','FDL Generation Queue','1','STEP_DEFINITION_ID',81237599,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);	
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) 
VALUES (seq_cell_id.nextval,'ManageWork_SLA_Target_Days','TASK_TYPE','FDL Generation Queue','5','STEP_DEFINITION_ID',81237599,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);

COMMIT;

END;
