-- NYHIX-9077

insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('Eligibility A','Large Font Notice Request');
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days_Type','TASK_TYPE','Large Font Notice Request','B','STEP_DEFINITION_ID',2016236,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);	
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days','TASK_TYPE','Large Font Notice Request','2','STEP_DEFINITION_ID',2016236,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);	
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Jeopardy_Days','TASK_TYPE','Large Font Notice Request','1','STEP_DEFINITION_ID',2016236,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);


COMMIT;