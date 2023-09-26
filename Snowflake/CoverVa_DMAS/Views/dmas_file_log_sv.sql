CREATE OR REPLACE VIEW PUBLIC.DMAS_FILE_LOG_SV
AS
SELECT file_id
  ,f.filename_prefix
  ,filename
  ,row_count
  ,file_date
  ,load_date
  ,load_status
  ,cdc_processed
  ,cdc_processed_date  
  ,l.use_in_inventory
FROM coverva_dmas.dmas_file_log f
 JOIN coverva_dmas.dmas_file_load_lkup l ON f.filename_prefix = l.filename_prefix;
 
CREATE OR REPLACE VIEW PUBLIC.dmas_alert_log_sv AS
SELECT alert_log_id
       ,alert_message
       ,filename
       ,create_dt       
FROM coverva_dmas.dmas_alert_log
WHERE is_active = 'Y';