ALTER TABLE coverva_dmas.dmas_application ADD(cm044_verified VARCHAR(3),non_maximus_initial_date TIMESTAMP_NTZ(9),non_maximus_returned_date TIMESTAMP_NTZ(9));
ALTER TABLE coverva_dmas.dmas_application_current ADD(cm044_verified VARCHAR(3),non_maximus_initial_date TIMESTAMP_NTZ(9),non_maximus_returned_date TIMESTAMP_NTZ(9));

INSERT INTO coverva_dmas.dmas_config_control(config_name,config_value,config_value_type,create_dt,update_dt)
VALUES('INVENTORY_BYPASS_MISSING_FILES','N','V',current_timestamp(),current_timestamp());
