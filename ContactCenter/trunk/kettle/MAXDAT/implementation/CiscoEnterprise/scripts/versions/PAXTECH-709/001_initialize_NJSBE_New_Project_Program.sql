alter session set current_schema = cisco_enterprise_cc;

/* Completed as a part of PAXTECH-469

--Project and Program

insert into cc_c_project_config (project_name, program_name, region_name, state_name, province_name, district_name, country_name, record_eff_dt, record_end_dt)
values ('New Jersey State Based Exchange', 'Get Covered New Jersey', 'Eastern', 'New Jersey', 'Unknown', 'Unknown', 'USA', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));

insert into cc_d_project (project_id, project_name, segment_id, include_in_reports_flag) values (SEQ_CC_D_PROJECT.nextval, 'New Jersey State Based Exchange', 2, 1 );

insert into cc_d_project_targets (d_project_targets_id, project_id, version, average_handle_time_target, utilization_target, cost_per_call_target, occupancy_target, labor_cost_per_call_target, record_eff_dt, record_end_dt)
values (SEQ_CC_D_PROJECT_TARGETS.nextval, (select project_id from cc_d_project where project_name = 'New Jersey State Based Exchange'), 1, 0, 0, 0, 0, 0, to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));

insert into cc_d_program (program_id, program_name, include_in_reports_flag) values (SEQ_CC_D_PROGRAM.nextval, 'Get Covered New Jersey', 1 );

insert into cc_d_state (state_name) values ('New Jersey');

insert into cc_d_geography_master (geography_master_id, geography_name, country_id, state_id, province_id, district_id, region_id)
values (SEQ_CC_D_GEOGRAPHY_MASTER.nextval, 'New Jersey', (select country_id from cc_d_country where country_name = 'USA'), (select state_id from cc_d_state where state_name = 'New Jersey'), 0, 0, (select region_id from cc_d_region where region_name = 'Eastern'));

commit;

*/


-- Units of work

insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('BNA Consumer Assistance','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('BNA Technical Assistance','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('CCB No Agent','CALL_BACK',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Consumer English','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Consumer Other','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Consumer Spanish','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Outbound','OUTBOUND',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Voicemail Transfer','VOICEMAIL_TRANSFER',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);


insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('BNA Consumer Assistance','INBOUND_CALL',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('BNA Technical Assistance','INBOUND_CALL',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('CCB No Agent','CALL_BACK',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Consumer English','INBOUND_CALL',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Consumer Other','INBOUND_CALL',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Consumer Spanish','INBOUND_CALL',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Outbound','OUTBOUND',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Voicemail Transfer','VOICEMAIL_TRANSFER',1, 'N', 'Seconds', 1, 0);

commit;

-- contact queues

update cc_c_contact_queue set queue_type = 'Outbound', Unit_of_work_name = 'Outbound', project_name = 'New Jersey State Based Exchange', program_name = 'Get Covered New Jersey', region_name = 'Eastern', state_name = 'New Jersey', service_percent = 80, service_seconds = 30, interval_minutes = 15 where queue_number = 8705;
update cc_c_contact_queue set queue_type = 'IVR', Unit_of_work_name = 'IVR', project_name = 'New Jersey State Based Exchange', program_name = 'Get Covered New Jersey', region_name = 'Eastern', state_name = 'New Jersey', service_percent = 80, service_seconds = 30, interval_minutes = 15 where queue_number = 8706;
update cc_c_contact_queue set queue_type = 'Outbound', Unit_of_work_name = 'Outbound', project_name = 'New Jersey State Based Exchange', program_name = 'Get Covered New Jersey', region_name = 'Eastern', state_name = 'New Jersey', service_percent = 80, service_seconds = 30, interval_minutes = 15 where queue_number = 8707;
update cc_c_contact_queue set queue_type = 'Outbound VM', Unit_of_work_name = 'Voicemail', project_name = 'New Jersey State Based Exchange', program_name = 'Get Covered New Jersey', region_name = 'Eastern', state_name = 'New Jersey', service_percent = 80, service_seconds = 30, interval_minutes = 15 where queue_number = 8708;
update cc_c_contact_queue set queue_type = 'Outbound VM Xfer', Unit_of_work_name = 'Voicemail Transfer', project_name = 'New Jersey State Based Exchange', program_name = 'Get Covered New Jersey', region_name = 'Eastern', state_name = 'New Jersey', service_percent = 80, service_seconds = 30, interval_minutes = 15 where queue_number = 8709;
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'BNA Consumer Assistance', project_name = 'New Jersey State Based Exchange', program_name = 'Get Covered New Jersey', region_name = 'Eastern', state_name = 'New Jersey', service_percent = 80, service_seconds = 30, interval_minutes = 15 where queue_number = 8710;
update cc_c_contact_queue set queue_type = 'IVR', Unit_of_work_name = 'IVR', project_name = 'New Jersey State Based Exchange', program_name = 'Get Covered New Jersey', region_name = 'Eastern', state_name = 'New Jersey', service_percent = 80, service_seconds = 30, interval_minutes = 15 where queue_number = 8711;
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'BNA Consumer Assistance', project_name = 'New Jersey State Based Exchange', program_name = 'Get Covered New Jersey', region_name = 'Eastern', state_name = 'New Jersey', service_percent = 80, service_seconds = 30, interval_minutes = 15 where queue_number = 8712;
update cc_c_contact_queue set queue_type = 'Voicemail Transfer', Unit_of_work_name = 'BNA Consumer Assistance', project_name = 'New Jersey State Based Exchange', program_name = 'Get Covered New Jersey', region_name = 'Eastern', state_name = 'New Jersey', service_percent = 80, service_seconds = 30, interval_minutes = 15 where queue_number = 8713;
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'BNA Technical Assistance', project_name = 'New Jersey State Based Exchange', program_name = 'Get Covered New Jersey', region_name = 'Eastern', state_name = 'New Jersey', service_percent = 80, service_seconds = 30, interval_minutes = 15 where queue_number = 8714;
update cc_c_contact_queue set queue_type = 'Callback', Unit_of_work_name = 'BNA Technical Assistance', project_name = 'New Jersey State Based Exchange', program_name = 'Get Covered New Jersey', region_name = 'Eastern', state_name = 'New Jersey', service_percent = 80, service_seconds = 30, interval_minutes = 15 where queue_number = 8715;
update cc_c_contact_queue set queue_type = 'IVR', Unit_of_work_name = 'IVR', project_name = 'New Jersey State Based Exchange', program_name = 'Get Covered New Jersey', region_name = 'Eastern', state_name = 'New Jersey', service_percent = 80, service_seconds = 30, interval_minutes = 15 where queue_number = 8716;
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'BNA Technical Assistance', project_name = 'New Jersey State Based Exchange', program_name = 'Get Covered New Jersey', region_name = 'Eastern', state_name = 'New Jersey', service_percent = 80, service_seconds = 30, interval_minutes = 15 where queue_number = 8717;
update cc_c_contact_queue set queue_type = 'Voicemail', Unit_of_work_name = 'BNA Technical Assistance', project_name = 'New Jersey State Based Exchange', program_name = 'Get Covered New Jersey', region_name = 'Eastern', state_name = 'New Jersey', service_percent = 80, service_seconds = 30, interval_minutes = 15 where queue_number = 8718;
update cc_c_contact_queue set queue_type = 'Voicemail Transfer', Unit_of_work_name = 'BNA Technical Assistance', project_name = 'New Jersey State Based Exchange', program_name = 'Get Covered New Jersey', region_name = 'Eastern', state_name = 'New Jersey', service_percent = 80, service_seconds = 30, interval_minutes = 15 where queue_number = 8719;
update cc_c_contact_queue set queue_type = 'Callback', Unit_of_work_name = 'Consumer English', project_name = 'New Jersey State Based Exchange', program_name = 'Get Covered New Jersey', region_name = 'Eastern', state_name = 'New Jersey', service_percent = 80, service_seconds = 30, interval_minutes = 15 where queue_number = 8720;
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'Consumer English', project_name = 'New Jersey State Based Exchange', program_name = 'Get Covered New Jersey', region_name = 'Eastern', state_name = 'New Jersey', service_percent = 80, service_seconds = 30, interval_minutes = 15 where queue_number = 8721;
update cc_c_contact_queue set queue_type = 'Voicemail', Unit_of_work_name = 'Consumer English', project_name = 'New Jersey State Based Exchange', program_name = 'Get Covered New Jersey', region_name = 'Eastern', state_name = 'New Jersey', service_percent = 80, service_seconds = 30, interval_minutes = 15 where queue_number = 8722;
update cc_c_contact_queue set queue_type = 'Voicemail Transfer', Unit_of_work_name = 'Consumer English', project_name = 'New Jersey State Based Exchange', program_name = 'Get Covered New Jersey', region_name = 'Eastern', state_name = 'New Jersey', service_percent = 80, service_seconds = 30, interval_minutes = 15 where queue_number = 8723;
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'Consumer Other', project_name = 'New Jersey State Based Exchange', program_name = 'Get Covered New Jersey', region_name = 'Eastern', state_name = 'New Jersey', service_percent = 80, service_seconds = 30, interval_minutes = 15 where queue_number = 8724;
update cc_c_contact_queue set queue_type = 'Callback', Unit_of_work_name = 'Consumer Other', project_name = 'New Jersey State Based Exchange', program_name = 'Get Covered New Jersey', region_name = 'Eastern', state_name = 'New Jersey', service_percent = 80, service_seconds = 30, interval_minutes = 15 where queue_number = 8725;
update cc_c_contact_queue set queue_type = 'IVR', Unit_of_work_name = 'IVR', project_name = 'New Jersey State Based Exchange', program_name = 'Get Covered New Jersey', region_name = 'Eastern', state_name = 'New Jersey', service_percent = 80, service_seconds = 30, interval_minutes = 15 where queue_number = 8726;
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'Consumer Other', project_name = 'New Jersey State Based Exchange', program_name = 'Get Covered New Jersey', region_name = 'Eastern', state_name = 'New Jersey', service_percent = 80, service_seconds = 30, interval_minutes = 15 where queue_number = 8727;
update cc_c_contact_queue set queue_type = 'Voicemail', Unit_of_work_name = 'Consumer Other', project_name = 'New Jersey State Based Exchange', program_name = 'Get Covered New Jersey', region_name = 'Eastern', state_name = 'New Jersey', service_percent = 80, service_seconds = 30, interval_minutes = 15 where queue_number = 8728;
update cc_c_contact_queue set queue_type = 'Voicemail Transfer', Unit_of_work_name = 'Consumer Other', project_name = 'New Jersey State Based Exchange', program_name = 'Get Covered New Jersey', region_name = 'Eastern', state_name = 'New Jersey', service_percent = 80, service_seconds = 30, interval_minutes = 15 where queue_number = 8729;
update cc_c_contact_queue set queue_type = 'Callback', Unit_of_work_name = 'BNA Consumer Assistance', project_name = 'New Jersey State Based Exchange', program_name = 'Get Covered New Jersey', region_name = 'Eastern', state_name = 'New Jersey', service_percent = 80, service_seconds = 30, interval_minutes = 15 where queue_number = 8730;
update cc_c_contact_queue set queue_type = 'Voicemail', Unit_of_work_name = 'BNA Consumer Assistance', project_name = 'New Jersey State Based Exchange', program_name = 'Get Covered New Jersey', region_name = 'Eastern', state_name = 'New Jersey', service_percent = 80, service_seconds = 30, interval_minutes = 15 where queue_number = 8731;
update cc_c_contact_queue set queue_type = 'Callback', Unit_of_work_name = 'Consumer Spanish', project_name = 'New Jersey State Based Exchange', program_name = 'Get Covered New Jersey', region_name = 'Eastern', state_name = 'New Jersey', service_percent = 80, service_seconds = 30, interval_minutes = 15 where queue_number = 8732;
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'Consumer Spanish', project_name = 'New Jersey State Based Exchange', program_name = 'Get Covered New Jersey', region_name = 'Eastern', state_name = 'New Jersey', service_percent = 80, service_seconds = 30, interval_minutes = 15 where queue_number = 8733;
update cc_c_contact_queue set queue_type = 'Voicemail', Unit_of_work_name = 'Consumer Spanish', project_name = 'New Jersey State Based Exchange', program_name = 'Get Covered New Jersey', region_name = 'Eastern', state_name = 'New Jersey', service_percent = 80, service_seconds = 30, interval_minutes = 15 where queue_number = 8734;
update cc_c_contact_queue set queue_type = 'Voicemail Transfer', Unit_of_work_name = 'Consumer Spanish', project_name = 'New Jersey State Based Exchange', program_name = 'Get Covered New Jersey', region_name = 'Eastern', state_name = 'New Jersey', service_percent = 80, service_seconds = 30, interval_minutes = 15 where queue_number = 8735;
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'Consumer English', project_name = 'New Jersey State Based Exchange', program_name = 'Get Covered New Jersey', region_name = 'Eastern', state_name = 'New Jersey', service_percent = 80, service_seconds = 30, interval_minutes = 15 where queue_number = 8736;
update cc_c_contact_queue set queue_type = 'IVR', Unit_of_work_name = 'IVR', project_name = 'New Jersey State Based Exchange', program_name = 'Get Covered New Jersey', region_name = 'Eastern', state_name = 'New Jersey', service_percent = 80, service_seconds = 30, interval_minutes = 15 where queue_number = 8737;
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'Consumer Spanish', project_name = 'New Jersey State Based Exchange', program_name = 'Get Covered New Jersey', region_name = 'Eastern', state_name = 'New Jersey', service_percent = 80, service_seconds = 30, interval_minutes = 15 where queue_number = 8738;
update cc_c_contact_queue set queue_type = 'IVR', Unit_of_work_name = 'IVR', project_name = 'New Jersey State Based Exchange', program_name = 'Get Covered New Jersey', region_name = 'Eastern', state_name = 'New Jersey', service_percent = 80, service_seconds = 30, interval_minutes = 15 where queue_number = 8739;
update cc_c_contact_queue set queue_type = 'Callback', Unit_of_work_name = 'BNA Consumer Assistance', project_name = 'New Jersey State Based Exchange', program_name = 'Get Covered New Jersey', region_name = 'Eastern', state_name = 'New Jersey', service_percent = 80, interval_minutes = 15 where queue_number = 8799;
update cc_c_contact_queue set queue_type = 'Callback', Unit_of_work_name = 'CCB No Agent', project_name = 'New Jersey State Based Exchange', program_name = 'Get Covered New Jersey', region_name = 'Eastern', state_name = 'New Jersey', service_percent = 80, interval_minutes = 15 where queue_number = 8800;

commit;

update cc_c_contact_queue
set bucketintervalid = 5085
where queue_number in 
(8705,
8706,
8707,
8708,
8709,
8710,
8711,
8712,
8713,
8714,
8715,
8716,
8717,
8718,
8719,
8720,
8721,
8722,
8723,
8724,
8725,
8726,
8727,
8728,
8729,
8730,
8731,
8732,
8733,
8734,
8735,
8736,
8737,
8738,
8739,
8799,
8800);

commit;

-- Agent Routing groups

update cc_c_agent_rtg_grp 
set project_name = 'New Jersey State Based Exchange', 
program_name = 'Get Covered New Jersey', 
region_name = 'Eastern', 
state_name = 'New Jersey' 
where agent_routing_group_number in 
(5548,
5549,
5550,
5551,
5552,
5553
);


insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5548);
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5549);
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5550);
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5551);
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5552);
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5553);

commit;

-- corp_etl_lkup
update cc_a_list_lkup
set out_var = '5185,5186,5106,5107,5177,5178,5171,5172,5175,5176,5169,5170,5167,5168,5163,5164,5165,5166,5145,5146,5147,5148,5141,5142,5137,5138,5111,5112,5104,5105,5102,5103,5094,5095,5092,5093,5004,5005,5090,5091,5074,5075,5086,5087,5084,5085,5083,5082,5010,5011,5004,5005,5006,5007,5008,5009,5014,5015,5021,5022,5019,5020,5023,5024,5033,5034,5016,5017,5035,5036,5025,5026,5027,5028,5029,5030,5031,5032,5037,5038,5039,5040,5042,5043,5050,5051,5048,5049,5044,5045,5052,5053,5012,5013,5054,5055,5056,5057,5065,5066,5071,5072,5061,5062,5076,5077,5073,5080,5081,5113,5114,5116,5117,5133,5134,5131,5132,5100,5101,5139,5140,5143,5144,5151,5152,5149,5150,5155,5156'
where name = 'Desk_settings_ids';

commit;

-- cc_c_lookup agent desk settings

insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_DESKSETTING_SITE', '5185', 'Lawrenceville');
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_DESKSETTING_PROJECT', '5185', 'New Jersey State Based Exchange');
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_DESKSETTING_PROGRAM', '5185', 'Get Covered New Jersey');

insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_DESKSETTING_SITE', '5186', 'Lawrenceville');
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_DESKSETTING_PROJECT', '5186', 'New Jersey State Based Exchange');
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_DESKSETTING_PROGRAM', '5186', 'Get Covered New Jersey');

commit;

-- cc_c_filter

insert into cc_c_filter (filter_type, value) values ('ACD_DESKSETTING_INC', '5185');
insert into cc_c_filter (filter_type, value) values ('ACD_DESKSETTING_INC', '5186');

commit;

-- Calls offered formula 

insert into cc_a_list_lkup     (	cc_cell_id
					,name
					,list_type
					,value
					,out_var
					,ref_type
					,ref_id
					,start_date
					,end_date
					,comments
					,created_ts
					,updated_ts)
			values (	seq_cc_cell_id.NEXTVAL
					,'NJSBE CALLS_OFFERED_FORMULA'
					,'CC_S_ACD_INTERVAL-CALLS_OFFERED'
					,'New Jersey State Based Exchange'
					,'select (CONTACTS_OFFERED - OUTFLOW_CONTACTS) from cc_s_acd_interval where acd_interval_id = :ACD_INTERVAL_ID'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Calls offered formula for various projects in the enterprise'
					,SYSDATE
					,SYSDATE);
					
insert into cc_a_list_lkup     (	cc_cell_id
					,name
					,list_type
					,value
					,out_var
					,ref_type
					,ref_id
					,start_date
					,end_date
					,comments
					,created_ts
					,updated_ts)
			values (	seq_cc_cell_id.NEXTVAL
					,'NJSBE CALLS_OFFERED_FORMULA'
					,'CC_S_ACD_QUEUE_INTERVAL-CALLS_OFFERED'
					,'New Jersey State Based Exchange'
					,'select (CONTACTS_OFFERED - OUTFLOW_CONTACTS) from cc_s_acd_queue_interval where acd_queue_interval_id = :ACD_INTERVAL_ID'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Calls offered formula for various projects in the enterprise'
					,SYSDATE
					,SYSDATE);	
					
        
commit;		

					