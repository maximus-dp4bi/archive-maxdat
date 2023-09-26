UPDATE coverva_dmas.dmas_file_load_lkup
SET select_fields = 'application_,case_,applicant,CAST(regexp_replace(app_received_date,''[^A-Za-z0-9 -:/*]'','''') AS DATE) AS application_received_date,worker_ldss,locality,programs,delay,no_of_days_pending,worker_id,filename'
WHERE filename_prefix = 'PPIT';

UPDATE coverva_dmas.dmas_file_load_lkup
SET select_fields = 'CAST(regexp_replace(date_received,''[^A-Za-z0-9 -:/*]'','''') AS DATE) AS date_received,t_number,switch,source,name,processing_unit,program,assigned_to,locality,processing_status,filename'
WHERE filename_prefix = 'CPU_I_INVENTORY';

UPDATE coverva_dmas.dmas_file_load_lkup
SET select_fields = 'CAST(regexp_replace(date_received,''[^A-Za-z0-9 -:/*]'','''') AS DATE) AS date_received,t_number,switch,source,name,processing_unit,program,assigned_to,locality,processing_status,filename'
WHERE filename_prefix ='CVIU_INVENTORY';