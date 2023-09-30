update cc_c_contact_queue
set unit_of_work_name='EBS_OUTBOUND'
,service_percent=0
,service_seconds=0
where queue_number=5020;

update cc_c_contact_queue
set unit_of_work_name='THS_OUTBOUND'
,service_percent=0
,service_seconds=0
where queue_number=5021;


update cc_c_contact_queue
set queue_type='Outbound'
,unit_of_work_name='CHIP_OUTBOUND'
,project_name='TX Enrollment Broker'
,program_name='CHIP'
where queue_number=5048;

update cc_c_contact_queue
set queue_type='Outbound'
,unit_of_work_name='CHIP_OUTBOUND_ENRL'
,project_name='TX Enrollment Broker'
,program_name='CHIP'
where queue_number=5077;

update cc_c_contact_queue
set queue_type='Outbound'
,unit_of_work_name='CHIP_OUTBOUND_ENRL'
,project_name='TX Enrollment Broker'
,program_name='CHIP'
where queue_number=5078;

update cc_c_contact_queue
set queue_type='Outbound'
,unit_of_work_name='CHIP_OUTBOUND_MI'
,project_name='TX Enrollment Broker'
,program_name='CHIP'
where queue_number=5079;

update cc_c_contact_queue
set queue_type='Outbound'
,unit_of_work_name='CHIP_OUTBOUND_MI'
,project_name='TX Enrollment Broker'
,program_name='CHIP'
where queue_number=5080;

update cc_c_contact_queue
set queue_type='Outbound'
,unit_of_work_name='CHIP_OUTBOUND_PMI'
,project_name='TX Enrollment Broker'
,program_name='CHIP'
where queue_number=5081;

update cc_c_contact_queue
set queue_type='Outbound'
,unit_of_work_name='CHIP_OUTBOUND_PMI'
,project_name='TX Enrollment Broker'
,program_name='CHIP'
where queue_number=5082;

update cc_c_contact_queue
set queue_type='Outbound'
,unit_of_work_name='CHIP_OUTBOUND_XFR'
,project_name='TX Enrollment Broker'
,program_name='CHIP'
where queue_number=5241;

update cc_c_contact_queue
set queue_type='Outbound'
,unit_of_work_name='CHIP_OUTBOUND_XFR'
,project_name='TX Enrollment Broker'
,program_name='CHIP'
where queue_number=5245;


INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('0.2.3','105','105_UPDATE_OUTBOUND_QUEUES_CC_C_CONTACT_QUEUE');

commit;