alter session set current_schema = cisco_enterprise_cc;

-- Units of work

insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Priority Phone App','INBOUND',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Member Eligibility Plan FCCB','Callback',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Member Eligibility Plan','INBOUND',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Taxform FCCB','Callback',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Taxform','INBOUND',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Taxform Spanish FCCB','Callback',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Taxform Spanish','INBOUND',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('MECSPLHD FCCB','Callback',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('MECSPLHDL','INBOUND',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Member Phone Spanish FCCB','Callback',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Member Phone App Spanish','INBOUND',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Phone Transfer App','INBOUND',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Pay Reform','INBOUND',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Internal Transfer','TRANSFER',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);

insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Priority Phone App','INBOUND',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Member Eligibility Plan FCCB','Callback',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Member Eligibility Plan','INBOUND',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Taxform FCCB','Callback',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Taxform','INBOUND',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Taxform Spanish FCCB','Callback',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Taxform Spanish','INBOUND',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('MECSPLHD FCCB','Callback',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('MECSPLHDL','INBOUND',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Member Phone Spanish FCCB','Callback',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Member Phone App Spanish','INBOUND',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Phone Transfer App','INBOUND',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Pay Reform','INBOUND',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Internal Transfer','TRANSFER',1, 'N', 'Seconds', 1, 0);

commit;

-- contact queues

update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'Priority Phone App', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number = 9008;
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'Priority Phone App', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number = 9009;
update cc_c_contact_queue set queue_type = 'Callback', Unit_of_work_name = 'Member Eligibility Plan FCCB', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number = 9010;
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'Member Eligibility Plan', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number = 9011;
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'Member Eligibility Plan', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number = 9012;
update cc_c_contact_queue set queue_type = 'Callback', Unit_of_work_name = 'Taxform FCCB', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number = 9013;
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'Taxform', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number = 9014;
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'Taxform', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number = 9015;
update cc_c_contact_queue set queue_type = 'Callback', Unit_of_work_name = 'Taxform Spanish FCCB', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number = 9016;
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'Taxform Spanish', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number = 9017;
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'Taxform Spanish', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number = 9018;
update cc_c_contact_queue set queue_type = 'Callback', Unit_of_work_name = 'MECSPLHD FCCB', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number = 9019;
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'MECSPLHDL', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number = 9020;
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'MECSPLHDL', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number = 9021;
update cc_c_contact_queue set queue_type = 'Callback', Unit_of_work_name = 'Member Phone Spanish FCCB', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number = 9022;
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'Member Phone App Spanish', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number = 9023;
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'Member Phone App Spanish', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number = 9024;
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'Phone Transfer App', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number = 9032;
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'Pay Reform', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number = 9033;
update cc_c_contact_queue set queue_type = 'Transfer', Unit_of_work_name = 'Internal Transfer', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number = 9034;

commit;

-- Agent Routing groups

update cc_c_agent_rtg_grp 
set project_name = 'Mass Health', 
program_name = 'Customer Service Center', 
region_name = 'Eastern', 
state_name = 'Massachusetts' 
where agent_routing_group_number in 
(5588,
5589,
5590,
5591,
5592,
5593
);


insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5588);
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5589);
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5590);
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5591);
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5592);
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5593);

commit;					