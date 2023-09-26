
UPDATE coverva_dmas.dmas_file_load_lkup
SET select_fields = 'TRIM(CASE WHEN LENGTH(application_) > 10 THEN SUBSTR(application_,1,REGEXP_INSTR(application_,'' '')-1) ELSE application_ END),case_,applicant,CAST(regexp_replace(app_received_date,''[^A-Za-z0-9 -:/*]'','''') AS DATE) AS application_received_date,worker_ldss,locality,programs,delay,no_of_days_pending,worker_id,filename'
WHERE filename_prefix = 'PPIT';

UPDATE coverva_dmas.dmas_file_load_lkup
SET select_fields = 'CAST(regexp_replace(date_received,''[^A-Za-z0-9 -:/*]'','''') AS DATE) AS date_received,TRIM(CASE WHEN LENGTH(t_number) > 10 THEN SUBSTR(t_number,1,REGEXP_INSTR(t_number,'' '')-1) ELSE t_number END) t_number,TRIM(COALESCE(CASE WHEN LENGTH(t_number) > 10  THEN SUBSTR(t_number,REGEXP_INSTR(t_number,'' '')) ELSE NULL END,switch)) switch,source,name,processing_unit,program,assigned_to,locality,processing_status,filename'
WHERE filename_prefix = 'CPU_I_INVENTORY';


UPDATE coverva_dmas.dmas_file_load_lkup
SET select_fields = 'CAST(regexp_replace(date_received,''[^A-Za-z0-9 -:/*]'','''') AS DATE) AS date_received,TRIM(CASE WHEN LENGTH(t_number) > 10 THEN SUBSTR(t_number,1,REGEXP_INSTR(t_number,'' '')-1) ELSE t_number END) t_number,TRIM(COALESCE(CASE WHEN LENGTH(t_number) > 10  THEN SUBSTR(t_number,REGEXP_INSTR(t_number,'' '')) ELSE NULL END,switch)) switch,source,name,processing_unit,program,assigned_to,locality,processing_status,filename'
WHERE filename_prefix ='CVIU_INVENTORY';

UPDATE coverva_dmas.dmas_application_current c
SET tracking_number = trim(case when length(c.tracking_number) > 10 then substr(c.tracking_number,1,regexp_instr(c.tracking_number,' ')-1) else tracking_number end)
WHERE length(c.tracking_number) > 10;

UPDATE coverva_dmas.dmas_application c
SET tracking_number = trim(case when length(c.tracking_number) > 10 then substr(c.tracking_number,1,regexp_instr(c.tracking_number,' ')-1) else tracking_number end)
WHERE length(c.tracking_number) > 10;

UPDATE coverva_dmas.dmas_application_event c
SET tracking_number = trim(case when length(c.tracking_number) > 10 then substr(c.tracking_number,1,regexp_instr(c.tracking_number,' ')-1) else tracking_number end)
WHERE length(c.tracking_number) > 10;

UPDATE coverva_dmas.dmas_excluded_application c
SET tracking_number = trim(case when length(c.tracking_number) > 10 then substr(c.tracking_number,1,regexp_instr(c.tracking_number,' ')-1) else tracking_number end)
WHERE length(c.tracking_number) > 10;

UPDATE coverva_dmas.cpu_incarcerated_full_load c
SET tracking_number = trim(case when length(c.tracking_number) > 10 then substr(c.tracking_number,1,regexp_instr(c.tracking_number,' ')-1) else tracking_number end)
  ,switch = TRIM(COALESCE(CASE WHEN LENGTH(c.tracking_number) > 10  THEN SUBSTR(c.tracking_number,REGEXP_INSTR(c.tracking_number,' ')) ELSE NULL END,switch)) 
WHERE length(c.tracking_number) > 10;

UPDATE coverva_dmas.ppit_data_full_load c
SET tracking_number = trim(case when length(c.tracking_number) > 10 then substr(c.tracking_number,1,regexp_instr(c.tracking_number,' ')-1) else tracking_number end)  
WHERE length(c.tracking_number) > 10;
