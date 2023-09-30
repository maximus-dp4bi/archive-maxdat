
update d_metric_project set calculate_control_chart_ind = 'Y';

select * from d_control_chart_parameters;

-- delete d_control_chart_parameters;
-- update d_control_chart_parameters set parameter_eff_dt = '01-JAN-2015 12:00:00';



SELECT 
  S_PROJECT_REPORT_ID
 , D_PROJECT_ID
 , D_PROGRAM_ID
 , D_GEOGRAPHY_MASTER_ID
 , D_METRIC_DEFINITION_ID
 , D_REPORTING_PERIOD_ID
FROM S_PROJECT_REPORT PR
INNER JOIN S_METRIC M ON PR.S_PROJECT_REPORT_ID = M.S_ACTUALS_PROJECT_REPORT_ID
WHERE STATUS='Approved'
AND IS_ACTUALS_TREND_PROCESSED <> 'Y'
AND IS_ERROR <> 'Y';


select rp.end_date, project_name, f.d_metric_project_id, md.label, actual_value, ACTUAL_TREND_INDICATOR, ccp.UPPER_CONTROL_LIMIT, ccp.LOWER_CONTROL_LIMIT, ccp.UPPER_WARNING_LIMIT, ccp.LOWER_WARNING_LIMIT, ccp.CENTER_LINE, ccp.UCL_OF_SIGMA
from f_metric f
inner join d_metric_project mp on f.d_metric_project_id = mp.d_metric_project_id
inner join d_project prj on mp.d_project_id = prj.d_project_id
inner join d_metric_definition md on mp.d_metric_definition_id = md.d_metric_definition_id
inner join d_reporting_period rp on f.d_reporting_period_id = rp.d_reporting_period_id
inner join d_control_chart_parameters ccp on mp.d_metric_project_id = ccp.d_metric_project_id
where project_name = 'TX EB'
-- and md.name = 'Average Speed to Answer'
and rp.end_date = TO_DATE('06/13/2015', 'mm/dd/yyyy')
order by rp.end_date desc;

delete f_metric
where exists (
  select 1
  from f_metric f
  inner join d_metric_project mp on f.d_metric_project_id = mp.d_metric_project_id
  inner join d_reporting_period rp on f.d_reporting_period_id = rp.d_reporting_period_id
  where f_metric.f_metric_id = f.f_metric_id
  and mp.d_project_id = -1
  and rp.end_date = TO_DATE('06/13/2015', 'mm/dd/yyyy')
);

rollback;

select rp.end_date, project_name, md.label, actual_value, pr.status
from s_metric s
inner join s_project_report pr on s.s_actuals_project_report_id = pr.s_project_report_id
inner join d_project prj on pr.d_project_id = prj.d_project_id
inner join d_metric_definition md on s.d_metric_definition_id = md.d_metric_definition_id
inner join d_reporting_period rp on pr.d_reporting_period_id = rp.d_reporting_period_id
where project_name = 'TX EB'
and md.name = 'AB Rate'
-- and rp.end_date = TO_DATE('06/13/2015', 'mm/dd/yyyy')
order by rp.end_date desc;




