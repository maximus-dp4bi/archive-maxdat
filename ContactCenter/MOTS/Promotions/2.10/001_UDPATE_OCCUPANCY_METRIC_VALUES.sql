-- update existing Occupancy metrics only loaded from ETL
merge into f_metric fm
  using (
    select dmp.d_metric_project_id, drp.d_reporting_period_id, trunc(100 * (sum(fabd.handle_time_seconds)/(sum(fabd.handle_time_seconds) + sum(fabd.idle_seconds))), 6) as Occupancy
    from cc_f_agent_by_date fabd
    inner join cc_d_dates dd
      on fabd.d_date_id = dd.d_date_id
    inner join cc_d_project_targets dpt
      on fabd.d_project_targets_id = dpt.d_project_targets_id
    inner join d_project dp
      on dp.d_project_id = dpt.project_id
    inner join d_metric_definition dmd
      on dmd.name = 'Occupancy'
    inner join d_metric_project dmp
      on (dmp.d_metric_definition_id = dmd.d_metric_definition_id and dmp.d_project_id = dp.d_project_id and dmp.d_program_id = fabd.d_program_id and dmp.d_geography_master_id = fabd.d_geography_master_id)
    inner join d_reporting_period drp
      on (dd.d_date >= drp.start_date and dd.d_date <= drp.end_date)
    where handle_time_seconds <> 0
    group by dmp.d_metric_project_id, dmd.d_metric_definition_id, drp.d_reporting_period_id, dp.d_project_id, fabd.d_program_id, fabd.d_geography_master_id) a
  on (fm.d_metric_project_id = a.d_metric_project_id and fm.d_reporting_period_id = a.d_reporting_period_id)
  when matched then update set fm.actual_value = a.Occupancy;

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
	VALUES ('2.10','001','001_UPDATE_OCCUPANCY_METRIC_VALUES');

COMMIT;