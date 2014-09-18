update cc_c_project_config
set project_name='TX Enrollment Broker'
where project_name='Enrollment Broker';

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
values ('0.1.9','109','109_UPDATE_CC_C_PROJ_CONFIG');

commit;