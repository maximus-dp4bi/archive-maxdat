alter session set current_schema=MOTS;
update d_metric_project set record_end_dt='31-DEC-2199 12:00:00 AM'
where d_project_id=(select d_project_id from d_project where project_name='HCO');

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
	VALUES ('2.12','003','003_update_metric_definition_ca_hco');
  
 commit;