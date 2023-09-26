INSERT INTO file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,derive_timestamp_stmt,file_day_received,current_table_name,current_table_primary_key,full_load_table_primary_key)
SELECT CASE WHEN filename_prefix = 'AD_HOC_PSID_SUBMISSIONS' THEN 'PROV_AD_HOC_PSID_SUBMISSIONS'
        WHEN filename_prefix = 'ALL_STAFF_ROSTER' THEN 'SMS_ALL_STAFF_ROSTER'        
        WHEN filename_prefix = 'CALLER_ESCALATIONS' THEN 'RCC_CALLER_ESCALATIONS' 
        WHEN filename_prefix = 'CLIENT_COMPLAINTS' THEN 'RCC_CLIENT_COMPLAINTS'
        WHEN filename_prefix = 'DFR_DIRECTIVES' THEN 'RCC_DFR_DIRECTIVES'
        WHEN filename_prefix = 'NEW_HIRE_PSID_SUBMISSIONS' THEN 'PROV_NEW_HIRE_PSID_SUBMISSIONS'
        WHEN filename_prefix = 'PIONEER_TEAM_COMS_LOG_ACTIVE' THEN 'PT_COMS_LOG'
        WHEN filename_prefix = 'PIONEER_TEAM_STAFF_ROSTER' THEN 'PT_PIONEER_TEAM_STAFF_ROSTER'
        WHEN filename_prefix = 'PRODUCTION_UNSCHEDULED_ABSENCES_ACTIVE' THEN 'WFM_PRODUCTION_UNSCHEDULED_ABSENCES'
        WHEN filename_prefix = 'PROVISIONING_STAFF_ROSTER' THEN 'PROV_PROVISIONING_STAFF_ROSTER'
        WHEN filename_prefix = 'QUALITY_STAFF_ROSTER' THEN 'QUAL_QUALITY_STAFF_ROSTER'
        WHEN filename_prefix = 'QUALITY_TASK_NOTIFICATIONS_ACTIVE' THEN 'QUAL_TASK_NOTIFICATIONS'
        WHEN filename_prefix = 'TIME_OFF_REQUESTS_ACTIVE' THEN 'WFM_TIME_OFF_REQUESTS'
        WHEN filename_prefix = 'TRAINING_NEW_HIRE_CLASS_TRACKER' THEN 'TRAIN_NEW_HIRE_CLASS_TRACKER'
        WHEN filename_prefix = 'TRAINING_NEW_HIRE_EXAM_TRACKER_ACTIVE' THEN 'TRAIN_NEW_HIRE_EXAM_TRACKER'
        WHEN filename_prefix = 'TRAINING_STAFF_ROSTER_ACTIVE_RECORDS' THEN 'TRAIN_TRAINING_STAFF_ROSTER'
        WHEN filename_prefix = 'TRAINING_UNSCHEDULED_ABSENCES_ACTIVE' THEN 'WFM_TRAINING_UNSCHEDULED_ABSENCES'
        WHEN filename_prefix = 'WFM_STAFF_ROSTER' THEN 'WFM_WFM_STAFF_ROSTER'
        WHEN filename_prefix = 'WFM_TRAINING_FORM_SUBMISSIONS_ACTIVE' THEN 'WFM_WFM_TRAINING_FORM_SUBMISSIONS'
      ELSE filename_prefix END new_filename_prefix,
full_load_table_name,
full_load_table_schema,
insert_fields,select_fields,
where_clause,
load_file,
derive_timestamp_stmt,
file_day_received,
current_table_name,
current_table_primary_key,
full_load_table_primary_key
FROM file_load_lkup
WHERE load_file = 'Y'
AND filename_prefix IN('AD_HOC_PSID_SUBMISSIONS','ALL_STAFF_ROSTER','CALLER_ESCALATIONS','CLIENT_COMPLAINTS','DFR_DIRECTIVES',
                          'NEW_HIRE_PSID_SUBMISSIONS','PIONEER_TEAM_COMS_LOG_ACTIVE','PIONEER_TEAM_STAFF_ROSTER','PRODUCTION_UNSCHEDULED_ABSENCES_ACTIVE',
                          'PROVISIONING_STAFF_ROSTER','QUALITY_STAFF_ROSTER','QUALITY_TASK_NOTIFICATIONS_ACTIVE','TIME_OFF_REQUESTS_ACTIVE','TRAINING_NEW_HIRE_CLASS_TRACKER','TRAINING_NEW_HIRE_EXAM_TRACKER_ACTIVE',
                          'TRAINING_STAFF_ROSTER_ACTIVE_RECORDS','TRAINING_UNSCHEDULED_ABSENCES_ACTIVE','WFM_STAFF_ROSTER','WFM_TRAINING_FORM_SUBMISSIONS_ACTIVE');  

                 
UPDATE file_load_lkup
SET load_file = 'N'
WHERE filename_prefix  IN('AD_HOC_PSID_SUBMISSIONS','ALL_STAFF_ROSTER','CALLER_ESCALATIONS','CLIENT_COMPLAINTS','DFR_DIRECTIVES',
                          'NEW_HIRE_PSID_SUBMISSIONS','PIONEER_TEAM_COMS_LOG_ACTIVE','PIONEER_TEAM_STAFF_ROSTER','PRODUCTION_UNSCHEDULED_ABSENCES_ACTIVE',
                          'PROVISIONING_STAFF_ROSTER','QUALITY_STAFF_ROSTER','QUALITY_TASK_NOTIFICATIONS_ACTIVE','TIME_OFF_REQUESTS_ACTIVE','TRAINING_NEW_HIRE_CLASS_TRACKER','TRAINING_NEW_HIRE_EXAM_TRACKER_ACTIVE',
                          'TRAINING_STAFF_ROSTER_ACTIVE_RECORDS','TRAINING_UNSCHEDULED_ABSENCES_ACTIVE','WFM_STAFF_ROSTER','WFM_TRAINING_FORM_SUBMISSIONS_ACTIVE');   

ALTER TABLE ineo_client_complaints add (complaint_conclusion VARCHAR);
ALTER TABLE ineo_client_complaints_history add (complaint_conclusion VARCHAR);                          

update file_load_lkup
set insert_fields ='civil_rights_sub_type,client_region,collection_region,complaint_id,complaint_type,eligibility_programs_sub_type,employee_id,employee_name,filename,follow_up_completed,follow_up_recommended,notes,rccccc,submitted_by,submitted_to_state,task_call_id,complaint_date,complaint_conclusion',
  select_fields = 'civil_rights_sub_type,client_region,collection_region,complaint_id,complaint_type,eligibility_programs_sub_type,employee_id,employee_name,filename,follow_up_completed,follow_up_recommended,notes,rccccc,submitted_by,submitted_to_state,task___call_id,
TO_DATE(TRIM(SUBSTR(REGEXP_REPLACE(complaint_id,''CLCO-'',''''),1,REGEXP_INSTR(REGEXP_REPLACE(complaint_id,''CLCO-'',''''),''-'')-1)),''YYYYMMDD'') complaint_date,complaint_conclusion'
where filename_prefix = 'RCC_CLIENT_COMPLAINTS';                          
         
                          
                          
delete from file_load_log
where filename = 'AGENTPERFORMANCE04042023_20230405110409';

delete from ineo_agent_performance_history
where upper(filename) = 'AGENTPERFORMANCE04042023_20230405110409';

UPDATE file_load_log
SET load_date = dateadd(HOUR,-11,load_date)
WHERE upper(filename) IN('RCC055_DFR_DIRECTIVES20230413122232','RCC054_CLIENT_COMPLAINTS20230413122203','PROV063_PROVISIONING_STAFF_ROSTER20230413122309','WFM064_WFM_TRAINING_FORM_SUBMISSIONS20230413122420'
                         ,'TRAIN069_NEW_HIRE_EXAM_TRACKER20230413122357','TRAIN054_TRAINING_STAFF_ROSTER20230413122339');



UPDATE INEO_CLIENT_COMPLAINTS_HISTORY
SET sf_create_ts = dateadd(HOUR,-11,sf_create_ts)
WHERE upper(filename) IN('RCC054_CLIENT_COMPLAINTS20230413122203');

UPDATE INEO_DFR_DIRECTIVES_BY_REGION_HISTORY
SET sf_create_ts = dateadd(HOUR,-11,sf_create_ts)
WHERE upper(filename) IN('RCC055_DFR_DIRECTIVES20230413122232');

UPDATE INEO_DFR_DIRECTIVES_BY_REGION
SET sf_create_ts = dateadd(HOUR,-11,sf_create_ts)
WHERE cast(sf_create_ts as date) = current_date();

UPDATE INEO_PROVISIONING_STAFF_ROSTER_HISTORY
SET sf_create_ts = dateadd(HOUR,-11,sf_create_ts)
WHERE upper(filename) IN('PROV063_PROVISIONING_STAFF_ROSTER20230413122309');
  
UPDATE INEO_ACTIVE_WFM_TRAINING_FORM_SUBMISSIONS_HISTORY
SET sf_create_ts = dateadd(HOUR,-11,sf_create_ts)
WHERE upper(filename) IN('WFM064_WFM_TRAINING_FORM_SUBMISSIONS20230413122420');  

UPDATE INEO_ACTIVE_TRAINING_NEWHIRE_EXAM_TRACKER_HISTORY
SET sf_create_ts = dateadd(HOUR,-11,sf_create_ts)
WHERE upper(filename) IN('TRAIN069_NEW_HIRE_EXAM_TRACKER20230413122357');
    
UPDATE INEO_ACTIVE_TRAINING_STAFF_ROSTER_HISTORY
SET sf_create_ts = dateadd(HOUR,-11,sf_create_ts)
WHERE upper(filename) IN('TRAIN054_TRAINING_STAFF_ROSTER20230413122339');
                          