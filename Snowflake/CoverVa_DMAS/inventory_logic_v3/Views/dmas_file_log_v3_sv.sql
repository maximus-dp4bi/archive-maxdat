CREATE OR REPLACE VIEW PUBLIC.DMAS_FILE_LOG_SV
AS
SELECT file_id
  ,f.filename_prefix
  ,filename
  ,row_count
  ,file_date
  ,load_date
  ,load_status
  ,CASE WHEN cc3.config_value = 'Y' THEN cdc_v3_processed WHEN cc.config_value = 'Y' THEN cdc_v2_processed ELSE cdc_processed END cdc_processed
  ,CASE WHEN cc3.config_value = 'Y' THEN cdc_v3_processed_date WHEN cc.config_value = 'Y' THEN cdc_v2_processed_date ELSE cdc_processed_date END cdc_processed_date
  ,CASE WHEN cc3.config_value = 'Y' THEN use_in_v3_inventory WHEN cc.config_value = 'Y' THEN use_in_v2_inventory ELSE use_in_inventory END use_in_inventory
  ,l.use_in_inventory use_in_v1_inventory
  ,cdc_processed cdc_v1_processed
  ,cdc_processed_date cdc_v1_processed_date
  ,l.use_in_v2_inventory
  ,cdc_v2_processed
  ,cdc_v2_processed_date
  ,l.use_in_v3_inventory
  ,cdc_v3_processed
  ,cdc_v3_processed_date  
FROM coverva_dmas.dmas_file_log f
 JOIN coverva_dmas.dmas_file_load_lkup l ON f.filename_prefix = l.filename_prefix
 JOIN coverva_dmas.dmas_config_control cc ON cc.config_name = 'INVENTORY_V2_SWITCH'
 JOIN coverva_dmas.dmas_config_control cc3 ON cc3.config_name = 'INVENTORY_V3_SWITCH';
 