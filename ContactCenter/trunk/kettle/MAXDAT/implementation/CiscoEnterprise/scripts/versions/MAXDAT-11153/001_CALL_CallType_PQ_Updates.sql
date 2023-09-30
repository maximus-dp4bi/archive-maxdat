alter session set current_schema = cisco_enterprise_cc;

--Units of work

insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('RNEW CAN QUEUE','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('RNEW ENG QUEUE','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('RNEW JAP QUEUE','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('RNEW KOR QUEUE','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('RNEW MAN QUEUE','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('RNEW SPA QUEUE','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('RNEW TAG QUEUE','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('RNEW VIE QUEUE','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('SPST ENG QUEUE','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('CAFM CALL LLIVR Main','IVR',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);


insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('RNEW CAN QUEUE','Inbound', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('RNEW ENG QUEUE','Inbound', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('RNEW JAP QUEUE','Inbound', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('RNEW KOR QUEUE','Inbound', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('RNEW MAN QUEUE','Inbound', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('RNEW SPA QUEUE','Inbound', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('RNEW TAG QUEUE','Inbound', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('RNEW VIE QUEUE','Inbound', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('SPST ENG QUEUE','Inbound', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('CAFM CALL LLIVR Main','IVR', 1, 'N', 'Seconds', 0, 1);


commit;

-- Contact queues

update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'RNEW CAN QUEUE', project_name = 'CA Lifeline', program_name = 'Customer Service Center', region_name = 'West', state_name = 'California',  interval_minutes = 15, service_seconds = 30 where queue_number = '8223';
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'RNEW ENG QUEUE', project_name = 'CA Lifeline', program_name = 'Customer Service Center', region_name = 'West', state_name = 'California',  interval_minutes = 15, service_seconds = 30 where queue_number = '8224';
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'RNEW JAP QUEUE', project_name = 'CA Lifeline', program_name = 'Customer Service Center', region_name = 'West', state_name = 'California',  interval_minutes = 15, service_seconds = 30 where queue_number = '8225';
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'RNEW KOR QUEUE', project_name = 'CA Lifeline', program_name = 'Customer Service Center', region_name = 'West', state_name = 'California',  interval_minutes = 15, service_seconds = 30 where queue_number = '8226';
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'RNEW MAN QUEUE', project_name = 'CA Lifeline', program_name = 'Customer Service Center', region_name = 'West', state_name = 'California',  interval_minutes = 15, service_seconds = 30 where queue_number = '8227';
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'RNEW SPA QUEUE', project_name = 'CA Lifeline', program_name = 'Customer Service Center', region_name = 'West', state_name = 'California',  interval_minutes = 15, service_seconds = 30 where queue_number = '8228';
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'RNEW TAG QUEUE', project_name = 'CA Lifeline', program_name = 'Customer Service Center', region_name = 'West', state_name = 'California',  interval_minutes = 15, service_seconds = 30 where queue_number = '8229';
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'RNEW VIE QUEUE', project_name = 'CA Lifeline', program_name = 'Customer Service Center', region_name = 'West', state_name = 'California',  interval_minutes = 15, service_seconds = 30 where queue_number = '8230';
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'SPST ENG QUEUE', project_name = 'CA Lifeline', program_name = 'Customer Service Center', region_name = 'West', state_name = 'California',  interval_minutes = 15, service_seconds = 30 where queue_number = '8231';
update cc_c_contact_queue set queue_type = 'IVR', Unit_of_work_name = 'CAFM CALL LLIVR Main', project_name = 'CA Lifeline', program_name = 'Customer Service Center', region_name = 'West', state_name = 'California',  interval_minutes = 15, service_seconds = 30 where queue_number = '8232';


update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'CA Lifeline' and program_name = 'Customer Service Center'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'RNEW CAN QUEUE'),  interval_minutes = 15, service_seconds = 30 where queue_number = '8223';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'CA Lifeline' and program_name = 'Customer Service Center'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'RNEW ENG QUEUE'),  interval_minutes = 15, service_seconds = 30 where queue_number = '8224';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'CA Lifeline' and program_name = 'Customer Service Center'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'RNEW JAP QUEUE'),  interval_minutes = 15, service_seconds = 30 where queue_number = '8225';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'CA Lifeline' and program_name = 'Customer Service Center'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'RNEW KOR QUEUE'),  interval_minutes = 15, service_seconds = 30 where queue_number = '8226';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'CA Lifeline' and program_name = 'Customer Service Center'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'RNEW MAN QUEUE'),  interval_minutes = 15, service_seconds = 30 where queue_number = '8227';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'CA Lifeline' and program_name = 'Customer Service Center'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'RNEW SPA QUEUE'),  interval_minutes = 15, service_seconds = 30 where queue_number = '8228';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'CA Lifeline' and program_name = 'Customer Service Center'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'RNEW TAG QUEUE'),  interval_minutes = 15, service_seconds = 30 where queue_number = '8229';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'CA Lifeline' and program_name = 'Customer Service Center'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'RNEW VIE QUEUE'),  interval_minutes = 15, service_seconds = 30 where queue_number = '8230';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'CA Lifeline' and program_name = 'Customer Service Center'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'SPST ENG QUEUE'),  interval_minutes = 15, service_seconds = 30 where queue_number = '8231';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'CA Lifeline' and program_name = 'Customer Service Center'), queue_type = 'IVR', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'CAFM CALL LLIVR Main'),  interval_minutes = 15, service_seconds = 30 where queue_number = '8232';


update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'CA Lifeline'), d_program_id = (select program_id from cc_d_program where program_name = 'Customer Service Center'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'RNEW CAN QUEUE'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'California'),  interval_minutes = 15, service_seconds = 30 where queue_number = '8223';
update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'CA Lifeline'), d_program_id = (select program_id from cc_d_program where program_name = 'Customer Service Center'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'RNEW ENG QUEUE'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'California'),  interval_minutes = 15, service_seconds = 30 where queue_number = '8224';
update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'CA Lifeline'), d_program_id = (select program_id from cc_d_program where program_name = 'Customer Service Center'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'RNEW JAP QUEUE'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'California'),  interval_minutes = 15, service_seconds = 30 where queue_number = '8225';
update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'CA Lifeline'), d_program_id = (select program_id from cc_d_program where program_name = 'Customer Service Center'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'RNEW KOR QUEUE'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'California'),  interval_minutes = 15, service_seconds = 30 where queue_number = '8226';
update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'CA Lifeline'), d_program_id = (select program_id from cc_d_program where program_name = 'Customer Service Center'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'RNEW MAN QUEUE'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'California'),  interval_minutes = 15, service_seconds = 30 where queue_number = '8227';
update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'CA Lifeline'), d_program_id = (select program_id from cc_d_program where program_name = 'Customer Service Center'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'RNEW SPA QUEUE'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'California'),  interval_minutes = 15, service_seconds = 30 where queue_number = '8228';
update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'CA Lifeline'), d_program_id = (select program_id from cc_d_program where program_name = 'Customer Service Center'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'RNEW TAG QUEUE'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'California'),  interval_minutes = 15, service_seconds = 30 where queue_number = '8229';
update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'CA Lifeline'), d_program_id = (select program_id from cc_d_program where program_name = 'Customer Service Center'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'RNEW VIE QUEUE'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'California'),  interval_minutes = 15, service_seconds = 30 where queue_number = '8230';
update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'CA Lifeline'), d_program_id = (select program_id from cc_d_program where program_name = 'Customer Service Center'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'SPST ENG QUEUE'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'California'),  interval_minutes = 15, service_seconds = 30 where queue_number = '8231';
update cc_d_contact_queue set queue_type = 'IVR', d_project_id = (select project_id from cc_d_project where project_name = 'CA Lifeline'), d_program_id = (select program_id from cc_d_program where program_name = 'Customer Service Center'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'CAFM CALL LLIVR Main'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'California'),  interval_minutes = 15, service_seconds = 30 where queue_number = '8232';


commit;


-- Agent Routing groups

update cc_c_agent_rtg_grp
set project_name = 'CA Lifeline', program_name = 'Customer Service Center', region_name = 'West', state_name = 'California'
where agent_routing_Group_number in
(5501,
5502,
5503,
5504,
5505,
5506,
5507,
5508
);

insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5501);
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5502);
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5503);
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5504);
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5505);
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5506);
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5507);
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5508);

commit;

