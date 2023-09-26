alter session set current_schema = cisco_enterprise_cc;

-- Units of work

insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('VAHM VTHX SEANAV','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('VAHM VTHX Internal Transfer', 'Internal Transfer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);

insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('VAHM VTHX SEANAV', 'Inbound', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('VAHM VTHX Internal Transfer', 'Internal Transfer', 1, 'N', 'Seconds', 1, 0);

commit;

-- contact queues

update cc_c_contact_queue set queue_type = 'Inbound', unit_of_work_name = 'VAHM VTHX SEANAV', project_name = 'VT HIX', program_name = 'Multiple', region_name = 'Eastern', state_name = 'Vermont', service_seconds = 24, interval_minutes = 15 where queue_number = 8454;
update cc_c_contact_queue set queue_type = 'Inbound', unit_of_work_name = 'VAHM VTHX SEANAV', project_name = 'VT HIX', program_name = 'Multiple', region_name = 'Eastern', state_name = 'Vermont', service_seconds = 24, interval_minutes = 15 where queue_number = 8455;
update cc_c_contact_queue set queue_type = 'Internal Transfer', unit_of_work_name = 'VAHM VTHX Internal Transfer', project_name = 'VT HIX', program_name = 'Multiple', region_name = 'Eastern', state_name = 'Vermont', service_seconds = 24, interval_minutes = 15 where queue_number = 8502;
update cc_c_contact_queue set queue_type = 'Internal Transfer', unit_of_work_name = 'VAHM VTHX Internal Transfer', project_name = 'VT HIX', program_name = 'Multiple', region_name = 'Eastern', state_name = 'Vermont', service_seconds = 24, interval_minutes = 15 where queue_number = 8503;

update cc_c_contact_queue
set unit_of_work_name = 'VTHIX Assist Queue'
where queue_number = 8299;

update cc_c_contact_queue
set unit_of_work_name = 'VTHIX Assist Queue Transfer'
where queue_number = 8300;


update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'VT HIX' and program_name = 'Multiple'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'VAHM VTHX SEANAV'), service_seconds = 24, interval_minutes = 15 where queue_number = '8454';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'VT HIX' and program_name = 'Multiple'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'VAHM VTHX SEANAV'), service_seconds = 24, interval_minutes = 15 where queue_number = '8455';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'VT HIX' and program_name = 'Multiple'), queue_type = 'Internal Transfer', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'VAHM VTHX Internal Transfer'), service_seconds = 24, interval_minutes = 15 where queue_number = '8502';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'VT HIX' and program_name = 'Multiple'), queue_type = 'Internal Transfer', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'VAHM VTHX Internal Transfer'), service_seconds = 24, interval_minutes = 15 where queue_number = '8503';

update cc_s_contact_queue 
set unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'VTHIX Assist Queue')
where queue_number = '8299';

update cc_s_contact_queue 
set unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'VTHIX Assist Queue Transfer')
where queue_number = '8300';

update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'VT HIX'), d_program_id = (select program_id from cc_d_program where program_name = 'Multiple'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'VAHM VTHX SEANAV'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Vermont'),service_seconds= 24, interval_minutes = 15 where queue_number = '8454';
update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'VT HIX'), d_program_id = (select program_id from cc_d_program where program_name = 'Multiple'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'VAHM VTHX SEANAV'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Vermont'),service_seconds= 24, interval_minutes = 15 where queue_number = '8455';
update cc_d_contact_queue set queue_type = 'Internal Transfer', d_project_id = (select project_id from cc_d_project where project_name = 'VT HIX'), d_program_id = (select program_id from cc_d_program where program_name = 'Multiple'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'VAHM VTHX Internal Transfer'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Vermont'),service_seconds= 24, interval_minutes = 15 where queue_number = '8502';
update cc_d_contact_queue set queue_type = 'Internal Transfer', d_project_id = (select project_id from cc_d_project where project_name = 'VT HIX'), d_program_id = (select program_id from cc_d_program where program_name = 'Multiple'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'VAHM VTHX Internal Transfer'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Vermont'),service_seconds= 24, interval_minutes = 15 where queue_number = '8503';

update cc_d_contact_queue 
set d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'VTHIX Assist Queue')
where queue_number = '8299';

update cc_d_contact_queue 
set d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'VTHIX Assist Queue Transfer')
where queue_number = '8300';

commit;


-- Agent Routing groups

update cc_c_agent_rtg_grp 
set project_name = 'VT HIX', 
program_name = 'Multiple', 
region_name = 'Eastern', 
state_name = 'Vermont' 
where agent_routing_group_number in (5539,5541);

insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5539);
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5541);

commit;

			