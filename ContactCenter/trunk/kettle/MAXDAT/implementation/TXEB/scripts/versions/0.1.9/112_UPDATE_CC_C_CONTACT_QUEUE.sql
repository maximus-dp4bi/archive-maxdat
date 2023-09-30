update cc_c_contact_queue
set project_name='TX Enrollment Broker'
where project_name='Enrollment Broker';

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('0.1.9','112','112_UPDATE_CC_C_CONTACT_QUEUE');

commit;