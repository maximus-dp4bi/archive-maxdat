--insert call types to CC_C_CONTACT_QUEUE


insert into CC_C_CONTACT_QUEUE (queue_number,queue_name,queue_type,service_percent,service_seconds,unit_of_work_name,project_name,program_name,region_name,state_name,province_name,district_name,country_name,record_eff_dt,record_end_dt) values (7127,'EB_INB_EN_StarPlus_Q','Inbound',null,null, 'STAR Plus NonFrew EN','TX Enrollment Broker','EB','Central','Texas','N/A','N/A','USA', to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'));
insert into CC_C_CONTACT_QUEUE (queue_number,queue_name,queue_type,service_percent,service_seconds,unit_of_work_name,project_name,program_name,region_name,state_name,province_name,district_name,country_name,record_eff_dt,record_end_dt) values (7131,'EB_INB_SP_StarPlus_Q','Inbound',null,null, 'STAR Plus NonFrew SP','TX Enrollment Broker','EB','Central','Texas','N/A','N/A','USA', to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'));
insert into CC_C_CONTACT_QUEUE (queue_number,queue_name,queue_type,service_percent,service_seconds,unit_of_work_name,project_name,program_name,region_name,state_name,province_name,district_name,country_name,record_eff_dt,record_end_dt) values (7136,'EB_Xfer_EN_StarPlus_Q','Inbound',null,null,'STAR Plus NonFrew EN','TX Enrollment Broker','EB','Central','Texas','N/A','N/A','USA', to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'));
insert into CC_C_CONTACT_QUEUE (queue_number,queue_name,queue_type,service_percent,service_seconds,unit_of_work_name,project_name,program_name,region_name,state_name,province_name,district_name,country_name,record_eff_dt,record_end_dt) values (7140,'EB_Xfer_SP_StarPlus_Q','Inbound',null,null,'STAR Plus NonFrew SP','TX Enrollment Broker','EB','Central','Texas','N/A','N/A','USA', to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'));

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('0.2.0','101','101_ADD_STARPLUS_QUEUES_TO_CC_C_CONTACT_QUEUE');

commit;
