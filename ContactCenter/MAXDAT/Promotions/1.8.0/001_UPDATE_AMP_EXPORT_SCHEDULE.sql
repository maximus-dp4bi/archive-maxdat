-- delete the latest AMP export scheduled record to reset the scheduled execution
delete
from cc_a_scheduled_job
where scheduled_job_id = (select max(scheduled_job_id)
                          from cc_a_scheduled_job
                          where scheduled_job_type = 'flatten_project_facts');

						  
INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('1.8.0','001','001_UPDATE_AMP_EXPORT_SCHEDULE');

COMMIT;