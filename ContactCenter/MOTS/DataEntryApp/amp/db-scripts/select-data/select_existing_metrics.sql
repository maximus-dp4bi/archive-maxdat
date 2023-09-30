
select distinct 
  -- rp.end_date,
  project_name
  , program_name
  , md.name metric_name
from f_metric f
inner join d_metric_project mp on f.d_metric_project_id = mp.d_metric_project_id
inner join d_project prj on mp.d_project_id = prj.d_project_id
inner join d_program prg on mp.d_program_id = prg.d_program_id
inner join d_reporting_period rp on f.d_reporting_period_id = rp.d_reporting_period_id
inner join d_metric_definition md on mp.d_metric_definition_id = md.d_metric_definition_id
where actual_value is not null
and project_name like 'IL%'
order by 
  --rp.end_date desc, 
  project_name
  , md.name;
  
  
select distinct project_name, metric
from s_metric_template smt
where smt.ACTUAL_VALUE is not null
order by project_name
;




