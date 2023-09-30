insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('Clinical Consultant','Internal Expert Reviewer Queue');
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days_Type','TASK_TYPE','Internal Expert Reviewer Queue','B','STEP_DEFINITION_ID',52258364,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);  
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days','TASK_TYPE','Internal Expert Reviewer Queue','5','STEP_DEFINITION_ID',52258364,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);  
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Jeopardy_Days','TASK_TYPE','Internal Expert Reviewer Queue','4','STEP_DEFINITION_ID',52258364,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);  
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Target_Days','TASK_TYPE','Internal Expert Reviewer Queue','5','STEP_DEFINITION_ID',52258364,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);  


UPDATE CORP_ETL_LIST_LKUP  set ref_id = '52258239'  where value = 'Clinical Consultant Queue';
UPDATE CORP_ETL_LIST_LKUP  set ref_id = '52258214'  where value = 'Clinical Consultant Escalation Queue';
UPDATE CORP_ETL_LIST_LKUP  set ref_id = '52258264'  where value = 'DWC Eligibility Reviewer Supervisor Queue';
UPDATE CORP_ETL_LIST_LKUP  set ref_id = '51461997'  where value = 'DWC RFI Queue';
UPDATE CORP_ETL_LIST_LKUP  set ref_id = '52258289'  where value = 'Document Review Escalation Queue';
UPDATE CORP_ETL_LIST_LKUP  set ref_id = '52258314'  where value = 'Expert Reviewer Escalation Queue';
UPDATE CORP_ETL_LIST_LKUP  set ref_id = '52258339'  where value = 'Final Determination Letter Escalation Queue';
UPDATE CORP_ETL_LIST_LKUP  set ref_id = '52258389'  where value = 'Medical Director Queue';
UPDATE CORP_ETL_LIST_LKUP  set ref_id = '52258414'  where value = 'Panel Scheduling Escalation Queue';
UPDATE CORP_ETL_LIST_LKUP  set ref_id = '52258439'  where value = 'Preliminary Reviewer Escalation Queue';
UPDATE CORP_ETL_LIST_LKUP  set ref_id = '52258464'  where value = 'Ready to Close Escalation Queue';
UPDATE CORP_ETL_LIST_LKUP  set ref_id = '52258489'  where value = 'Termination Escalation Queue';

commit;
