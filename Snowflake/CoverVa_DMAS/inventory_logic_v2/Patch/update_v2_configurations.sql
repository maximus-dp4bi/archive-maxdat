ALTER TABLE coverva_dmas.dmas_file_log ADD(cdc_v2_processed VARCHAR DEFAULT 'N',cdc_v2_processed_date TIMESTAMP_NTZ(9));
ALTER TABLE coverva_dmas.dmas_file_load_lkup ADD(use_in_v2_inventory VARCHAR);

INSERT INTO coverva_dmas.dmas_config_control(config_name,config_value,config_value_type,create_dt,update_dt)
VALUES('INVENTORY_V2_FILE_DATE','03/09/2023','D',current_timestamp(),current_timestamp());

INSERT INTO coverva_dmas.dmas_config_control(config_name,config_value,config_value_type,create_dt,update_dt)
VALUES('INVENTORY_V2_SWITCH','N','V',current_timestamp(),current_timestamp());

UPDATE coverva_dmas.dmas_file_load_lkup
SET use_in_v2_inventory = 'Y'
WHERE use_in_inventory = 'Y'
AND filename_prefix not in('APPMETRIC','APPMETRIC_PW');

UPDATE coverva_dmas.dmas_file_load_lkup
SET use_in_v2_inventory = 'N'
WHERE use_in_inventory = 'N';

UPDATE coverva_dmas.dmas_file_load_lkup
SET use_in_v2_inventory = 'N'
WHERE filename_prefix in('APPMETRIC','APPMETRIC_PW');

UPDATE coverva_dmas.dmas_file_load_lkup
SET use_in_inventory = 'N'
WHERE filename_prefix in('APPMETRIC_REPORT');

UPDATE dmas_file_log da
SET cdc_v2_processed = cdc_processed,cdc_v2_processed_date = cdc_processed_date
FROM(SELECT d.file_id
     FROM dmas_file_log d
      JOIN dmas_file_load_lkup l on d.filename_prefix = l.filename_prefix
     WHERE l.use_in_inventory = 'Y') d
WHERE da.file_id = d.file_id;