ALTER TABLE coverva_dmas.dmas_file_load_lkup ADD(file_day_received VARCHAR);

UPDATE coverva_dmas.dmas_file_load_lkup
SET file_day_received = 'SAME_DAY'
WHERE filename_prefix NOT IN('CM_044','CM_043','APPMETRIC_PW','APPMETRIC');

UPDATE coverva_dmas.dmas_file_load_lkup
SET file_day_received = 'PREVIOUS_BUSINESS_DAY'
WHERE filename_prefix IN('APPMETRIC_PW','APPMETRIC');

UPDATE coverva_dmas.dmas_file_load_lkup
SET file_day_received = 'PREVIOUS_DAY'
WHERE filename_prefix IN('CM_044','CM_043');

update coverva_dmas.dmas_config_control
set config_value = '06:30:00'
where config_name = 'INVENTORY_CDC_START_TIME';

update coverva_dmas.dmas_config_control
set config_value = '09:30:00'
where config_name = 'INVENTORY_CDC_TIME';