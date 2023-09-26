INSERT INTO file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,derive_timestamp_stmt,file_day_received,current_table_name,current_table_primary_key,full_load_table_primary_key) 
 VALUES('QUAL_M_TRASH','INEO_QUALITY_METRIC_SCORECARDS_TRASH_HISTORY','INEO',
'autonumber,region,supervisor,manager,status,filename,supervisor_name,send_to_trash,employee_id,fssa_id,art_id,employee_name,submitted_employee_name,training_status,record_id,scoring_date,task_sequence_number',
'autonumber,region,supervisor,manager,status,filename,supervisor_name,send_to_trash,employee_id,fssa_id,REGEXP_REPLACE(art_id,''[^0-9]'','''') art_id,employee_name,submitted_employee_name,training_status,record_id,scoring_date,task_sequence_',
'WHERE 1=1',
'Y',
'SELECT TO_CHAR(TO_TIMESTAMP(TRIM(SUBSTR(<filename>,LENGTH(<filename>)-13)),''yyyymmddhh24miss''),''mm/dd/yyyy hh24:mi:ss'') file_date,''Y'' with_timestamp FROM dual',
'PREVIOUS_BUSINESS_DAY', NULL,NULL,'QUAL_METRIC_SC_TRASH_ID');