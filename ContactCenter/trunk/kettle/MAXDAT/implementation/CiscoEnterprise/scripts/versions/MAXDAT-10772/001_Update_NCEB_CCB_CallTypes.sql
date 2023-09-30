alter session set current_schema = cisco_enterprise_cc;

--Units of work

insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('NCEB PRV Spanish CCB', 'Callback', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('NCEB PRV English CCB', 'Callback', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('NCEB GRV Spanish CCB', 'Callback', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('NCEB GRV English CCB', 'Callback', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('NCEB GEN Spanish CCB', 'Callback', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('NCEB GEN English CCB', 'Callback', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('NCEB ENR Spanish CCB', 'Callback', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('NCEB APP Spanish CCB', 'Callback', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('NCEB DSS Spanish CCB', 'Callback', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('NCEB ENR English CCB', 'Callback', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('NCEB Appeals ENG CCB', 'Callback', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('NCEB DSS English CCB', 'Callback', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);

insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('NCEB PRV Spanish CCB', 'Callback',  1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('NCEB PRV English CCB', 'Callback',  1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('NCEB GRV Spanish CCB', 'Callback',  1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('NCEB GRV English CCB', 'Callback',  1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('NCEB GEN Spanish CCB', 'Callback',  1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('NCEB GEN English CCB', 'Callback',  1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('NCEB ENR Spanish CCB', 'Callback',  1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('NCEB APP Spanish CCB', 'Callback',  1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('NCEB DSS Spanish CCB', 'Callback',  1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('NCEB ENR English CCB', 'Callback',  1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('NCEB Appeals ENG CCB', 'Callback',  1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('NCEB DSS English CCB', 'Callback',  1, 'N', 'Seconds', 1, 0);

commit;

--Contact Queues

update cc_c_contact_queue set queue_type = 'Callback', unit_of_work_name = 'NCEB PRV Spanish CCB', project_name = 'NCEB', program_name = 'Medicaid', region_name = 'Eastern', state_name = 'North Carolina', interval_minutes = 15, service_seconds = 30, bucketintervalid = 5080 where queue_number = 8194;
update cc_c_contact_queue set queue_type = 'Callback', unit_of_work_name = 'NCEB PRV English CCB', project_name = 'NCEB', program_name = 'Medicaid', region_name = 'Eastern', state_name = 'North Carolina', interval_minutes = 15, service_seconds = 30, bucketintervalid = 5080 where queue_number = 8188;
update cc_c_contact_queue set queue_type = 'Callback', unit_of_work_name = 'NCEB GRV Spanish CCB', project_name = 'NCEB', program_name = 'Medicaid', region_name = 'Eastern', state_name = 'North Carolina', interval_minutes = 15, service_seconds = 30, bucketintervalid = 5080 where queue_number = 8193;
update cc_c_contact_queue set queue_type = 'Callback', unit_of_work_name = 'NCEB GRV English CCB', project_name = 'NCEB', program_name = 'Medicaid', region_name = 'Eastern', state_name = 'North Carolina', interval_minutes = 15, service_seconds = 30, bucketintervalid = 5080 where queue_number = 8187;
update cc_c_contact_queue set queue_type = 'Callback', unit_of_work_name = 'NCEB GEN Spanish CCB', project_name = 'NCEB', program_name = 'Medicaid', region_name = 'Eastern', state_name = 'North Carolina', interval_minutes = 15, service_seconds = 30, bucketintervalid = 5080 where queue_number = 8192;
update cc_c_contact_queue set queue_type = 'Callback', unit_of_work_name = 'NCEB GEN English CCB', project_name = 'NCEB', program_name = 'Medicaid', region_name = 'Eastern', state_name = 'North Carolina', interval_minutes = 15, service_seconds = 30, bucketintervalid = 5080 where queue_number = 8186;
update cc_c_contact_queue set queue_type = 'Callback', unit_of_work_name = 'NCEB ENR Spanish CCB', project_name = 'NCEB', program_name = 'Medicaid', region_name = 'Eastern', state_name = 'North Carolina', interval_minutes = 15, service_seconds = 30, bucketintervalid = 5080 where queue_number = 8189;
update cc_c_contact_queue set queue_type = 'Callback', unit_of_work_name = 'NCEB APP Spanish CCB', project_name = 'NCEB', program_name = 'Medicaid', region_name = 'Eastern', state_name = 'North Carolina', interval_minutes = 15, service_seconds = 30, bucketintervalid = 5080 where queue_number = 8190;
update cc_c_contact_queue set queue_type = 'Callback', unit_of_work_name = 'NCEB DSS Spanish CCB', project_name = 'NCEB', program_name = 'Medicaid', region_name = 'Eastern', state_name = 'North Carolina', interval_minutes = 15, service_seconds = 30, bucketintervalid = 5080 where queue_number = 8191;
update cc_c_contact_queue set queue_type = 'Callback', unit_of_work_name = 'NCEB ENR English CCB', project_name = 'NCEB', program_name = 'Medicaid', region_name = 'Eastern', state_name = 'North Carolina', interval_minutes = 15, service_seconds = 30, bucketintervalid = 5080 where queue_number = 8182;
update cc_c_contact_queue set queue_type = 'Callback', unit_of_work_name = 'NCEB Appeals ENG CCB', project_name = 'NCEB', program_name = 'Medicaid', region_name = 'Eastern', state_name = 'North Carolina', interval_minutes = 15, service_seconds = 30, bucketintervalid = 5080 where queue_number = 8184;
update cc_c_contact_queue set queue_type = 'Callback', unit_of_work_name = 'NCEB DSS English CCB', project_name = 'NCEB', program_name = 'Medicaid', region_name = 'Eastern', state_name = 'North Carolina', interval_minutes = 15, service_seconds = 30, bucketintervalid = 5080 where queue_number = 8185;

commit;