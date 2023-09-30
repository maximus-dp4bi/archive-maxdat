ALTER SESSION SET CURRENT_SCHEMA = CISCO_ENTERPRISE_CC;

/* CONTACT QUEUE */
/* QUEUE_NUMBER 7075 didn't exist in DEV, so couldn't run Update below - Had to create Insert statement on DEV */
update cc_c_contact_queue set unit_of_work_name = 'Boston MA Pay Reform', service_seconds = '30', interval_minutes = '15', queue_type = 'Inbound', project_name = 'Mass Health', program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts' where queue_number =7075;

/*
insert into cc_c_contact_queue (queue_number, queue_name, queue_type, service_percent, service_seconds, interval_minutes, unit_of_work_name, project_name, program_name, region_name, state_name, province_name, district_name, country_name, record_eff_dt, record_end_dt)
values
('7075','VAHM_MAMH_1839_PYRFM_Q','Inbound','0','30','15','Boston MA Pay Reform','Mass Health','Customer Service Center','Eastern','Massachusetts','Unknown','Unknown','USA',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));
*/

/* SKILL SET */
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', '5292');

insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_PQ_PROJECT', '5292', 'Mass Health');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_PQ_PROGRAM', '5292', 'Customer Service Center');

/* UOF */
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('Boston MA Pay Reform','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('Boston MA Pay Reform','INBOUND_CALL',1,'N','Seconds');

COMMIT;