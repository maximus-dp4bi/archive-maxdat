alter session set current_schema = cisco_enterprise_cc;

update cc_c_contact_queue
set queue_type = 'Callback', unit_of_work_name = 'Forced Callback', interval_minutes = 15, service_seconds = 30, project_name = 'Mass Health', program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts'
where 
queue_number = 6830;

update cc_c_contact_queue
set queue_type = 'Callback', unit_of_work_name = 'Transfer to CSI Callback', interval_minutes = 15, service_seconds = 30, project_name = 'Mass Health', program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts'
where 
queue_number = 6584;

update cc_c_contact_queue
set queue_type = 'Outbound', unit_of_work_name = 'English', interval_minutes = 15, service_seconds = 30, project_name = 'Mass Health', program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts'
where 
queue_number in (6821, 6822, 6825, 6826);

update cc_c_contact_queue
set queue_type = 'Outbound', unit_of_work_name = 'Spanish', interval_minutes = 15, service_seconds = 30, project_name = 'Mass Health', program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts'
where 
queue_number in (6823, 6824, 6827, 6828);

insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', '5244');
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', '5245');

insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_PQ_PROJECT', '5244', 'Mass Health');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_PQ_PROJECT', '5245', 'Mass Health');

insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_PQ_PROGRAM', '5244', 'Customer Service Center');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_PQ_PROGRAM', '5245', 'Customer Service Center');

insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('Forced Callback', 'CALLBACK', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);

insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('Forced Callback', 'CALLBACK', 161, 'N', 'Seconds');


commit;

----------------------------------------------

---UOW Names were changed later. Updates to incorporate those

update cc_c_contact_queue
set unit_of_work_name = 'Outbound - English'
where queue_number in (6821,
6826,
6825,
6822);

update cc_c_contact_queue
set unit_of_work_name = 'Outbound - Spanish'
where queue_number in (6827,
6828,
6823,
6824);

insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('Outbound - English', 'OUTBOUND', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('Outbound - Spanish', 'OUTBOUND', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);

insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('Outbound - English', 'OUTBOUND', 161, 'N', 'Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('Outbound - Spanish', 'OUTBOUND', 161, 'N', 'Seconds');

commit;




