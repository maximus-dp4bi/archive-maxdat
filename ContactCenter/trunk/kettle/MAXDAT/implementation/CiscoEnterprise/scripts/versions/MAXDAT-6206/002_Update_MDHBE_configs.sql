alter session set current_schema = cisco_enterprise_cc;

update cc_c_contact_queue
set unit_of_work_name = 'MCO', service_percent = 0
where queue_number in (7005, 7006, 7010);

update cc_c_contact_queue
set unit_of_work_name = 'MCO - SPA', service_percent = 0
where queue_number in (7007, 7011, 7013);

--insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('MCO', 'Inbound', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('MCO - SPA', 'Inbound', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);

--insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('MCO', 'Inbound', 161, 'N', 'Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('MCO - SPA', 'Inbound', 161, 'N', 'Seconds');

commit;
