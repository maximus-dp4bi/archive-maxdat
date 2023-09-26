alter session set current_schema = cisco_enterprise_cc;


-- Units of work

insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Consumer English Callback','CALL_BACK',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('BNA Consumer Assistance Callback','CALL_BACK',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('BNA Technical Assistance Callback','CALL_BACK',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Consumer Other Callback','CALL_BACK',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Consumer Spanish Callback','CALL_BACK',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Callback Cancel by Caller','CALL_BACK',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);


insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Consumer English Callback','CALL_BACK',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('BNA Consumer Assistance Callback','CALL_BACK',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('BNA Technical Assistance Callback','CALL_BACK',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Consumer Other Callback','CALL_BACK',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Consumer Spanish Callback','CALL_BACK',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Callback Cancel by Caller','CALL_BACK',1, 'N', 'Seconds', 1, 0);


commit;

-- contact queues


update cc_c_contact_queue set queue_type = 'Callback Offered'
where queue_number in (8720, 8725, 8730, 8799);

update cc_c_contact_queue set queue_type = 'Callback Waiting', Unit_of_work_name = 'Consumer English', project_name = 'New Jersey State Based Exchange', program_name = 'Get Covered New Jersey', region_name = 'Eastern', state_name = 'New Jersey', service_percent = 80, service_seconds = 30, interval_minutes = 15 where queue_number = 8823;
update cc_c_contact_queue set queue_type = 'Callback', Unit_of_work_name = 'Consumer English Callback', project_name = 'New Jersey State Based Exchange', program_name = 'Get Covered New Jersey', region_name = 'Eastern', state_name = 'New Jersey', service_percent = 80, service_seconds = 30, interval_minutes = 15 where queue_number = 8824;
update cc_c_contact_queue set queue_type = 'Callback Waiting', Unit_of_work_name = 'BNA Consumer Assistance', project_name = 'New Jersey State Based Exchange', program_name = 'Get Covered New Jersey', region_name = 'Eastern', state_name = 'New Jersey', service_percent = 80, service_seconds = 30, interval_minutes = 15 where queue_number = 8825;
update cc_c_contact_queue set queue_type = 'Callback', Unit_of_work_name = 'BNA Consumer Assistance Callback', project_name = 'New Jersey State Based Exchange', program_name = 'Get Covered New Jersey', region_name = 'Eastern', state_name = 'New Jersey', service_percent = 80, service_seconds = 30, interval_minutes = 15 where queue_number = 8826;
update cc_c_contact_queue set queue_type = 'Callback Waiting', Unit_of_work_name = 'BNA Technical Assistance', project_name = 'New Jersey State Based Exchange', program_name = 'Get Covered New Jersey', region_name = 'Eastern', state_name = 'New Jersey', service_percent = 80, service_seconds = 30, interval_minutes = 15 where queue_number = 8827;
update cc_c_contact_queue set queue_type = 'Callback', Unit_of_work_name = 'BNA Technical Assistance Callback', project_name = 'New Jersey State Based Exchange', program_name = 'Get Covered New Jersey', region_name = 'Eastern', state_name = 'New Jersey', service_percent = 80, service_seconds = 30, interval_minutes = 15 where queue_number = 8828;
update cc_c_contact_queue set queue_type = 'Callback Waiting', Unit_of_work_name = 'Consumer Other', project_name = 'New Jersey State Based Exchange', program_name = 'Get Covered New Jersey', region_name = 'Eastern', state_name = 'New Jersey', service_percent = 80, service_seconds = 30, interval_minutes = 15 where queue_number = 8829;
update cc_c_contact_queue set queue_type = 'Callback', Unit_of_work_name = 'Consumer Other Callback', project_name = 'New Jersey State Based Exchange', program_name = 'Get Covered New Jersey', region_name = 'Eastern', state_name = 'New Jersey', service_percent = 80, service_seconds = 30, interval_minutes = 15 where queue_number = 8830;
update cc_c_contact_queue set queue_type = 'Callback Waiting', Unit_of_work_name = 'Consumer Spanish', project_name = 'New Jersey State Based Exchange', program_name = 'Get Covered New Jersey', region_name = 'Eastern', state_name = 'New Jersey', service_percent = 80, service_seconds = 30, interval_minutes = 15 where queue_number = 8831;
update cc_c_contact_queue set queue_type = 'Callback', Unit_of_work_name = 'Consumer Spanish Callback', project_name = 'New Jersey State Based Exchange', program_name = 'Get Covered New Jersey', region_name = 'Eastern', state_name = 'New Jersey', service_percent = 80, service_seconds = 30, interval_minutes = 15 where queue_number = 8832;
update cc_c_contact_queue set queue_type = 'Callback Cancel', Unit_of_work_name = 'Callback Cancel by Caller', project_name = 'New Jersey State Based Exchange', program_name = 'Get Covered New Jersey', region_name = 'Eastern', state_name = 'New Jersey', service_percent = 80, service_seconds = 30, interval_minutes = 15 where queue_number = 8833;

commit;

/*
update cc_c_contact_queue
set bucketintervalid = 5085
where queue_number in 
(8823,
8824,
8825,
8826,
8827,
8828,
8829,
8830,
8831,
8832,
8833
);
*/

commit;

					