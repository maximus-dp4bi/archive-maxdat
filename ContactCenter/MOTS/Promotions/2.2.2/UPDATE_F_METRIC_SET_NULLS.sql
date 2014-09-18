/*
CCO Brownsville for 3/22:
-	NA for Forecast Calls Arriving 
-	NA for Forecast Calls Offered 
-	NA for Forecast AB rate
-	NA for Forecast ASA
*/

update f_metric 
set forecast_value = NULL
where f_metric_id in (
  select f_metric_id
  from f_metric f
  inner join d_metric_project mp on f.d_metric_project_id = mp.d_metric_project_id
  inner join d_metric_definition m on mp.d_metric_definition_id = m.d_metric_definition_id
  inner join d_project p on mp.d_project_id = p.d_project_id
  inner join d_reporting_period rp on f.d_reporting_period_id = rp.d_reporting_period_id
  where rp.end_date = '22-MAR-2014'
  and project_name = 'CCO - Brownsville'
  and m.name in (
    'Calls Arriving'
    , 'Calls Offered'
    , 'AB Rate'
    , 'ASA'
  )
);

/*
CT HIX for 3/22:
-	NS for Actual Calls Arriving
-	NS for Forecast Calls Arriving
*/

update f_metric 
set actual_value = NULL
where f_metric_id = (
  select f_metric_id
  from f_metric f
  inner join d_metric_project mp on f.d_metric_project_id = mp.d_metric_project_id
  inner join d_metric_definition m on mp.d_metric_definition_id = m.d_metric_definition_id
  inner join d_project p on mp.d_project_id = p.d_project_id
  inner join d_reporting_period rp on f.d_reporting_period_id = rp.d_reporting_period_id
  where rp.end_date = '22-MAR-2014'
  and project_name = 'CT HIX'
  and m.name in (
    'Calls Arriving'
  )
);

update f_metric 
set forecast_value = NULL
where f_metric_id = (
  select f_metric_id
  from f_metric f
  inner join d_metric_project mp on f.d_metric_project_id = mp.d_metric_project_id
  inner join d_metric_definition m on mp.d_metric_definition_id = m.d_metric_definition_id
  inner join d_project p on mp.d_project_id = p.d_project_id
  inner join d_reporting_period rp on f.d_reporting_period_id = rp.d_reporting_period_id
  where rp.end_date = '22-MAR-2014'
  and project_name = 'CT HIX'
  and m.name in (
    'Calls Arriving'
  )
);


/*
VT HIX for 3/22
-	NA for Actual FTE Count
-	NA for Forecast FTE Count
*/

update f_metric 
set actual_value = NULL
where f_metric_id = (
  select f_metric_id
  from f_metric f
  inner join d_metric_project mp on f.d_metric_project_id = mp.d_metric_project_id
  inner join d_metric_definition m on mp.d_metric_definition_id = m.d_metric_definition_id
  inner join d_project p on mp.d_project_id = p.d_project_id
  inner join d_reporting_period rp on f.d_reporting_period_id = rp.d_reporting_period_id
  where rp.end_date = '22-MAR-2014'
  and project_name = 'VT HIX'
  and m.name in (
    'FTE Count'
  )
);

update f_metric 
set forecast_value = NULL
where f_metric_id = (
  select f_metric_id
  from f_metric f
  inner join d_metric_project mp on f.d_metric_project_id = mp.d_metric_project_id
  inner join d_metric_definition m on mp.d_metric_definition_id = m.d_metric_definition_id
  inner join d_project p on mp.d_project_id = p.d_project_id
  inner join d_reporting_period rp on f.d_reporting_period_id = rp.d_reporting_period_id
  where rp.end_date = '22-MAR-2014'
  and project_name = 'VT HIX'
  and m.name in (
    'FTE Count'
  )
);
