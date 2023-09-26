update file_load_lkup
set load_file = 'N'
where filename_prefix IN('PRIVACY_INCIDENT_TRACKER','R_TASKS_CREATED_PRIOR_DAY_','AGENTS_AVAILABILITY');
