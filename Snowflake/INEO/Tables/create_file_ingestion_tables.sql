USE SCHEMA INEO;
CREATE OR REPLACE sequence seq_file_id;
CREATE OR REPLACE sequence seq_errlog_id;
CREATE OR REPLACE sequence seq_alert_log_id;
CREATE OR REPLACE sequence seq_file_check_lkup_id;
CREATE OR REPLACE sequence seq_dmas_stagefile_id;
CREATE OR REPLACE sequence seq_synchlog_id;

DROP TABLE IF EXISTS file_load_log;
CREATE TABLE file_load_log(
    File_Id NUMBER DEFAULT seq_file_id.nextval,
    Filename_Prefix VARCHAR,
    Filename VARCHAR, 
    Row_Count NUMBER, 
    File_Date TIMESTAMP_NTZ, 
    Load_Date TIMESTAMP_NTZ DEFAULT current_timestamp(),
    Load_Status VARCHAR,
    Processed VARCHAR,
    processed_date TIMESTAMP_NTZ);

ALTER TABLE file_load_log ADD PRIMARY KEY(File_Id);

DROP TABLE IF EXISTS file_load_error_log;
CREATE TABLE file_load_error_log(
    Error_Log_Id NUMBER DEFAULT seq_errlog_id.nextval,
    File_Id NUMBER,
    Filename VARCHAR, 
    Error_Log_Date TIMESTAMP_NTZ DEFAULT current_date(),
    Error_Message VARCHAR);

ALTER TABLE file_load_error_log ADD PRIMARY KEY(Error_Log_Id);    

DROP TABLE IF EXISTS file_load_lkup;
CREATE TABLE file_load_lkup(
    Filename_Prefix VARCHAR,
    Full_Load_Table_Name VARCHAR, 
    Full_Load_Table_Schema VARCHAR,
    Insert_Fields VARCHAR, 
    Select_Fields VARCHAR,
    Where_Clause VARCHAR,
    Load_File VARCHAR,    
    derive_timestamp_stmt VARCHAR,
    file_day_received VARCHAR,
    current_table_name VARCHAR,
    current_table_primary_key VARCHAR,
    full_load_table_primary_key VARCHAR);

ALTER TABLE file_load_lkup ADD PRIMARY KEY(Filename_Prefix);    

DROP TABLE IF EXISTS file_load_config_control;
CREATE TABLE file_load_config_control(
  config_name VARCHAR NOT NULL
  ,config_value VARCHAR
  ,config_value_type VARCHAR
  ,create_dt TIMESTAMP_NTZ
  ,update_dt TIMESTAMP_NTZ);

ALTER TABLE file_load_config_control ADD PRIMARY KEY (config_name);

DROP TABLE IF EXISTS file_load_alert_log;
CREATE TABLE file_load_alert_log(
alert_log_id NUMBER DEFAULT seq_alert_log_id.nextval,
alert_lookup_id NUMBER,
alert_message VARCHAR,
filename VARCHAR,
create_dt TIMESTAMP_NTZ,
update_dt TIMESTAMP_NTZ,
is_active VARCHAR,
alert_type VARCHAR);

ALTER TABLE file_load_alert_log ADD primary key(alert_log_id);

DROP TABLE IF EXISTS file_load_check_lkup;
CREATE TABLE file_load_check_lkup(
file_check_lkup_id NUMBER DEFAULT seq_file_check_lkup_id.nextval,
filename_prefix VARCHAR,
file_check_query VARCHAR,
error_message VARCHAR,
is_active VARCHAR,
create_dt TIMESTAMP_NTZ,
update_dt TIMESTAMP_NTZ);

ALTER TABLE file_load_check_lkup ADD primary key(file_check_lkup_id);

DROP TABLE IF EXISTS file_load_drop_stage_list;
CREATE TABLE file_load_drop_stage_list
(stage_file_id NUMBER NOT NULL DEFAULT seq_dmas_stagefile_id.nextval
,stage_table_name VARCHAR
,is_dropped VARCHAR(2)
,comments VARCHAR
,create_dt TIMESTAMP_NTZ(9) DEFAULT current_timestamp()
,update_dt TIMESTAMP_NTZ(9) DEFAULT current_timestamp());

ALTER TABLE file_load_drop_stage_list ADD primary key(stage_file_id);

CREATE TABLE ineo.synchronize_table_log(synch_log_id NUMBER DEFAULT ineo.seq_synchlog_id.nextval, synch_table_name VARCHAR,synch_status VARCHAR,status_date TIMESTAMP_NTZ(9),num_rows_inserted NUMBER,num_rows_updated NUMBER);
ALTER TABLE  ineo.synchronize_table_log ADD PRIMARY KEY(synch_log_id);

DELETE FROM file_load_lkup;
INSERT INTO file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,derive_timestamp_stmt,file_day_received,current_table_name,current_table_primary_key,full_load_table_primary_key)
VALUES('R_TASKS_COMPLETED_','INEO_COMPLETED_TASK_BY_DAY_HISTORY','INEO','filename,task_id,task_name,reference_number,reference_type,case_num,work_queue_id,work_queue_name,task_created_datetime,task_assigned_datetime,task_reassigned_datetime,total_number_of_reassignments,task_completed_datetime,time_first_assignment_to_completion,time_latest_reassignment_to_completion,user_id,username,user_primary_office,office_name_of_task_assignment,county,task_inprogress_datetime',
      'UPPER(filename) filename,TRY_CAST(task_id AS NUMBER),task_name,reference_number,reference_type,TRY_CAST(case_number AS NUMBER) case_num,workqueue_id,workqueue_name,
CASE WHEN REGEXP_INSTR(task_created_datetime,''/'') > 0 THEN TO_TIMESTAMP_NTZ(task_created_datetime,''MM/DD/YYYY HH12:MI:SS AM'') ELSE TO_TIMESTAMP_NTZ(task_created_datetime,''MON DD"," YYYY HH12:MI:SS AM'') END task_created_datetime,
CASE WHEN REGEXP_INSTR(task_assigned_datetime_a,''/'') > 0 THEN TO_TIMESTAMP_NTZ(task_assigned_datetime_a,''MM/DD/YYYY HH12:MI:SS AM'') ELSE TO_TIMESTAMP_NTZ(task_assigned_datetime_a,''MON DD"," YYYY HH12:MI:SS AM'') END task_assigned_datetime,
CASE WHEN REGEXP_INSTR(task_reassigned_datetime_latest_reassignmentb,''/'') > 0 THEN TO_TIMESTAMP_NTZ(task_reassigned_datetime_latest_reassignmentb,''MM/DD/YYYY HH12:MI:SS AM'') ELSE TO_TIMESTAMP_NTZ(task_reassigned_datetime_latest_reassignmentb,''MON DD"," YYYY HH12:MI:SS AM'') END  task_reassigned_datetime,
TRY_CAST(total_number_of_reassignments_ AS NUMBER) total_number_of_reassignments,
CASE WHEN REGEXP_INSTR(task_completed_datetime_c,''/'') > 0 THEN TO_TIMESTAMP_NTZ(task_completed_datetime_c,''MM/DD/YYYY HH12:MI:SS AM'') ELSE TO_TIMESTAMP_NTZ(task_completed_datetime_c,''MON DD"," YYYY HH12:MI:SS AM'') END task_completed_datetime,
TRY_CAST(time_taken_in_sec_first_assignment_to_completion_c_a AS NUMBER) time_first_assignment_to_completion,TRY_CAST(time_taken_in_sec_from_latest_reassignment_to_completion_c_b AS NUMBER) time_latest_reassignment_to_completion,
user_id,user_name,user_primary_office,office_name_of_task_assignment,county,
CASE WHEN REGEXP_INSTR(task_in_progress_datetime,''/'') > 0 THEN TO_TIMESTAMP_NTZ(task_in_progress_datetime,''MM/DD/YYYY HH12:MI:SS AM'') ELSE TO_TIMESTAMP_NTZ(task_in_progress_datetime,''MON DD"," YYYY HH12:MI:SS AM'') END task_in_progress_datetime',
      'WHERE 1=1','Y', 'SELECT TO_CHAR(TO_TIMESTAMP(TRIM(SUBSTR(<filename>,LENGTH(<filename>)-13)),''yyyymmddhh24miss''),''mm/dd/yyyy hh24:mi:ss'') file_date,''Y'' with_timestamp FROM dual','PREVIOUS_BUSINESS_DAY',
      'INEO_COMPLETED_TASK_BY_DAY','TASK_ID','TASK_DETAIL_HISTORY_ID');
      
INSERT INTO file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,derive_timestamp_stmt,file_day_received,current_table_name,current_table_primary_key,full_load_table_primary_key)
VALUES('INEO_PT_STAFF_ROSTER','INEO_STAFF_ROSTER_HISTORY','INEO','filename,training_class_number,fssa_id,eid,first_name,last_name,position_title,hire_date,conversion_date,region,reports_to,coordinator,qitl,employer,employee_type,address,address_line_2,city,state,zip_code,personal_phone_number,equipment_provided,psid_form_completed,modified_ts',
      'UPPER(filename) filename,training_class_,fssa_id,eid,first_name,last_name,position_title,TRY_CAST(hire_date AS DATE) hire_date,conversion_date,region,reports_to,coordinator,qitl,employer,employee_type,address,address_line_2,city,state,zip_code,personal_phone_number,equipment_provided,psid_form_completed,TRY_CAST(modified AS TIMESTAMP) modified_ts',
      'WHERE 1=1','Y', 'SELECT TO_CHAR(TO_TIMESTAMP(TRIM(SUBSTR(<filename>,LENGTH(<filename>)-7)),''yyyymmdd''),''mm/dd/yyyy'') file_date,''N'' with_timestamp FROM dual','PREVIOUS_BUSINESS_DAY',
      'INEO_STAFF_ROSTER','EID','STAFF_ROSTER_HIST_ID');

INSERT INTO file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,derive_timestamp_stmt,file_day_received,current_table_name,current_table_primary_key,full_load_table_primary_key)
VALUES('CALL_DETAIL_REPORT','INEO_CALL_DETAIL_BY_DAY_HISTORY','INEO','call_date,call_id,call_start_ts,call_end_ts,call_duration,wrap_up_cd,queue_nm,user_id,transfer_count,type_of_transfer,filename',
      'TRY_CAST(call_date AS DATE) call_date,TRY_CAST(call_id AS NUMBER) call_id,call_start_ts,call_end_ts,call_duration,wrap_up_cd,queue_nm,user_id,transfer_count,type_of_transfer,UPPER(filename) filename',
       'WHERE 1=1','Y','SELECT TO_CHAR(TO_TIMESTAMP(TRIM(SUBSTR(<filename>,LENGTH(<filename>)-7)),''yyyymmdd''),''mm/dd/yyyy'') file_date,''N'' with_timestamp FROM dual','PREVIOUS_BUSINESS_DAY',
       'INEO_CALL_DETAIL_BY_DAY','CALL_ID','CALL_DETAIL_HISTORY_ID');
       
INSERT INTO file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,derive_timestamp_stmt,file_day_received,current_table_name,current_table_primary_key,full_load_table_primary_key)
VALUES('QUALITY_SCORES','INEO_QUALITY_SCORES_BY_STAFF_HISTORY','INEO','filename,record_id,self_review,eid,fssa_id,employee_name,team_lead,qitl,coordinator,status,task_id,score,nf_1,nf_1c,nf_2,nf_2c,nf_3,nf_3c,nf_4,nf_4c,nf_5,nf_5c,f_1,f_1c,f_2,f_2c,r_1,r_1c,ex_1,ex_1c,se_1,se_1c,se_2,se_2c,se_3,se_3c,se_4,se_4c,cd_1,cd_1c,ee_1,ee_1c,ee_2,ee_2c,ee_3,ee_3c,ee_4,ee_4c,ee_5,ee_5c,overall_comments,created_by,nf_1s,nf_2s,nf_3s,nf_4s,nf_5s,f_1s,f_2s,r_1s,ex_1s,se_1s,se_2s,se_3s,se_4s,cd_1s,ee_1s,ee_2s,ee_3s,ee_4s,ee_5s,created_ts,modified_ts',
      'UPPER(filename) filename,record_id,self_review,eid,fssa_id,employee_name,team_lead,qitl,coordinator,status,task_id,score,nf_1,nf_1c,nf_2,nf_2c,nf_3,nf_3c,nf_4,nf_4c,nf_5,nf_5c,f_1,f_1c,f_2,f_2c,r_1,r_1c,ex_1,ex_1c,se_1,se_1c,se_2,se_2c,se_3,se_3c,se_4,se_4c,cd_1,cd_1c,ee_1,ee_1c,ee_2,ee_2c,ee_3,ee_3c,ee_4,ee_4c,ee_5,ee_5c,overall_comments,created_by,
nf_1s,nf_2s,nf_3s,nf_4s,nf_5s,f_1s,f_2s,r_1s,ex_1s,se_1s,se_2s,se_3s,se_4s,cd_1s,ee_1s,ee_2s,ee_3s,ee_4s,ee_5s,TRY_CAST(created AS TIMESTAMP) created_ts,TRY_CAST(modified AS TIMESTAMP) modified_ts',
      'WHERE 1=1','Y','SELECT TO_CHAR(TO_TIMESTAMP(TRIM(SUBSTR(<filename>,LENGTH(<filename>)-13)),''yyyymmddhh24miss''),''mm/dd/yyyy hh24:mi:ss'') file_date,''Y'' with_timestamp FROM dual','PREVIOUS_BUSINESS_DAY',
      'INEO_QUALITY_SCORES_BY_STAFF','RECORD_ID','QUALITY_SCORE_HIST_ID');

INSERT INTO file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,derive_timestamp_stmt,file_day_received,current_table_name,current_table_primary_key,full_load_table_primary_key)
VALUES('DFR_DIRECTIVES','INEO_DFR_DIRECTIVES_BY_REGION_HISTORY','INEO','directive_region_id,filename,primary_column,communication_date,communication_time,effective_date,effective_time,region,dfr_representative,ineo_representative,work_distribution_directive,action_items,directive_type,task_type,task_notes,call_handling_type,call_handling_notes,additional_details,created_by,communication_type,communication_type_comments',
      'REGEXP_REPLACE(CONCAT(region,COALESCE(directive_type,''X''),COALESCE(to_char(try_cast(effective_date as date),''yyyymmdd''),''NA''),COALESCE(REGEXP_REPLACE(effective_time,''[^A-Za-z0-9]''),''000am''),COALESCE(to_char(try_cast(communication_date as date),''yyyymmdd''),''NA''),COALESCE(REGEXP_REPLACE(communication_time,''[^A-Za-z0-9]''),''000am'')),''[^A-Za-z0-9]'') directive_region_id,
      filename,primary_column,try_cast(communication_date as date),communication_time,try_cast(effective_date as date),effective_time,region,dfr_representative,ineo_representative,work_distribution_directive,action_items,directive_type,task_type,task_notes,call_handling_type,call_handling_notes,additional_details,created_by,communication_type,communication_type_comments',
      'WHERE 1=1','Y', 'SELECT TO_CHAR(TO_TIMESTAMP(TRIM(SUBSTR(<filename>,LENGTH(<filename>)-13)),''yyyymmddhh24miss''),''mm/dd/yyyy hh24:mi:ss'') file_date,''Y'' with_timestamp FROM dual','PREVIOUS_BUSINESS_DAY',
      'INEO_DFR_DIRECTIVES_BY_REGION','DIRECTIVE_REGION_ID','DIRECTIVE_REGION_HIST_ID');
            
INSERT INTO file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,derive_timestamp_stmt,file_day_received,current_table_name,current_table_primary_key,full_load_table_primary_key)
VALUES('TASKCATEGORY','INEO_TASK_CATEGORY_HISTORY','INEO','task_category_id,filename,queue,local_office_flag,task_name,task_due_date,task_priority,reference_type,assignment_type,detailed_description,work_category,system_manual,task_category',
      'task_id,filename,queue,local_office_flag,task_name,task_due_date,task_priority,reference_type,assignment_type,detailed_description,work_category,systemmanual,task_category',
      'WHERE 1=1','Y', 'SELECT TO_CHAR(TO_TIMESTAMP(TRIM(SUBSTR(<filename>,LENGTH(<filename>)-7)),''yyyymmdd''),''mm/dd/yyyy'') file_date,''N'' with_timestamp FROM dual','PREVIOUS_BUSINESS_DAY',
      'INEO_TASK_CATEGORY','TASK_CATEGORY_ID','TASK_CATEGORY_HIST_ID');
      
INSERT INTO file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,derive_timestamp_stmt,file_day_received,current_table_name,current_table_primary_key,full_load_table_primary_key)
VALUES('AD_HOC_PSID_SUBMISSIONS','INEO_ADHOC_PSID_SUBMISSIONS_HISTORY','INEO',
       'adhoc_psid_submission_id,agency_hire_date,business_address_county,business_email,business_phone_number,complete_business_address,created,delete_duplicate,dob,drivers_lic_number,employee_id,employee_name,employee_status,filename,gender,legal_name,maximus_hire_date,position_title,previous_psid,psid,psid_received,psid_submitted,region,tracking,training_class_id,training_status',
      'TRIM(CONCAT(TO_CHAR(TRY_CAST(created AS TIMESTAMP_NTZ),''yyyymmddhh24miss''),REGEXP_REPLACE(UPPER(employee_id),''[^A-Za-z0-9]''))),TRY_CAST(agency_hire_date AS DATE),business_address_county,business_email,business_phone_,complete_business_address,TRY_CAST(created AS TIMESTAMP_NTZ),delete_duplicate,TRY_CAST(dob AS DATE),drivers_lic_number,employee_id,employee_name,employee_status,filename,gender,legal_name,TRY_CAST(maximus_hire_date AS DATE),position_title,previous_psid,psid,TRY_CAST(psid_received AS DATE),TRY_CAST(psid_submitted AS DATE),region,tracking,training_class_id,training_status',
      'WHERE 1=1','Y', 'SELECT TO_CHAR(TO_TIMESTAMP(TRIM(SUBSTR(<filename>,LENGTH(<filename>)-13)),''yyyymmddhh24miss''),''mm/dd/yyyy hh24:mi:ss'') file_date,''Y'' with_timestamp FROM dual','PREVIOUS_BUSINESS_DAY',
      'INEO_ADHOC_PSID_SUBMISSIONS','ADHOC_PSID_SUBMISSION_ID','ADHOC_PSID_HISTORY_ID');
      
INSERT INTO file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,derive_timestamp_stmt,file_day_received,current_table_name,current_table_primary_key,full_load_table_primary_key)
VALUES('ALL_STAFF_ROSTER','INEO_ALL_STAFF_ROSTER_HISTORY','INEO',
       'agency_hire_date,attendance_points_accrued,average_cpc_training_exam_score,break_1_time,break_2_time,closed_corrective_actions,conversion_date,department,employee_id,employee_name,employee_status,employee_type,exemption_status,facility_specialist,filename,first_name,fssa_email,fssa_id,genesys_i3_id,hr_specialist,incumbent_transition,
last_name,lunch_end_time,lunch_start_time,manager, maximus_email,maximus_hire_date,modified,nesting_end_date,nesting_start_date,open_corrective_actions,personal_email,position_title,previous_stateconduent_employee,psid,qi_supervisor,qisc,region,regional_supervisors,regional_team_leads,regions_supporting,shift_end_time,
shift_schedule_week_starting,shift_start_time,sr_operations_manager,staffing_agency,supervisor,term_date,time_zone,training_class_id,training_co_facilitator,training_end_date,training_facilitator,training_hours_missed,training_start_date,training_status,transition_team_lead,work_group',
      'TRY_CAST(agency_hire_date AS DATE),attendance_points_accrued,average_cpc_training_exam_score,break_1_time,break_2_time,closed_corrective_actions,TRY_CAST(conversion_date AS DATE),department,employee_id,
employee_name,employee_status,employee_type,exemption_status,facilities_specialist,filename,first_name,fssa_email,fssa_id,genesys_i3_id,hr_specialist,incumbent_transition,
last_name,lunch_end_time,lunch_start_time,manager, maximus_email,TRY_CAST(maximus_hire_date AS DATE),TRY_CAST(modified AS TIMESTAMP_NTZ),TRY_CAST(nesting_end_date AS DATE),TRY_CAST(nesting_start_date AS DATE),open_corrective_actions,personal_email,
position_title,previous_stateconduent_employee,psid,qi_supervisor,qisc,region,regional_supervisors,regional_team_leads,regions_supporting,shift_end_time,
shift_schedule_week_starting,shift_start_time,sr_operations_manager,staffing_agency,supervisor,TRY_CAST(term_date AS DATE),time_zone,training_class_id,training_co_facilitator,
TRY_CAST(training_end_date AS DATE),training_facilitator,training_hours_missed,TRY_CAST(training_start_date AS DATE),training_status,transition_team_lead,work_group',
      'WHERE 1=1','Y', 'SELECT TO_CHAR(TO_TIMESTAMP(TRIM(SUBSTR(<filename>,LENGTH(<filename>)-13)),''yyyymmddhh24miss''),''mm/dd/yyyy hh24:mi:ss'') file_date,''Y'' with_timestamp FROM dual','PREVIOUS_BUSINESS_DAY',
      'INEO_ALL_STAFF_ROSTER','EMPLOYEE_ID','STAFF_ROSTER_HISTORY_ID');

INSERT INTO file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,derive_timestamp_stmt,file_day_received,current_table_name,current_table_primary_key,full_load_table_primary_key)
VALUES('ARCHIVED_DAILY_CHECK_INS','INEO_ARCHIVED_DAILY_CHECK_INS_HISTORY','INEO',
       'archived_daily_checkin_id,attendance_status,checked_in,created,date,department,employee_id,employee_name,employee_status,filename,maximus_email,position_title,region,submitted_employee_name,supervisor,training_status',
      'TRIM(CONCAT(TO_CHAR(TRY_CAST(created AS TIMESTAMP_NTZ),''yyyymmddhh24miss''),REGEXP_REPLACE(UPPER(employee_id),''[^A-Za-z0-9]''))),attendance_status,checked_in,TRY_CAST(created AS TIMESTAMP_NTZ),TRY_CAST(date AS DATE),department,employee_id,employee_name,employee_status,filename,maximus_email,position_title,region,submitted_employee_name,supervisor,training_status',
      'WHERE 1=1','Y', 'SELECT TO_CHAR(TO_TIMESTAMP(TRIM(SUBSTR(<filename>,LENGTH(<filename>)-13)),''yyyymmddhh24miss''),''mm/dd/yyyy hh24:mi:ss'') file_date,''Y'' with_timestamp FROM dual','PREVIOUS_BUSINESS_DAY',
      'INEO_ARCHIVED_DAILY_CHECK_INS','ARCHIVED_DAILY_CHECKIN_ID','ARCHIVE_CHECKIN_HISTORY_ID');
      
INSERT INTO file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,derive_timestamp_stmt,file_day_received,current_table_name,current_table_primary_key,full_load_table_primary_key)
VALUES('ARCHIVED_TIME_OFF_REQUESTS','INEO_ARCHIVED_TIME_OFF_REQUESTS_HISTORY','INEO',
       'timeoff_request_id,absence_date,absence_description,absence_end_time,absence_start_time,absence_type,archive_error,arrival_time,departure_time,employee_id,employee_name,
employee_status,employee_type,filename,latest_comment,manager,maximus_email,month_number,month_name,operations_approval_date,operations_approval_status,position_title,
region,regional_supervisors,staffing_agency,submission_comments,submission_date,submission_timestamp,submitted_employee_name,supervisor,time_zone,training_status,
transition_team_lead,wfm_absence_description,wfm_approval_date,wfm_approval_status,regions_supporting',
      'TRIM(CONCAT(TO_CHAR(TRY_CAST(absence_date AS DATE),''yyyymmdd''),TO_CHAR(TRY_CAST(submission_timestamp AS TIMESTAMP_NTZ),''yyyymmddhh24miss''),REGEXP_REPLACE(UPPER(employee_id),''[^A-Za-z0-9]''))) timeoff_request_id,TRY_CAST(absence_date AS DATE),absence_description,absence_end_time,absence_start_time,absence_type,archive_error,arrival_time,departure_time,employee_id,employee_name,
employee_status,employee_type,filename,latest_comment,manager,maximus_email,TRY_CAST(month_ AS NUMBER),month_name,TRY_CAST(operations_approval_date AS DATE),operations_approval_status,position_title,
region,regional_supervisors,staffing_agency,submission_comments,TRY_CAST(submission_date AS DATE),TRY_CAST(submission_timestamp AS TIMESTAMP_NTZ),submitted_employee_name,supervisor,time_zone,training_status,
transition_team_lead,wfm_absence_description,TRY_CAST(wfm_approval_date AS DATE),wfm_approval_status,regions_supporting',
      'WHERE 1=1','Y', 'SELECT TO_CHAR(TO_TIMESTAMP(TRIM(SUBSTR(<filename>,LENGTH(<filename>)-13)),''yyyymmddhh24miss''),''mm/dd/yyyy hh24:mi:ss'') file_date,''Y'' with_timestamp FROM dual','PREVIOUS_BUSINESS_DAY',
      'INEO_ARCHIVED_TIME_OFF_REQUESTS','TIMEOFF_REQUEST_ID','TIMEOFF_REQ_HISTORY_ID');

INSERT INTO file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,derive_timestamp_stmt,file_day_received,current_table_name,current_table_primary_key,full_load_table_primary_key)
VALUES('ARCHIVED_UNSCHEDULED_ABSENCES_PRODUCTION','INEO_ARCHIVED_UNSCHED_ABSENCES_PRODUCTION_HISTORY','INEO',
       'unscheduled_absence_id,absence_date,absence_description,absence_end_time,absence_start_time,absence_type,archive_error,arrival_time,departure_time,employee_id,employee_name,
employee_status,employee_type,filename,latest_comment,manager,maximus_email,point_value,position_title,region,regional_supervisors,staffing_agency,submission_comments,
submission_date,submission_timestamp,submitted_employee_name,supervisor,time_zone,training_status,wfm_absence_description,regions_supporting',
      'TRIM(CONCAT(TO_CHAR(TRY_CAST(absence_date AS DATE),''yyyymmdd''),TO_CHAR(TRY_CAST(submission_timestamp AS TIMESTAMP_NTZ),''yyyymmddhh24miss''),REGEXP_REPLACE(UPPER(employee_id),''[^A-Za-z0-9]''))) unscheduled_absence_id,TRY_CAST(absence_date AS DATE),absence_description,absence_end_time,absence_start_time,absence_type,archive_error,arrival_time,departure_time,employee_id,employee_name,
employee_status,employee_type,filename,latest_comment,manager,maximus_email,point_value,position_title,region,regional_supervisors,staffing_agency,submission_comments,
TRY_CAST(submission_date AS DATE),TRY_CAST(submission_timestamp AS TIMESTAMP_NTZ),submitted_employee_name,supervisor,time_zone,training_status,wfm_absence_description,regions_supporting',
      'WHERE 1=1','Y', 'SELECT TO_CHAR(TO_TIMESTAMP(TRIM(SUBSTR(<filename>,LENGTH(<filename>)-13)),''yyyymmddhh24miss''),''mm/dd/yyyy hh24:mi:ss'') file_date,''Y'' with_timestamp FROM dual','PREVIOUS_BUSINESS_DAY',
      'INEO_ARCHIVED_UNSCHED_ABSENCES_PRODUCTION','UNSCHEDULED_ABSENCE_ID','UNSCHED_ABSENCE_HISTORY_ID');
      
INSERT INTO file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,derive_timestamp_stmt,file_day_received,current_table_name,current_table_primary_key,full_load_table_primary_key)
VALUES('CALLER_ESCALATIONS','INEO_CALLER_ESCALATIONS_HISTORY','INEO',
       'client_region,collection_region,employee_id,employee_name,escalation_id,escalation_reason,filename,follow_up_completed,follow_up_recommended,notes,rccccc,submitted_by,task_call_id,escalation_date',
      'client_region,collection_region,employee_id,employee_name,escalation_id,escalation_reason,filename,follow_up_completed,follow_up_recommended,notes,rccccc,submitted_by,task___call_id
 ,TO_DATE(TRIM(SUBSTR(REGEXP_REPLACE(escalation_id,''ESC-'',''''),1,REGEXP_INSTR(REGEXP_REPLACE(escalation_id,''ESC-'',''''),''-'')-1)),''YYYYMMDD'') escalation_date',
      'WHERE 1=1','Y', 'SELECT TO_CHAR(TO_TIMESTAMP(TRIM(SUBSTR(<filename>,LENGTH(<filename>)-13)),''yyyymmddhh24miss''),''mm/dd/yyyy hh24:mi:ss'') file_date,''Y'' with_timestamp FROM dual','PREVIOUS_BUSINESS_DAY',
      'INEO_CALLER_ESCALATIONS','ESCALATION_ID','CALLER_ESCALATION_HISTORY_ID'); 
 
INSERT INTO file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,derive_timestamp_stmt,file_day_received,current_table_name,current_table_primary_key,full_load_table_primary_key)
VALUES('CLIENT_COMPLAINTS','INEO_CLIENT_COMPLAINTS_HISTORY','INEO',
       'civil_rights_sub_type,client_region,collection_region,complaint_id,complaint_type,eligibility_programs_sub_type,employee_id,employee_name,filename,follow_up_completed,follow_up_recommended,notes,rccccc,submitted_by,submitted_to_state,task_call_id,complaint_date',
      'civil_rights_sub_type,client_region,collection_region,complaint_id,complaint_type,eligibility_programs_sub_type,employee_id,employee_name,filename,follow_up_completed,follow_up_recommended,notes,rccccc,submitted_by,submitted_to_state,task___call_id,
TO_DATE(TRIM(SUBSTR(REGEXP_REPLACE(complaint_id,''CLCO-'',''''),1,REGEXP_INSTR(REGEXP_REPLACE(complaint_id,''CLCO-'',''''),''-'')-1)),''YYYYMMDD'') complaint_date',
      'WHERE 1=1','Y', 'SELECT TO_CHAR(TO_TIMESTAMP(TRIM(SUBSTR(<filename>,LENGTH(<filename>)-13)),''yyyymmddhh24miss''),''mm/dd/yyyy hh24:mi:ss'') file_date,''Y'' with_timestamp FROM dual','PREVIOUS_BUSINESS_DAY',
      'INEO_CLIENT_COMPLAINTS','COMPLAINT_ID','CLIENT_COMPLAINT_HISTORY_ID');       

INSERT INTO file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,derive_timestamp_stmt,file_day_received,current_table_name,current_table_primary_key,full_load_table_primary_key)
VALUES('NEW_HIRE_PSID_SUBMISSIONS','INEO_NEW_HIRE_PSID_SUBMISSIONS_HISTORY','INEO',
       'newhire_psid_id,agency_hire_date,business_address_county,business_email,business_phone_number,complete_business_address,created,delete_duplicate,dob,drivers_lic_number,employee_id,employee_name,employee_status,filename,gender,legal_name,maximus_hire_date,position_title,previous_psid,psid,psid_received,psid_submitted,region,tracking,training_class_id,training_status',
      'TRIM(CONCAT(TO_CHAR(TRY_CAST(created AS TIMESTAMP_NTZ),''yyyymmddhh24miss''),REGEXP_REPLACE(UPPER(employee_id),''[^A-Za-z0-9]''))) newhire_psid_id,TRY_CAST(agency_hire_date AS DATE),business_address_county,business_email,business_phone_,complete_business_address,
  TRY_CAST(created AS TIMESTAMP_NTZ),delete_duplicate,dob,drivers_lic_number,employee_id,employee_name,employee_status,filename,gender,legal_name,TRY_CAST(maximus_hire_date AS DATE),position_title,previous_psid,psid,TRY_CAST(psid_received AS DATE),TRY_CAST(psid_submitted AS DATE),region,tracking,training_class_id,training_status',
      'WHERE 1=1','Y', 'SELECT TO_CHAR(TO_TIMESTAMP(TRIM(SUBSTR(<filename>,LENGTH(<filename>)-13)),''yyyymmddhh24miss''),''mm/dd/yyyy hh24:mi:ss'') file_date,''Y'' with_timestamp FROM dual','PREVIOUS_BUSINESS_DAY',
      'INEO_NEW_HIRE_PSID_SUBMISSIONS','NEWHIRE_PSID_ID','NEWHIRE_PSID_HISTORY_ID'); 
 
INSERT INTO file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,derive_timestamp_stmt,file_day_received,current_table_name,current_table_primary_key,full_load_table_primary_key)
VALUES('WFM_DAILY_STAFF_ATTENDANCE_ROSTER','INEO_WFM_DAILY_STAFF_ATTENDANCE_ROSTER_HISTORY','INEO',
       'wfm_attendance_id,attendance_status,attendance_substatus,checked_in,date,employee_id,employee_name,employee_status,employee_type,filename,manager,modified,points_accrued_to_date,points_earned,position_title,region,supervisor,time,time_zone,timestamp,training_status,regions_supporting',
      'TRIM(CONCAT(TO_CHAR(TRY_CAST(modified AS TIMESTAMP_NTZ),''yyyymmddhh24miss''),REGEXP_REPLACE(UPPER(employee_id),''[^A-Za-z0-9]'')))  wfm_attendance_id,attendance_status,attendance_substatus,
 checked_in,TRY_CAST(date AS DATE),employee_id,employee_name,employee_status,employee_type,filename,manager,TRY_CAST(modified AS TIMESTAMP_NTZ),TRY_CAST(points_accrued_to_date AS NUMBER),TRY_CAST(points_earned AS NUMBER),position_title,region,supervisor,time,time_zone,TRY_CAST(timestamp AS TIMESTAMP_NTZ),training_status,regions_supporting',
      'WHERE 1=1','Y', 'SELECT TO_CHAR(TO_TIMESTAMP(TRIM(SUBSTR(<filename>,LENGTH(<filename>)-13)),''yyyymmddhh24miss''),''mm/dd/yyyy hh24:mi:ss'') file_date,''Y'' with_timestamp FROM dual','PREVIOUS_BUSINESS_DAY',
      'INEO_WFM_DAILY_STAFF_ATTENDANCE_ROSTER','WFM_ATTENDANCE_ID','WFM_ATTENDANCE_HISTORY_ID'); 

INSERT INTO file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,derive_timestamp_stmt,file_day_received,current_table_name,current_table_primary_key,full_load_table_primary_key)
VALUES('PRODUCTION_UNSCHEDULED_ABSENCES_ACTIVE','INEO_ACTIVE_UNSCHED_ABSENCES_PRODUCTION_HISTORY','INEO',
       'active_unsched_absence_id,absence_date,absence_description,absence_end_time,absence_start_time,absence_type,archive_error,arrival_time,departure_time,employee_id,employee_name,
employee_status,employee_type,filename,manager,maximus_email,point_value,position_title,region,regional_supervisors,submission_comments,
submission_date,submission_timestamp,submitted_employee_name,supervisor,time_zone,training_status,transition_team_lead,wfm_absence_description,regions_supporting,employee_total',
      'TRIM(CONCAT(TO_CHAR(TRY_CAST(absence_date AS DATE),''yyyymmdd''),TO_CHAR(TRY_CAST(submission_timestamp AS TIMESTAMP_NTZ),''yyyymmddhh24miss''),REGEXP_REPLACE(UPPER(employee_id),''[^A-Za-z0-9]''))) active_unsched_absence_id,TRY_CAST(absence_date AS DATE),absence_description,absence_end_time,absence_start_time,absence_type,archive_error,arrival_time,departure_time,employee_id,employee_name,
employee_status,employee_type,filename,manager,maximus_email,point_value,position_title,region,regional_supervisors,submission_comments,
TRY_CAST(submission_date AS DATE),TRY_CAST(submission_timestamp AS TIMESTAMP_NTZ),submitted_employee_name,supervisor,time_zone,training_status,transition_team_lead,wfm_absence_description,regions_supporting,0 employeetotal',
      'WHERE 1=1','Y', 'SELECT TO_CHAR(TO_TIMESTAMP(TRIM(SUBSTR(<filename>,LENGTH(<filename>)-13)),''yyyymmddhh24miss''),''mm/dd/yyyy hh24:mi:ss'') file_date,''Y'' with_timestamp FROM dual','PREVIOUS_BUSINESS_DAY',
      'INEO_ACTIVE_UNSCHED_ABSENCES_PRODUCTION','ACTIVE_UNSCHED_ABSENCE_ID','ACTIVE_UNSCHED_HISTORY_ID');

INSERT INTO file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,derive_timestamp_stmt,file_day_received,current_table_name,current_table_primary_key,full_load_table_primary_key)
VALUES('PROVISIONING_STAFF_ROSTER','INEO_PROVISIONING_STAFF_ROSTER_HISTORY','INEO',
       'provisioning_staff_roster_id,agency_hire_date,cognos_needed,cognos_received,cognos_requested,department,employee_id,employee_name,employee_status,filename,fssa_id,fssa_received,fssa_requested,genesys_i3_id,genesys_requested,iedss_received
,iedss_requested,manager,maximus_email,maximus_hire_date,position_title,psid,psid_overdue,psid_received,psid_requested,region,supervisor,term_date,time_zone,training_class_id,training_co_facilitator
,training_facilitator,training_start_date,training_status,transition_team_lead',
      'TRIM(CONCAT(TO_CHAR(TRY_CAST(agency_hire_date AS DATE),''yyyymmdd''),department,REGEXP_REPLACE(UPPER(employee_id),''[^A-Za-z0-9]''))) provisioning_staff_roster_id,TRY_CAST(agency_hire_date AS DATE),cognos_needed,TRY_CAST(cognos_received AS DATE),TRY_CAST(cognos_requested AS DATE),department,employee_id,employee_name,employee_status,filename,fssa_id,
TRY_CAST(fssa_received AS DATE),TRY_CAST(fssa_requested AS DATE),genesys_i3_id,TRY_CAST(genesys_requested AS DATE),TRY_CAST(iedss_received AS DATE),
TRY_CAST(iedss_requested AS DATE),manager,maximus_email,TRY_CAST(maximus_hire_date AS DATE),position_title,psid,psid_overdue,TRY_CAST(psid_received AS DATE),TRY_CAST(psid_requested AS DATE),region,
supervisor,TRY_CAST(term_date AS DATE),time_zone,training_class_id,training_co_facilitator
,training_facilitator,TRY_CAST(training_start_date AS DATE),training_status,transition_team_lead',
      'WHERE 1=1','Y', 'SELECT TO_CHAR(TO_TIMESTAMP(TRIM(SUBSTR(<filename>,LENGTH(<filename>)-13)),''yyyymmddhh24miss''),''mm/dd/yyyy hh24:mi:ss'') file_date,''Y'' with_timestamp FROM dual','PREVIOUS_BUSINESS_DAY',
      'INEO_PROVISIONING_STAFF_ROSTER','PROVISIONING_STAFF_ROSTER_ID','PROV_STAFF_ROSTER_HISTORY_ID');

INSERT INTO file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,derive_timestamp_stmt,file_day_received,current_table_name,current_table_primary_key,full_load_table_primary_key)
VALUES('TIME_OFF_REQUESTS_ACTIVE','INEO_ACTIVE_TIME_OFF_REQUESTS_HISTORY','INEO',
       'active_timeoff_request_id,absence_date,absence_description,absence_end_time,absence_start_time,absence_type,archive_error,arrival_time,departure_time,employee_id,employee_name,
employee_status,employee_type,filename,latest_comment,manager,maximus_email,month_number,month_name,operations_approval_date,operations_approval_status,position_title,
region,regional_supervisors,submission_comments,submission_date,submission_timestamp,submitted_employee_name,supervisor,time_zone,training_status,
transition_team_lead,wfm_absence_description,wfm_approval_date,wfm_approval_status,regions_supporting',
      'TRIM(CONCAT(TO_CHAR(TRY_CAST(absence_date AS DATE),''yyyymmdd''),TO_CHAR(TRY_CAST(submission_timestamp AS TIMESTAMP_NTZ),''yyyymmddhh24miss''),REGEXP_REPLACE(UPPER(employee_id),''[^A-Za-z0-9]''))) timeoff_request_id,TRY_CAST(absence_date AS DATE),absence_description,absence_end_time,absence_start_time,absence_type,archive_error,arrival_time,departure_time,employee_id,employee_name,
employee_status,employee_type,filename,latest_comment,manager,maximus_email,TRY_CAST(month_ AS NUMBER),month_name,TRY_CAST(operations_approval_date AS DATE),operations_approval_status,position_title,
region,regional_supervisors,submission_comments,TRY_CAST(submission_date AS DATE),TRY_CAST(submission_timestamp AS TIMESTAMP_NTZ),submitted_employee_name,supervisor,time_zone,training_status,
transition_team_lead,wfm_absence_description,TRY_CAST(wfm_approval_date AS DATE),wfm_approval_status,regions_supporting',
      'WHERE 1=1','Y', 'SELECT TO_CHAR(TO_TIMESTAMP(TRIM(SUBSTR(<filename>,LENGTH(<filename>)-13)),''yyyymmddhh24miss''),''mm/dd/yyyy hh24:mi:ss'') file_date,''Y'' with_timestamp FROM dual','PREVIOUS_BUSINESS_DAY',
      'INEO_ACTIVE_TIME_OFF_REQUESTS','ACTIVE_TIMEOFF_REQUEST_ID','ACTIVE_TIMEOFF_REQ_HISTORY_ID');

INSERT INTO file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,derive_timestamp_stmt,file_day_received,current_table_name,current_table_primary_key,full_load_table_primary_key)
VALUES('TRAINING_NEW_HIRE_CLASS_TRACKER','INEO_TRAINING_NEWHIRE_CLASS_TRACKER_HISTORY','INEO',
       'training_newhire_tracker_id,actual_attendees,attrition_rate_to_date,block_1_average_attempts,block_1_class_average,block_2_average_attempts,block_2_class_average,block_3_average_attempts,block_3_class_average,block_4_average_attempts,
block_4_class_average,block_5_a_average_attempts,block_5_a_class_average,block_5_b_average_attempts,block_5_b_class_average,block_6_7_average_attempts,block_6_7_class_average,conduent_trainer,expected_attendees,
filename,maximus_co_facilitator,maximus_facilitator,nesting_end_date,nesting_start_date,region,training_class_id,training_end_date,training_start_date',
      'CONCAT(COALESCE(training_class_id,''NA''),COALESCE(TO_CHAR(TRY_CAST(training_start_date AS DATE),''yyyymmdd''),''NA''),COALESCE(TO_CHAR(TRY_CAST(training_end_date AS DATE),''yyyymmdd''),''NA'')) training_newhire_tracker_id,TRY_CAST(actual_attendees AS NUMBER),
TRY_CAST(attrition_rate_to_date AS FLOAT),TRY_CAST(block_1_average_attempts AS FLOAT),TRY_CAST(block_1_class_average AS FLOAT),TRY_CAST(block_2_average_attempts AS FLOAT),TRY_CAST(block_2_class_average AS FLOAT),
TRY_CAST(block_3_average_attempts AS FLOAT),TRY_CAST(block_3_class_average AS FLOAT),TRY_CAST(block_4_average_attempts AS FLOAT),TRY_CAST(block_4_class_average AS FLOAT),TRY_CAST(block_5_a_average_attempts AS FLOAT),
TRY_CAST(block_5_a_class_average AS FLOAT),TRY_CAST(block_5_b_average_attempts AS FLOAT),TRY_CAST(block_5_b_class_average AS FLOAT),TRY_CAST(block_6__7_average_attempts AS FLOAT),TRY_CAST(block_6__7_class_average AS FLOAT),
conduent_trainer,TRY_CAST(expected_attendees AS NUMBER),filename,maximus_co_facilitator,maximus_facilitator,TRY_CAST(nesting_end_date AS DATE),TRY_CAST(nesting_start_date AS DATE),region,training_class_id,TRY_CAST(training_end_date AS DATE),TRY_CAST(training_start_date AS DATE)',
      'WHERE 1=1','Y', 'SELECT TO_CHAR(TO_TIMESTAMP(TRIM(SUBSTR(<filename>,LENGTH(<filename>)-13)),''yyyymmddhh24miss''),''mm/dd/yyyy hh24:mi:ss'') file_date,''Y'' with_timestamp FROM dual','PREVIOUS_BUSINESS_DAY',
      'INEO_TRAINING_NEWHIRE_CLASS_TRACKER','TRAINING_NEWHIRE_TRACKER_ID','TRAINING_NEWHIRE_TRACKER_HISTORY_ID');
      
INSERT INTO file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,derive_timestamp_stmt,file_day_received,current_table_name,current_table_primary_key,full_load_table_primary_key)
VALUES('TRAINING_NEW_HIRE_EXAM_TRACKER_ACTIVE','INEO_ACTIVE_TRAINING_NEWHIRE_EXAM_TRACKER_HISTORY','INEO',
       'training_newhire_exam_id,block_1_attempt_1,block_1_attempt_2,block_1_attempt_3,block_1_average,block_1_count_of_attempts,block_2_attempt_1,block_2_attempt_2,block_2_attempt_3,block_2_average,block_2_count_of_attempts,
block_3_attempt_1,block_3_attempt_2,block_3_attempt_3,block_3_average,block_3_count_of_attempts,block_4_attempt_1,block_4_attempt_2,block_4_attempt_3,block_4_average,block_4_count_of_attempts,block_5_a_attempt_1,
block_5_a_attempt_2,block_5_a_attempt_3,block_5_a_average,block_5_a_count_of_attempts,block_5_b_attempt_1,block_5_b_attempt_2,block_5_b_attempt_3,block_5_b_average,block_5_b_count_of_attempts,block_6_7_attempt_1,
block_6_7_attempt_2,block_6_7_attempt_3,block_6_7_average,block_6_7_count_of_attempts,employee_id,employee_name,employee_status,exam_average,filename,region,training_class_id,training_end_date,training_start_date',
      'CONCAT(COALESCE(training_class_id,''NA''),COALESCE(TO_CHAR(TRY_CAST(training_start_date AS DATE),''yyyymmdd''),''NA''),COALESCE(TO_CHAR(TRY_CAST(training_end_date AS DATE),''yyyymmdd''),''NA''),employee_id) training_newhire_exam_id,
TRY_CAST(block_1_attempt_1 AS FLOAT),TRY_CAST(block_1_attempt_2 AS FLOAT),TRY_CAST(block_1_attempt_3 AS FLOAT),TRY_CAST(block_1_average AS FLOAT),TRY_CAST(block_1_count_of_attempts AS FLOAT),
TRY_CAST(block_2_attempt_1 AS FLOAT),TRY_CAST(block_2_attempt_2 AS FLOAT),TRY_CAST(block_2_attempt_3 AS FLOAT),TRY_CAST(block_2_average AS FLOAT),TRY_CAST(block_2_count_of_attempts AS FLOAT),
TRY_CAST(block_3_attempt_1 AS FLOAT),TRY_CAST(block_3_attempt_2 AS FLOAT),TRY_CAST(block_3_attempt_3 AS FLOAT),TRY_CAST(block_3_average AS FLOAT),TRY_CAST(block_3_count_of_attempts AS FLOAT),
TRY_CAST(block_4_attempt_1 AS FLOAT),TRY_CAST(block_4_attempt_2 AS FLOAT),TRY_CAST(block_4_attempt_3 AS FLOAT),TRY_CAST(block_4_average AS FLOAT),TRY_CAST(block_4_count_of_attempts AS FLOAT),
TRY_CAST(block_5_a_attempt_1 AS FLOAT),TRY_CAST(block_5_a_attempt_2 AS FLOAT),TRY_CAST(block_5_a_attempt_3 AS FLOAT),TRY_CAST(block_5_a_average AS FLOAT),TRY_CAST(block_5_a_count_of_attempts AS FLOAT),
TRY_CAST(block_5_b_attempt_1 AS FLOAT),TRY_CAST(block_5_b_attempt_2 AS FLOAT),TRY_CAST(block_5_b_attempt_3 AS FLOAT),TRY_CAST(block_5_b_average AS FLOAT),TRY_CAST(block_5_b_count_of_attempts AS FLOAT),
TRY_CAST(block_6__7_attempt_1 AS FLOAT),TRY_CAST(block_6__7_attempt_2 AS FLOAT),TRY_CAST(block_6__7_attempt_3 AS FLOAT),TRY_CAST(block_6__7_average AS FLOAT),TRY_CAST(block_6__7_count_of_attempts AS FLOAT),
employee_id,employee_name,employee_status,TRY_CAST(exam_average AS FLOAT),filename,region,training_class_id,TRY_CAST(training_end_date AS DATE),TRY_CAST(training_start_date AS DATE)',
      'WHERE 1=1','Y', 'SELECT TO_CHAR(TO_TIMESTAMP(TRIM(SUBSTR(<filename>,LENGTH(<filename>)-13)),''yyyymmddhh24miss''),''mm/dd/yyyy hh24:mi:ss'') file_date,''Y'' with_timestamp FROM dual','PREVIOUS_BUSINESS_DAY',
      'INEO_ACTIVE_TRAINING_NEWHIRE_EXAM_TRACKER','TRAINING_NEWHIRE_EXAM_ID','TRAINING_NEWHIRE_EXAM_HISTORY_ID');
  
INSERT INTO file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,derive_timestamp_stmt,file_day_received,current_table_name,current_table_primary_key,full_load_table_primary_key)
VALUES('TRAINING_UNSCHEDULED_ABSENCES_ACTIVE','INEO_ACTIVE_TRAINING_UNSCHED_ABSENCES_HISTORY','INEO',
       'active_training_unsched_absence_id,absence_date,absence_description,absence_end_time,absence_start_time,absence_type,archive_error,arrival_time,departure_time,employee_id,employee_name,
employee_status,employee_type,filename,manager,maximus_email,position_title,region,regional_supervisors,submission_comments,
submission_date,submission_timestamp,submitted_employee_name,supervisor,time_zone,training_class_id,training_end_date,training_start_date,training_status,transition_team_lead,wfm_absence_description',
      'TRIM(CONCAT(COALESCE(training_class_id,''NA''),TO_CHAR(TRY_CAST(absence_date AS DATE),''yyyymmdd''),COALESCE(REGEXP_REPLACE(absence_start_time,''[^A-Za-z0-9]''),''000am''),TO_CHAR(TRY_CAST(submission_timestamp AS TIMESTAMP_NTZ),''yyyymmddhh24miss''),REGEXP_REPLACE(UPPER(employee_id),''[^A-Za-z0-9]''))) active_unsched_absence_id,TRY_CAST(absence_date AS DATE),absence_description,absence_end_time,absence_start_time,absence_type,archive_error,arrival_time,departure_time,employee_id,employee_name,
employee_status,employee_type,filename,manager,maximus_email,position_title,region,regional_supervisors,submission_comments,
TRY_CAST(submission_date AS DATE),TRY_CAST(submission_timestamp AS TIMESTAMP_NTZ),submitted_employee_name,supervisor,time_zone,training_class_id,TRY_CAST(training_end_date AS DATE),TRY_CAST(training_start_date AS DATE),training_status,transition_team_lead,wfm_absence_description',
      'WHERE 1=1','Y', 'SELECT TO_CHAR(TO_TIMESTAMP(TRIM(SUBSTR(<filename>,LENGTH(<filename>)-13)),''yyyymmddhh24miss''),''mm/dd/yyyy hh24:mi:ss'') file_date,''Y'' with_timestamp FROM dual','PREVIOUS_BUSINESS_DAY',
      'INEO_ACTIVE_TRAINING_UNSCHED_ABSENCES','ACTIVE_TRAINING_UNSCHED_ABSENCE_ID','ACTIVE_TRAINING_UNSCHED_HISTORY_ID');

INSERT INTO file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,derive_timestamp_stmt,file_day_received,current_table_name,current_table_primary_key,full_load_table_primary_key)
VALUES('TRAINING_STAFF_ROSTER_ACTIVE_RECORDS','INEO_ACTIVE_TRAINING_STAFF_ROSTER_HISTORY','INEO','active_training_staff_roster_id,average_cpc_training_exam_score,conduent_trainer,department,employee_id,employee_name,employee_status,filename,manager,maximus_co_facilitator,maximus_email,maximus_facilitator,nesting_end_date,nesting_start_date,
personal_email,position_title,previous_stateconduent_employee,psid_form_submission,region,send_welcome_email,staffing_agency,time_zone,training_class_id,training_end_date,training_hours_missed,training_start_date,
training_status,transition_team_lead',
      'CONCAT(COALESCE(training_class_id,''NA''),COALESCE(TO_CHAR(TRY_CAST(training_start_date AS DATE),''yyyymmdd''),''NA''),COALESCE(TO_CHAR(TRY_CAST(training_end_date AS DATE),''yyyymmdd''),''NA''),employee_id) active_training_staff_roster_id,
TRY_CAST(average_cpc_training_exam_score AS FLOAT),conduent_trainer,department,employee_id,employee_name,employee_status,filename,manager,maximus_co_facilitator,maximus_email,maximus_facilitator,
TRY_CAST(nesting_end_date AS DATE),TRY_CAST(nesting_start_date AS DATE),personal_email,position_title,previous_stateconduent_employee,psid_form_submission,region,send_welcome_email,staffing_agency,
time_zone,training_class_id,TRY_CAST(training_end_date AS DATE),training_hours_missed,TRY_CAST(training_start_date AS DATE),training_status,transition_team_lead',
      'WHERE 1=1','Y', 'SELECT TO_CHAR(TO_TIMESTAMP(TRIM(SUBSTR(<filename>,LENGTH(<filename>)-13)),''yyyymmddhh24miss''),''mm/dd/yyyy hh24:mi:ss'') file_date,''Y'' with_timestamp FROM dual','PREVIOUS_BUSINESS_DAY',
      'INEO_ACTIVE_TRAINING_STAFF_ROSTER','ACTIVE_TRAINING_STAFF_ROSTER_ID','ACTIVE_TRN_STAFF_ROSTER_HISTORY_ID');
      
--no need for a current table for WFM_TRAINING_FORM_SUBMISSIONS_ACTIVE because there is nothing on the record that could make it unique
INSERT INTO file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,derive_timestamp_stmt,file_day_received,current_table_name,current_table_primary_key,full_load_table_primary_key)
VALUES('WFM_TRAINING_FORM_SUBMISSIONS_ACTIVE','INEO_ACTIVE_WFM_TRAINING_FORM_SUBMISSIONS_HISTORY','INEO',
       'active_wfm_training_form_submission_id,comments,absence_type,date_of_absence,delete_record,emailed_submitted_form_for_absence,employee_id,employee_name,employee_status,filename,hours_missed,position_title,
reason_for_absence,region,submitted_employee_name,training_class_id',
      'TRIM(CONCAT(COALESCE(training_class_id,''NA''),TO_CHAR(TRY_CAST(date_of_absence AS DATE),''yyyymmdd''),REGEXP_REPLACE(UPPER(employee_id),''[^A-Za-z0-9]''))) active_wfm_training_form_submission_id,
comments,absence_type,TRY_CAST(date_of_absence AS DATE),delete_record,emailed__submitted_form_for_absence,employee_id,employee_name,employee_status,filename,TRY_CAST(hours_missed AS FLOAT),position_title,reason_for_absence,region,submitted_employee_name,training_class_id',
      'WHERE 1=1','Y', 'SELECT TO_CHAR(TO_TIMESTAMP(TRIM(SUBSTR(<filename>,LENGTH(<filename>)-13)),''yyyymmddhh24miss''),''mm/dd/yyyy hh24:mi:ss'') file_date,''Y'' with_timestamp FROM dual','PREVIOUS_BUSINESS_DAY',
      null,null,'ACTIVE_WFM_TRN_FORM_SUBMISSION_HISTORY_ID');      

/* --use this for WFM_TRAINING_FORM_SUBMISSIONS_ACTIVE if there is a field that can be used as unique/pk
INSERT INTO file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,derive_timestamp_stmt,file_day_received,current_table_name,current_table_primary_key,full_load_table_primary_key)
VALUES('WFM_TRAINING_FORM_SUBMISSIONS_ACTIVE','INEO_ACTIVE_WFM_TRAINING_FORM_SUBMISSIONS_HISTORY','INEO',
       'active_wfm_training_form_submission_id,comments,absence_type,date_of_absence,delete_record,emailed_submitted_form_for_absence,employee_id,employee_name,employee_status,filename,hours_missed,position_title,
reason_for_absence,region,submitted_employee_name,training_class_id',
      'TRIM(CONCAT(COALESCE(training_class_id,''NA''),TO_CHAR(TRY_CAST(date_of_absence AS DATE),''yyyymmdd''),REGEXP_REPLACE(UPPER(employee_id),''[^A-Za-z0-9]''))) active_wfm_training_form_submission_id,
comments,absence_type,TRY_CAST(date_of_absence AS DATE),delete_record,emailed__submitted_form_for_absence,employee_id,employee_name,employee_status,filename,TRY_CAST(hours_missed AS FLOAT),position_title,reason_for_absence,region,submitted_employee_name,training_class_id',
      'WHERE 1=1','Y', 'SELECT TO_CHAR(TO_TIMESTAMP(TRIM(SUBSTR(<filename>,LENGTH(<filename>)-13)),''yyyymmddhh24miss''),''mm/dd/yyyy hh24:mi:ss'') file_date,''Y'' with_timestamp FROM dual','PREVIOUS_BUSINESS_DAY',
      'INEO_ACTIVE_WFM_TRAINING_FORM_SUBMISSIONS','ACTIVE_WFM_TRAINING_FORM_SUBMISSION_ID','ACTIVE_WFM_TRN_FORM_SUBMISSION_HISTORY_ID');      */

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
VALUES('QUALITY_TASK_NOTIFICATIONS_ACTIVE','INEO_ACTIVE_QUALITY_TASK_NOTIFICATIONS_HISTORY','INEO',
'autonumber,comments,employee_id,employee_name,filename,fssa_email,fssa_id,genesys_i3_id,maximus_email,move_to_trash,position_title,qi_supervisor,qisc,record_id,region,regional_team_leads,regions_supporting,
scorecard,status,submission_date,submitted_employee_name,supervisor,task_sequence_number,time_zone,training_status',
'autonumber,comments,employee_id,employee_name,filename,fssa_email,fssa_id,genesys_i3_id,maximus_email,move_to_trash,position_title,qi_supervisor,qisc,record_id,region,regional_team_leads,regions_supporting,
scorecard,status,TRY_CAST(submission_date AS DATE),submitted_employee_name,supervisor,task_sequence_,time_zone,training_status',
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
      
DELETE FROM file_load_config_control;

INSERT INTO file_load_config_control(config_name,config_value,config_value_type,create_dt,update_dt)
VALUES('FILE_LOAD_START_TIME','06:30:00','D',current_timestamp(),current_timestamp());

INSERT INTO file_load_config_control(config_name,config_value,config_value_type,create_dt,update_dt)
VALUES('FILE_LOAD_END_TIME','23:30:00','D',current_timestamp(),current_timestamp());

--DELETE FROM file_load_check_lkup;
--INSERT INTO file_load_check_lkup(filename_prefix,file_check_query,error_message,is_active,create_dt,update_dt)
--VALUES();
