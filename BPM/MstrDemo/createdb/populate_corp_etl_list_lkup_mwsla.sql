
 INSERT INTO corp_etl_list_lkup (name, value, list_type, out_var, ref_type,ref_id,start_date, end_date, comments)
 SELECT 'ManageWork_SLA_Days_Type',task_name,'TASK_TYPE','B','TASK_TYPE_ID',task_type_id,trunc(sysdate,'yyyy'),to_date('07/07/7777','mm/dd/yyyy'),'SLA Days Type'
 FROM d_task_types;
 
 INSERT INTO corp_etl_list_lkup (name, value, list_type, out_var, ref_type,ref_id,start_date, end_date, comments)
 SELECT 'ManageWork_SLA_Jeopardy_Days',task_name,'TASK_TYPE',to_char(sla_jeopardy_days),'TASK_TYPE_ID',task_type_id,trunc(sysdate,'yyyy'),to_date('07/07/7777','mm/dd/yyyy'),'SLA Jeopardy Days'
 FROM d_task_types;
 
  INSERT INTO corp_etl_list_lkup (name, value, list_type, out_var, ref_type,ref_id,start_date, end_date, comments)
 SELECT 'ManageWork_SLA_Days',task_name,'TASK_TYPE',to_char(sla_days),'TASK_TYPE_ID',task_type_id,trunc(sysdate,'yyyy'),to_date('07/07/7777','mm/dd/yyyy'),'SLA Days'
 FROM d_task_types;
 
 COMMIT;