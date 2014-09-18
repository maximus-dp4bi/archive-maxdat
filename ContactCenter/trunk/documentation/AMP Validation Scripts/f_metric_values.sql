
select 
  rp.type reporting_period_type
  , rp.end_date
  , project_name
  , md.label metric_label
  -- , mp.actual_eff_dt
  , f.actual_value
  -- , mp.forecast_eff_dt
  , f.forecast_value
  , forecast_comments
  , f.create_date
  , f.*
from f_metric f
inner join d_metric_project mp on f.d_metric_project_id = mp.d_metric_project_id
inner join d_metric_definition md on mp.d_metric_definition_id = md.d_metric_definition_id
inner join d_project p on mp.d_project_id = p.d_project_id
inner join d_program pg on mp.d_program_id = pg.d_program_id
inner join d_reporting_period rp on f.d_reporting_period_id = rp.d_reporting_period_id
where 
rp.type = 'WEEKLY' and
--rp.type = 'MONTHLY' and 
project_name = 'IL EB' --'IL EEV'
and end_date = '05-APR-2014' -- or end_date = '31-MAR-2014')
order by rp.type, rp.end_date, project_name, md.sort_order;


