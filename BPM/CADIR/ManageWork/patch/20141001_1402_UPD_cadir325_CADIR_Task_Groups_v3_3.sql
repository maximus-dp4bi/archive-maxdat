--select * from corp_etl_list_lkup
--where value = 'Panel Scheduling Queue';

update corp_etl_list_lkup set out_var ='2' where value = 'Panel Scheduling Queue' and name = 'ManageWork_SLA_Days';
update corp_etl_list_lkup set out_var ='1' where value = 'Panel Scheduling Queue' and name = 'ManageWork_SLA_Jeopardy_Days';
update corp_etl_list_lkup set out_var ='2' where value = 'Panel Scheduling Queue' and name = 'ManageWork_SLA_Target_Days';

update corp_etl_list_lkup set out_var ='18' where value = '15 Day Waiting Period Queue' and name = 'ManageWork_SLA_Days';
update corp_etl_list_lkup set out_var ='17' where value = '15 Day Waiting Period Queue' and name = 'ManageWork_SLA_Jeopardy_Days';
update corp_etl_list_lkup set out_var ='18' where value = '15 Day Waiting Period Queue' and name = 'ManageWork_SLA_Target_Days';

--select * from bpm_d_ops_group_task
--where task_type in ('Panel Scheduling Queue','15 Day Waiting Period Queue');


insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('Case Closing','caseClosing');  
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days_Type','TASK_TYPE','caseClosing','B','STEP_DEFINITION_ID',1,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);  
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days','TASK_TYPE','caseClosing','2','STEP_DEFINITION_ID',1,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);  
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Jeopardy_Days','TASK_TYPE','caseClosing','1','STEP_DEFINITION_ID',1,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);  
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Target_Days','TASK_TYPE','caseClosing','2','STEP_DEFINITION_ID',1,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('Case Creation','caseCreation');  
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days_Type','TASK_TYPE','caseCreation','B','STEP_DEFINITION_ID',2,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);  
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days','TASK_TYPE','caseCreation','2','STEP_DEFINITION_ID',2,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);  
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Jeopardy_Days','TASK_TYPE','caseCreation','1','STEP_DEFINITION_ID',2,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);  
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Target_Days','TASK_TYPE','caseCreation','2','STEP_DEFINITION_ID',2,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('Document Sorting','documentIndexing');  
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days_Type','TASK_TYPE','documentIndexing','B','STEP_DEFINITION_ID',3,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);  
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days','TASK_TYPE','documentIndexing','2','STEP_DEFINITION_ID',3,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);  
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Jeopardy_Days','TASK_TYPE','documentIndexing','1','STEP_DEFINITION_ID',3,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);  
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Target_Days','TASK_TYPE','documentIndexing','2','STEP_DEFINITION_ID',3,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('Document Sorting','documentSorting');  
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days_Type','TASK_TYPE','documentSorting','B','STEP_DEFINITION_ID',4,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);  
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days','TASK_TYPE','documentSorting','2','STEP_DEFINITION_ID',4,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);  
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Jeopardy_Days','TASK_TYPE','documentSorting','1','STEP_DEFINITION_ID',4,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);  
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Target_Days','TASK_TYPE','documentSorting','2','STEP_DEFINITION_ID',4,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('Document Sorting','highPriority');  
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days_Type','TASK_TYPE','highPriority','B','STEP_DEFINITION_ID',5,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);  
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days','TASK_TYPE','highPriority','2','STEP_DEFINITION_ID',5,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);  
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Jeopardy_Days','TASK_TYPE','highPriority','1','STEP_DEFINITION_ID',5,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);  
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Target_Days','TASK_TYPE','highPriority','2','STEP_DEFINITION_ID',5,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('Panel Scheduling','mprRouting');  
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days_Type','TASK_TYPE','mprRouting','B','STEP_DEFINITION_ID',6,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);  
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days','TASK_TYPE','mprRouting','2','STEP_DEFINITION_ID',6,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);  
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Jeopardy_Days','TASK_TYPE','mprRouting','1','STEP_DEFINITION_ID',6,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);  
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Target_Days','TASK_TYPE','mprRouting','2','STEP_DEFINITION_ID',6,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('Document Sorting','returnedMail');  
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days_Type','TASK_TYPE','returnedMail','B','STEP_DEFINITION_ID',7,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);  
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days','TASK_TYPE','returnedMail','2','STEP_DEFINITION_ID',7,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);  
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Jeopardy_Days','TASK_TYPE','returnedMail','1','STEP_DEFINITION_ID',7,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);  
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Target_Days','TASK_TYPE','returnedMail','2','STEP_DEFINITION_ID',7,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('Document Sorting','NotKnown');  
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days_Type','TASK_TYPE','NotKnown','B','STEP_DEFINITION_ID',8,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);  
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days','TASK_TYPE','NotKnown','2','STEP_DEFINITION_ID',8,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);	
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Jeopardy_Days','TASK_TYPE','NotKnown','1','STEP_DEFINITION_ID',8,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);	
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Target_Days','TASK_TYPE','NotKnown','2','STEP_DEFINITION_ID',8,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);

commit;
