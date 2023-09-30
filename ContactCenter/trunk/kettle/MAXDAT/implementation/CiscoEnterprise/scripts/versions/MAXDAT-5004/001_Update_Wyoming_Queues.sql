alter session set current_schema = cisco_enterprise_cc;

update cc_c_contact_queue
set queue_type = 'IVR Survey'
where 
queue_type = 'IVR'
and queue_number in (6269,
6270,
6293,
6294,
6295,
6296,
6297,
6298,
6299,
6300,
6301,
6302,
6303,
6304,
6305,
6306,
6307,
6308,
6309,
6310,
6311,
6312,
6313,
6314,
6315,
6316,
6317,
6318,
6319,
6320,
6321,
6322,
6323,
6324,
6325,
6326
);

update cc_c_contact_queue
set queue_type = 'Call Back', unit_of_work_name = 'Call Back', service_percent = null, service_seconds = null, interval_minutes = 15, project_name = 'Wyoming Dept of Health', program_name = 'Medicaid / CHIP', region_name = 'West', state_name = 'Wyoming'
where queue_number = 6509;

update cc_c_contact_queue
set unit_of_work_name = 'English Surveys Offered'
where queue_number = 6269;

update cc_c_contact_queue
set unit_of_work_name = 'Spanish Surveys Offered'
where queue_number = 6270;

update cc_c_contact_queue
set unit_of_work_name = 'Spoke with CSR First Time?'
where queue_number = 6293;

update cc_c_contact_queue
set unit_of_work_name = 'Spoke with CSR First Time (Spanish)?'
where queue_number = 6294;

update cc_c_contact_queue
set unit_of_work_name = 'Willingness to Help?'
where queue_number = 6295;

update cc_c_contact_queue
set unit_of_work_name = 'Customer Service Skills?'
where queue_number = 6296;

update cc_c_contact_queue
set unit_of_work_name = 'Knowledge in Resolving the Issue?'
where queue_number = 6297;

update cc_c_contact_queue
set unit_of_work_name = 'Timeliness in Resolving the Issue?'
where queue_number = 6298;

update cc_c_contact_queue
set unit_of_work_name = 'Overall Experience'
where queue_number = 6299;

update cc_c_contact_queue
set unit_of_work_name = 'No'
where queue_number = 6300;

update cc_c_contact_queue
set unit_of_work_name = 'Yes'
where queue_number = 6301;

update cc_c_contact_queue
set unit_of_work_name = '1'
where queue_number in (6302, 6307, 6312, 6317, 6322);

update cc_c_contact_queue
set unit_of_work_name = '2'
where queue_number in (6303, 6308, 6313, 6318, 6323);

update cc_c_contact_queue
set unit_of_work_name = '3'
where queue_number in (6304, 6309, 6314, 6319, 6324);

update cc_c_contact_queue
set unit_of_work_name = '4'
where queue_number in (6305, 6310, 6315, 6320, 6325);

update cc_c_contact_queue
set unit_of_work_name = '5'
where queue_number in (6306, 6311, 6316, 6321, 6326);

insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('Spoke with CSR First Time?', 'IVR SURVEY', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('Spoke with CSR First Time (Spanish)?', 'IVR SURVEY', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('Willingness to Help?', 'IVR SURVEY', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('Customer Service Skills?', 'IVR SURVEY', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('Knowledge in Resolving the Issue?', 'IVR SURVEY', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('Timeliness in Resolving the Issue?', 'IVR SURVEY', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('Overall Experience', 'IVR SURVEY', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('1', 'IVR SURVEY', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('2', 'IVR SURVEY', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('3', 'IVR SURVEY', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('4', 'IVR SURVEY', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('5', 'IVR SURVEY', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);

insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('Spoke with CSR First Time?', 'IVR SURVEY', 155, 'N', 'Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('Spoke with CSR First Time (Spanish)?', 'IVR SURVEY', 155, 'N', 'Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('Willingness to Help?', 'IVR SURVEY', 155, 'N', 'Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('Customer Service Skills?', 'IVR SURVEY', 155, 'N', 'Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('Knowledge in Resolving the Issue?', 'IVR SURVEY', 155, 'N', 'Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('Timeliness in Resolving the Issue?', 'IVR SURVEY', 155, 'N', 'Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('Overall Experience', 'IVR SURVEY', 155, 'N', 'Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('1', 'IVR SURVEY', 155, 'N', 'Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('2', 'IVR SURVEY', 155, 'N', 'Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('3', 'IVR SURVEY', 155, 'N', 'Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('4', 'IVR SURVEY', 155, 'N', 'Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('5', 'IVR SURVEY', 155, 'N', 'Seconds');


commit;

