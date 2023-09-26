alter session set current_schema = cisco_enterprise_cc;

update cc_c_contact_queue
set queue_type = 'IVR', unit_of_work_name = 'MAIN INGRESS', service_seconds = 30, interval_minutes = 15, project_name = 'MD HBE', program_name = 'CSC', region_name = 'Eastern', state_name = 'Maryland'
where queue_number = 5075;

update cc_c_contact_queue
set queue_type = 'Inbound', unit_of_work_name = 'CAC'
where queue_number in (5219, 5852);

update cc_c_contact_queue
set queue_type = 'Inbound', unit_of_work_name = 'CAC - SPA'
where queue_number = 5226;

commit;

insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('MAIN INGRESS', 'IVR', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
--insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('CAC', 'INBOUND', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('CAC - SPA', 'INBOUND', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);

insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('MAIN INGRESS', 'IVR', 1, 'N', 'Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('CAC', 'INBOUND', 1, 'N', 'Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('CAC - SPA', 'INBOUND', 1, 'N', 'Seconds');

UPDATE CC_C_UNIT_OF_WORK
SET UNIT_OF_WORK_CATEGORY = 'INBOUND'
WHERE UNIT_OF_WORK_NAME = 'CAC';

commit;

UPDATE CC_C_LOOKUP
SET LOOKUP_VALUE = 'MD HBE'
WHERE LOOKUP_TYPE LIKE '%DESKSETTING_PROJECT%'
AND LOOKUP_KEY IN (5004, 5005, 5006, 5007, 5019, 5020);

UPDATE CC_C_LOOKUP
SET LOOKUP_VALUE = 'CSC'
WHERE LOOKUP_TYPE LIKE '%DESKSETTING_PROGRAM%'
AND LOOKUP_KEY IN (5004, 5005, 5006, 5007, 5019, 5020);

UPDATE CC_C_LOOKUP
SET LOOKUP_VALUE = 'Maryland'
WHERE LOOKUP_TYPE LIKE '%DESKSETTING_SITE%'
AND LOOKUP_KEY IN (5004, 5005, 5019, 5020);

UPDATE CC_C_LOOKUP
SET LOOKUP_VALUE = 'Colorado'
WHERE LOOKUP_TYPE LIKE '%DESKSETTING_SITE%'
AND LOOKUP_KEY IN (5006, 5007);

commit;
------------------------------------------------------

update cc_c_contact_queue
set unit_of_work_name = 'IRN'
where unit_of_work_name = 'NAVIGATOR'
and queue_number = 5331
and project_name = 'MD HBE';

update cc_c_unit_of_work
set unit_of_work_name = 'IRN'
where unit_of_work_name = 'NAVIGATOR';

update cc_d_unit_of_work
set unit_of_work_name = 'IRN'
where unit_of_work_name = 'NAVIGATOR';

commit;