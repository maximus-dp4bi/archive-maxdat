DELETE FROM file_load_lkup
WHERE filename_prefix IN('R_TASKS_CREATED_PRIOR_DAY_','AGENTS_AVAILABILITY');
INSERT INTO file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,derive_timestamp_stmt,file_day_received,current_table_name,current_table_primary_key,full_load_table_primary_key) 
 VALUES('R_TASKS_CREATED_PRIOR_DAY_','INEO_TASKS_CREATED_PRIOR_DAY_HISTORY','INEO',
'filename,task_id,task_name,work_queue_name,task_status,assigned_to,user_type,user_primary_office,task_created_date,task_created_by',
'filename,TRY_CAST(task_id AS NUMBER) task_id,task_name,work_queue_name,task_status,assigned_to,user_type,user_primary_office,CASE WHEN REGEXP_INSTR(task_created_date,''/'') > 0 THEN TO_TIMESTAMP_NTZ(task_created_date,''MM/DD/YYYY HH12:MI:SS AM'') ELSE TO_TIMESTAMP_NTZ(task_created_date,''MON DD"," YYYY HH12:MI:SS AM'') END,task_created_by',
'WHERE 1=1',
'Y',
'SELECT TO_CHAR(TO_TIMESTAMP(TRIM(SUBSTR(<filename>,LENGTH(<filename>)-13)),''yyyymmddhh24miss''),''mm/dd/yyyy hh24:mi:ss'') file_date,''Y'' with_timestamp FROM dual',
'PREVIOUS_BUSINESS_DAY',
'INEO_TASKS_CREATED_PRIOR_DAY','TASK_ID','TASK_CREATED_PRIOR_DAY_ID');

INSERT INTO file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,derive_timestamp_stmt,file_day_received,current_table_name,current_table_primary_key,full_load_table_primary_key) 
 VALUES('AGENTS_AVAILABILITY','INEO_AGENT_AVAILABILITY_HISTORY','INEO',
'date,userid,last_name,first_name,business_phone,org_name,department,loc_name,first_activity,last_activity,tot_activity_time,logged_in,acd_logged_in,non_acd_logged_in,dnd,acw,non_task_work,available_noacd,available,follow_up,available_followme,available_forward,at_break,at_lunch,away_from_desk,do_not_disturb,quality_session,in_a_meeting,at_a_training_session,gone_home,on_vacation,out_of_town,out_of_office,working_at_home,interactions,avgtalk,totaltalk,avgacw,totalacw,avgspeedans,local_disconnected,load_ratio,inbound,avg_in_talk,tot_time_in,outbound,avg_out_talk,tot_time_out,filename',
'TRY_CAST(date AS DATE),userid,last_name,first_name,business_phone,orgname,department,locname,first_activity,last_activity,tot_activity_time,logged_in,acd_logged_in,non_acd_logged_in,dnd,acw,non_task_work,available_noacd,available,follow_up,available_followme,available_forward,at_break,at_lunch,away_from_desk,do_not_disturb,quality_session,in_a_meeting,at_a_training_session,gone_home,on_vacation,out_of_town,out_of_office,working_at_home,TRY_CAST(interactions AS NUMBER),avgtalk,totaltalk,avgacw,totalacw,avgspeedans,TRY_CAST(localdisconnected AS NUMBER),TRY_CAST(loadratio AS NUMBER),TRY_CAST("IN" AS NUMBER),avg_in_talk,tot_time_in,TRY_CAST(out AS NUMBER),avg_out_talk,tot_time_out,filename',
'WHERE 1=1',
'Y',
'SELECT TO_CHAR(TO_TIMESTAMP(TRIM(SUBSTR(<filename>,LENGTH(<filename>)-7)),''mmddyyyy''),''mm/dd/yyyy'') file_date,''N'' with_timestamp FROM dual',
'PREVIOUS_BUSINESS_DAY'
,null,null,'AGENT_AVAILABILITY_ID');