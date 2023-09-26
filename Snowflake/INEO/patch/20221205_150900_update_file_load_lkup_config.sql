update file_load_lkup
set insert_fields = 'active_unsched_absence_id,absence_date,absence_description,absence_end_time,absence_start_time,absence_type,archive_error,arrival_time,departure_time,employee_id,employee_name,
employee_status,employee_type,filename,manager,maximus_email,point_value,position_title,region,regional_supervisors,submission_comments,
submission_date,submission_timestamp,submitted_employee_name,supervisor,time_zone,training_status,transition_team_lead,wfm_absence_description,regions_supporting,employee_total',
select_fields= 'TRIM(CONCAT(TO_CHAR(TRY_CAST(absence_date AS DATE),''yyyymmdd''),TO_CHAR(TRY_CAST(submission_timestamp AS TIMESTAMP_NTZ),''yyyymmddhh24miss''),REGEXP_REPLACE(UPPER(employee_id),''[^A-Za-z0-9]''))) active_unsched_absence_id,TRY_CAST(absence_date AS DATE),absence_description,absence_end_time,absence_start_time,absence_type,archive_error,arrival_time,departure_time,employee_id,employee_name,
employee_status,employee_type,filename,manager,maximus_email,point_value,position_title,region,regional_supervisors,submission_comments,
TRY_CAST(submission_date AS DATE),TRY_CAST(submission_timestamp AS TIMESTAMP_NTZ),submitted_employee_name,supervisor,time_zone,training_status,transition_team_lead,wfm_absence_description,regions_supporting,employeetotal'
where filename_prefix = 'PRODUCTION_UNSCHEDULED_ABSENCES_ACTIVE';

update file_load_lkup
set insert_fields ='unscheduled_absence_id,absence_date,absence_description,absence_end_time,absence_start_time,absence_type,archive_error,arrival_time,departure_time,employee_id,employee_name,
employee_status,employee_type,filename,latest_comment,manager,maximus_email,point_value,position_title,region,regional_supervisors,staffing_agency,submission_comments,
submission_date,submission_timestamp,submitted_employee_name,supervisor,time_zone,training_status,wfm_absence_description,regions_supporting',
select_fields ='TRIM(CONCAT(TO_CHAR(TRY_CAST(absence_date AS DATE),''yyyymmdd''),TO_CHAR(TRY_CAST(submission_timestamp AS TIMESTAMP_NTZ),''yyyymmddhh24miss''),REGEXP_REPLACE(UPPER(employee_id),''[^A-Za-z0-9]''))) unscheduled_absence_id,TRY_CAST(absence_date AS DATE),absence_description,absence_end_time,absence_start_time,absence_type,archive_error,arrival_time,departure_time,employee_id,employee_name,
employee_status,employee_type,filename,latest_comment,manager,maximus_email,point_value,position_title,region,regional_supervisors,staffing_agency,submission_comments,
TRY_CAST(submission_date AS DATE),TRY_CAST(submission_timestamp AS TIMESTAMP_NTZ),submitted_employee_name,supervisor,time_zone,training_status,wfm_absence_description,regions_supporting'
where filename_prefix = 'ARCHIVED_UNSCHEDULED_ABSENCES_PRODUCTION';

update file_load_lkup
set insert_fields ='timeoff_request_id,absence_date,absence_description,absence_end_time,absence_start_time,absence_type,archive_error,arrival_time,departure_time,employee_id,employee_name,
employee_status,employee_type,filename,latest_comment,manager,maximus_email,month_number,month_name,operations_approval_date,operations_approval_status,position_title,
region,regional_supervisors,staffing_agency,submission_comments,submission_date,submission_timestamp,submitted_employee_name,supervisor,time_zone,training_status,
transition_team_lead,wfm_absence_description,wfm_approval_date,wfm_approval_status,regions_supporting',
    select_fields = 'TRIM(CONCAT(TO_CHAR(TRY_CAST(absence_date AS DATE),''yyyymmdd''),TO_CHAR(TRY_CAST(submission_timestamp AS TIMESTAMP_NTZ),''yyyymmddhh24miss''),REGEXP_REPLACE(UPPER(employee_id),''[^A-Za-z0-9]''))) timeoff_request_id,TRY_CAST(absence_date AS DATE),absence_description,absence_end_time,absence_start_time,absence_type,archive_error,arrival_time,departure_time,employee_id,employee_name,
employee_status,employee_type,filename,latest_comment,manager,maximus_email,TRY_CAST(month_ AS NUMBER),month_name,TRY_CAST(operations_approval_date AS DATE),operations_approval_status,position_title,
region,regional_supervisors,staffing_agency,submission_comments,TRY_CAST(submission_date AS DATE),TRY_CAST(submission_timestamp AS TIMESTAMP_NTZ),submitted_employee_name,supervisor,time_zone,training_status,
transition_team_lead,wfm_absence_description,TRY_CAST(wfm_approval_date AS DATE),wfm_approval_status,regions_supporting'
where filename_prefix = 'ARCHIVED_TIME_OFF_REQUESTS';

update file_load_lkup
set insert_fields = 'active_timeoff_request_id,absence_date,absence_description,absence_end_time,absence_start_time,absence_type,archive_error,arrival_time,departure_time,employee_id,employee_name,
employee_status,employee_type,filename,latest_comment,manager,maximus_email,month_number,month_name,operations_approval_date,operations_approval_status,position_title,
region,regional_supervisors,submission_comments,submission_date,submission_timestamp,submitted_employee_name,supervisor,time_zone,training_status,
transition_team_lead,wfm_absence_description,wfm_approval_date,wfm_approval_status,regions_supporting',
     select_fields = 'TRIM(CONCAT(TO_CHAR(TRY_CAST(absence_date AS DATE),''yyyymmdd''),TO_CHAR(TRY_CAST(submission_timestamp AS TIMESTAMP_NTZ),''yyyymmddhh24miss''),REGEXP_REPLACE(UPPER(employee_id),''[^A-Za-z0-9]''))) timeoff_request_id,TRY_CAST(absence_date AS DATE),absence_description,absence_end_time,absence_start_time,absence_type,archive_error,arrival_time,departure_time,employee_id,employee_name,
employee_status,employee_type,filename,latest_comment,manager,maximus_email,TRY_CAST(month_ AS NUMBER),month_name,TRY_CAST(operations_approval_date AS DATE),operations_approval_status,position_title,
region,regional_supervisors,submission_comments,TRY_CAST(submission_date AS DATE),TRY_CAST(submission_timestamp AS TIMESTAMP_NTZ),submitted_employee_name,supervisor,time_zone,training_status,
transition_team_lead,wfm_absence_description,TRY_CAST(wfm_approval_date AS DATE),wfm_approval_status,regions_supporting'
where filename_prefix = 'TIME_OFF_REQUESTS_ACTIVE';

update file_load_lkup
set insert_fields = 'wfm_attendance_id,attendance_status,attendance_substatus,checked_in,date,employee_id,employee_name,employee_status,employee_type,filename,manager,modified,points_accrued_to_date,points_earned,position_title,region,supervisor,time,time_zone,timestamp,training_status,regions_supporting',
      select_fields = 'TRIM(CONCAT(TO_CHAR(TRY_CAST(modified AS TIMESTAMP_NTZ),''yyyymmddhh24miss''),REGEXP_REPLACE(UPPER(employee_id),''[^A-Za-z0-9]'')))  wfm_attendance_id,attendance_status,attendance_substatus,
 checked_in,TRY_CAST(date AS DATE),employee_id,employee_name,employee_status,employee_type,filename,manager,TRY_CAST(modified AS TIMESTAMP_NTZ),TRY_CAST(points_accrued_to_date AS NUMBER),TRY_CAST(points_earned AS NUMBER),position_title,region,supervisor,time,time_zone,TRY_CAST(timestamp AS TIMESTAMP_NTZ),training_status,regions_supporting'
where filename_prefix = 'WFM_DAILY_STAFF_ATTENDANCE_ROSTER';

alter table INEO_ARCHIVED_TIME_OFF_REQUESTS ADD (regions_supporting VARCHAR);
alter table INEO_ARCHIVED_TIME_OFF_REQUESTS_HISTORY ADD (regions_supporting VARCHAR);
alter table INEO_ARCHIVED_UNSCHED_ABSENCES_PRODUCTION ADD (regions_supporting VARCHAR);
alter table INEO_ARCHIVED_UNSCHED_ABSENCES_PRODUCTION_HISTORY ADD (regions_supporting VARCHAR);
alter table INEO_ACTIVE_UNSCHED_ABSENCES_PRODUCTION_HISTORY ADD (regions_supporting VARCHAR,employee_total FLOAT);
alter table INEO_ACTIVE_UNSCHED_ABSENCES_PRODUCTION ADD (regions_supporting VARCHAR,employee_total FLOAT);
alter table INEO_WFM_DAILY_STAFF_ATTENDANCE_ROSTER ADD (regions_supporting VARCHAR);
alter table INEO_WFM_DAILY_STAFF_ATTENDANCE_ROSTER_HISTORY ADD (regions_supporting VARCHAR);
alter table INEO_ACTIVE_TIME_OFF_REQUESTS ADD (regions_supporting VARCHAR);
alter table INEO_ACTIVE_TIME_OFF_REQUESTS_HISTORY ADD (regions_supporting VARCHAR);


INSERT INTO file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,derive_timestamp_stmt,file_day_received,current_table_name,current_table_primary_key,full_load_table_primary_key)
VALUES('PIONEER_TEAM_COMS_LOG_ACTIVE','INEO_ACTIVE_PIONEER_TEAM_COMS_LOG_HISTORY','INEO',
       'added_by,communication_content_and_summary,date,employee_id,evaluation_score,filename,first_last_name,initial_or_follow_up,reports_to,topic',
       'added_by,communication_content_and_summary,TRY_CAST(date AS DATE),employee_id,TRY_CAST(evaluation_score AS FLOAT),filename,first__last_name,initial_or_follow_up,reports_to,topic',
      'WHERE 1=1','Y', 'SELECT TO_CHAR(TO_TIMESTAMP(TRIM(SUBSTR(<filename>,LENGTH(<filename>)-13)),''yyyymmddhh24miss''),''mm/dd/yyyy hh24:mi:ss'') file_date,''Y'' with_timestamp FROM dual','PREVIOUS_BUSINESS_DAY',
      null,null,'ACTIVE_PNR_COMS_LOG_ID');   

INSERT INTO file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,derive_timestamp_stmt,file_day_received,current_table_name,current_table_primary_key,full_load_table_primary_key)
VALUES('PIONEER_TEAM_COMS_LOG_ARCHIVE','INEO_ARCHIVE_PIONEER_TEAM_COMS_LOG_HISTORY','INEO',
       'added_by,communication_content_and_summary,date,employee_id,evaluation_score,filename,first_last_name,initial_or_follow_up,reports_to,topic',
       'added_by,communication_content_and_summary,TRY_CAST(date AS DATE),employee_id,TRY_CAST(evaluation_score AS FLOAT),filename,first__last_name,initial_or_follow_up,reports_to,topic',
      'WHERE 1=1','Y', 'SELECT TO_CHAR(TO_TIMESTAMP(TRIM(SUBSTR(<filename>,LENGTH(<filename>)-13)),''yyyymmddhh24miss''),''mm/dd/yyyy hh24:mi:ss'') file_date,''Y'' with_timestamp FROM dual','PREVIOUS_BUSINESS_DAY',
      null,null,'ARCHIVE_PNR_COMS_LOG_ID');  
      
INSERT INTO file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,derive_timestamp_stmt,file_day_received,current_table_name,current_table_primary_key,full_load_table_primary_key)
VALUES('PIONEER_TEAM_STAFF_ROSTER','INEO_PIONEER_TEAM_STAFF_ROSTER_HISTORY','INEO',
       'agency_hire_date,department,employee_id,employee_name,employee_status,filename,fssa_email,fssa_id,hr_specialist,manager,maximus_email,position_title,qi_supervisor,qisc,region,regions_supporting,sr_operations_manager,supervisor,term_date,training_status,work_order_end_date',
       'TRY_CAST(agency_hire_date AS DATE),department,employee_id,employee_name,employee_status,filename,fssa_email,fssa_id,hr_specialist,manager,maximus_email,position_title,qi_supervisor,qisc,region,regions_supporting,
sr_operations_manager,supervisor,TRY_CAST(term_date AS DATE),training_status,TRY_CAST(work_order_end_date AS DATE)',
      'WHERE 1=1','Y', 'SELECT TO_CHAR(TO_TIMESTAMP(TRIM(SUBSTR(<filename>,LENGTH(<filename>)-13)),''yyyymmddhh24miss''),''mm/dd/yyyy hh24:mi:ss'') file_date,''Y'' with_timestamp FROM dual','PREVIOUS_BUSINESS_DAY',
      'INEO_PIONEER_TEAM_STAFF_ROSTER','EMPLOYEE_ID','PIONEER_STAFF_ROSTER_ID');  
      
INSERT INTO file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,derive_timestamp_stmt,file_day_received,current_table_name,current_table_primary_key,full_load_table_primary_key)
VALUES('QUALITY_APP_PROCESS_SCORECARD_ACTIVE','INEO_ACTIVE_QUALITY_APP_SCORECARD_HISTORY','INEO',
       'ap_1_comments,ap_10_comments,ap_10a,ap_11_comments,ap_11a,ap_11b,ap_11c,ap_12_comments,ap_12a,ap_13_comments,ap_13a,ap_14_comments,ap_14a,ap_15_comments,ap_15a,ap_15b,ap_16_comments,ap_16a,ap_16b,ap_17_comments,
ap_17a,ap_17b,ap_18_comments,ap_18a,ap_18b,ap_19_comments,ap_19a,ap_1a,ap_1b,ap_2_comments,ap_20_comments,ap_20a,ap_20b,ap_20c,ap_20d,ap_20e,ap_20f,ap_2a,ap_2b,ap_2c,ap_2d,ap_2e,ap_2f,ap_3_comments,ap_3a,ap_3b,
ap_3c,ap_3d,ap_3e,ap_3f,ap_4_comments,ap_4a,ap_4b,ap_4c,ap_4d,ap_4e,ap_4f,ap_4g,ap_4h,ap_4i,ap_4j,ap_5_comments,ap_5a,ap_5b,ap_5c,ap_5d,ap_5e,ap_5f,ap_5g,ap_5h,ap_5i,ap_6_comments,ap_6a,ap_6b,ap_7_comments,ap_7a,
ap_7b,ap_7c,ap_7d,ap_7e,ap_7f,ap_7g,ap_7h,ap_7i,ap_8_comments,ap_8a,ap_8b,ap_8c,ap_8d,ap_8e,ap_8f,ap_8g,ap_8h,ap_9_comments,ap_9a,ap_9b,ap_9c,ap_9d,ap_9e,ap_9f,ap_9g,ap_9h,ap_9i,autonumber,employee_id,employee_name,
filename,fssa_email,fssa_id,manager,maximus_email,overall_comments,position_title,qi_supervisor,qisc,record_id,region,regional_supervisors,regions_supporting,score,send_to_trash,status,submitted_employee_name,
supervisor,task_sequence_number,time_zone,training_status',
'ap_1_comments,ap_10_comments,ap_10a,ap_11_comments,ap_11a,ap_11b,ap_11c,ap_12_comments,ap_12a,ap_13_comments,ap_13a,ap_14_comments,ap_14a,ap_15_comments,ap_15a,ap_15b,ap_16_comments,ap_16a,ap_16b,ap_17_comments,
ap_17a,ap_17b,ap_18_comments,ap_18a,ap_18b,ap_19_comments,ap_19a,ap_1a,ap_1b,ap_2_comments,ap_20_comments,ap_20a,ap_20b,ap_20c,ap_20d,ap_20e,ap_20f,ap_2a,ap_2b,ap_2c,ap_2d,ap_2e,ap_2f,ap_3_comments,ap_3a,ap_3b,
ap_3c,ap_3d,ap_3e,ap_3f,ap_4_comments,ap_4a,ap_4b,ap_4c,ap_4d,ap_4e,ap_4f,ap_4g,ap_4h,ap_4i,ap_4j,ap_5_comments,ap_5a,ap_5b,ap_5c,ap_5d,ap_5e,ap_5f,ap_5g,ap_5h,ap_5i,ap_6_comments,ap_6a,ap_6b,ap_7_comments,ap_7a,
ap_7b,ap_7c,ap_7d,ap_7e,ap_7f,ap_7g,ap_7h,ap_7i,ap_8_comments,ap_8a,ap_8b,ap_8c,ap_8d,ap_8e,ap_8f,ap_8g,ap_8h,ap_9_comments,ap_9a,ap_9b,ap_9c,ap_9d,ap_9e,ap_9f,ap_9g,ap_9h,ap_9i,autonumber,employee_id,employee_name,
filename,fssa_email,fssa_id,manager,maximus_email,overall_comments,position_title,qi_supervisor,qisc,record_id,region,regional_supervisors,regions_supporting,TRY_CAST(score AS FLOAT),send_to_trash,status,submitted_employee_name,
supervisor,task_sequence_,time_zone,training_status',
      'WHERE 1=1','Y', 'SELECT TO_CHAR(TO_TIMESTAMP(TRIM(SUBSTR(<filename>,LENGTH(<filename>)-13)),''yyyymmddhh24miss''),''mm/dd/yyyy hh24:mi:ss'') file_date,''Y'' with_timestamp FROM dual','PREVIOUS_BUSINESS_DAY',
      'INEO_ACTIVE_QUALITY_APP_SCORECARD','RECORD_ID','ACTIVE_QA_APP_SCORECARD_ID');   

INSERT INTO file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,derive_timestamp_stmt,file_day_received,current_table_name,current_table_primary_key,full_load_table_primary_key)
VALUES('QUALITY_CHANGE_PROCESSING_SCORECARD_ACTIVE','INEO_ACTIVE_QUALITY_CHANGE_SCORECARD_HISTORY','INEO',
'autonumber,cp_10a,cp_10b,cp_10c,cp_10comments,cp_10d,cp_10e,cp_10f,cp_10g,cp_10h,cp_10i,cp_11a,cp_11b,cp_11c,cp_11comments,cp_11d,cp_11e,cp_11f,cp_11g,cp_11h,cp_12a,cp_12b,cp_12c,cp_12comments,cp_12d,cp_12e,cp_12f,
cp_12g,cp_12h,cp_12i,cp_13a,cp_13comments,cp_14a,cp_14comments,cp_15a,cp_15b,cp_15c,cp_15comments,cp_16a,cp_16b,cp_16comments,cp_17a,cp_17b,cp_17c,cp_17comments,cp_17d,cp_17e,cp_17f,cp_18a,cp_18comments,cp_19a,
cp_19comments,cp_1a,cp_1b,cp_1c,cp_1comments,cp_1d,cp_1e,cp_1f,cp_1g,cp_1h,cp_1i,cp_1j,cp_20a,cp_20b,cp_20comments,cp_21a,cp_21b,cp_21comments,cp_22a,cp_22comments,cp_23a,cp_23comments,cp_24a,cp_24comments,cp_25a,
cp_25comments,cp_26a,cp_26b,cp_26comments,cp_27a,cp_27b,cp_27c,cp_27comments,cp_28a,cp_28comments,cp_29a,cp_29b,cp_29c,cp_29comments,cp_29d,cp_29e,cp_29f,cp_2a,cp_2b,cp_2comments,cp_3a,cp_3b,cp_3c,cp_3comments,
cp_3d,cp_3e,cp_3f,cp_4a,cp_4b,cp_4c,cp_4comments,cp_4d,cp_4e,cp_4f,cp_5a,cp_5b,cp_5c,cp_5comments,cp_5d,cp_5e,cp_5f,cp_5g,cp_5h,cp_5i,cp_5j,cp_5k,cp_5l,cp_6a,cp_6b,cp_6c,cp_6comments,cp_6d,cp_7a,cp_7b,cp_7c,cp_7comments,
cp_7d,cp_7e,cp_7f,cp_7g,cp_7h,cp_7i,cp_8a,cp_8b,cp_8c,cp_8comments,cp_9a,cp_9b,cp_9c,cp_9comments,cp_9d,cp_9e,cp_9f,cp_9g,cp_9h,cp_9i,cp_9j,cp_9k,employee_id,employee_name,filename,fssa_email,fssa_id,manager,maximus_email,
overall_comments,position_title,qi_supervisor,qisc,record_id,region,regional_supervisors,regions_supporting,score,send_to_trash,status,submitted_employee_name,supervisor,task_sequence_number,time_zone,training_status',
'autonumber,cp_10a,cp_10b,cp_10c,cp_10comments,cp_10d,cp_10e,cp_10f,cp_10g,cp_10h,cp_10i,cp_11a,cp_11b,cp_11c,cp_11comments,cp_11d,cp_11e,cp_11f,cp_11g,cp_11h,cp_12a,cp_12b,cp_12c,cp_12comments,cp_12d,cp_12e,cp_12f,
cp_12g,cp_12h,cp_12i,cp_13a,cp_13comments,cp_14a,cp_14comments,cp_15a,cp_15b,cp_15c,cp_15comments,cp_16a,cp_16b,cp_16comments,cp_17a,cp_17b,cp_17c,cp_17comments,cp_17d,cp_17e,cp_17f,cp_18a,cp_18comments,cp_19a,
cp_19comments,cp_1a,cp_1b,cp_1c,cp_1comments,cp_1d,cp_1e,cp_1f,cp_1g,cp_1h,cp_1i,cp_1j,cp_20a,cp_20b,cp_20comments,cp_21a,cp_21b,cp_21comments,cp_22a,cp_22comments,cp_23a,cp_23comments,cp_24a,cp_24comments,cp_25a,
cp_25comments,cp_26a,cp_26b,cp_26comments,cp_27a,cp_27b,cp_27c,cp_27comments,cp_28a,cp_28comments,cp_29a,cp_29b,cp_29c,cp_29comments,cp_29d,cp_29e,cp_29f,cp_2a,cp_2b,cp_2comments,cp_3a,cp_3b,cp_3c,cp_3comments,
cp_3d,cp_3e,cp_3f,cp_4a,cp_4b,cp_4c,cp_4comments,cp_4d,cp_4e,cp_4f,cp_5a,cp_5b,cp_5c,cp_5comments,cp_5d,cp_5e,cp_5f,cp_5g,cp_5h,cp_5i,cp_5j,cp_5k,cp_5l,cp_6a,cp_6b,cp_6c,cp_6comments,cp_6d,cp_7a,cp_7b,cp_7c,cp_7comments,
cp_7d,cp_7e,cp_7f,cp_7g,cp_7h,cp_7i,cp_8a,cp_8b,cp_8c,cp_8comments,cp_9a,cp_9b,cp_9c,cp_9comments,cp_9d,cp_9e,cp_9f,cp_9g,cp_9h,cp_9i,cp_9j,cp_9k,employee_id,employee_name,filename,fssa_email,fssa_id,manager,maximus_email,
overall_comments,position_title,qi_supervisor,qisc,record_id,region,regional_supervisors,regions_supporting,TRY_CAST(score AS FLOAT),send_to_trash,status,submitted_employee_name,supervisor,task_sequence_,time_zone,training_status',      'WHERE 1=1','Y', 'SELECT TO_CHAR(TO_TIMESTAMP(TRIM(SUBSTR(<filename>,LENGTH(<filename>)-13)),''yyyymmddhh24miss''),''mm/dd/yyyy hh24:mi:ss'') file_date,''Y'' with_timestamp FROM dual','PREVIOUS_BUSINESS_DAY',
      'INEO_ACTIVE_QUALITY_CHANGE_SCORECARD','RECORD_ID','ACTIVE_QA_CHANGE_SCORECARD_ID');       
      
INSERT INTO file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,derive_timestamp_stmt,file_day_received,current_table_name,current_table_primary_key,full_load_table_primary_key)
VALUES('QUALITY_REDETS_SCORECARD_ACTIVE','INEO_ACTIVE_QUALITY_REDETS_SCORECARD_HISTORY','INEO',
'autonumber,created,created_by,employee_id,employee_name,filename,fssa_email,fssa_id,latest_comment,manager,maximus_email,move_to_trash,overall_comments,position_title,qi_supervisor,qisc,rd_1_comments,rd_10_comments,
rd_10a,rd_10b,rd_10c,rd_10d,rd_10e,rd_10f,rd_10g,rd_10h,rd_10i,rd_11_comments,rd_11a,rd_12_comments,rd_12a,rd_13_comments,rd_13a,rd_13b,rd_14_comments,rd_14a,rd_14b,rd_14c,rd_15_comments,rd_15a,rd_16_comments,rd_16a,
rd_17_comments,rd_17a,rd_17b,rd_18_comments,rd_18a,rd_18b,rd_19_comments,rd_19a,rd_1a,rd_1b,rd_2_comments,rd_20_comments,rd_20a,rd_21_comments,rd_21a,rd_21b,rd_22_comments,rd_22a,rd_22b,rd_23_comments,rd_23a,rd_24_comments,
rd_24a,rd_24b,rd_24c,rd_24d,rd_24e,rd_24f,rd_2a,rd_2b,rd_3_comments,rd_3a,rd_3b,rd_3c,rd_3d,rd_3e,rd_3f,rd_4_comments,rd_4a,rd_4b,rd_4c,rd_4d,rd_4e,rd_4f,rd_4g,rd_4h,rd_4i,rd_4j,rd_4k,rd_4l,rd_5_comments,rd_5a,rd_5b,
rd_5c,rd_5d,rd_5e,rd_5f,rd_5g,rd_5h,rd_5i,rd_6_comments,rd_6a,rd_6b,rd_7_comments,rd_7a,rd_7b,rd_7c,rd_7d,rd_7e,rd_7f,rd_7g,rd_7h,rd_7i,rd_7j,rd_7k,rd_8_comments,rd_8a,rd_8b,rd_8c,rd_8d,rd_8e,rd_8f,rd_8g,rd_8h,rd_8i,
rd_9_comments,rd_9a,rd_9b,rd_9c,rd_9d,rd_9e,rd_9f,rd_9g,rd_9h,record_id,region,regional_supervisors,regions_supporting,score,status,submitted_employee_name,supervisor,task_sequence_number,time_zone,training_status',
'autonumber,TRY_CAST(created AS TIMESTAMP),created_by,employee_id,employee_name,filename,fssa_email,fssa_id,latest_comment,manager,maximus_email,move_to_trash,overall_comments,position_title,qi_supervisor,qisc,rd_1_comments,rd_10_comments,
rd_10a,rd_10b,rd_10c,rd_10d,rd_10e,rd_10f,rd_10g,rd_10h,rd_10i,rd_11_comments,rd_11a,rd_12_comments,rd_12a,rd_13_comments,rd_13a,rd_13b,rd_14_comments,rd_14a,rd_14b,rd_14c,rd_15_comments,rd_15a,rd_16_comments,rd_16a,
rd_17_comments,rd_17a,rd_17b,rd_18_comments,rd_18a,rd_18b,rd_19_comments,rd_19a,rd_1a,rd_1b,rd_2_comments,rd_20_comments,rd_20a,rd_21_comments,rd_21a,rd_21b,rd_22_comments,rd_22a,rd_22b,rd_23_comments,rd_23a,rd_24_comments,
rd_24a,rd_24b,rd_24c,rd_24d,rd_24e,rd_24f,rd_2a,rd_2b,rd_3_comments,rd_3a,rd_3b,rd_3c,rd_3d,rd_3e,rd_3f,rd_4_comments,rd_4a,rd_4b,rd_4c,rd_4d,rd_4e,rd_4f,rd_4g,rd_4h,rd_4i,rd_4j,rd_4k,rd_4l,rd_5_comments,rd_5a,rd_5b,
rd_5c,rd_5d,rd_5e,rd_5f,rd_5g,rd_5h,rd_5i,rd_6_comments,rd_6a,rd_6b,rd_7_comments,rd_7a,rd_7b,rd_7c,rd_7d,rd_7e,rd_7f,rd_7g,rd_7h,rd_7i,rd_7j,rd_7k,rd_8_comments,rd_8a,rd_8b,rd_8c,rd_8d,rd_8e,rd_8f,rd_8g,rd_8h,rd_8i,
rd_9_comments,rd_9a,rd_9b,rd_9c,rd_9d,rd_9e,rd_9f,rd_9g,rd_9h,record_id,region,regional_supervisors,regions_supporting,TRY_CAST(score AS FLOAT),status,submitted_employee_name,supervisor,task_sequence_,time_zone,training_status',      'WHERE 1=1','Y', 'SELECT TO_CHAR(TO_TIMESTAMP(TRIM(SUBSTR(<filename>,LENGTH(<filename>)-13)),''yyyymmddhh24miss''),''mm/dd/yyyy hh24:mi:ss'') file_date,''Y'' with_timestamp FROM dual','PREVIOUS_BUSINESS_DAY',
      'INEO_ACTIVE_QUALITY_REDETS_SCORECARD','RECORD_ID','ACTIVE_QA_REDETS_SCORECARD_ID'); 

INSERT INTO file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,derive_timestamp_stmt,file_day_received,current_table_name,current_table_primary_key,full_load_table_primary_key)
VALUES('QUALITY_STAFF_ROSTER','INEO_QUALITY_STAFF_ROSTER_HISTORY','INEO',
'department,employee_id,employee_name,employee_status,employee_type,filename,fssa_email,fssa_id,genesys_i3_id,hr_specialist,incumbent_transition,manager,maximus_email,nesting_end_date,nesting_start_date,position_title,
previous_stateconduent_employee,qi_supervisor,qisc,region,regional_supervisors,regions_supporting,supervisor,term_date,time_zone,training_class_id,training_end_date,training_start_date,training_status,transition_team_lead,work_group',
'department,employee_id,employee_name,employee_status,employee_type,filename,fssa_email,fssa_id,genesys_i3_id,hr_specialist,incumbent_transition,manager,maximus_email,TRY_CAST(nesting_end_date AS DATE),TRY_CAST(nesting_start_date AS DATE),
position_title,previous_stateconduent_employee,qi_supervisor,qisc,region,regional_supervisors,regions_supporting,supervisor,TRY_CAST(term_date AS DATE),time_zone,training_class_id,TRY_CAST(training_end_date AS DATE),
TRY_CAST(training_start_date AS DATE),training_status,transition_team_lead,work_group', 
 'WHERE 1=1','Y', 'SELECT TO_CHAR(TO_TIMESTAMP(TRIM(SUBSTR(<filename>,LENGTH(<filename>)-13)),''yyyymmddhh24miss''),''mm/dd/yyyy hh24:mi:ss'') file_date,''Y'' with_timestamp FROM dual','PREVIOUS_BUSINESS_DAY',
 'INEO_QUALITY_STAFF_ROSTER','EMPLOYEE_ID','QUALITY_STAFF_ROSTER_ID');   
      
INSERT INTO file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,derive_timestamp_stmt,file_day_received,current_table_name,current_table_primary_key,full_load_table_primary_key)
VALUES('QUAL_TASK_NOTIFICATIONS','INEO_ACTIVE_QUALITY_TASK_NOTIFICATIONS_HISTORY','INEO',
'autonumber,comments,employee_id,employee_name,filename,fssa_id,genesys_i3_id,qi_supervisor,qisc,record_id,region,regional_team_leads,status,submission_date,submitted_employee_name,supervisor,task_sequence_number,time_zone',
'autonumber,comments,employee_id,employee_name,filename,fssa_id,genesys_i3_id,qi_supervisor,qisc,record_id,region,regional_team_leads,status,TRY_CAST(submission_date AS DATE),submitted_employee_name,supervisor,task_sequence_,time_zone',
'WHERE 1=1','Y', 'SELECT TO_CHAR(TO_TIMESTAMP(TRIM(SUBSTR(<filename>,LENGTH(<filename>)-13)),''yyyymmddhh24miss''),''mm/dd/yyyy hh24:mi:ss'') file_date,''Y'' with_timestamp FROM dual','PREVIOUS_BUSINESS_DAY',
'INEO_ACTIVE_QUALITY_TASK_NOTIFICATIONS','RECORD_ID','ACTIVE_QA_TASK_NOTIF_ID');   

INSERT INTO file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,derive_timestamp_stmt,file_day_received,current_table_name,current_table_primary_key,full_load_table_primary_key)
VALUES('QUALITY_TASK_NOTIFICATIONS_ARCHIVE','INEO_ARCHIVE_QUALITY_TASK_NOTIFICATIONS_HISTORY','INEO',
'autonumber,comments,employee_id,employee_name,filename,fssa_email,fssa_id,genesys_i3_id,maximus_email,move_to_trash,position_title,qi_supervisor,qisc,record_id,region,regional_team_leads,regions_supporting,
scorecard,status,submission_date,submitted_employee_name,supervisor,task_sequence_number,time_zone,training_status',
'autonumber,comments,employee_id,employee_name,filename,fssa_email,fssa_id,genesys_i3_id,maximus_email,move_to_trash,position_title,qi_supervisor,qisc,record_id,region,regional_team_leads,regions_supporting,
scorecard,status,TRY_CAST(submission_date AS DATE),submitted_employee_name,supervisor,task_sequence_,time_zone,training_status',
'WHERE 1=1','Y', 'SELECT TO_CHAR(TO_TIMESTAMP(TRIM(SUBSTR(<filename>,LENGTH(<filename>)-13)),''yyyymmddhh24miss''),''mm/dd/yyyy hh24:mi:ss'') file_date,''Y'' with_timestamp FROM dual','PREVIOUS_BUSINESS_DAY',
'INEO_ARCHIVE_QUALITY_TASK_NOTIFICATIONS','RECORD_ID','ARCHIVE_QA_TASK_NOTIF_ID'); 

INSERT INTO file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,derive_timestamp_stmt,file_day_received,current_table_name,current_table_primary_key,full_load_table_primary_key)
VALUES('QUALITY_APP_PROCESSING_SCORECARD_ARCHIVE','INEO_ARCHIVE_QUALITY_APP_SCORECARD_HISTORY','INEO',
'ap_1_comments,ap_10_comments,ap_10a,ap_11_comments,ap_11a,ap_11b,ap_11c,ap_12_comments,ap_12a,ap_12b,ap_13_comments,ap_13a,ap_14_comments,ap_14a,ap_15_comments,ap_15a,ap_15b,ap_16_comments,ap_16a,ap_16b,ap_17_comments,ap_17a,
ap_17b,ap_18_comments,ap_18a,ap_18b,ap_19_comments,ap_19a,ap_1a,ap_1b,ap_2_comments,ap_20_comments,ap_20a,ap_20b,ap_20c,ap_20d,ap_20e,ap_20f,ap_2a,ap_2b,ap_2c,ap_2d,ap_2e,ap_2f,ap_3_comments,ap_3a,ap_3b,ap_3c,ap_3d,ap_3e,
ap_3f,ap_3g,ap_4_comments,ap_4a,ap_4b,ap_4c,ap_4d,ap_4e,ap_4f,ap_4g,ap_4h,ap_4i,ap_4j,ap_5_comments,ap_5a,ap_5b,ap_5c,ap_5d,ap_5e,ap_5f,ap_5g,ap_5h,ap_5i,ap_5j,ap_5k,ap_6_comments,ap_6a,ap_6b,ap_7_comments,ap_7a,ap_7b,ap_7c,
ap_7d,ap_7e,ap_7f,ap_7g,ap_7h,ap_7i,ap_8_comments,ap_8a,ap_8b,ap_8c,ap_8d,ap_8e,ap_8f,ap_8g,ap_8h,ap_9_comments,ap_9a,ap_9b,ap_9c,ap_9d,ap_9e,ap_9f,ap_9g,ap_9h,ap_9i,autonumber,employee_id,employee_name,filename,fssa_email,
fssa_id,manager,maximus_email,overall_comments,position_title,qi_supervisor,qisc,record_id,region,regional_supervisors,regions_supporting,score,send_to_trash,status,submitted_employee_name,supervisor,task_sequence_number,time_zone,training_status',
'ap_1_comments,ap_10_comments,ap_10a,ap_11_comments,ap_11a,ap_11b,ap_11c,ap_12_comments,ap_12a,ap_12b,ap_13_comments,ap_13a,ap_14_comments,ap_14a,ap_15_comments,ap_15a,ap_15b,ap_16_comments,ap_16a,ap_16b,ap_17_comments,ap_17a,
ap_17b,ap_18_comments,ap_18a,ap_18b,ap_19_comments,ap_19a,ap_1a,ap_1b,ap_2_comments,ap_20_comments,ap_20a,ap_20b,ap_20c,ap_20d,ap_20e,ap_20f,ap_2a,ap_2b,ap_2c,ap_2d,ap_2e,ap_2f,ap_3_comments,ap_3a,ap_3b,ap_3c,ap_3d,ap_3e,
ap_3f,ap_3g,ap_4_comments,ap_4a,ap_4b,ap_4c,ap_4d,ap_4e,ap_4f,ap_4g,ap_4h,ap_4i,ap_4j,ap_5_comments,ap_5a,ap_5b,ap_5c,ap_5d,ap_5e,ap_5f,ap_5g,ap_5h,ap_5i,ap_5j,ap_5k,ap_6_comments,ap_6a,ap_6b,ap_7_comments,ap_7a,ap_7b,ap_7c,
ap_7d,ap_7e,ap_7f,ap_7g,ap_7h,ap_7i,ap_8_comments,ap_8a,ap_8b,ap_8c,ap_8d,ap_8e,ap_8f,ap_8g,ap_8h,ap_9_comments,ap_9a,ap_9b,ap_9c,ap_9d,ap_9e,ap_9f,ap_9g,ap_9h,ap_9i,autonumber,employee_id,employee_name,filename,fssa_email,
fssa_id,manager,maximus_email,overall_comments,position_title,qi_supervisor,qisc,record_id,region,regional_supervisors,regions_supporting,TRY_CAST(score AS FLOAT),send_to_trash,status,submitted_employee_name,supervisor,task_sequence_,time_zone,training_status',
      'WHERE 1=1','Y', 'SELECT TO_CHAR(TO_TIMESTAMP(TRIM(SUBSTR(<filename>,LENGTH(<filename>)-13)),''yyyymmddhh24miss''),''mm/dd/yyyy hh24:mi:ss'') file_date,''Y'' with_timestamp FROM dual','PREVIOUS_BUSINESS_DAY',
      'INEO_ARCHIVE_QUALITY_APP_SCORECARD','RECORD_ID','ARCHIVE_QA_APP_SCORECARD_ID');  