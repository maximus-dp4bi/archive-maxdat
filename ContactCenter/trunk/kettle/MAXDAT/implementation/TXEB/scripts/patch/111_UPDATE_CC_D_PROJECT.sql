update cc_d_project
set project_name='TX Enrollment Broker'
where project_name='Enrollment Broker';

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('0.1.9','111','111_UPDATE_CC_D_PROJECT');

commit;