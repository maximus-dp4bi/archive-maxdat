-- wipe CCO - Boise and Brownsville AB Rate and ASA metrics
update d_metric_project
set actual_eff_dt = NULL 
where d_metric_project_id in (
  select d_metric_project_id
  from d_metric_project mp
  inner join d_project p on mp.d_project_id = p.d_project_id
  inner join d_metric_definition md on mp.d_metric_definition_id = md.d_metric_definition_id
  where project_name in ('CCO - Boise', 'CCO - Brownsville')
  and md.name in ('AB Rate', 'ASA')
);

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
	VALUES ('2.7','006','006_UPDATE_D_METRIC_PROJECT_EFF_DATES');

commit;