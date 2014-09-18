update cc_c_contact_queue
set queue_type='Inbound'
,unit_of_work_name='STAR Plus NonFrew EN'
,project_name='TX Enrollment Broker'
,program_name='EB'
,province_name='N/A'
,district_name='N/A'
where queue_number=7127;

update cc_c_contact_queue
set queue_type='Inbound'
,unit_of_work_name='STAR Plus NonFrew SP'
,project_name='TX Enrollment Broker'
,program_name='EB'
,province_name='N/A'
,district_name='N/A'
where queue_number=7131;


update cc_c_contact_queue
set queue_type='Inbound'
,unit_of_work_name='STAR Plus NonFrew EN'
,project_name='TX Enrollment Broker'
,program_name='EB'
,province_name='N/A'
,district_name='N/A'
where queue_number=7136;

update cc_c_contact_queue
set queue_type='Inbound'
,unit_of_work_name='STAR Plus NonFrew SP'
,project_name='TX Enrollment Broker'
,program_name='EB'
,province_name='N/A'
,district_name='N/A'
where queue_number=7140;


INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('0.2.0','108','108_UPDATE_STARPLUS_QUEUES_CC_C_CONTACT_QUEUE');

commit;