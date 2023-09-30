ALTER SESSION SET CURRENT_SCHEMA = CISCO_ENTERPRISE_CC;

/* CONTACT QUEUE */
insert into cc_c_contact_queue 
(queue_number, queue_name, queue_type, service_percent, service_seconds, interval_minutes, unit_of_work_name, project_name, program_name, region_name, state_name, province_name, district_name, country_name, record_eff_dt, record_end_dt)
values
(7073,'WYCH_DHCS_2127_SSESC','Escalation',0,0,15,'Spanish','Wyoming Dept of Health','Medicaid / CHIP', 'West', 'Wyoming', 'Unknown', 'Unknown', 'USA', to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'));

update cc_c_contact_queue set unit_of_work_name='English', interval_minutes ='15', queue_type='Escalation', project_name='Wyoming Dept of Health', program_name='Medicaid / CHIP', region_name='West', state_name='Wyoming' where queue_number ='7072';


insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_INC','7072');
insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_INC','7073');

/* SKILL SET */
/* 5290 */
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_PQ_PROJECT', '5290', 'Wyoming Dept of Health');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_PQ_PROGRAM', '5290', 'Medicaid / CHIP');

/* 5289 */
-- update cc_c_filter set filter_type='ACD_CALL_TYPE_ID_INC' where value='5289';
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_PQ_PROJECT', '5289', 'Wyoming Dept of Health');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_PQ_PROGRAM', '5289', 'Medicaid / CHIP');

insert into cc_c_filter (filter_type, value)
values ('ACD_PQ_ID_INC', 5289);

insert into cc_c_filter (filter_type, value)
values ('ACD_PQ_ID_INC', 5290);


COMMIT;