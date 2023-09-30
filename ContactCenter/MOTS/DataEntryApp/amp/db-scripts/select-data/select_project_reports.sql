-- retrieve metric values by actuals report
select 
  project_name
  , program_name
  , geography_name
  , end_date
  , actual_value
  , forecast_value
  , abs(round(1 - (forecast_value/actual_value), 3)) as pct_diff
  , actual_forecast_variance_frmt
  , approved
  , aproved_date
from
  s_metric m
  inner join s_project_report apr on m.s_actuals_project_report_id = apr.s_project_report_id
  inner join d_reporting_period rp on apr.d_reporting_period_id = rp.d_reporting_period_id
  inner join d_project prj on apr.d_project_id = prj.d_project_id
  inner join d_program prg on apr.d_program_id = prg.d_program_id
  inner join d_geography_master geo on apr.d_geography_master_id = geo.d_geography_master_id
order by 
  project_name
  , program_name
  , geography_name
  , end_date
 ; 
 
 -- retrieve metric values by forecasts report
select 
  project_name
  , program_name
  , geography_name
  , end_date
  , actual_value
  , forecast_value
  , abs(round(1 - (forecast_value/actual_value), 3)) as pct_diff
  , actual_forecast_variance_frmt
  , approved
  , aproved_date
from
  s_metric m
  inner join s_project_report fpr on m.s_forecasts_project_report_id = fpr.s_project_report_id
  inner join d_reporting_period rp on fpr.d_reporting_period_id = rp.d_reporting_period_id
  inner join d_project prj on fpr.d_project_id = prj.d_project_id
  inner join d_program prg on fpr.d_program_id = prg.d_program_id
  inner join d_geography_master geo on fpr.d_geography_master_id = geo.d_geography_master_id
order by 
  project_name
  , program_name
  , geography_name
  , end_date
 ; 
  