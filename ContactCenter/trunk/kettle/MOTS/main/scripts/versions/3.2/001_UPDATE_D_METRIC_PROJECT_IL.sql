
update d_metric_project
set actual_value_provided_by = 'AUTO_LOAD'
where d_metric_project_id in (
  select d_metric_project_id
  from d_project p 
  inner join d_metric_project mp on p.d_project_id = mp.d_project_id
  inner join d_metric_definition md on mp.d_metric_definition_id = md.d_metric_definition_id
  where project_name like 'IL%'
  and md.name in (
    'MAX_NUMBER_OF_AGENTS_IN_TRAINING'
    , 'FTE Count'
    , 'NUMBER_OF_SKILLED_AGENTS_ATTRITTED'    
  )
)
;


INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME)
VALUES ('3.2.0','001','001_UPDATE_D_METRIC_PROJECT_IL');

COMMIT;


