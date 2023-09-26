
delete f_metric
where f_metric_id in (
  select f_metric_id
  from f_metric f
  inner join d_metric_project mp on f.d_metric_project_id = mp.d_metric_project_id
  inner join d_project p on mp.d_project_id = p.d_project_id
  inner join d_reporting_period rp on f.d_reporting_period_id = rp.d_reporting_period_id
  inner join d_metric_definition md on mp.d_metric_definition_id = md.d_metric_definition_id
  where actual_value is not null
  and (project_name like 'IL%' or project_name like 'TX%')
  and md.name in (
    'PLANNED_ABSENTEEISM_PERCENTAGE'
    ,'MAX_NUMBER_OF_AGENTS_SCHEDULED_TO_HANDLE_CONTACTS'
    ,'PLANNED_UNPAID_ABSENTEEISM_PERCENTAGE'
    ,'UNPLANNED_ABSENTEEISM_PERCENTAGE'
  )
)
;


INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
	VALUES ('3.1','006','006_DELETE_SCHEDULE_METRICS');

COMMIT;