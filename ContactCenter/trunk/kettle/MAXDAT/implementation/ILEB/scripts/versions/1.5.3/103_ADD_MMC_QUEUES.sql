insert into CC_C_CONTACT_QUEUE (queue_number,queue_name,queue_type,service_percent,service_seconds,unit_of_work_name,project_name,program_name,region_name,state_name,province_name,district_name,country_name,record_eff_dt,record_end_dt, interval_minutes) 
values (10087,'MMC Inbound English','Inbound',0,0,'MMC English','IL EB','EB','Central','Illinois','Unknown','Unknown','USA', to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'),15);

insert into CC_C_CONTACT_QUEUE (queue_number,queue_name,queue_type,service_percent,service_seconds,unit_of_work_name,project_name,program_name,region_name,state_name,province_name,district_name,country_name,record_eff_dt,record_end_dt, interval_minutes) 
values (10088,'MMC Outbound English','Outbound',0,0,'EB Outbound','IL EB','EB','Central','Illinois','Unknown','Unknown','USA', to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'),15);

insert into CC_C_CONTACT_QUEUE (queue_number,queue_name,queue_type,service_percent,service_seconds,unit_of_work_name,project_name,program_name,region_name,state_name,province_name,district_name,country_name,record_eff_dt,record_end_dt, interval_minutes) 
values (10089,'MMC Outbound Spanish','Outbound',0,0,'EB Outbound','IL EB','EB','Central','Illinois','Unknown','Unknown','USA', to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'),15);

insert into CC_C_CONTACT_QUEUE (queue_number,queue_name,queue_type,service_percent,service_seconds,unit_of_work_name,project_name,program_name,region_name,state_name,province_name,district_name,country_name,record_eff_dt,record_end_dt, interval_minutes) 
values (10090,'MMC Inbound Spanish','Inbound',0,0,'MMC Spanish','IL EB','EB','Central','Illinois','Unknown','Unknown','USA', to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'),15);

insert into cc_c_unit_of_work(unit_of_work_name,record_eff_dt,record_end_dt,unit_of_work_category)values('MMC English',to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'),'INBOUND_CALL');
insert into cc_c_unit_of_work(unit_of_work_name,record_eff_dt,record_end_dt,unit_of_work_category)values('MMC Spanish',to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'),'INBOUND_CALL');


insert into cc_d_unit_of_work(unit_of_work_name,production_plan_id,hourly_flag, handle_time_unit,unit_of_work_category)
values('MMC English',	0,	'N',	'Seconds','INBOUND_CALL');

insert into cc_d_unit_of_work(unit_of_work_name,production_plan_id,hourly_flag, handle_time_unit,unit_of_work_category)
values('MMC Spanish',	0,	'N',	'Seconds','INBOUND_CALL');

insert into cc_c_filter(filter_type,value) values('ACD_SKILL_GROUP_INC','10101');
insert into cc_c_filter(filter_type,value) values('ACD_SKILL_GROUP_INC','10102');
insert into cc_c_filter(filter_type,value) values('ACD_SKILL_GROUP_INC','10103');
insert into cc_c_filter(filter_type,value) values('ACD_SKILL_GROUP_INC','10104');


insert into cc_c_filter(filter_type,value) values('ACD_APPLICATION_ID_INC','10087');
insert into cc_c_filter(filter_type,value) values('ACD_APPLICATION_ID_INC','10088');
insert into cc_c_filter(filter_type,value) values('ACD_APPLICATION_ID_INC','10089');
insert into cc_c_filter(filter_type,value) values('ACD_APPLICATION_ID_INC','10090');

insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values('ACD_SKILLSET_PROGRAM','10101','EB');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values('ACD_SKILLSET_PROGRAM','10102','EB');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values('ACD_SKILLSET_PROGRAM','10103','EB');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values('ACD_SKILLSET_PROGRAM','10104','EB');

insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values('ACD_SKILLSET_PROJECT','10101','IL EB');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values('ACD_SKILLSET_PROJECT','10102','IL EB');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values('ACD_SKILLSET_PROJECT','10103','IL EB');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values('ACD_SKILLSET_PROJECT','10104','IL EB');

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('1.0.3','103','103_ADD_MMC_QUEUES');

commit;


