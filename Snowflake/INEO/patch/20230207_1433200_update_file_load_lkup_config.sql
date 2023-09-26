delete from file_load_lkup
where filename_prefix in('HR_ARCHIVED_TERMINATIONS','HR_TERMINATIONS_TRACKER');

INSERT INTO file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,derive_timestamp_stmt,file_day_received,current_table_name,current_table_primary_key,full_load_table_primary_key) 
 VALUES('HR_ARCHIVED_TERMINATIONS_','INEO_HR_ARCHIVED_TERMINATIONS_HISTORY','INEO',
'region,supervisor,manager,filename,regions_supporting,employee_id,first_name,last_name,maximus_email,position_title,previous_stateconduent_employee,employee_type,incumbent_transition,training_status,training_class_id,agency_hire_date,maximus_hire_date,term_date,days_active,months_active,weeks_active,voluntary_involuntary,termination_reason,rehire_status,rehired_archive_term,left_for_state_position,left_to_stateother_vendor_on_ineo_project',
'region,supervisor,manager,filename,regions_supporting,employee_id,first_name,last_name,maximus_email,position_title,previous_stateconduent_employee,employee_type,incumbent_transition,training_status,training_class_id,try_cast(agency_hire_date as date),try_cast(maximus_hire_date as date),try_cast(term_date as date),try_cast(days_active as number),try_cast(months_active as float),try_cast(weeks_active as float),voluntary__involuntary,termination_reason,rehire_status,rehired___archive_term,left_for_state_position,left_to_stateother_vendor_on_ineo_project',
'WHERE 1=1',
'Y',
'SELECT TO_CHAR(TO_TIMESTAMP(TRIM(SUBSTR(<filename>,LENGTH(<filename>)-13)),''yyyymmddhh24miss''),''mm/dd/yyyy hh24:mi:ss'') file_date,''Y'' with_timestamp FROM dual',
'PREVIOUS_BUSINESS_DAY',null,null,'HR_ARCHIVED_TERMINATIONS_ID');

INSERT INTO file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,derive_timestamp_stmt,file_day_received,current_table_name,current_table_primary_key,full_load_table_primary_key) 
 VALUES('HR_TERMINATIONS_TRACKER_','INEO_HR_TERMINATIONS_TRACKER_HISTORY','INEO',
'region,supervisor,manager,filename,regions_supporting,rehired_archive_term,employee_id,first_name,last_name,maximus_email,position_title,previous_stateconduent_employee,employee_type,incumbent_transition,training_status,training_class_id,agency_hire_date,maximus_hire_date,term_date,days_active,months_active,weeks_active,voluntary_involuntary,termination_reason,left_to_stateother_vendor_on_ineo_project,rehire_status',
'region,supervisor,manager,filename,regions_supporting,rehired___archive_term,employee_id,first_name,last_name,maximus_email,position_title,previous_stateconduent_employee,employee_type,incumbent_transition,training_status,training_class_id,try_cast(agency_hire_date as date),try_cast(maximus_hire_date as date),try_cast(term_date as date),try_cast(days_active as number),try_cast(months_active as float),try_cast(weeks_active as float),voluntary__involuntary,termination_reason,left_to_stateother_vendor_on_ineo_project,rehire_status',
'WHERE 1=1',
'Y',
'SELECT TO_CHAR(TO_TIMESTAMP(TRIM(SUBSTR(<filename>,LENGTH(<filename>)-13)),''yyyymmddhh24miss''),''mm/dd/yyyy hh24:mi:ss'') file_date,''Y'' with_timestamp FROM dual',
'PREVIOUS_BUSINESS_DAY',null,null,'HR_TERMINATIONS_TRACKER_ID');
