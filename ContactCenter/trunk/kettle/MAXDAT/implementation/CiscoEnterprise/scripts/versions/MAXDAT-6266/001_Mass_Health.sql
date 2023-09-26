alter session set current_schema = cisco_enterprise_cc;

/* CONTACT QUEUE */
update cc_c_contact_queue set unit_of_work_name='SS Eligibility', service_seconds='30', interval_minutes ='15', queue_type='Inbound', project_name='Mass Health', program_name='Customer Service Center', region_name='Eastern', state_name='Massachusetts' where queue_number ='7079';

insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_INC','7079');

/* PRECISION QUEUE */
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC','5293');

insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_PQ_PROJECT', '5293', 'Mass Health');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_PQ_PROGRAM', '5293', 'Customer Service Center');

/* UNIT OF WORK */
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('SS Eligibility','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('SS Eligibility','INBOUND_CALL',1,'N','Seconds');

commit;
