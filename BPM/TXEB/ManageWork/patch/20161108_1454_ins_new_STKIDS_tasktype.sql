insert into bpm_d_ops_group_task(ops_group,task_type)
values ('Data Entry','STAR Kids Enrollment');

insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days_Type','TASK_TYPE','STAR Kids Enrollment','B','STEP_DEFINITION_ID',32325,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);

insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days','TASK_TYPE','STAR Kids Enrollment',' 3.0','STEP_DEFINITION_ID',32325,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);

insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Jeopardy_Days','TASK_TYPE','STAR Kids Enrollment',' 2.0','STEP_DEFINITION_ID',32325,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);

insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Target_Days','TASK_TYPE','STAR Kids Enrollment',' 2.0','STEP_DEFINITION_ID',32325,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);

UPDATE d_mw_current
set "SLA Days" = 3
   ,"SLA Days Type" = 'B'
   ,"SLA Jeopardy Days" = 2
   ,"SLA Target Days" = 2
WHERE "Current Task Type" = 'STAR Kids Enrollment' ;

UPDATE d_mw_current
SET   "Jeopardy Flag" = MANAGE_WORK.GET_JEOPARDY_FLAG("SLA Days Type","Age in Business Days","Age in Calendar Days","SLA Jeopardy Days","Jeopardy Flag"),
      "Status Age in Business Days" = MANAGE_WORK.GET_STATUS_AGE_IN_BUS_DAYS("Current Status Date","Complete Date"),
      "Status Age in Calendar Days" = MANAGE_WORK.GET_STATUS_AGE_IN_CAL_DAYS("Current Status Date","Complete Date"),
      "Timeliness Status" = MANAGE_WORK.GET_TIMELINESS_STATUS("Complete Date","SLA Days Type","Age in Business Days","Age in Calendar Days","SLA Days")
WHERE "Current Task Type" = 'STAR Kids Enrollment' 
and ("Complete Date" is not null or "Cancel Work Date" is not null);

commit;
