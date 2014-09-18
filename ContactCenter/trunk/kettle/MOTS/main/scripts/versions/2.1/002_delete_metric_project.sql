
delete from f_metric
where exists (
  select f.f_metric_id
  from f_metric f
  inner join d_metric_project mp on f.d_metric_project_id = mp.d_metric_project_id
  inner join d_metric_definition m on mp.d_metric_definition_id = m.d_metric_definition_id
  inner join d_project p on mp.d_project_id = p.d_project_id
  where project_name like 'CCO%'
  and m.name in ('ASA', 'AB Rate')
  and f.f_metric_id = f_metric.f_metric_id
);


delete from d_metric_project
where exists (
  select mp.d_metric_project_id
  from d_metric_project mp
  inner join d_metric_definition m on mp.d_metric_definition_id = m.d_metric_definition_id
  inner join d_project p on mp.d_project_id = p.d_project_id
  where project_name like 'CCO%'
  and m.name in ('ASA', 'AB Rate')
  and mp.d_metric_project_id = d_metric_project.d_metric_project_id
);

