UPDATE coverva_dmas.dmas_file_load_lkup
SET file_day_received = 'SAME_DAY'
WHERE filename_prefix IN('APPMETRIC_PW','APPMETRIC');

update coverva_dmas.dmas_config_control
set config_value = '15:30:00'
where config_name = 'INVENTORY_CDC_START_TIME';

update coverva_dmas.dmas_config_control
set config_value = '18:30:00'
where config_name = 'INVENTORY_CDC_TIME';