insert into d_geography_master(geography_name, country_id,state_id,province_id,district_id,region_id)
values('California',1,5,0,0,3);

insert into d_program(program_name)
values ('HCO - Rancho');

INSERT INTO d_project(project_name, d_division_id)
VALUES('HCO',3);

INSERT INTO d_metric_project(d_project_id, d_program_id,d_geography_master_id,d_metric_definition_id,record_eff_dt
,record_end_dt,actual_eff_dt, forecast_eff_dt,actual_value_provided_by,forecast_value_provided_by,calculate_control_chart_ind,trend_indicator_calculation)
SELECT 61,61,61,d_metric_definition_id,record_eff_dt,record_end_dt,actual_eff_dt,forecast_eff_dt,actual_value_provided_by,
forecast_value_provided_by,calculate_control_chart_ind,trend_indicator_calculation
FROM d_metric_project
WHERE d_project_id = 41
and d_metric_definition_id not in (19,21,4,10);

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
	VALUES ('2.12','001','001_insert_metric_definition_ca_hco');
commit;