alter session set current_schema = cisco_enterprise_cc;

update cc_c_contact_queue
set queue_type = 'Inbound', service_seconds = 30, interval_minutes = 15, unit_of_work_name = 'Global - Main',
project_name = 'CA HCO', program_name = 'CHIP', Region_name = 'West', state_name = 'CA'
where queue_number in (6132, 6133);

update cc_c_filter
set filter_type = 'ACD_CALL_TYPE_ID_INC'
where value in (6132, 6133);

insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_IGNORE',6327);

insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr)
values ('Global - Main', 'INBOUND_CALL', TO_DATE('01/01/1900', 'MM/DD/YYYY'), TO_DATE('12/31/2999','MM/DD/YYYY'), 1, 0);

insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr)
values ('Global - Main', 'INBOUND_CALL', 150,'N','Seconds', 1, 0);

commit;