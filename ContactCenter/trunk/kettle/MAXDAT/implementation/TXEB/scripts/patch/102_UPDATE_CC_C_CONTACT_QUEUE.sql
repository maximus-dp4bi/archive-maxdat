update cc_c_contact_queue
set project_name='TX Enrollment Broker'
where queue_number in (5083,5099);

update cc_c_contact_queue
set program_name='CHIP'
where queue_number=5083;

update cc_c_contact_queue
set program_name='CHIP'
where queue_number=5099;

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
values ('0.2.6','102','102_UPDATE_CC_C_CONTACT_QUEUE');

commit;