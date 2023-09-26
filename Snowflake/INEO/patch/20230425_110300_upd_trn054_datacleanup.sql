DELETE FROM ineo_queue_daily_summary_history
where upper(filename) in('INEOQUEUEDAILYSUMMARY04172023_20230418110428');

DELETE FROM ineo_queue_summary_history
where upper(filename) in('INEOQUEUESUMMARY04172023_20230418110426');

DELETE FROM file_load_log
where upper(filename) in('INEOQUEUESUMMARY04172023_20230418110426','INEOQUEUEDAILYSUMMARY04172023_20230418110428');

ALTER TABLE INEO_ACTIVE_TRAINING_STAFF_ROSTER ADD(fssa_email VARCHAR);
ALTER TABLE INEO_ACTIVE_TRAINING_STAFF_ROSTER_HISTORY ADD(fssa_email VARCHAR);

UPDATE file_load_lkup
SET insert_fields = 'active_training_staff_roster_id,average_cpc_training_exam_score,conduent_trainer,department,employee_id,employee_name,employee_status,filename,manager,maximus_co_facilitator,maximus_email,maximus_facilitator,nesting_end_date,nesting_start_date,
personal_email,position_title,previous_stateconduent_employee,psid_form_submission,region,send_welcome_email,staffing_agency,time_zone,training_class_id,training_end_date,training_hours_missed,training_start_date,
training_status,transition_team_lead,fssa_email',
select_fields = 'CONCAT(COALESCE(training_class_id,''NA''),COALESCE(TO_CHAR(TRY_CAST(training_start_date AS DATE),''yyyymmdd''),''NA''),COALESCE(TO_CHAR(TRY_CAST(training_end_date AS DATE),''yyyymmdd''),''NA''),employee_id) active_training_staff_roster_id,
TRY_CAST(average_cpc_training_exam_score AS FLOAT),conduent_trainer,department,employee_id,employee_name,employee_status,filename,manager,maximus_co_facilitator,maximus_email,maximus_facilitator,
TRY_CAST(nesting_end_date AS DATE),TRY_CAST(nesting_start_date AS DATE),personal_email,position_title,previous_stateconduent_employee,psid_form_submission,region,send_welcome_email,staffing_agency,
time_zone,training_class_id,TRY_CAST(training_end_date AS DATE),training_hours_missed,TRY_CAST(training_start_date AS DATE),training_status,transition_team_lead,fssa_email'
WHERE filename_prefix = 'TRAIN_TRAINING_STAFF_ROSTER';

UPDATE file_load_lkup
SET select_fields = 'filename,TRY_CAST(task_id AS NUMBER) task_id,task_name,work_queue_name,task_status,assigned_to,user_type,user_primary_office,CASE WHEN REGEXP_INSTR(task_created_date,''/'') > 0 THEN TO_TIMESTAMP_NTZ(task_created_date,''MM/DD/YYYY HH12:MI:SS AM'') ELSE TO_TIMESTAMP_NTZ(task_created_date,''MON DD"," YYYY HH12:MI:SS AM'') END,task_created_by'
WHERE filename_prefix = 'R_TASKS_CREATED_PRIOR_DAY_';

--update R5 report - task created date not populating

