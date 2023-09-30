

update f_metric
set actual_value = null
where f_metric_id in (
  select f_metric_id
  from f_metric f
  inner join d_reporting_period rp on f.d_reporting_period_id = rp.d_reporting_period_id
  inner join d_metric_project mp on f.d_metric_project_id = mp.d_metric_project_id
  inner join d_project p on mp.d_project_id = p.d_project_id
  inner join d_metric_definition md on mp.d_metric_definition_id = md.d_metric_definition_id
  where project_name = 'NY HIX'
  and end_date = '08-FEB-2014'
  and md.name = 'Calls Arriving'
);
