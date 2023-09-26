alter table coverva_dmas.dmas_application_current add(Case_Type VARCHAR,SD_Stage VARCHAR);
alter table coverva_dmas.dmas_application add(Case_Type VARCHAR,SD_Stage VARCHAR);
alter table coverva_dmas.dmas_application_event add(Case_Type VARCHAR,SD_Stage VARCHAR);
ALTER TABLE coverva_dmas.cm043_data_full_load ADD(application_type VARCHAR);

UPDATE coverva_dmas.dmas_file_load_lkup
SET insert_fields = 'source,name,address,locality,filename,date_received,processing_status,tracking_number,application_type',
select_fields = 'source,name,address,locality,filename,CASE WHEN LENGTH(date_received) > 8 THEN TRY_TO_DATE(date_received,''mm/dd/yyyy'') ELSE TRY_TO_DATE(date_received,''mm/dd/yy'') END AS date_received,processing_status,REGEXP_REPLACE(tracking_,''[^A-Za-z0-9]'',''''),application_type'
WHERE filename_prefix = 'CM_043';