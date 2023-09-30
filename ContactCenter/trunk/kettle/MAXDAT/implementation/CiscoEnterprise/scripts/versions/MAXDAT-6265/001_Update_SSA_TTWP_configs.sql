ALTER SESSION SET CURRENT_SCHEMA = CISCO_ENTERPRISE_CC;

/* CONTACT QUEUE */
update cc_c_contact_queue set unit_of_work_name='Cost of Living Adjustment - Spa', interval_minutes ='15', service_seconds = 30,  queue_type='Transfer', project_name='SSA TTWP', program_name='TTWP-Beneficiary Service', region_name='Eastern', state_name='Texas' where queue_number ='7081';
update cc_c_contact_queue set unit_of_work_name='Cost of Living Adjustment - Eng', interval_minutes ='15', service_seconds = 30,  queue_type='Transfer', project_name='SSA TTWP', program_name='TTWP-Beneficiary Service', region_name='Eastern', state_name='Texas' where queue_number ='7082';

insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_INC','7081');
insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_INC','7082');

/* UNIT OF WORK */
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('Cost of Living Adjustment - Eng', 'TRANSFER', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('Cost of Living Adjustment - Spa', 'TRANSFER', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);

insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('Cost of Living Adjustment - Eng', 'TRANSFER', 1, 'N', 'Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('Cost of Living Adjustment - Spa', 'TRANSFER', 1, 'N', 'Seconds');


COMMIT;