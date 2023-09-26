alter session set current_schema = cisco_enterprise_cc;

insert into cc_c_project_config (project_name, program_name, region_name, state_name, province_name, district_name, country_name, record_eff_dt, record_end_dt)
values ('LA EB', 'Medicaid', 'Eastern', 'Louisiana', 'Unknown', 'Unknown', 'USA', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));

insert into cc_d_project (project_id, project_name, segment_id, include_in_reports_flag) values (SEQ_CC_D_PROJECT.nextval, 'LA EB', 2, 1 );

--insert into cc_d_program (program_id, program_name, include_in_reports_flag) values (SEQ_CC_D_PROGRAM.nextval, 'Medicaid', 1 );

commit;

insert into cc_d_project_targets (d_project_targets_id, project_id, version, average_handle_time_target, utilization_target, cost_per_call_target, occupancy_target, labor_cost_per_call_target, record_eff_dt, record_end_dt)
values (SEQ_CC_D_PROJECT_TARGETS.nextval, (select project_id from cc_d_project where project_name = 'LA EB'), 1, 0, 0, 0, 0, 0, to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));

commit;


-- Units of work

--insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Inbound English', 'INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('After hours', 'IVR',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('IVR Main Menu', 'IVR',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
--insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Inbound Spanish', 'INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('No Agent Logged In', 'INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);


--insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Inbound English', 'INBOUND_CALL', 1, 'N', 'Seconds', 0, 1);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('After hours', 'IVR', 1, 'N', 'Seconds', 0, 1);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('IVR Main Menu', 'IVR', 1, 'N', 'Seconds', 0, 1);
--insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Inbound Spanish', 'INBOUND_CALL', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('No Agent Logged In', 'INBOUND_CALL', 1, 'N', 'Seconds', 1, 0);


commit;

-- contact queues

update cc_c_contact_queue set queue_type = 'Inbound', unit_of_work_name = 'Inbound English', project_name = 'LA EB', program_name = 'Medicaid', region_name = 'Eastern', state_name = 'Louisiana', service_seconds= 120, interval_minutes = 15 where queue_number = 7107;
update cc_c_contact_queue set queue_type = 'IVR', unit_of_work_name = 'After hours', project_name = 'LA EB', program_name = 'Medicaid', region_name = 'Eastern', state_name = 'Louisiana', service_seconds= 120, interval_minutes = 15 where queue_number = 7111;
update cc_c_contact_queue set queue_type = 'IVR', unit_of_work_name = 'IVR Main Menu', project_name = 'LA EB', program_name = 'Medicaid', region_name = 'Eastern', state_name = 'Louisiana', service_seconds= 120, interval_minutes = 15 where queue_number = 7109;
update cc_c_contact_queue set queue_type = 'Inbound', unit_of_work_name = 'Inbound Spanish', project_name = 'LA EB', program_name = 'Medicaid', region_name = 'Eastern', state_name = 'Louisiana', service_seconds= 120, interval_minutes = 15 where queue_number = 7108;
update cc_c_contact_queue set queue_type = 'Inbound', unit_of_work_name = 'No Agent Logged In', project_name = 'LA EB', program_name = 'Medicaid', region_name = 'Eastern', state_name = 'Louisiana', service_seconds= 120, interval_minutes = 15 where queue_number = 7110;

update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'LA EB' and program_name = 'Medicaid'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'Inbound English'), service_seconds= 120, interval_minutes = 15 where queue_number = '7107';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'LA EB' and program_name = 'Medicaid'), queue_type = 'IVR', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'After hours'), service_seconds= 120, interval_minutes = 15 where queue_number = '7111';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'LA EB' and program_name = 'Medicaid'), queue_type = 'IVR', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'IVR Main Menu'), service_seconds= 120, interval_minutes = 15 where queue_number = '7109';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'LA EB' and program_name = 'Medicaid'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'Inbound Spanish'), service_seconds= 120, interval_minutes = 15 where queue_number = '7108';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'LA EB' and program_name = 'Medicaid'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'No Agent Logged In'), service_seconds= 120, interval_minutes = 15 where queue_number = '7110';

update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'LA EB'), d_program_id = (select program_id from cc_d_program where program_name = 'Medicaid'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'Inbound English'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Louisiana'),service_seconds= 120, interval_minutes = 15 where queue_number = '7107';
update cc_d_contact_queue set queue_type = 'IVR', d_project_id = (select project_id from cc_d_project where project_name = 'LA EB'), d_program_id = (select program_id from cc_d_program where program_name = 'Medicaid'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'After hours'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Louisiana'),service_seconds= 120, interval_minutes = 15 where queue_number = '7111';
update cc_d_contact_queue set queue_type = 'IVR', d_project_id = (select project_id from cc_d_project where project_name = 'LA EB'), d_program_id = (select program_id from cc_d_program where program_name = 'Medicaid'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'IVR Main Menu'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Louisiana'),service_seconds= 120, interval_minutes = 15 where queue_number = '7109';
update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'LA EB'), d_program_id = (select program_id from cc_d_program where program_name = 'Medicaid'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'Inbound Spanish'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Louisiana'),service_seconds= 120, interval_minutes = 15 where queue_number = '7108';
update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'LA EB'), d_program_id = (select program_id from cc_d_program where program_name = 'Medicaid'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'No Agent Logged In'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Louisiana'),service_seconds= 120, interval_minutes = 15 where queue_number = '7110';

commit;


-- Agent Routing groups

update cc_c_agent_rtg_grp 
set project_name = 'LA EB', 
program_name = 'Medicaid', 
region_name = 'Eastern', 
state_name = 'Louisiana' 
where agent_routing_group_number in (5304,5305);


insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5304);
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5305);

commit;

-- corp_etl_lkup
update cc_a_list_lkup
set out_var = '5106,5107,5177,5178,5171,5172,5175,5176,5169,5170,5167,5168,5163,5164,5165,5166,5145,5146,5147,5148,5141,5142,5137,5138,5111,5112,5104,5105,5102,5103,5094,5095,5092,5093,5004,5005,5090,5091,5074,5075,5086,5087,5084,5085,5083,5082,5010,5011,5004,5005,5006,5007,5008,5009,5014,5015,5021,5022,5019,5020,5023,5024,5033,5034,5016,5017,5035,5036,5025,5026,5027,5028,5029,5030,5031,5032,5037,5038,5039,5040,5042,5043,5050,5051,5048,5049,5044,5045,5052,5053,5012,5013,5054,5055,5056,5057,5065,5066,5071,5072,5061,5062,5076,5077,5073,5080,5081,5113,5114,5116,5117,5133,5134,5131,5132,5100,5101,5139,5140,5143,5144,5151,5152,5149,5150,5155,5156'
where name = 'Desk_settings_ids';

commit;

-- cc_c_lookup agent desk settings

insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_DESKSETTING_SITE', '5106', 'Hampton');
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_DESKSETTING_PROJECT', '5106', 'LA EB');
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_DESKSETTING_PROGRAM', '5106', 'Medicaid');

insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_DESKSETTING_SITE', '5107', 'Hampton');
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_DESKSETTING_PROJECT', '5107', 'LA EB');
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_DESKSETTING_PROGRAM', '5107', 'Medicaid');

commit;

-- cc_c_filter

insert into cc_c_filter (filter_type, value) values ('ACD_DESKSETTING_INC', '5106');
insert into cc_c_filter (filter_type, value) values ('ACD_DESKSETTING_INC', '5107');

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
					,'LA EB CALLS_OFFERED_FORMULA'
					,'CC_S_ACD_INTERVAL-CALLS_OFFERED'
					,'LA EB'
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
					,'LA EB CALLS_OFFERED_FORMULA'
					,'CC_S_ACD_QUEUE_INTERVAL-CALLS_OFFERED'
					,'LA EB'
					,'select (CONTACTS_OFFERED - OUTFLOW_CONTACTS) from cc_s_acd_queue_interval where acd_queue_interval_id = :ACD_INTERVAL_ID'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Calls offered formula for various projects in the enterprise'
					,SYSDATE
					,SYSDATE);	
					
        
commit;		

					