alter session set nls_date_format = 'DD-MON-RR HH24:MI:SS';

alter session set current_schema = CISCO_ENTERPRISE_CC;

update cc_c_contact_queue set queue_type = 'Inbound' , service_seconds = 30, interval_minutes = 15, unit_of_work_name = 'CAC', project_name = 'MD HIX', program_name = 'MD HIX', region_name = 'Eastern', state_name = 'Maryland' where queue_number = '5841';
update cc_c_contact_queue set queue_type = 'Inbound' , service_seconds = 30, interval_minutes = 15, unit_of_work_name = 'CAC', project_name = 'MD HIX', program_name = 'MD HIX', region_name = 'Eastern', state_name = 'Maryland' where queue_number = '5842';
update cc_c_contact_queue set queue_type = 'Inbound' , service_seconds = 30, interval_minutes = 15, unit_of_work_name = 'CAC', project_name = 'MD HIX', program_name = 'MD HIX', region_name = 'Eastern', state_name = 'Maryland' where queue_number = '5851';
update cc_c_contact_queue set queue_type = 'Inbound' , service_seconds = 30, interval_minutes = 15, unit_of_work_name = 'CAC', project_name = 'MD HIX', program_name = 'MD HIX', region_name = 'Eastern', state_name = 'Maryland' where queue_number = '5852';


insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt) values ('CAC', 'INBOUND_CALL', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));

insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('CAC', 'INBOUND_CALL', 152, 'N', 'Seconds');

commit;