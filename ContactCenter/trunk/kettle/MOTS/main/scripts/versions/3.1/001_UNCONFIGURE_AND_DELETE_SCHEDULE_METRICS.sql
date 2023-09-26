
delete f_metric
where f_metric_id in (
  select f_metric_id
  from f_metric f
  inner join d_metric_project mp on f.d_metric_project_id = mp.d_metric_project_id
  where actual_value_provided_by = 'MAXDAT'
  and d_metric_definition_id in (
    select d_metric_definition_id
    from d_metric_definition
    where name in (
      'PLANNED_ABSENTEEISM_PERCENTAGE'
      ,'MAX_NUMBER_OF_AGENTS_SCHEDULED_TO_HANDLE_CONTACTS'
      ,'PLANNED_UNPAID_ABSENTEEISM_PERCENTAGE'
      ,'UNPLANNED_ABSENTEEISM_PERCENTAGE'
    )
  )
);


update d_metric_project
set actual_value_provided_by = 'Web', actual_eff_dt = NULL, updated_by = 'MAXDAT-2561'
where actual_value_provided_by = 'MAXDAT'
and d_metric_definition_id in (
  select d_metric_definition_id
  from d_metric_definition
  where name in (
    'PLANNED_ABSENTEEISM_PERCENTAGE'
    ,'MAX_NUMBER_OF_AGENTS_SCHEDULED_TO_HANDLE_CONTACTS'
    ,'PLANNED_UNPAID_ABSENTEEISM_PERCENTAGE'
    ,'UNPLANNED_ABSENTEEISM_PERCENTAGE'
  )
)
;


INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
	VALUES ('3.1','001','001_UNCONFIGURE_AND_DELETE_SCHEDULE_METRICS');

COMMIT;
