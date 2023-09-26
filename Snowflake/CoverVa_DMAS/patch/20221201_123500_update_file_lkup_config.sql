
update coverva_dmas.dmas_file_load_lkup
set select_fields = regexp_replace(select_fields,'application_number','REGEXP_REPLACE(application_number,''[^A-Za-z0-9]'','''')')   
where filename_prefix = 'APPMETRIC_PW';

update coverva_dmas.dmas_file_load_lkup
set select_fields = regexp_replace(select_fields,'app_number','REGEXP_REPLACE(app_number,''[^A-Za-z0-9]'','''')')   
where filename_prefix = 'APPMETRIC';

update coverva_dmas.dmas_file_load_lkup
set select_fields = regexp_replace(select_fields,'trackingnum','REGEXP_REPLACE(trackingnum,''[^A-Za-z0-9]'','''')')   
where filename_prefix = 'CPUREPORT';

update coverva_dmas.dmas_file_load_lkup
set select_fields = regexp_replace(select_fields,'trackingnum','REGEXP_REPLACE(trackingnum,''[^A-Za-z0-9]'','''')')   
where filename_prefix = 'CPUREPORT_YESTERDAY';

update coverva_dmas.dmas_file_load_lkup
set select_fields = regexp_replace(select_fields,'trknum','REGEXP_REPLACE(trknum,''[^A-Za-z0-9]'','''')')   
where filename_prefix = 'CPUREPORT_TRNS_YESTERDAY';

update coverva_dmas.dmas_file_load_lkup
set select_fields = regexp_replace(select_fields,'tracking_','REGEXP_REPLACE(tracking_,''[^A-Za-z0-9]'','''')')   
where filename_prefix = 'CM_044';

update coverva_dmas.dmas_file_load_lkup
set select_fields =  regexp_replace(select_fields,'tracking_','REGEXP_REPLACE(tracking_,''[^A-Za-z0-9]'','''')')   
where filename_prefix = 'CM_043';

update coverva_dmas.dmas_file_load_lkup
set select_fields = 'CAST(regexp_replace(date_received,''[^A-Za-z0-9 -:/*]'','''') AS DATE) AS date_received,TRIM(CASE WHEN LENGTH(t_number) > 10 THEN SUBSTR(REGEXP_REPLACE(t_number,''[^A-Za-z0-9]'',''''),1,REGEXP_INSTR(t_number,''[^A-Za-z0-9]'')-1) ELSE REGEXP_REPLACE(t_number,''[^A-Za-z0-9]'','''') END) t_number,TRIM(COALESCE(CASE WHEN LENGTH(t_number) > 10  THEN SUBSTR(t_number,REGEXP_INSTR(t_number,''[^A-Za-z0-9]'')) ELSE NULL END,switch)) switch,source,name,processing_unit,program,assigned_to,locality,processing_status,filename'
where filename_prefix = 'CPU_I_INVENTORY'; 

update coverva_dmas.dmas_file_load_lkup
set select_fields = 'CAST(regexp_replace(date_received,''[^A-Za-z0-9 -:/*]'','''') AS DATE) AS date_received,TRIM(CASE WHEN LENGTH(t_number) > 10 THEN SUBSTR(REGEXP_REPLACE(t_number,''[^A-Za-z0-9]'',''''),1,REGEXP_INSTR(t_number,''[^A-Za-z0-9]'')-1) ELSE REGEXP_REPLACE(t_number,''[^A-Za-z0-9]'','''') END) t_number,TRIM(COALESCE(CASE WHEN LENGTH(t_number) > 10  THEN SUBSTR(t_number,REGEXP_INSTR(t_number,''[^A-Za-z0-9]'')) ELSE NULL END,switch)) switch,source,name,processing_unit,program,assigned_to,locality,processing_status,filename'
where filename_prefix = 'CVIU_INVENTORY'; 

update coverva_dmas.dmas_file_load_lkup
set select_fields = 'TRIM(REGEXP_REPLACE(t,''[^A-Za-z0-9 ]'','''')),source,CASE WHEN LENGTH(app_received_date) > 8 THEN TRY_TO_DATE(app_received_date,''mm/dd/yyyy'') ELSE TRY_TO_DATE(app_received_date,''mm/dd/yy'') END AS app_received_date,unit,type,in_cp,current_state, CASE WHEN LENGTH(initial_review_complete_date) > 8 THEN TRY_TO_DATE(initial_review_complete_date,''mm/dd/yyyy'') ELSE TRY_TO_DATE(initial_review_complete_date,''mm/dd/yy'') END AS initrvwdt,CASE WHEN LENGTH(end_date) > 8 THEN TRY_TO_DATE(end_date,''mm/dd/yyyy'') ELSE TRY_TO_DATE(end_date,''mm/dd/yy'') END AS end_date,last_employee,CASE WHEN LENGTH(recent_submission_date) > 8 THEN TRY_TO_DATE(recent_submission_date,''mm/dd/yyyy'') ELSE TRY_TO_DATE(recent_submission_date,''mm/dd/yy'') END AS recent_submission_date,submitter,filename'
where filename_prefix = 'RUNNING_MASTER_OVERRIDE';

update coverva_dmas.dmas_file_load_lkup
set select_fields = 'REGEXP_REPLACE(application_,''[^A-Za-z0-9]'',''''),case_,applicant,CAST(regexp_replace(application_receivedscreening_date,''[^A-Za-z0-9 -:/*]'','''') AS DATE) AS application_received_date,worker_processing_unit,locality,programs,delay,no_of_days_pending,worker_id,filename,interview_held_date,worker_name,stage,application_source,CAST(regexp_replace(vcl_due_date,''[^A-Za-z0-9 -:/*]'','''') AS DATE) AS vcl_due_date,_of_days_app_held_before_transfer,entity_that_transferred_app,indicator,minimal_information,extend_pend_performed,expedited_snap,resource_assessment_only,snap_expedited_ppv_application,snap_expedited_ppv_case,ppv_overdue__nonexpedited'
where filename_prefix = 'PPIT';