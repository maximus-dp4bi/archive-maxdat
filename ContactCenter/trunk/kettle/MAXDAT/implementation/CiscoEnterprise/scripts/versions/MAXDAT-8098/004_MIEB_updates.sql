alter session set current_schema = cisco_enterprise_cc;

set define off;

insert into cc_c_project_config (project_name, program_name, region_name, state_name, province_name, district_name, country_name, record_eff_dt, record_end_dt)
values ('MIEB', 'Nursing Facility Transition', 'Eastern', 'Michigan', 'Unknown', 'Unknown', 'USA', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));

insert into cc_d_program (program_id, program_name, include_in_reports_flag) values (SEQ_CC_D_PROGRAM.nextval,'Nursing Facility Transition', 1);

commit;

-- Units of work

insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('MIEB NFTS IVR Entry','IVR',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('MIEB NFTS No Agent ','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('MIEB NFTS RONA','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('MIEB NFTS After Hours','IVR',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('MIELB NFTS Emergency','IVR',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('MIEB NFTS Holiday','IVR',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('MIEB NFTS English','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);

insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('MIEB NFTS IVR Entry','IVR', 1, 'N', 'Seconds', 0, 1);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('MIEB NFTS No Agent ','Inbound', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('MIEB NFTS RONA','Inbound', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('MIEB NFTS After Hours','IVR', 1, 'N', 'Seconds', 0, 1);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('MIELB NFTS Emergency','IVR', 1, 'N', 'Seconds', 0, 1);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('MIEB NFTS Holiday','IVR', 1, 'N', 'Seconds', 0, 1);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('MIEB NFTS English','Inbound', 1, 'N', 'Seconds', 1, 0);

commit;

-- contact queues

update cc_c_contact_queue set queue_type = 'IVR', Unit_of_work_name = 'MIEB NFTS IVR Entry', project_name = 'MIEB', program_name = 'Nursing Facility Transition', region_name = 'Eastern', state_name = 'Michigan', service_seconds = 30, service_percent= 80, interval_minutes = 15 where queue_number = '7373';
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'MIEB NFTS No Agent ', project_name = 'MIEB', program_name = 'Nursing Facility Transition', region_name = 'Eastern', state_name = 'Michigan', service_seconds = 30, service_percent= 80, interval_minutes = 15 where queue_number = '7375';
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'MIEB NFTS RONA', project_name = 'MIEB', program_name = 'Nursing Facility Transition', region_name = 'Eastern', state_name = 'Michigan', service_seconds = 30, service_percent= 80, interval_minutes = 15 where queue_number = '7374';
update cc_c_contact_queue set queue_type = 'IVR', Unit_of_work_name = 'MIEB NFTS After Hours', project_name = 'MIEB', program_name = 'Nursing Facility Transition', region_name = 'Eastern', state_name = 'Michigan', service_seconds = 30, service_percent= 80, interval_minutes = 15 where queue_number = '7369';
update cc_c_contact_queue set queue_type = 'IVR', Unit_of_work_name = 'MIELB NFTS Emergency', project_name = 'MIEB', program_name = 'Nursing Facility Transition', region_name = 'Eastern', state_name = 'Michigan', service_seconds = 30, service_percent= 80, interval_minutes = 15 where queue_number = '7370';
update cc_c_contact_queue set queue_type = 'IVR', Unit_of_work_name = 'MIEB NFTS Holiday', project_name = 'MIEB', program_name = 'Nursing Facility Transition', region_name = 'Eastern', state_name = 'Michigan', service_seconds = 30, service_percent= 80, interval_minutes = 15 where queue_number = '7371';
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'MIEB NFTS English', project_name = 'MIEB', program_name = 'Nursing Facility Transition', region_name = 'Eastern', state_name = 'Michigan', service_seconds = 30, service_percent= 80, interval_minutes = 15 where queue_number = '7372';


update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'MIEB' and program_name = 'Nursing Facility Transition'), queue_type = 'IVR', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'MIEB NFTS IVR Entry'), service_seconds = 30, service_percent= 80, interval_minutes = 15 where queue_number = '7373';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'MIEB' and program_name = 'Nursing Facility Transition'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'MIEB NFTS No Agent '), service_seconds = 30, service_percent= 80, interval_minutes = 15 where queue_number = '7375';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'MIEB' and program_name = 'Nursing Facility Transition'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'MIEB NFTS RONA'), service_seconds = 30, service_percent= 80, interval_minutes = 15 where queue_number = '7374';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'MIEB' and program_name = 'Nursing Facility Transition'), queue_type = 'IVR', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'MIEB NFTS After Hours'), service_seconds = 30, service_percent= 80, interval_minutes = 15 where queue_number = '7369';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'MIEB' and program_name = 'Nursing Facility Transition'), queue_type = 'IVR', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'MIELB NFTS Emergency'), service_seconds = 30, service_percent= 80, interval_minutes = 15 where queue_number = '7370';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'MIEB' and program_name = 'Nursing Facility Transition'), queue_type = 'IVR', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'MIEB NFTS Holiday'), service_seconds = 30, service_percent= 80, interval_minutes = 15 where queue_number = '7371';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'MIEB' and program_name = 'Nursing Facility Transition'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'MIEB NFTS English'), service_seconds = 30, service_percent= 80, interval_minutes = 15 where queue_number = '7372';



update cc_d_contact_queue set queue_type = 'IVR', d_project_id = (select project_id from cc_d_project where project_name = 'MIEB'), d_program_id = (select program_id from cc_d_program where program_name = 'Nursing Facility Transition'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'MIEB NFTS IVR Entry'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Michigan'),service_seconds= 30, service_percent=80, interval_minutes = 15 where queue_number = '7373';
update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'MIEB'), d_program_id = (select program_id from cc_d_program where program_name = 'Nursing Facility Transition'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'MIEB NFTS No Agent '), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Michigan'),service_seconds= 30, service_percent=80, interval_minutes = 15 where queue_number = '7375';
update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'MIEB'), d_program_id = (select program_id from cc_d_program where program_name = 'Nursing Facility Transition'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'MIEB NFTS RONA'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Michigan'),service_seconds= 30, service_percent=80, interval_minutes = 15 where queue_number = '7374';
update cc_d_contact_queue set queue_type = 'IVR', d_project_id = (select project_id from cc_d_project where project_name = 'MIEB'), d_program_id = (select program_id from cc_d_program where program_name = 'Nursing Facility Transition'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'MIEB NFTS After Hours'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Michigan'),service_seconds= 30, service_percent=80, interval_minutes = 15 where queue_number = '7369';
update cc_d_contact_queue set queue_type = 'IVR', d_project_id = (select project_id from cc_d_project where project_name = 'MIEB'), d_program_id = (select program_id from cc_d_program where program_name = 'Nursing Facility Transition'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'MIELB NFTS Emergency'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Michigan'),service_seconds= 30, service_percent=80, interval_minutes = 15 where queue_number = '7370';
update cc_d_contact_queue set queue_type = 'IVR', d_project_id = (select project_id from cc_d_project where project_name = 'MIEB'), d_program_id = (select program_id from cc_d_program where program_name = 'Nursing Facility Transition'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'MIEB NFTS Holiday'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Michigan'),service_seconds= 30, service_percent=80, interval_minutes = 15 where queue_number = '7371';
update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'MIEB'), d_program_id = (select program_id from cc_d_program where program_name = 'Nursing Facility Transition'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'MIEB NFTS English'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Michigan'),service_seconds= 30, service_percent=80, interval_minutes = 15 where queue_number = '7372';

commit;


-- Agent Routing groups

update cc_c_agent_rtg_grp set project_name = 'MIEB', program_name = 'Nursing Facility Transition ', region_name = 'Eastern', state_name = 'Michigan' where agent_routing_group_number = 5358;

insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5358);

commit;