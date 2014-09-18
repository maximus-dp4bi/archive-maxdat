/*
Created on 18-Sep-2014 by Raj A. for NYHIX-10852
*/
insert into BPM_D_OPS_GROUP_TASK  values ('Research','DERT-Other');

insert into BPM_D_OPS_GROUP_TASK  values ('Research','DPR - Application-Missing Data');  
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) 
VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days_Type','TASK_TYPE','DPR - Application-Missing Data','C','STEP_DEFINITION_ID',2013058,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);	
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) 
VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days','TASK_TYPE','DPR - Application-Missing Data','25','STEP_DEFINITION_ID',2013058,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);	
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) 
VALUES (seq_cell_id.nextval,'ManageWork_SLA_Jeopardy_Days','TASK_TYPE','DPR - Application-Missing Data','21','STEP_DEFINITION_ID',2013058,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);

commit;