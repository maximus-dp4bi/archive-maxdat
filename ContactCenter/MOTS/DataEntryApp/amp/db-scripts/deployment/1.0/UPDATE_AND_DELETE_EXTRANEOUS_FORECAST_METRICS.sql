
-- delete any metric records that have a null forecast value,
-- a null actual value, a null actuals report
-- and whose project is not configured to deliver a forecast 
-- for a given metric def
delete s_metric
where s_metric_id in (
  select m.s_metric_id
  from s_metric m 
  inner join s_project_report pr on m.s_forecasts_project_report_id = pr.s_project_report_id
  inner join d_reporting_period rp on pr.d_reporting_period_id = rp.d_reporting_period_id
  inner join d_metric_project mp 
    on m.d_metric_definition_id = mp.d_metric_definition_id 
    and pr.d_project_id = mp.d_project_id
    and pr.d_program_id = mp.d_program_id
  where pr.report_type = 'forecasts' 
  and mp.forecast_eff_dt is null
  and m.s_actuals_project_report_id is null
  and m.forecast_value is null
  and m.actual_value is null
)
;

-- update any metric records that have a null forecast value,
-- and whose project is not configured to deliver a forecast 
-- for a given metric def and set the forecast report id to null
-- so that it doesn't show up on the forecast report
update s_metric
set s_forecasts_project_report_id = null
where s_metric_id in (
  select m.s_metric_id
  from s_metric m 
  inner join s_project_report pr on m.s_forecasts_project_report_id = pr.s_project_report_id
  inner join d_reporting_period rp on pr.d_reporting_period_id = rp.d_reporting_period_id
  inner join d_metric_project mp 
    on m.d_metric_definition_id = mp.d_metric_definition_id 
    and pr.d_project_id = mp.d_project_id
    and pr.d_program_id = mp.d_program_id
  where pr.report_type = 'forecasts' 
  and mp.forecast_eff_dt is null
  and m.forecast_value is null
);

INSERT INTO CC_L_PATCH_LOG(PATCH_VERSION, SCRIPT_SEQUENCE, SCRIPT_NAME, SCRIPT_RUN_DATE) VALUES ('AMP-DC-1.0', 24, 'UPDATE_AND_DELETE_EXTRANEOUS_FORECAST_METRICS.sql', SYSDATE);

COMMIT;