alter session set current_schema = cisco_enterprise_cc;

-- Units of work

insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('NCUI PUA Queue 500 Threshold','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Claimant Threshold Message 500', 'INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);

insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('NCUI PUA Queue 500 Threshold', 'INBOUND_CALL', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Claimant Threshold Message 500', 'INBOUND_CALL', 1, 'N', 'Seconds', 1, 0);

commit;

-- contact queues

update cc_c_contact_queue set queue_type = 'Busy Message', unit_of_work_name = 'NCUI PUA Queue 500 Threshold', project_name = 'NC UI', program_name = 'Unemployment Insurance Helpline', region_name = 'Eastern', state_name = 'North Carolina', service_seconds = 30, interval_minutes = 15 where queue_number = 8593;
update cc_c_contact_queue set queue_type = 'Busy Message', unit_of_work_name = 'Claimant Threshold Message 500', project_name = 'NC UI', program_name = 'Unemployment Insurance Helpline', region_name = 'Eastern', state_name = 'North Carolina', service_seconds = 30, interval_minutes = 15 where queue_number = 8594;

update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'NC UI' and program_name = 'Unemployment Insurance Helpline'), queue_type = 'Busy Message', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'NCUI PUA Queue 500 Threshold'), service_seconds = 30, interval_minutes = 15 where queue_number = '8593';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'NC UI' and program_name = 'Unemployment Insurance Helpline'), queue_type = 'Busy Message', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'Claimant Threshold Message 500'), service_seconds = 30, interval_minutes = 15 where queue_number = '8594';

update cc_d_contact_queue set queue_type = 'Busy Message', d_project_id = (select project_id from cc_d_project where project_name = 'NC UI'), d_program_id = (select program_id from cc_d_program where program_name = 'Unemployment Insurance Helpline'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'NCUI PUA Queue 500 Threshold'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'North Carolina'),service_seconds= 30, interval_minutes = 15 where queue_number = '8593';
update cc_d_contact_queue set queue_type = 'Busy Message', d_project_id = (select project_id from cc_d_project where project_name = 'NC UI'), d_program_id = (select program_id from cc_d_program where program_name = 'Unemployment Insurance Helpline'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'Claimant Threshold Message 500'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'North Carolina'),service_seconds= 30, interval_minutes = 15 where queue_number = '8594';

commit;

			