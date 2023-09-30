alter session set current_schema = cisco_enterprise_cc;

--Units of work

insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Inbound Assist Folsom','INBOUND',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Assist Folsom Transfer','TRANSFER',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Member Enroll Spanish','INBOUND',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Member Eligibility Spanish','INBOUND',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Member Application Status Spanish','INBOUND',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('External MHPB Spanish','INBOUND',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Member Transportation Spanish','INBOUND',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Member Other Language','INBOUND',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);

insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Inbound Assist Folsom','INBOUND', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Assist Folsom Transfer','TRANSFER', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Member Enroll Spanish','INBOUND', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Member Eligibility Spanish','INBOUND', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Member Application Status Spanish','INBOUND', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('External MHPB Spanish','INBOUND', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Member Transportation Spanish','INBOUND', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Member Other Language','INBOUND', 1, 'N', 'Seconds', 1, 0);
   
commit;

--Contact Queues

update cc_c_contact_queue
set queue_type = 'Inbound', interval_minutes = 15, service_seconds = 30, project_name = 'Mass Health', program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts' 
where queue_number in (
7821,
7844,
7845,
7846,
7847,
7848,
7849
);

update cc_c_contact_queue
set queue_type = 'Transfer', interval_minutes = 15, service_seconds = 30, project_name = 'Mass Health', program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts' 
where queue_number = 7822;

update cc_c_contact_queue set unit_of_work_name = 'Inbound Assist Folsom' where queue_number = 7821;
update cc_c_contact_queue set unit_of_work_name = 'Assist Folsom Transfer' where queue_number = 7822;
update cc_c_contact_queue set unit_of_work_name = 'Member Enroll Spanish' where queue_number = 7844;
update cc_c_contact_queue set unit_of_work_name = 'Member Eligibility Spanish' where queue_number = 7845;
update cc_c_contact_queue set unit_of_work_name = 'Member Application Status Spanish' where queue_number = 7846;
update cc_c_contact_queue set unit_of_work_name = 'External MHPB Spanish' where queue_number = 7847;
update cc_c_contact_queue set unit_of_work_name = 'Member Transportation Spanish' where queue_number = 7848;
update cc_c_contact_queue set unit_of_work_name = 'Member Other Language' where queue_number = 7849;

commit;

-- Agent Routing groups

update cc_c_agent_rtg_grp
set project_name = 'Mass Health', program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts'
where agent_routing_Group_number in (
5444,
5445,
5446,
5447,
5448,
5449,
5450,
5451
);

insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5444);
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5445);
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5446);
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5447);
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5448);
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5449);
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5450);
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5451);

commit;