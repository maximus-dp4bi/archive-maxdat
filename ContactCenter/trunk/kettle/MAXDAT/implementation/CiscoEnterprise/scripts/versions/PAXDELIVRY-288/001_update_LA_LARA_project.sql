alter session set current_schema = cisco_enterprise_cc;

update cc_c_project_config
set project_name = 'LA LARA', program_name = 'Medicaid Application Assistance'
where project_name = 'LA EB';

update cc_d_project
set project_name = 'LA LARA'
where project_name = 'LA EB';

insert into cc_d_program (program_id, program_name, include_in_reports_flag) values (SEQ_CC_D_PROGRAM.nextval, 'Medicaid Application Assistance', 1 );

-- Units of work

insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Inbound','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);

insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Inbound','Inbound', 1, 'N', 'Seconds', 1, 0);

commit;


-- contact queues

update cc_c_contact_queue 
set queue_type = 'IVR', Unit_of_work_name = 'Main IVR', project_name = 'LA LARA', program_name = 'Medicaid Application Assistance' 
where queue_number = '7106';

update cc_c_contact_queue 
set queue_type = 'Voicemail', Unit_of_work_name = 'Voicemail', project_name = 'LA LARA', program_name = 'Medicaid Application Assistance' 
where queue_number = '7092';

update cc_c_contact_queue
set project_name = 'LA LARA',
program_name = 'Medicaid Application Assistance'
where project_name = 'LA EB';


update cc_c_contact_queue 
set queue_type = 'Transfer', Unit_of_work_name = 'Transfer', project_name = 'LA LARA', program_name = 'Medicaid Application Assistance', region_name = 'Eastern', state_name = 'Louisiana', service_seconds = 120, interval_minutes = 15 
where queue_number in (8129,
8130,
8131,
8132,
8133,
8134
);

update cc_c_contact_queue
set unit_of_work_name = 'Inbound'
where queue_number in (7104,
7098,
7100,
7099,
7101,
7103,
7102,
7091,
7105
)
;

update cc_s_contact_queue 
set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'LA LARA' and program_name = 'Medicaid Application Assistance'), 
queue_type = 'Voicemail', 
unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'Voicemail')
where queue_number = '7092';

update cc_s_contact_queue 
set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'LA LARA' and program_name = 'Medicaid Application Assistance'), 
queue_type = 'IVR', 
unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'Main IVR')
where queue_number = '7106';

update cc_s_contact_queue 
set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'LA LARA' and program_name = 'Medicaid Application Assistance'), 
queue_type = 'Transfer', 
unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'Transfer'), 
service_seconds = 120, interval_minutes = 15 
where queue_number in (8129,
8130,
8131,
8132,
8133,
8134
);

update cc_s_contact_queue 
set unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'Inbound')
where queue_number in (7104,
7098,
7100,
7099,
7101,
7103,
7102,
7091,
7105
)
;

update cc_d_contact_queue 
set queue_type = 'Voicemail', 
d_project_id = (select project_id from cc_d_project where project_name = 'LA LARA'), 
d_program_id = (select program_id from cc_d_program where program_name = 'Medicaid Application Assistance'), 
d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'Voicemail')
where queue_number = '7092';

update cc_d_contact_queue 
set queue_type = 'IVR', 
d_project_id = (select project_id from cc_d_project where project_name = 'LA LARA'), 
d_program_id = (select program_id from cc_d_program where program_name = 'Medicaid Application Assistance'), 
d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'Main IVR')
where queue_number = '7106';

update cc_d_contact_queue 
set queue_type = 'Transfer', 
d_project_id = (select project_id from cc_d_project where project_name = 'LA LARA'), 
d_program_id = (select program_id from cc_d_program where program_name = 'Medicaid Application Assistance'), 
d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'Transfer'), 
d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Louisiana'),
service_seconds= 120, 
interval_minutes = 15 
where queue_number in (8129,
8130,
8131,
8132,
8133,
8134
);

update cc_d_contact_queue 
set d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'Inbound')
where queue_number in  (7104,
7098,
7100,
7099,
7101,
7103,
7102,
7091,
7105
)
;

commit;


-- Agent Routing groups

update cc_c_agent_rtg_grp 
set project_name = 'LA LARA', 
program_name = 'Medicaid Application Assistance'
where agent_routing_group_number in (5303,
5296,
5297,
5298,
5299,
5300,
5301,
5302
)
and project_name = 'LA EB';

commit;

-- cc_c_lookup agent desk settings

update cc_c_lookup
set lookup_value = 'LA LARA'
where lookup_value = 'LA EB';

update cc_c_lookup 
set lookup_value = 'Medicaid Application Assistance'
where lookup_value = 'Multiple'
and lookup_key in (5104,
5105,
5143,
5144);


commit;


-- Calls offered formula 

update cc_a_list_lkup
set name = 'LA LARA CALLS_OFFERED_FORMULA',
value = 'LA LARA'
where value = 'LA EB';
        
commit;		
					