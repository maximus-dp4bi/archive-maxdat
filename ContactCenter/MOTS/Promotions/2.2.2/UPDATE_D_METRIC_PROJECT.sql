
update d_metric_project
set forecast_eff_dt = NULL
where d_metric_project_id in (
  select d_metric_project_id
  from d_metric_project mp
  inner join d_metric_definition m on mp.d_metric_definition_id = m.d_metric_definition_id
  inner join d_project p on mp.d_project_id = p.d_project_id
  where project_name = 'CCO - Brownsville'
  and m.name in (
    'Calls Arriving'
    , 'Calls Offered'
    , 'AB Rate'
    , 'ASA'
  )
);

update d_metric_project 
set actual_eff_dt = NULL, forecast_eff_dt = NULL 
where d_metric_project_id = ( 
  select d_metric_project_id 
  from d_metric_project mp 
  inner join d_metric_definition m on mp.d_metric_definition_id = m.d_metric_definition_id 
  inner join d_project p on mp.d_project_id = p.d_project_id 
  where project_name = 'VT HIX' 
  and m.name = 'FTE Count' 

); 

commit;

