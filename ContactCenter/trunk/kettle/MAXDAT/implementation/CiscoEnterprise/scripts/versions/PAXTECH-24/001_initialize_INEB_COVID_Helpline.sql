alter session set current_schema = cisco_enterprise_cc;

insert into cc_c_project_config (project_name, program_name, region_name, state_name, province_name, district_name, country_name, record_eff_dt, record_end_dt)
values ('IN EB', 'COVID-19 Information Helpline', 'Eastern', 'Indiana', 'Unknown', 'Unknown', 'USA', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));

insert into cc_d_program (program_id, program_name, include_in_reports_flag) values (SEQ_CC_D_PROGRAM.nextval, 'COVID-19 Information Helpline', 1 );

commit;

-- Units of work

insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('ININ_CO19_Main','IVR',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('ININ_CO19_Q_ENG','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('ININ_CO19_Q_RONA','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('ININ_CO19_ENG_NoAgents','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);


insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('ININ_CO19_Main','IVR', 1, 'N', 'Seconds', 0, 1);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('ININ_CO19_Q_ENG','INBOUND_CALL', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('ININ_CO19_Q_RONA','INBOUND_CALL', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('ININ_CO19_ENG_NoAgents','INBOUND_CALL', 1, 'N', 'Seconds', 1, 0);

commit;

-- contact queues

update cc_c_contact_queue set queue_type = 'IVR', Unit_of_work_name = 'ININ_CO19_Main', project_name = 'IN EB', program_name = 'COVID-19 Information Helpline', region_name = 'Eastern', state_name = 'Indiana', service_seconds = 30, interval_minutes = 15 where queue_number = 8284;
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'ININ_CO19_Q_ENG', project_name = 'IN EB', program_name = 'COVID-19 Information Helpline', region_name = 'Eastern', state_name = 'Indiana', service_seconds = 30, interval_minutes = 15 where queue_number = 8285;
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'ININ_CO19_Q_RONA', project_name = 'IN EB', program_name = 'COVID-19 Information Helpline', region_name = 'Eastern', state_name = 'Indiana', service_seconds = 30, interval_minutes = 15 where queue_number = 8286;
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'ININ_CO19_ENG_NoAgents', project_name = 'IN EB', program_name = 'COVID-19 Information Helpline', region_name = 'Eastern', state_name = 'Indiana', service_seconds = 30, interval_minutes = 15 where queue_number = 8283;

update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'IN EB' and program_name = 'COVID-19 Information Helpline'), queue_type = 'IVR', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'ININ_CO19_Main'), service_seconds = 30, interval_minutes = 15 where queue_number =8284;
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'IN EB' and program_name = 'COVID-19 Information Helpline'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'ININ_CO19_Q_ENG'), service_seconds = 30, interval_minutes = 15 where queue_number =8285;
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'IN EB' and program_name = 'COVID-19 Information Helpline'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'ININ_CO19_Q_RONA'), service_seconds = 30, interval_minutes = 15 where queue_number =8286;
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'IN EB' and program_name = 'COVID-19 Information Helpline'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'ININ_CO19_ENG_NoAgents'), service_seconds = 30, interval_minutes = 15 where queue_number =8283;

update cc_d_contact_queue set queue_type = 'IVR', d_project_id = (select project_id from cc_d_project where project_name = 'IN EB'), d_program_id = (select program_id from cc_d_program where program_name = 'COVID-19 Information Helpline'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'ININ_CO19_Main'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Indiana'),service_seconds= 30, interval_minutes = 15 where queue_number = 8284;
update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'IN EB'), d_program_id = (select program_id from cc_d_program where program_name = 'COVID-19 Information Helpline'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'ININ_CO19_Q_ENG'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Indiana'),service_seconds= 30, interval_minutes = 15 where queue_number = 8285;
update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'IN EB'), d_program_id = (select program_id from cc_d_program where program_name = 'COVID-19 Information Helpline'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'ININ_CO19_Q_RONA'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Indiana'),service_seconds= 30, interval_minutes = 15 where queue_number = 8286;
update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'IN EB'), d_program_id = (select program_id from cc_d_program where program_name = 'COVID-19 Information Helpline'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'ININ_CO19_ENG_NoAgents'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Indiana'),service_seconds= 30, interval_minutes = 15 where queue_number = 8283;


commit;


-- Agent Routing groups

update cc_c_agent_rtg_grp 
set project_name = 'IN EB', 
program_name = 'COVID-19 Information Helpline', 
region_name = 'Eastern', 
state_name = 'Indiana' 
where agent_routing_group_number in (5513);


insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5513);


commit;


	

					