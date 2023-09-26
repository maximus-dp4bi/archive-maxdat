insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('CM-Expedite','Expedite P2 Request Task');  
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days_Type','TASK_TYPE','Expedite P2 Request Task','B','STEP_DEFINITION_ID',32245,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);  
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days','TASK_TYPE','Expedite P2 Request Task','1','STEP_DEFINITION_ID',32245,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);  
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Jeopardy_Days','TASK_TYPE','Expedite P2 Request Task','1','STEP_DEFINITION_ID',32245,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);  
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Target_Days','TASK_TYPE','Expedite P2 Request Task','1','STEP_DEFINITION_ID',32245,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);

INSERT INTO PP_D_UOW_SOURCE_REF SELECT 70, 11, 1, 'Expedite P2 Request Task', 'TASK ID', TRUNC(SYSDATE), TO_DATE('20770707','YYYYMMDD') FROM DUAL;

commit;

/


 
 


 
 
 
