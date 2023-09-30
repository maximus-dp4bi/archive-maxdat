insert into cc_c_contact_queue (queue_number, queue_name, queue_type, service_percent,service_seconds, interval_minutes,unit_of_work_name, project_name,program_name, region_name,state_name, province_name, district_name,country_name)
values(10037,'OMB_Eng_s','Inbound',0,30,15,'COEEMAP Inbound','COEEMAP','MEDICAID','West','Colorado','Unknown','Unknown','USA');
insert into cc_c_contact_queue (queue_number, queue_name, queue_type, service_percent,service_seconds, interval_minutes,unit_of_work_name, project_name,program_name, region_name,state_name, province_name, district_name,country_name)
values(10038,'OMB_Spn_s','Inbound',0,30,15,'COEEMAP Inbound','COEEMAP','MEDICAID','West','Colorado','Unknown','Unknown','USA');
insert into cc_c_contact_queue (queue_number, queue_name, queue_type, service_percent,service_seconds, interval_minutes,unit_of_work_name, project_name,program_name, region_name,state_name, province_name, district_name,country_name)
values(10039,'FML_Eng_s','Inbound',0,30,15,'COEEMAP Inbound','COEEMAP','MEDICAID','West','Colorado','Unknown','Unknown','USA');
insert into cc_c_contact_queue (queue_number, queue_name, queue_type, service_percent,service_seconds, interval_minutes,unit_of_work_name, project_name,program_name, region_name,state_name, province_name, district_name,country_name)
values(10040,'FML_Spn_s','Inbound',0,30,15,'COEEMAP Inbound','COEEMAP','MEDICAID','West','Colorado','Unknown','Unknown','USA');
insert into cc_c_contact_queue (queue_number, queue_name, queue_type, service_percent,service_seconds, interval_minutes,unit_of_work_name, project_name,program_name, region_name,state_name, province_name, district_name,country_name)
values(10041,'CHP_Eng_s','Inbound',0,30,15,'COEEMAP Inbound','COEEMAP','MEDICAID','West','Colorado','Unknown','Unknown','USA');
insert into cc_c_contact_queue (queue_number, queue_name, queue_type, service_percent,service_seconds, interval_minutes,unit_of_work_name, project_name,program_name, region_name,state_name, province_name, district_name,country_name)
values(10042,'CHP_Spn_s','Inbound',0,30,15,'COEEMAP Inbound','COEEMAP','MEDICAID','West','Colorado','Unknown','Unknown','USA');
insert into cc_c_contact_queue (queue_number, queue_name, queue_type, service_percent,service_seconds, interval_minutes,unit_of_work_name, project_name,program_name, region_name,state_name, province_name, district_name,country_name)
values(10043,'PAC_Eng_s','Inbound',0,30,15,'COEEMAP Inbound','COEEMAP','MEDICAID','West','Colorado','Unknown','Unknown','USA');
insert into cc_c_contact_queue (queue_number, queue_name, queue_type, service_percent,service_seconds, interval_minutes,unit_of_work_name, project_name,program_name, region_name,state_name, province_name, district_name,country_name)
values(10044,'PAC_Spn_s','Inbound',0,30,15,'COEEMAP Inbound','COEEMAP','MEDICAID','West','Colorado','Unknown','Unknown','USA');


insert into cc_c_filter (filter_type,value) values('ACD_APPLICATION_ID_INC', 10037);
insert into cc_c_filter (filter_type,value) values('ACD_APPLICATION_ID_INC', 10038);
insert into cc_c_filter (filter_type,value) values('ACD_APPLICATION_ID_INC', 10039);
insert into cc_c_filter (filter_type,value) values('ACD_APPLICATION_ID_INC', 10040);
insert into cc_c_filter (filter_type,value) values('ACD_APPLICATION_ID_INC', 10041);
insert into cc_c_filter (filter_type,value) values('ACD_APPLICATION_ID_INC', 10042);
insert into cc_c_filter (filter_type,value) values('ACD_APPLICATION_ID_INC', 10043);
insert into cc_c_filter (filter_type,value) values('ACD_APPLICATION_ID_INC', 10044);

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('1.1.0','102','102_UPDATE_CONTACT_QUEUES');

commit;