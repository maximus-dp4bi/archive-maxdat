alter session set current_schema = cisco_enterprise_cc;

-- Units of work

insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('External Transfer NCUI', 'External Transfer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('External Transfer NCUI Claimant', 'External Transfer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('NCUI Claimant Inbound No Agent', 'INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('NCUI Claimant Inbound', 'INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('NCUI Claimant Inbound Rona', 'INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('IVR Main - NCUI Claimant', 'IVR',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);


insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('External Transfer NCUI', 'External Transfer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('External Transfer NCUI Claimant', 'External Transfer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('NCUI Claimant Inbound No Agent', 'INBOUND_CALL', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('NCUI Claimant Inbound', 'INBOUND_CALL', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('NCUI Claimant Inbound Rona', 'INBOUND_CALL', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('IVR Main - NCUI Claimant', 'IVR', 1, 'N', 'Seconds', 0, 1);

commit;

-- contact queues

update cc_c_contact_queue set queue_type = 'External Transfer', unit_of_work_name = 'External Transfer NCUI Claimant', project_name = 'NC UI', program_name = 'Unemployment Insurance Helpline', region_name = 'Eastern', state_name = 'North Carolina', service_seconds = 30, interval_minutes = 15 where queue_number = 8348;
update cc_c_contact_queue set queue_type = 'Inbound', unit_of_work_name = 'NCUI Claimant Inbound No Agent', project_name = 'NC UI', program_name = 'Unemployment Insurance Helpline', region_name = 'Eastern', state_name = 'North Carolina', service_seconds = 30, interval_minutes = 15 where queue_number = 8433;
update cc_c_contact_queue set queue_type = 'Inbound', unit_of_work_name = 'NCUI Claimant Inbound', project_name = 'NC UI', program_name = 'Unemployment Insurance Helpline', region_name = 'Eastern', state_name = 'North Carolina', service_seconds = 30, interval_minutes = 15 where queue_number = 8434;
update cc_c_contact_queue set queue_type = 'Inbound', unit_of_work_name = 'NCUI Claimant Inbound Rona', project_name = 'NC UI', program_name = 'Unemployment Insurance Helpline', region_name = 'Eastern', state_name = 'North Carolina', service_seconds = 30, interval_minutes = 15 where queue_number = 8435;
update cc_c_contact_queue set queue_type = 'IVR', unit_of_work_name = 'IVR Main - NCUI Claimant', project_name = 'NC UI', program_name = 'Unemployment Insurance Helpline', region_name = 'Eastern', state_name = 'North Carolina', service_seconds = 30, interval_minutes = 15 where queue_number = 8437;
update cc_c_contact_queue set queue_type = 'External Transfer', unit_of_work_name = 'External Transfer NCUI', project_name = 'NC UI', program_name = 'Unemployment Insurance Helpline', region_name = 'Eastern', state_name = 'North Carolina', service_seconds = 30, interval_minutes = 15 where queue_number = 8325;

update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'NC UI' and program_name = 'Unemployment Insurance Helpline'), queue_type = 'External Transfer', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'External Transfer NCUI Claimant'), service_seconds = 30, interval_minutes = 15 where queue_number = '8348';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'NC UI' and program_name = 'Unemployment Insurance Helpline'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'NCUI Claimant Inbound No Agent'), service_seconds = 30, interval_minutes = 15 where queue_number = '8433';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'NC UI' and program_name = 'Unemployment Insurance Helpline'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'NCUI Claimant Inbound'), service_seconds = 30, interval_minutes = 15 where queue_number = '8434';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'NC UI' and program_name = 'Unemployment Insurance Helpline'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'NCUI Claimant Inbound Rona'), service_seconds = 30, interval_minutes = 15 where queue_number = '8435';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'NC UI' and program_name = 'Unemployment Insurance Helpline'), queue_type = 'IVR', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'IVR Main - NCUI Claimant'), service_seconds = 30, interval_minutes = 15 where queue_number = '8437';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'NC UI' and program_name = 'Unemployment Insurance Helpline'), queue_type = 'External Transfer', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'External Transfer NCUI'), service_seconds = 30, interval_minutes = 15 where queue_number = '8325';

update cc_d_contact_queue set queue_type = 'External Transfer', d_project_id = (select project_id from cc_d_project where project_name = 'NC UI'), d_program_id = (select program_id from cc_d_program where program_name = 'Unemployment Insurance Helpline'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'External Transfer NCUI Claimant'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'North Carolina'),service_seconds= 30, interval_minutes = 15 where queue_number = '8348';
update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'NC UI'), d_program_id = (select program_id from cc_d_program where program_name = 'Unemployment Insurance Helpline'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'NCUI Claimant Inbound No Agent'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'North Carolina'),service_seconds= 30, interval_minutes = 15 where queue_number = '8433';
update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'NC UI'), d_program_id = (select program_id from cc_d_program where program_name = 'Unemployment Insurance Helpline'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'NCUI Claimant Inbound'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'North Carolina'),service_seconds= 30, interval_minutes = 15 where queue_number = '8434';
update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'NC UI'), d_program_id = (select program_id from cc_d_program where program_name = 'Unemployment Insurance Helpline'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'NCUI Claimant Inbound Rona'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'North Carolina'),service_seconds= 30, interval_minutes = 15 where queue_number = '8435';
update cc_d_contact_queue set queue_type = 'IVR', d_project_id = (select project_id from cc_d_project where project_name = 'NC UI'), d_program_id = (select program_id from cc_d_program where program_name = 'Unemployment Insurance Helpline'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'IVR Main - NCUI Claimant'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'North Carolina'),service_seconds= 30, interval_minutes = 15 where queue_number = '8437';
update cc_d_contact_queue set queue_type = 'External Transfer', d_project_id = (select project_id from cc_d_project where project_name = 'NC UI'), d_program_id = (select program_id from cc_d_program where program_name = 'Unemployment Insurance Helpline'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'External Transfer NCUI'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'North Carolina'),service_seconds= 30, interval_minutes = 15 where queue_number = '8325';

commit;


-- Agent Routing groups

update cc_c_agent_rtg_grp 
set project_name = 'NC UI', 
program_name = 'Unemployment Insurance Helpline', 
region_name = 'Eastern', 
state_name = 'North Carolina' 
where agent_routing_group_number in (5530);


insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5530);

commit;

			