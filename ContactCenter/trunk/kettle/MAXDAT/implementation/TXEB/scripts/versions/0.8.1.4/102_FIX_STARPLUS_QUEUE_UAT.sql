delete from cc_c_contact_queue 
where queue_number in (7127,7131,7136,7140)
and project_name='TX Eligibility Support';

update cc_c_contact_queue
set service_percent=0
,service_seconds=0
where queue_number in (7127,7131,7136,7140)
and project_name='TX Enrollment Broker';


update cc_c_contact_queue set QUEUE_TYPE='Inbound',UNIT_OF_WORK_NAME='N/A',PROJECT_NAME='TX Enrollment Broker',PROGRAM_NAME='EB',PROVINCE_NAME='N/A',DISTRICT_NAME='N/A' where QUEUE_NUMBER=7124;
update cc_c_contact_queue set QUEUE_TYPE='Inbound',UNIT_OF_WORK_NAME='N/A',PROJECT_NAME='TX Enrollment Broker',PROGRAM_NAME='EB',PROVINCE_NAME='N/A',DISTRICT_NAME='N/A' where QUEUE_NUMBER=7125;
update cc_c_contact_queue set QUEUE_TYPE='Inbound',UNIT_OF_WORK_NAME='N/A',PROJECT_NAME='TX Enrollment Broker',PROGRAM_NAME='EB',PROVINCE_NAME='N/A',DISTRICT_NAME='N/A' where QUEUE_NUMBER=7126;

update cc_c_contact_queue set QUEUE_TYPE='Inbound',UNIT_OF_WORK_NAME='N/A',PROJECT_NAME='TX Enrollment Broker',PROGRAM_NAME='EB',PROVINCE_NAME='N/A',DISTRICT_NAME='N/A' where QUEUE_NUMBER=7128;
update cc_c_contact_queue set QUEUE_TYPE='Inbound',UNIT_OF_WORK_NAME='N/A',PROJECT_NAME='TX Enrollment Broker',PROGRAM_NAME='EB',PROVINCE_NAME='N/A',DISTRICT_NAME='N/A' where QUEUE_NUMBER=7129;
update cc_c_contact_queue set QUEUE_TYPE='Inbound',UNIT_OF_WORK_NAME='N/A',PROJECT_NAME='TX Enrollment Broker',PROGRAM_NAME='EB',PROVINCE_NAME='N/A',DISTRICT_NAME='N/A' where QUEUE_NUMBER=7130;

update cc_c_contact_queue set QUEUE_TYPE='Inbound',UNIT_OF_WORK_NAME='N/A',PROJECT_NAME='TX Enrollment Broker',PROGRAM_NAME='EB',PROVINCE_NAME='N/A',DISTRICT_NAME='N/A' where QUEUE_NUMBER=7132;
update cc_c_contact_queue set QUEUE_TYPE='Inbound',UNIT_OF_WORK_NAME='N/A',PROJECT_NAME='TX Enrollment Broker',PROGRAM_NAME='EB',PROVINCE_NAME='N/A',DISTRICT_NAME='N/A' where QUEUE_NUMBER=7147;
update cc_c_contact_queue set QUEUE_TYPE='Inbound',UNIT_OF_WORK_NAME='N/A',PROJECT_NAME='TX Enrollment Broker',PROGRAM_NAME='EB',PROVINCE_NAME='N/A',DISTRICT_NAME='N/A' where QUEUE_NUMBER=7143;
update cc_c_contact_queue set QUEUE_TYPE='Inbound',UNIT_OF_WORK_NAME='N/A',PROJECT_NAME='TX Enrollment Broker',PROGRAM_NAME='EB',PROVINCE_NAME='N/A',DISTRICT_NAME='N/A' where QUEUE_NUMBER=7144;
update cc_c_contact_queue set QUEUE_TYPE='Inbound',UNIT_OF_WORK_NAME='N/A',PROJECT_NAME='TX Enrollment Broker',PROGRAM_NAME='EB',PROVINCE_NAME='N/A',DISTRICT_NAME='N/A' where QUEUE_NUMBER=7146;
update cc_c_contact_queue set QUEUE_TYPE='Inbound',UNIT_OF_WORK_NAME='N/A',PROJECT_NAME='TX Enrollment Broker',PROGRAM_NAME='EB',PROVINCE_NAME='N/A',DISTRICT_NAME='N/A' where QUEUE_NUMBER=7145;
update cc_c_contact_queue set QUEUE_TYPE='Inbound',UNIT_OF_WORK_NAME='N/A',PROJECT_NAME='TX Enrollment Broker',PROGRAM_NAME='EB',PROVINCE_NAME='N/A',DISTRICT_NAME='N/A' where QUEUE_NUMBER=7086;
update cc_c_contact_queue set QUEUE_TYPE='Inbound',UNIT_OF_WORK_NAME='N/A',PROJECT_NAME='TX Enrollment Broker',PROGRAM_NAME='EB',PROVINCE_NAME='N/A',DISTRICT_NAME='N/A' where QUEUE_NUMBER=7087;
update cc_c_contact_queue set QUEUE_TYPE='Inbound',UNIT_OF_WORK_NAME='N/A',PROJECT_NAME='TX Enrollment Broker',PROGRAM_NAME='EB',PROVINCE_NAME='N/A',DISTRICT_NAME='N/A' where QUEUE_NUMBER=7133;
update cc_c_contact_queue set QUEUE_TYPE='Inbound',UNIT_OF_WORK_NAME='N/A',PROJECT_NAME='TX Enrollment Broker',PROGRAM_NAME='EB',PROVINCE_NAME='N/A',DISTRICT_NAME='N/A' where QUEUE_NUMBER=7134;
update cc_c_contact_queue set QUEUE_TYPE='Inbound',UNIT_OF_WORK_NAME='N/A',PROJECT_NAME='TX Enrollment Broker',PROGRAM_NAME='EB',PROVINCE_NAME='N/A',DISTRICT_NAME='N/A' where QUEUE_NUMBER=7135;

update cc_c_contact_queue set QUEUE_TYPE='Inbound',UNIT_OF_WORK_NAME='N/A',PROJECT_NAME='TX Enrollment Broker',PROGRAM_NAME='EB',PROVINCE_NAME='N/A',DISTRICT_NAME='N/A' where QUEUE_NUMBER=7137;
update cc_c_contact_queue set QUEUE_TYPE='Inbound',UNIT_OF_WORK_NAME='N/A',PROJECT_NAME='TX Enrollment Broker',PROGRAM_NAME='EB',PROVINCE_NAME='N/A',DISTRICT_NAME='N/A' where QUEUE_NUMBER=7138;
update cc_c_contact_queue set QUEUE_TYPE='Inbound',UNIT_OF_WORK_NAME='N/A',PROJECT_NAME='TX Enrollment Broker',PROGRAM_NAME='EB',PROVINCE_NAME='N/A',DISTRICT_NAME='N/A' where QUEUE_NUMBER=7139;



delete from cc_f_actuals_queue_interval
where d_contact_queue_id in (select d_contact_queue_id from cc_d_contact_queue where queue_number in (7127,7131,7136,7140));

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('0.1.8.4','102','102_FIX_STARPLUS_QUEUE_UAT');

commit;