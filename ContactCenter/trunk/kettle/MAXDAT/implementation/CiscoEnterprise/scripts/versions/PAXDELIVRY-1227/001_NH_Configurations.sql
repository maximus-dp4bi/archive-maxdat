alter session set current_schema = cisco_enterprise_cc;

insert into cc_c_project_config (project_name, program_name, region_name, state_name, province_name, district_name, country_name, record_eff_dt, record_end_dt)
values ('NH Medicaid Service Center', 'Medicaid', 'Eastern', 'New Hampshire', 'Unknown', 'Unknown', 'USA', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));

insert into cc_d_project (project_id, project_name, segment_id, include_in_reports_flag) values (SEQ_CC_D_PROJECT.nextval, 'NH Medicaid Service Center', 2, 1 );

--insert into cc_d_program (program_id, program_name, include_in_reports_flag) values (SEQ_CC_D_PROGRAM.nextval, 'Medicaid', 1 );

commit;

insert into cc_d_project_targets (d_project_targets_id, project_id, version, average_handle_time_target, utilization_target, cost_per_call_target, occupancy_target, labor_cost_per_call_target, record_eff_dt, record_end_dt)
values (SEQ_CC_D_PROJECT_TARGETS.nextval, (select project_id from cc_d_project where project_name = 'NH Medicaid Service Center'), 1, 0, 0, 0, 0, 0, to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));

insert into cc_d_state (state_name) values ('New Hampshire');

insert into cc_d_geography_master (geography_name, country_id, state_id, province_id, district_id, region_id)
values ('New Hampshire', (select country_id from cc_d_country where country_name = 'USA'), (select state_id from cc_d_state where state_name = 'New Hampshire'), 0, 0, (select region_id from cc_d_region where region_name = 'Eastern'));

commit;


-- Units of work

insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('New Hampshire English For Boston', 'INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('New Hampshire Spanish For Boston', 'INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);

insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('New Hampshire English For Boston', 'INBOUND_CALL', 1, 'N', 'Seconds', 0, 1);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('New Hampshire Spanish For Boston', 'INBOUND_CALL', 1, 'N', 'Seconds', 0, 1);

commit;

-- contact queues

update cc_c_contact_queue set queue_type = 'Inbound', unit_of_work_name = 'New Hampshire English For Boston', project_name = 'NH Medicaid Service Center', program_name = 'Medicaid', region_name = 'Eastern', state_name = 'New Hampshire', service_seconds= 30, interval_minutes = 15 where queue_number = 8595;
update cc_c_contact_queue set queue_type = 'Inbound', unit_of_work_name = 'New Hampshire Spanish For Boston', project_name = 'NH Medicaid Service Center', program_name = 'Medicaid', region_name = 'Eastern', state_name = 'New Hampshire', service_seconds= 30, interval_minutes = 15 where queue_number = 8596;

update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'NH Medicaid Service Center' and program_name = 'Medicaid'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'New Hampshire English For Boston'), service_seconds= 30, interval_minutes = 15 where queue_number = '8595';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'NH Medicaid Service Center' and program_name = 'Medicaid'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'New Hampshire Spanish For Boston'), service_seconds= 30, interval_minutes = 15 where queue_number = '8596';

update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'NH Medicaid Service Center'), d_program_id = (select program_id from cc_d_program where program_name = 'Medicaid'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'New Hampshire English For Boston'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'New Hampshire'),service_seconds= 30, interval_minutes = 15 where queue_number = '8595';
update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'NH Medicaid Service Center'), d_program_id = (select program_id from cc_d_program where program_name = 'Medicaid'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'New Hampshire Spanish For Boston'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'New Hampshire'),service_seconds= 30, interval_minutes = 15 where queue_number = '8596';

commit;


-- Agent Routing groups

update cc_c_agent_rtg_grp 
set project_name = 'NH Medicaid Service Center', 
program_name = 'Medicaid', 
region_name = 'Eastern', 
state_name = 'New Hampshire' 
where agent_routing_group_number in (5545,5546);


insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5545);
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5546);

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
					,'NH CALLS_OFFERED_FORMULA'
					,'CC_S_ACD_INTERVAL-CALLS_OFFERED'
					,'NH Medicaid Service Center'
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
					,'NH CALLS_OFFERED_FORMULA'
					,'CC_S_ACD_QUEUE_INTERVAL-CALLS_OFFERED'
					,'NH Medicaid Service Center'
					,'select (CONTACTS_OFFERED - OUTFLOW_CONTACTS) from cc_s_acd_queue_interval where acd_queue_interval_id = :ACD_INTERVAL_ID'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Calls offered formula for various projects in the enterprise'
					,SYSDATE
					,SYSDATE);	
					
        
commit;		

					