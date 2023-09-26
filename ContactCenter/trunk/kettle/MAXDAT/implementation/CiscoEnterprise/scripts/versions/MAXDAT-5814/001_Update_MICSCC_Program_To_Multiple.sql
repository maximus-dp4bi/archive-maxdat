alter session set current_schema = cisco_enterprise_cc;

update cc_c_project_config
set program_name = 'Multiple'
where project_name = 'MI CSCC'
and program_name = 'Customer Support';

update cc_c_contact_queue
set program_name = 'Multiple'
where queue_number in (5513,
5514,
5515,
5516,
5517,
5518,
5524,
5525);

update cc_c_contact_queue
set queue_type = 'Transfer', unit_of_work_name = 'Tier 2 Transfer'
where queue_number in (5518, 5525);

update cc_c_contact_queue
set queue_type = 'Inbound', unit_of_work_name = 'CSCC Arabic', interval_minutes = 15, service_seconds = 30, project_name = 'MI CSCC', program_name = 'Multiple', region_name = 'Eastern', state_name = 'Michigan'
where 
queue_number = 6606;

update cc_c_contact_queue
set queue_type = 'Inbound', unit_of_work_name = 'CSCC Spanish', interval_minutes = 15, service_seconds = 30, project_name = 'MI CSCC', program_name = 'Multiple', region_name = 'Eastern', state_name = 'Michigan'
where 
queue_number = 6607;

update cc_c_contact_queue
set queue_type = 'Voicemail', unit_of_work_name = 'Voicemail - Arabic', interval_minutes = 15, service_seconds = 30, project_name = 'MI CSCC', program_name = 'Multiple', region_name = 'Eastern', state_name = 'Michigan'
where 
queue_number = 6611;

update cc_c_contact_queue
set queue_type = 'Voicemail', unit_of_work_name = 'Voicemail - Spanish', interval_minutes = 15, service_seconds = 30, project_name = 'MI CSCC', program_name = 'Multiple', region_name = 'Eastern', state_name = 'Michigan'
where 
queue_number = 6612;

update cc_c_contact_queue
set queue_type = 'After Hours', unit_of_work_name = 'After Hours', interval_minutes = 15, service_seconds = 30, project_name = 'MI CSCC', program_name = 'Multiple', region_name = 'Eastern', state_name = 'Michigan'
where 
queue_number in (5510, 5512);

update cc_c_contact_queue
set service_seconds = 30
where queue_number in (5524, 5525);

update cc_c_contact_queue
set queue_name = 'MIEL_CSCC_SM2_TIER2_103629'
where queue_number = 5525;

update cc_c_lookup
set lookup_value = 'Multiple'
where lookup_type = 'ACD_PQ_PROGRAM'
and lookup_key in (5073,
5074,
5075,
5076)
and lookup_value = 'Customer Support';

update cc_c_lookup
set lookup_value = 'Multiple'
where lookup_key in (5023,
5024
)
and lookup_type = 'ACD_DESKSETTING_PROGRAM';

update cc_c_unit_of_work
set unit_of_work_category = 'TRANSFER'
where unit_of_work_name = 'Tier 2 Transfer';

insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('Voicemail - Arabic', 'Voicemail', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('Voicemail - Spanish', 'Voicemail', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);

insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('Voicemail - Arabic', 'Voicemail', 15, 'N', 'Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('Voicemail - Spanish', 'Voicemail', 15, 'N', 'Seconds');


update cc_f_acd_agent_interval
set d_program_id = (select distinct program_id from cc_d_program where program_name = 'Multiple')
where d_project_id in (select project_id from cc_d_project where project_name = 'MI CSCC');

update cc_f_agent_activity_by_date
set d_program_id = (select distinct program_id from cc_d_program where program_name = 'Multiple')
where d_project_id in (select project_id from cc_d_project where project_name = 'MI CSCC');

update cc_f_agent_by_date
set d_program_id = (select distinct program_id from cc_d_program where program_name = 'Multiple')
where D_PROJECT_TARGETS_ID = (select distinct d_project_targets_id from cc_d_project_targets
                                    where project_id in (select project_id from cc_d_project where project_name = 'MI CSCC'));
                                    
update cc_f_actuals_ivr_interval
set d_program_id = (select distinct program_id from cc_d_program where program_name = 'Multiple')
where d_project_id in (select project_id from cc_d_project where project_name = 'MI CSCC');

update cc_f_ivr_self_service_usage
set d_program_id = (select distinct program_id from cc_d_program where program_name = 'Multiple')
where d_project_id in (select project_id from cc_d_project where project_name = 'MI CSCC');

update cc_s_ivr_response
set program_name = 'Multiple'
where project_name = 'MI CSCC';

update cc_a_list_lkup
set ref_type = 'Multiple'
where ref_type = 'Customer Support'
and out_var = 'MI CSCC'
and name = 'IVR_DATA_FILE_NAMES';

commit;


