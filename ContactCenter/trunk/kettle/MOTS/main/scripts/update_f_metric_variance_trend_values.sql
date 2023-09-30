/*

alter table f_metric
add (     
  ACTUAL_FORECAST_VARIANCE_FRMT NUMBER (1) , 
  ACTUAL_TREND_INDICATOR NUMBER (1) 
);
  
select 
  f_metric_id
  , end_date
  , project_name
  , md.name metric_name
  , actual_value
  , lag(actual_value, 1, 0) over (partition by f.d_metric_project_id order by rp.end_date) prev_actual
  , round(((actual_value - lag(actual_value, 1, 0) over (partition by f.d_metric_project_id order by rp.end_date))/actual_value), 2) pct_actual_change
  , ACTUAL_TREND_INIDICATOR
  , abs(round(((forecast_value-actual_value)/forecast_value), 2)) as actual_forecast_variance
  , actual_forecast_variance_frmt
from f_metric f
inner join d_reporting_period rp on f.d_reporting_period_id = rp.d_reporting_period_id
inner join d_metric_project mp on f.d_metric_project_id = mp.d_metric_project_id
inner join d_metric_definition md on mp.d_metric_definition_id = md.d_metric_definition_id
inner join d_project p on mp.d_project_id = p.d_project_id
  
  
     
*/

merge into f_metric f
using (
  select 
    f_metric_id
    , end_date
    , project_name
    , md.name metric_name
    , actual_value
    , lag(actual_value, 1, 0) over (partition by f.d_metric_project_id order by rp.end_date) prev_actual
    , round(((actual_value - lag(actual_value, 1, 0) over (partition by f.d_metric_project_id order by rp.end_date))/actual_value), 2) pct_actual_change
    , abs(round(((forecast_value-actual_value)/forecast_value), 2)) as actual_forecast_variance
  from f_metric f
  inner join d_reporting_period rp on f.d_reporting_period_id = rp.d_reporting_period_id
  inner join d_metric_project mp on f.d_metric_project_id = mp.d_metric_project_id
  inner join d_metric_definition md on mp.d_metric_definition_id = md.d_metric_definition_id
  inner join d_project p on mp.d_project_id = p.d_project_id
) t on (f.f_metric_id = t.f_metric_id)
when matched then update 
  set ACTUAL_FORECAST_VARIANCE_FRMT = case 
      when actual_forecast_variance < .1 then 3
      when actual_forecast_variance between .10 and .3 then 2
      when actual_forecast_variance > .3 then 1 end
  , ACTUAL_TREND_INDICATOR = case 
      when pct_actual_change < -.5 then 5
      when pct_actual_change between -.11 and -.5 then 4
      when pct_actual_change between -.1 and .1 then 3
      when pct_actual_change between .11 and .5 then 2
      when actual_forecast_variance > .5 then 1 end
;


