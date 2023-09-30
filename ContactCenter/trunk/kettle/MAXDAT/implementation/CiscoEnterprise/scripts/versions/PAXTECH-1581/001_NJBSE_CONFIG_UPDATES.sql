alter session set current_schema = cisco_enterprise_cc;

--Units of Work

insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Medicaid','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);

insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Medicaid','INBOUND_CALL',1, 'N', 'Seconds', 1, 0);


--Contact Queues

update cc_c_contact_queue set queue_type = 'Inbound',Unit_of_work_name = 'Medicaid', project_name = 'New Jersey State Based Exchange',  program_name = 'Get Covered New Jersey', region_name = 'Eastern', state_name = 'New Jersey', service_percent = 80, service_seconds = 30, interval_minutes = 15 where queue_number =9122;
update cc_c_contact_queue set queue_type = 'IVR',Unit_of_work_name = 'IVR', project_name = 'New Jersey State Based Exchange',  program_name = 'Get Covered New Jersey', region_name = 'Eastern', state_name = 'New Jersey', service_percent = 80, service_seconds = 30, interval_minutes = 15 where queue_number =9123;
update cc_c_contact_queue set queue_type = 'Inbound',Unit_of_work_name = 'Medicaid', project_name = 'New Jersey State Based Exchange',  program_name = 'Get Covered New Jersey', region_name = 'Eastern', state_name = 'New Jersey', service_percent = 80, service_seconds = 30, interval_minutes = 15 where queue_number =9124;

update cc_c_contact_queue
set bucketintervalid = null
where queue_number in (9122,9123,9124);

---Precision Queues

update cc_c_agent_rtg_grp 
set project_name = 'New Jersey State Based Exchange', 
program_name = 'Get Covered New Jersey', 
region_name = 'Eastern', 
state_name = 'New Jersey'
where agent_routing_group_number in (5612);

insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5612);

commit;