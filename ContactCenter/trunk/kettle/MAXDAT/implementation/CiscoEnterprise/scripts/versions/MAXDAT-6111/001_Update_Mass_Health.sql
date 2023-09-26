ALTER SESSION SET CURRENT_SCHEMA = CISCO_ENTERPRISE_CC;

/* CONTACT QUEUE */
update cc_c_contact_queue set unit_of_work_name = 'Boston MA Phone App - ENG', service_seconds = '30', interval_minutes = '15', queue_type = 'Inbound', project_name = 'Mass Health', program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts' where queue_number =7019;
update cc_c_contact_queue set unit_of_work_name = 'Boston MA Phone App - SPA', service_seconds = '30', interval_minutes = '15', queue_type = 'Inbound', project_name = 'Mass Health', program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts' where queue_number =7020;


/* SKILL SET */
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', '5282');
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', '5281');


insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_PQ_PROJECT', '5282', 'Mass Health');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_PQ_PROGRAM', '5282', 'Customer Service Center');


insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_PQ_PROJECT', '5281', 'Mass Health');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_PQ_PROGRAM', '5281', 'Customer Service Center');


insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('Boston MA Phone App - ENG','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('Boston MA Phone App - SPA','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);

insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('Boston MA Phone App - ENG','INBOUND_CALL',1,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('Boston MA Phone App - SPA','INBOUND_CALL',1,'N','Seconds');



COMMIT;