alter session set current_schema = cisco_enterprise_cc;

-- Units of work

insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Run Ext. Script Failed','IVR',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('ILEB ENG LMAI Queue','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('ILEB ENG MAI Queue','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('ILEB SPA LMAI Queue','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('ILEB SPA MAI Queue','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);


insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Run Ext. Script Failed','IVR', 1, 'N', 'Seconds', 0, 1);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('ILEB ENG LMAI Queue','Inbound', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('ILEB ENG MAI Queue','Inbound', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('ILEB SPA LMAI Queue','Inbound', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('ILEB SPA MAI Queue','Inbound', 1, 'N', 'Seconds', 1, 0);

commit;

-- contact queues

update cc_c_contact_queue set queue_type = 'IVR', Unit_of_work_name = 'Run Ext. Script Failed', project_name = 'IL EB', program_name = 'Multiple', region_name = 'Central', state_name = 'Illinois', service_seconds = 30, interval_minutes = 15 where queue_number = 7349;
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'ILEB ENG LMAI Queue', project_name = 'IL EB', program_name = 'Multiple', region_name = 'Central', state_name = 'Illinois', service_seconds = 30, interval_minutes = 15 where queue_number = 7350;
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'ILEB ENG MAI Queue', project_name = 'IL EB', program_name = 'Multiple', region_name = 'Central', state_name = 'Illinois', service_seconds = 30, interval_minutes = 15 where queue_number = 7351;
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'ILEB SPA LMAI Queue', project_name = 'IL EB', program_name = 'Multiple', region_name = 'Central', state_name = 'Illinois', service_seconds = 30, interval_minutes = 15 where queue_number = 7352;
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'ILEB SPA MAI Queue', project_name = 'IL EB', program_name = 'Multiple', region_name = 'Central', state_name = 'Illinois', service_seconds = 30, interval_minutes = 15 where queue_number = 7353;

update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'IL EB' and program_name = 'Multiple'), queue_type = 'IVR', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'Run Ext. Script Failed'), service_seconds = 30, interval_minutes = 15 where queue_number =7349;
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'IL EB' and program_name = 'Multiple'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'ILEB ENG LMAI Queue'), service_seconds = 30, interval_minutes = 15 where queue_number =7350;
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'IL EB' and program_name = 'Multiple'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'ILEB ENG MAI Queue'), service_seconds = 30, interval_minutes = 15 where queue_number =7351;
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'IL EB' and program_name = 'Multiple'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'ILEB SPA LMAI Queue'), service_seconds = 30, interval_minutes = 15 where queue_number =7352;
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'IL EB' and program_name = 'Multiple'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'ILEB SPA MAI Queue'), service_seconds = 30, interval_minutes = 15 where queue_number =7353;

update cc_d_contact_queue set queue_type = 'IVR', d_project_id = (select project_id from cc_d_project where project_name = 'IL EB'), d_program_id = (select program_id from cc_d_program where program_name = 'Multiple'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'Run Ext. Script Failed'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Illinois'),service_seconds= 30, interval_minutes = 15 where queue_number = 7349;
update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'IL EB'), d_program_id = (select program_id from cc_d_program where program_name = 'Multiple'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'ILEB ENG LMAI Queue'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Illinois'),service_seconds= 30, interval_minutes = 15 where queue_number = 7350;
update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'IL EB'), d_program_id = (select program_id from cc_d_program where program_name = 'Multiple'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'ILEB ENG MAI Queue'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Illinois'),service_seconds= 30, interval_minutes = 15 where queue_number = 7351;
update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'IL EB'), d_program_id = (select program_id from cc_d_program where program_name = 'Multiple'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'ILEB SPA LMAI Queue'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Illinois'),service_seconds= 30, interval_minutes = 15 where queue_number = 7352;
update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'IL EB'), d_program_id = (select program_id from cc_d_program where program_name = 'Multiple'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'ILEB SPA MAI Queue'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Illinois'),service_seconds= 30, interval_minutes = 15 where queue_number = 7353;


commit;


-- Agent Routing groups

update cc_c_agent_rtg_grp 
set project_name = 'IL EB', 
program_name = 'Multiple', 
region_name = 'Central', 
state_name = 'Illinois' 
where agent_routing_group_number in 
(5352,
5353,
5354,
5355
);


insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5352);
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5353);
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5354);
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5355);

commit;


	

					