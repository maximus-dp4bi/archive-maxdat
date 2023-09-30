alter session set current_schema = cisco_enterprise_cc;

-- Units of work

insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Research Special Project','INBOUND',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Special Projects FCCB','Callback',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Health Plan FCCB','Callback',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Health Plan English','INBOUND',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
--insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Special Projects FCCB','Callback',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Special Project External','INBOUND',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Community Partners FCCB','Callback',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Community Partners','INBOUND',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Member Fair Hearing App Support FCCB','Callback',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Member Fair Hearing App Support Eng','INBOUND',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Member Health Plans Spanish','INBOUND',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Member Health Plans Spanish Q','INBOUND',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Fair Hearing App Support Spanish','INBOUND',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Fair Hearing App Support Spanish Q','INBOUND',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);


insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Research Special Project','INBOUND',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Special Projects FCCB','Callback',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Health Plan FCCB','Callback',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Health Plan English','INBOUND',1, 'N', 'Seconds', 1, 0);
--insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Special Projects FCCB','Callback',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Special Project External','INBOUND',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Community Partners FCCB','Callback',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Community Partners','INBOUND',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Member Fair Hearing App Support FCCB','Callback',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Member Fair Hearing App Support Eng','INBOUND',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Member Health Plans Spanish','INBOUND',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Member Health Plans Spanish Q','INBOUND',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Fair Hearing App Support Spanish','INBOUND',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Fair Hearing App Support Spanish Q','INBOUND',1, 'N', 'Seconds', 1, 0);

commit;

-- contact queues

update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'Research Special Project', project_name = 'Mass Health', program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number = 8977;
update cc_c_contact_queue set queue_type = 'Call Back',Unit_of_work_name = 'Special Projects FCCB', project_name = 'Mass Health', program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number = 8978;
update cc_c_contact_queue set queue_type = 'Inbound',Unit_of_work_name = 'Research Special Project', project_name = 'Mass Health', program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number = 8979;
update cc_c_contact_queue set queue_type = 'Call Back',Unit_of_work_name = 'Health Plan FCCB', project_name = 'Mass Health', program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number = 8980;
update cc_c_contact_queue set queue_type = 'Inbound',Unit_of_work_name = 'Health Plan English', project_name = 'Mass Health', program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number = 8981;
update cc_c_contact_queue set queue_type = 'Inbound',Unit_of_work_name = 'Health Plan English', project_name = 'Mass Health', program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number = 8982;
update cc_c_contact_queue set queue_type = 'Call Back',Unit_of_work_name = 'Special Projects FCCB', project_name = 'Mass Health', program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number = 8983;
update cc_c_contact_queue set queue_type = 'Inbound',Unit_of_work_name = 'Special Project External', project_name = 'Mass Health', program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number = 8984;
update cc_c_contact_queue set queue_type = 'Inbound',Unit_of_work_name = 'Special Project External', project_name = 'Mass Health', program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number = 8985;
update cc_c_contact_queue set queue_type = 'Call Back',Unit_of_work_name = 'Community Partners FCCB', project_name = 'Mass Health', program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number = 8986;
update cc_c_contact_queue set queue_type = 'Inbound',Unit_of_work_name = 'Community Partners', project_name = 'Mass Health', program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number = 8987;
update cc_c_contact_queue set queue_type = 'Inbound',Unit_of_work_name = 'Community Partners', project_name = 'Mass Health', program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number = 8988;
update cc_c_contact_queue set queue_type = 'Call Back',Unit_of_work_name = 'Member Fair Hearing App Support FCCB', project_name = 'Mass Health', program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number = 8989;
update cc_c_contact_queue set queue_type = 'Inbound',Unit_of_work_name = 'Member Fair Hearing App Support Eng', project_name = 'Mass Health', program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number = 8990;
update cc_c_contact_queue set queue_type = 'Inbound',Unit_of_work_name = 'Member Fair Hearing App Support Eng', project_name = 'Mass Health', program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number = 8991;
update cc_c_contact_queue set queue_type = 'Inbound',Unit_of_work_name = 'Member Health Plans Spanish', project_name = 'Mass Health', program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number = 8992;
update cc_c_contact_queue set queue_type = 'Inbound',Unit_of_work_name = 'Member Health Plans Spanish Q', project_name = 'Mass Health', program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number = 8993;
update cc_c_contact_queue set queue_type = 'Inbound',Unit_of_work_name = 'Fair Hearing App Support Spanish', project_name = 'Mass Health', program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number = 8994;
update cc_c_contact_queue set queue_type = 'Inbound',Unit_of_work_name = 'Fair Hearing App Support Spanish Q', project_name = 'Mass Health', program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number = 8995;

commit;

-- Agent Routing groups

update cc_c_agent_rtg_grp 
set project_name = 'Mass Health', 
program_name = 'Customer Service Center', 
region_name = 'Eastern', 
state_name = 'Massachusetts' 
where agent_routing_group_number in 
(5514,
5582,
5583,
5584,
5585,
5586,
5587
);


insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5514);
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5582);
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5583);
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5584);
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5585);
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5586);
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5587);

commit;
					