--insert into d_task_types
insert into d_task_types (TASK_TYPE_ID, TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS, SLA_DAYS_TYPE, SLA_TARGET_DAYS, SLA_JEOPARDY_DAYS,UNIT_OF_WORK) values (361580,'Pending Tolling','Pending Tolling','None - Part D-Drug',999,'C',999,999,null);
insert into d_task_types (TASK_TYPE_ID, TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS, SLA_DAYS_TYPE, SLA_TARGET_DAYS, SLA_JEOPARDY_DAYS,UNIT_OF_WORK) values (215390231580,'Awaiting Data Entry','Awaiting Data Entry','None - Part D-Drug',999,'C',999,999,null);

--insert into ops groups
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('None - Part D-Drug','Pending Tolling');
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('None - Part D-Drug','Awaiting Data Entry');

--insert into lst lookup
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days_Type','TASK_TYPE','Pending Tolling','C','STEP_DEFINITION_ID',361580,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days_Type','TASK_TYPE','Awaiting Data Entry','C','STEP_DEFINITION_ID',215390231580,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);

insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days','TASK_TYPE','Pending Tolling','999','STEP_DEFINITION_ID',361580,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days','TASK_TYPE','Awaiting Data Entry','999','STEP_DEFINITION_ID',215390231580,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);

insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Jeopardy_Days','TASK_TYPE','Pending Tolling','999','STEP_DEFINITION_ID',361580,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Jeopardy_Days','TASK_TYPE','Awaiting Data Entry','999','STEP_DEFINITION_ID',215390231580,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);

insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Target_Days','TASK_TYPE','Pending Tolling','999','STEP_DEFINITION_ID',361580,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Target_Days','TASK_TYPE','Awaiting Data Entry','999','STEP_DEFINITION_ID',215390231580,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);

insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'TASK_MONITOR_TYPE','LIST','Pending Tolling','not used','STEP_DEFINITION_ID',361580,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'TASK_MONITOR_TYPE','LIST','Awaiting Data Entry','not used','STEP_DEFINITION_ID',215390231580,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);

