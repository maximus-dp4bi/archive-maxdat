update file_load_lkup
set insert_fields = 'active_unsched_absence_id,absence_date,absence_description,absence_end_time,absence_start_time,absence_type,archive_error,arrival_time,departure_time,employee_id,employee_name,
employee_status,employee_type,filename,manager,maximus_email,point_value,position_title,region,regional_supervisors,submission_comments,
submission_date,submission_timestamp,submitted_employee_name,supervisor,time_zone,training_status,transition_team_lead,wfm_absence_description,regions_supporting,employee_total',
select_fields= 'TRIM(CONCAT(TO_CHAR(TRY_CAST(absence_date AS DATE),''yyyymmdd''),TO_CHAR(TRY_CAST(submission_timestamp AS TIMESTAMP_NTZ),''yyyymmddhh24miss''),REGEXP_REPLACE(UPPER(employee_id),''[^A-Za-z0-9]''))) active_unsched_absence_id,TRY_CAST(absence_date AS DATE),absence_description,absence_end_time,absence_start_time,absence_type,archive_error,arrival_time,departure_time,employee_id,employee_name,
employee_status,employee_type,filename,manager,maximus_email,point_value,position_title,region,regional_supervisors,submission_comments,
TRY_CAST(submission_date AS DATE),TRY_CAST(submission_timestamp AS TIMESTAMP_NTZ),submitted_employee_name,supervisor,time_zone,training_status,transition_team_lead,wfm_absence_description,regions_supporting,0 employeetotal'
,current_table_primary_key = 'ACTIVE_UNSCHED_ABSENCE_ID'
where filename_prefix = 'PRODUCTION_UNSCHEDULED_ABSENCES_ACTIVE';

delete from file_load_lkup
where filename_prefix = 'QUALITY_APP_PROCESSING_SCORECARD_ARCHIVE';
INSERT INTO file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,derive_timestamp_stmt,file_day_received,current_table_name,current_table_primary_key,full_load_table_primary_key)
VALUES('QUALITY_APP_PROCESSING_SCORECARD_ARCHIVE','INEO_ARCHIVE_QUALITY_APP_SCORECARD_HISTORY','INEO',
'ap_1_comments,ap_10_comments,ap_10a,ap_11_comments,ap_11a,ap_11b,ap_11c,ap_12_comments,ap_12a,ap_12b,ap_13_comments,ap_13a,ap_14_comments,ap_14a,ap_15_comments,ap_15a,ap_15b,ap_16_comments,ap_16a,ap_16b,ap_17_comments,ap_17a,
ap_17b,ap_18_comments,ap_18a,ap_18b,ap_19_comments,ap_19a,ap_1a,ap_1b,ap_2_comments,ap_20_comments,ap_20a,ap_20b,ap_20c,ap_20d,ap_20e,ap_20f,ap_2a,ap_2b,ap_2c,ap_2d,ap_2e,ap_2f,ap_3_comments,ap_3a,ap_3b,ap_3c,ap_3d,ap_3e,
ap_3f,ap_3g,ap_4_comments,ap_4a,ap_4b,ap_4c,ap_4d,ap_4e,ap_4f,ap_4g,ap_4h,ap_4i,ap_4j,ap_5_comments,ap_5a,ap_5b,ap_5c,ap_5d,ap_5e,ap_5f,ap_5g,ap_5h,ap_5i,ap_5j,ap_5k,ap_6_comments,ap_6a,ap_6b,ap_7_comments,ap_7a,ap_7b,ap_7c,
ap_7d,ap_7e,ap_7f,ap_7g,ap_7h,ap_7i,ap_8_comments,ap_8a,ap_8b,ap_8c,ap_8d,ap_8e,ap_8f,ap_8g,ap_8h,ap_9_comments,ap_9a,ap_9b,ap_9c,ap_9d,ap_9e,ap_9f,ap_9g,ap_9h,ap_9i,autonumber,employee_id,employee_name,filename,fssa_email,
fssa_id,manager,maximus_email,overall_comments,position_title,qi_supervisor,qisc,record_id,region,regional_supervisors,regions_supporting,score,send_to_trash,status,submitted_employee_name,supervisor,task_sequence_number,time_zone,training_status',
'ap_1_comments,ap_10_comments,ap_10a,ap_11_comments,ap_11a,ap_11b,ap_11c,ap_12_comments,ap_12a,null ap_12b,ap_13_comments,ap_13a,ap_14_comments,ap_14a,ap_15_comments,ap_15a,ap_15b,ap_16_comments,ap_16a,ap_16b,ap_17_comments,ap_17a,
ap_17b,ap_18_comments,ap_18a,ap_18b,ap_19_comments,ap_19a,ap_1a,ap_1b,ap_2_comments,ap_20_comments,ap_20a,ap_20b,ap_20c,ap_20d,ap_20e,ap_20f,ap_2a,ap_2b,ap_2c,ap_2d,ap_2e,ap_2f,ap_3_comments,ap_3a,ap_3b,ap_3c,ap_3d,ap_3e,
ap_3f,null ap_3g,ap_4_comments,ap_4a,ap_4b,ap_4c,ap_4d,ap_4e,ap_4f,ap_4g,ap_4h,ap_4i,ap_4j,ap_5_comments,ap_5a,ap_5b,ap_5c,ap_5d,ap_5e,ap_5f,ap_5g,ap_5h,ap_5i,null ap_5j,null ap_5k,ap_6_comments,ap_6a,ap_6b,ap_7_comments,ap_7a,ap_7b,ap_7c,
ap_7d,ap_7e,ap_7f,ap_7g,ap_7h,ap_7i,ap_8_comments,ap_8a,ap_8b,ap_8c,ap_8d,ap_8e,ap_8f,ap_8g,ap_8h,ap_9_comments,ap_9a,ap_9b,ap_9c,ap_9d,ap_9e,ap_9f,ap_9g,ap_9h,ap_9i,autonumber,employee_id,employee_name,filename,fssa_email,
fssa_id,manager,maximus_email,overall_comments,position_title,qi_supervisor,qisc,record_id,region,regional_supervisors,regions_supporting,TRY_CAST(score AS FLOAT),send_to_trash,status,submitted_employee_name,supervisor,task_sequence_,time_zone,training_status',
      'WHERE 1=1','Y', 'SELECT TO_CHAR(TO_TIMESTAMP(TRIM(SUBSTR(<filename>,LENGTH(<filename>)-13)),''yyyymmddhh24miss''),''mm/dd/yyyy hh24:mi:ss'') file_date,''Y'' with_timestamp FROM dual','PREVIOUS_BUSINESS_DAY',
      'INEO_ARCHIVE_QUALITY_APP_SCORECARD','RECORD_ID','ARCHIVE_QA_APP_SCORECARD_ID'); 