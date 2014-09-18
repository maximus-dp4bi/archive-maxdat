-- this script deletes fact/dimension records tied to unknown projects and programs

-- fact table records
delete
from cc_f_agent_activity_by_date
where (d_program_id = 0 
	or d_project_id = 0);

delete
from cc_f_agent_by_date
where d_project_targets_id = 0
	or d_program_id = 0;
	
delete
from f_metric fm
where fm.d_metric_project_id in (select d_metric_project_id
								from d_metric_project
								where d_project_id = 0
									or d_program_id = 0);

-- corresponding dimensional table records
delete
from d_metric_project
where d_project_id = 0
	or d_program_id = 0;

delete
from cc_d_agent
where d_project_id = 0
  and d_agent_id <> 0;


INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
	VALUES ('2.11','002','002_DELETE_UNKNOWN_FACT_RECORDS');

COMMIT;