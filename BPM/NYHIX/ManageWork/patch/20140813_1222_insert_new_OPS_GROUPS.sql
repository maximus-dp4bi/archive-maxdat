/*
Created on 13-Aug-2014 by Raj A. for NYHIX-9962
*/
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('Research','Re-verification Manual Task');
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('Research','Letter Resend Request');
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('Research','Relink Request');
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('DOH','Personal Injury Form Task');

insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) 
VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days_Type','TASK_TYPE','Re-verification Manual Task','B','STEP_DEFINITION_ID',2013450,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);	
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) 
VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days','TASK_TYPE','Re-verification Manual Task','5','STEP_DEFINITION_ID',2013450,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);	
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) 
VALUES (seq_cell_id.nextval,'ManageWork_SLA_Jeopardy_Days','TASK_TYPE','Re-verification Manual Task','3','STEP_DEFINITION_ID',2013450,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);	

insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) 
VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days_Type','TASK_TYPE','Relink Request','B','STEP_DEFINITION_ID',2016156,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);	
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) 
VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days','TASK_TYPE','Relink Request','0','STEP_DEFINITION_ID',2016156,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);	
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) 
VALUES (seq_cell_id.nextval,'ManageWork_SLA_Jeopardy_Days','TASK_TYPE','Relink Request','1','STEP_DEFINITION_ID',2016156,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);

insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) 
VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days_Type','TASK_TYPE','Personal Injury Form Task','C','STEP_DEFINITION_ID',2016214,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);	
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) 
VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days','TASK_TYPE','Personal Injury Form Task','365','STEP_DEFINITION_ID',2016214,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);

-------------'Document Problem Resolution'
update bpm_d_ops_group_task
  set ops_group = 'Research'
  where task_type = 'Document Problem Resolution';
  
update   CORP_ETL_LIST_LKUP
set out_var = 5
where 1=1
and list_type = 'TASK_TYPE'
and value = 'Document Problem Resolution'
and name = 'ManageWork_SLA_Days'
and ref_type = 'STEP_DEFINITION_ID'
and ref_id = 3003;

update   CORP_ETL_LIST_LKUP
set out_var = 3
where 1=1
and list_type = 'TASK_TYPE'
and value = 'Document Problem Resolution'
and name = 'ManageWork_SLA_Jeopardy_Days'
and ref_type = 'STEP_DEFINITION_ID'
and ref_id = 3003;

-------------'Link Document Set'
update   CORP_ETL_LIST_LKUP
set out_var = 0
where 1=1
and list_type = 'TASK_TYPE'
and value = 'Link Document Set'
and name = 'ManageWork_SLA_Days'
and ref_type = 'STEP_DEFINITION_ID'
and ref_id = 3005;


--------------'HSDE-QC VHT'
update   CORP_ETL_LIST_LKUP
set out_var = 0
where 1=1
and list_type = 'TASK_TYPE'
and value = 'HSDE-QC VHT'
and name = 'ManageWork_SLA_Days'
and ref_type = 'STEP_DEFINITION_ID'
and ref_id = 32282;


--------------'DPR - Complaint'
update bpm_d_ops_group_task
  set ops_group = 'Research'
  where task_type = 'DPR - Complaint';
  
update   CORP_ETL_LIST_LKUP
set out_var = 3
where 1=1
and list_type = 'TASK_TYPE'
and value = 'DPR - Complaint'
and name = 'ManageWork_SLA_Days'
and ref_type = 'STEP_DEFINITION_ID'
and ref_id = 2013010;

update   CORP_ETL_LIST_LKUP
set out_var = 2
where 1=1
and list_type = 'TASK_TYPE'
and value = 'DPR - Complaint'
and name = 'ManageWork_SLA_Jeopardy_Days'
and ref_type = 'STEP_DEFINITION_ID'
and ref_id = 2013010;

---------'DPR - Account Correction'
update bpm_d_ops_group_task
  set ops_group = 'Research'
  where task_type = 'DPR - Account Correction';
  
update   CORP_ETL_LIST_LKUP
set out_var = 1
where 1=1
and list_type = 'TASK_TYPE'
and value = 'DPR - Account Correction'
and name = 'ManageWork_SLA_Days'
and ref_type = 'STEP_DEFINITION_ID'
and ref_id = 2013011;

---------'DPR - Wrong Program'
update bpm_d_ops_group_task
  set ops_group = 'Research'
  where task_type = 'DPR - Wrong Program';
  
  
---------'DPR - Orphan Document'
update bpm_d_ops_group_task
  set ops_group = 'Research'
  where task_type = 'DPR - Orphan Document';
  
update   CORP_ETL_LIST_LKUP
set out_var = 'C'
where 1=1
and list_type = 'TASK_TYPE'
and value = 'DPR - Orphan Document'
and name = 'ManageWork_SLA_Days_Type'
and ref_type = 'STEP_DEFINITION_ID'
and ref_id = 2013013;

update   CORP_ETL_LIST_LKUP
set out_var = 15
where 1=1
and list_type = 'TASK_TYPE'
and value = 'DPR - Orphan Document'
and name = 'ManageWork_SLA_Days'
and ref_type = 'STEP_DEFINITION_ID'
and ref_id = 2013013;

update   CORP_ETL_LIST_LKUP
set out_var = 12
where 1=1
and list_type = 'TASK_TYPE'
and value = 'DPR - Orphan Document'
and name = 'ManageWork_SLA_Jeopardy_Days'
and ref_type = 'STEP_DEFINITION_ID'
and ref_id = 2013013;

---------'DPR - Free Form Follow-Up'
update bpm_d_ops_group_task
  set ops_group = 'Research'
  where task_type = 'DPR - Free Form Follow-Up';
  
update   CORP_ETL_LIST_LKUP
set out_var = 1
where 1=1
and list_type = 'TASK_TYPE'
and value = 'DPR - Free Form Follow-Up'
and name = 'ManageWork_SLA_Days'
and ref_type = 'STEP_DEFINITION_ID'
and ref_id = 2013014;


---------'NYHBE Verification Doc Research Task'
update bpm_d_ops_group_task
  set ops_group = 'Research'
  where task_type = 'NYHBE Verification Doc Research Task';
  
---------'DPR - Doc/Form Type Mismatch Task '
update bpm_d_ops_group_task
  set ops_group = 'Research'
  where task_type = 'DPR - Doc/Form Type Mismatch Task ';
  
update   CORP_ETL_LIST_LKUP
set out_var = 1
where 1=1
and list_type = 'TASK_TYPE'
and value = 'DPR - Doc/Form Type Mismatch Task '
and name = 'ManageWork_SLA_Days'
and ref_type = 'STEP_DEFINITION_ID'
and ref_id = 2013028;

update   CORP_ETL_LIST_LKUP
set out_var = 1
where 1=1
and list_type = 'TASK_TYPE'
and value = 'DPR - Doc/Form Type Mismatch Task '
and name = 'ManageWork_SLA_Jeopardy_Days'
and ref_type = 'STEP_DEFINITION_ID'
and ref_id = 2013028;  

---------'DPR - Appeals'
update bpm_d_ops_group_task
  set ops_group = 'Research'
  where task_type = 'DPR - Appeals';


---------'NYHBE Verification Doc DERT-Other'
update bpm_d_ops_group_task
  set ops_group = 'Research'
  where task_type = 'NYHBE Verification Doc DERT-Other';
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) 
VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days_Type','TASK_TYPE','NYHBE Verification Doc DERT-Other','B','STEP_DEFINITION_ID',2013052,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);	
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) 
VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days','TASK_TYPE','NYHBE Verification Doc DERT-Other','5','STEP_DEFINITION_ID',2013052,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);	
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) 
VALUES (seq_cell_id.nextval,'ManageWork_SLA_Jeopardy_Days','TASK_TYPE','NYHBE Verification Doc DERT-Other','3','STEP_DEFINITION_ID',2013052,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);	


---------'DPR - Financial Management'
update bpm_d_ops_group_task
  set ops_group = 'Research'
  where task_type = 'DPR - Financial Management';
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) 
VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days_Type','TASK_TYPE','DPR - Financial Management','C','STEP_DEFINITION_ID',2013400,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);	
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) 
VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days','TASK_TYPE','DPR - Financial Management','15','STEP_DEFINITION_ID',2013400,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);	
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) 
VALUES (seq_cell_id.nextval,'ManageWork_SLA_Jeopardy_Days','TASK_TYPE','DPR - Financial Management','12','STEP_DEFINITION_ID',2013400,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);	


---------'DPR - Returned Mail Application'
update bpm_d_ops_group_task
  set ops_group = 'Research'
  where task_type = 'DPR - Returned Mail Application';
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) 
VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days_Type','TASK_TYPE','DPR - Returned Mail Application','B','STEP_DEFINITION_ID',2013420,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);	
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) 
VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days','TASK_TYPE','DPR - Returned Mail Application','2','STEP_DEFINITION_ID',2013420,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);	
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) 
VALUES (seq_cell_id.nextval,'ManageWork_SLA_Jeopardy_Days','TASK_TYPE','DPR - Returned Mail Application','1','STEP_DEFINITION_ID',2013420,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);	

update   CORP_ETL_LIST_LKUP
set out_var = 2
where 1=1
and list_type = 'TASK_TYPE'
and value = 'DPR - Returned Mail Application'
and name = 'ManageWork_SLA_Days'
and ref_type = 'STEP_DEFINITION_ID'
and ref_id = 2013420;

update   CORP_ETL_LIST_LKUP
set out_var = 1
where 1=1
and list_type = 'TASK_TYPE'
and value = 'DPR - Returned Mail Application'
and name = 'ManageWork_SLA_Jeopardy_Days'
and ref_type = 'STEP_DEFINITION_ID'
and ref_id = 2013420;

---------'DPR - FM Returned Mail'
update bpm_d_ops_group_task
  set ops_group = 'Research'
  where task_type = 'DPR - FM Returned Mail';
  
---------'DPR - Application in Process'
update bpm_d_ops_group_task
  set ops_group = 'Research'
  where task_type = 'DPR - Application in Process';  
  
commit;