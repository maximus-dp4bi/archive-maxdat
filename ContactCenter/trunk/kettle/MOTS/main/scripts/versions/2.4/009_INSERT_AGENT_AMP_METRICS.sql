-- insert agent metrics into D_METRIC_DEFINITION

-- agents on payroll metric
insert into d_metric_definition (d_data_type_id, name, type, category, value_type, status, has_target, has_forecast, is_calculated, functional_area,
	record_eff_dt, record_end_dt, label, sort_order, sub_category, display_format, has_actual, is_weekly, is_monthly)
values (2, 'MAX_NUMBER_OF_AGENTS_ON_PAYROLL', 'Corporate Standard', 'Staff Level', 'Decimal', 'Active', 'N', 'N', 'N', 'Contact Center', 
	to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2199/12/31', 'yyyy/mm/dd'), 'Max Number of Agents on Payroll', 31, 'Staff Level', 'Default', 'Y', 'Y', 'Y');

-- number of agents attritted metric
insert into d_metric_definition (d_data_type_id, name, type, category, value_type, status, has_target, has_forecast, is_calculated, functional_area,
	record_eff_dt, record_end_dt, label, sort_order, sub_category, display_format, has_actual, is_weekly, is_monthly)
values (2, 'NUMBER_OF_SKILLED_AGENTS_ATTRITTED', 'Corporate Standard', 'Staff Level', 'Decimal', 'Active', 'N', 'N', 'N', 'Contact Center', 
	to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2199/12/31', 'yyyy/mm/dd'), 'Number of Skilled Agents Attritted', 31, 'Staff Level', 'Default', 'Y', 'Y', 'Y');

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('2.4','009','009_INSERT_AGENT_AMP_METRICS');

COMMIT;