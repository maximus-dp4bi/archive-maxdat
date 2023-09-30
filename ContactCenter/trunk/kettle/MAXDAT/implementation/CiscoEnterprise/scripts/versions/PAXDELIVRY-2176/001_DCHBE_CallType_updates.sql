alter session set current_schema = cisco_enterprise_cc;

insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('SPANISH CCB CT','Callback',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('ENGLISH CCB CT','Callback',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);


insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('SPANISH CCB CT','Callback',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('ENGLISH CCB CT','Callback',1, 'N', 'Seconds', 1, 0);


update cc_c_contact_queue set queue_name = 'WADC_DCEB_7802_SSENQ_CCB', queue_type = 'Callback',Unit_of_work_name = 'SPANISH CCB CT', project_name = 'DC EB',  program_name = 'Managed Care Medicaid', region_name = 'Eastern', state_name = 'District of Columbia', service_seconds = 15, interval_minutes = 15 where queue_number =9171;
update cc_c_contact_queue set queue_type = 'Callback',Unit_of_work_name = 'ENGLISH CCB CT', project_name = 'DC EB',  program_name = 'Managed Care Medicaid', region_name = 'Eastern', state_name = 'District of Columbia', service_seconds = 15, interval_minutes = 15 where queue_number =9172;


commit;