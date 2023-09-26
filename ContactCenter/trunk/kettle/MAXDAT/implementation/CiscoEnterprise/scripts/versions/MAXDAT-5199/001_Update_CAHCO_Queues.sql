alter session set current_schema = cisco_enterprise_cc;

update cc_c_contact_queue
set queue_type = 'IVR', interval_minutes = 15, project_name = 'CA HCO', program_name = 'Medi-Cal', region_name = 'West', state_name = 'California'
where 
queue_number in (6586,
6587,
6588,
6589,
6590,
6591,
6592,
6593,
6594,
6595,
6596,
6597,
6598
);

update cc_c_contact_queue
set unit_of_work_name = 'English'
where queue_number = 6586;

update cc_c_contact_queue
set unit_of_work_name = 'Spanish'
where queue_number = 6587;

update cc_c_contact_queue
set unit_of_work_name = 'Farsi'
where queue_number = 6588;

update cc_c_contact_queue
set unit_of_work_name = 'Russian'
where queue_number = 6589;

update cc_c_contact_queue
set unit_of_work_name = 'Arabic'
where queue_number = 6590;

update cc_c_contact_queue
set unit_of_work_name = 'Hamong'
where queue_number = 6591;

update cc_c_contact_queue
set unit_of_work_name = 'Armenian'
where queue_number = 6592;

update cc_c_contact_queue
set unit_of_work_name = 'Mandarin'
where queue_number = 6593;

update cc_c_contact_queue
set unit_of_work_name = 'Tagalog'
where queue_number = 6594;

update cc_c_contact_queue
set unit_of_work_name = 'Korean'
where queue_number = 6595;

update cc_c_contact_queue
set unit_of_work_name = 'Cantonese'
where queue_number = 6596;

update cc_c_contact_queue
set unit_of_work_name = 'Vietnamese'
where queue_number = 6597;

update cc_c_contact_queue
set unit_of_work_name = 'Cambodian'
where queue_number = 6598;

insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('Farsi', 'IVR', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('Russian', 'IVR', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('Arabic', 'IVR', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('Hamong', 'IVR', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('Armenian', 'IVR', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('Mandarin', 'IVR', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('Tagalog', 'IVR', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('Korean', 'IVR', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('Cantonese', 'IVR', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('Vietnamese', 'IVR', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('Cambodian', 'IVR', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);



insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('Farsi', 'IVR', 158, 'N', 'Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('Russian', 'IVR', 158, 'N', 'Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('Arabic', 'IVR', 158, 'N', 'Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('Hamong', 'IVR', 158, 'N', 'Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('Armenian', 'IVR', 158, 'N', 'Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('Mandarin', 'IVR', 158, 'N', 'Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('Tagalog', 'IVR', 158, 'N', 'Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('Korean', 'IVR', 158, 'N', 'Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('Cantonese', 'IVR', 158, 'N', 'Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('Vietnamese', 'IVR', 158, 'N', 'Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('Cambodian', 'IVR', 158, 'N', 'Seconds');

commit;

----------------------------------------------

insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('Transfer - Folsom English', 'TRANSFER', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('Transfer - Folsom Spanish', 'TRANSFER', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('Transfer - Queue Menu', 'TRANSFER', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('Laotian', 'INBOUND_CALL', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('No Agent', 'INBOUND_CALL', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);

insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('Transfer - Folsom English', 'TRANSFER', 158, 'N', 'Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('Transfer - Folsom Spanish', 'TRANSFER', 158, 'N', 'Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('Transfer - Queue Menu', 'TRANSFER', 158, 'N', 'Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('Laotian', 'INBOUND_CALL', 158, 'N', 'Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('No Agent', 'INBOUND_CALL', 158, 'N', 'Seconds');

commit;

update cc_c_contact_queue
set unit_of_work_name = 'No Agent'
where queue_number = 6132;

update cc_c_contact_queue
set unit_of_work_name = 'RONA'
where queue_number = 6133;

update cc_c_contact_queue
set unit_of_work_name = 'Hamong'
where queue_number in (6110, 6139);

update cc_c_contact_queue
set unit_of_work_name = 'Laotian'
where queue_number in (6111, 6140);

update cc_c_contact_queue
set unit_of_work_name = 'Cambodian'
where queue_number in (6112, 6141);

update cc_c_contact_queue
set unit_of_work_name = 'Cantonese'
where queue_number in (6113, 6142);

update cc_c_contact_queue
set unit_of_work_name = 'Russian'
where queue_number in (6114, 6143);

update cc_c_contact_queue
set unit_of_work_name = 'Vietnamese'
where queue_number in (6115, 6144);

update cc_c_contact_queue
set unit_of_work_name = 'Arabic'
where queue_number in (6117, 6145);

update cc_c_contact_queue
set unit_of_work_name = 'Korean'
where queue_number in (6118, 6146);

update cc_c_contact_queue
set unit_of_work_name = 'Mandarin'
where queue_number in (6119, 6147);

update cc_c_contact_queue
set unit_of_work_name = 'Tagalog'
where queue_number in (6120, 6148);

update cc_c_contact_queue
set unit_of_work_name = 'Armenian'
where queue_number in (6121, 6149);

update cc_c_contact_queue
set unit_of_work_name = 'Farsi'
where queue_number in (6122, 6150);

update cc_c_contact_queue
set unit_of_work_name = 'English'
where queue_number in (6108, 6221);

update cc_c_contact_queue
set unit_of_work_name = 'Spanish'
where queue_number in (6109, 6222);

update cc_c_contact_queue
set unit_of_work_name = 'Transfer - Folsom English'
where queue_number = 6126;

update cc_c_contact_queue
set unit_of_work_name = 'Transfer - Folsom Spanish'
where queue_number = 6152;

update cc_c_contact_queue
set unit_of_work_name = 'Provider'
where queue_number = 6223;

update cc_c_contact_queue
set unit_of_work_name = 'ESR'
where queue_number = 6224;

update cc_c_contact_queue
set unit_of_work_name = 'Research'
where queue_number = 6225;

update cc_c_contact_queue
set unit_of_work_name = 'Main IVR', queue_type = 'IVR'
where queue_number in (6106, 6107);

update cc_c_contact_queue
set unit_of_work_name = 'Transfer - Queue Menu'
where queue_number = 6116;

update cc_c_contact_queue
set service_seconds = 20
where queue_number in (
6108,
6109,
6110,
6111,
6112,
6113,
6114,
6115,
6117,
6118,
6119,
6120,
6121,
6122,
6124);

update cc_c_contact_queue
set service_seconds = 30
where queue_number in (
6123,
6125,
6106,
6107);

update cc_c_contact_queue
set queue_type = 'IVR', unit_of_work_name = 'Laotian', interval_minutes = 15, project_name = 'CA HCO', program_name = 'Medi-Cal', region_name = 'West', state_name = 'California'
where 
queue_number = 6599;

update cc_c_unit_of_work
set unit_of_work_category = 'IVR'
where unit_of_work_name = 'Laotian';

update cc_d_unit_of_work
set unit_of_work_category = 'IVR'
where unit_of_work_name = 'Laotian';

commit;