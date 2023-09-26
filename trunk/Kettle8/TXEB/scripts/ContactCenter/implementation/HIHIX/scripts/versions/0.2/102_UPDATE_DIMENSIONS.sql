

update cc_d_project
set project_name = 'HI HIX'
where project_name = 'HIHIX';

update cc_c_project_config
set project_name = 'HI HIX'
where project_name = 'HIHIX';

update cc_c_contact_queue
set project_name = 'HI HIX'
where project_name = 'HIHIX';


update cc_d_agent
set middle_initial = 'Unknown'
, last_name = 'Unknown'
, job_title = 'Unknown'
, language = 'Unknown'
, site_name = 'Unknown'
where first_name = 'HIHIX Agents';


INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('0.2','102','102_UPDATE_DIMENSIONS');

COMMIT;
