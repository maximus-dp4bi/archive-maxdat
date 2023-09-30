alter session set current_schema = cisco_enterprise_cc;

set define off;

update cc_c_project_config
set project_name = 'Health First Colorado Enrollment'
where project_name = 'Health Colorado';

update cc_c_project_config
set program_name = 'Health First Colorado'
where program_name = 'Health Colorado';

update cc_d_project
set project_name = 'Health First Colorado Enrollment'
where project_name = 'Health Colorado';

update cc_d_program
set program_name = 'Health First Colorado'
where program_name = 'Health Colorado';

insert into cc_c_project_config (project_name, program_name, region_name, state_name, province_name, district_name, country_name, record_eff_dt, record_end_dt)
values ('Health First Colorado Enrollment', 'CHP+', 'West', 'Colorado', 'Unknown', 'Unknown', 'USA', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));

insert into cc_d_program (program_id, program_name, include_in_reports_flag) values (SEQ_CC_D_PROGRAM.nextval,'CHP+', 1);

update cc_c_lookup
set lookup_value = 'Health First Colorado Enrollment'
where lookup_value = 'Health Colorado'
and lookup_type = 'ACD_DESKSETTING_PROJECT';

update cc_a_list_lkup
set value = 'Health First Colorado Enrollment'
, out_var = 'select (CONTACTS_OFFERED - OUTFLOW_CONTACTS) from cc_s_acd_interval where acd_interval_id = :ACD_INTERVAL_ID'
where name = 'HLCO_CALLS_OFFERED_FORMULA'
and list_type = 'CC_S_ACD_INTERVAL-CALLS_OFFERED'
and value = 'Health Colorado';

update cc_a_list_lkup
set value = 'Health First Colorado Enrollment'
, out_var = 'select (CONTACTS_OFFERED - OUTFLOW_CONTACTS) from cc_s_acd_queue_interval where acd_queue_interval_id = :ACD_INTERVAL_ID'
where name = 'HLCO_CALLS_OFFERED_FORMULA'
and list_type = 'CC_S_ACD_QUEUE_INTERVAL-CALLS_OFFERED'
and value = 'Health Colorado';

commit;

-- Units of work

insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) 
values ('English - Medicaid','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);

insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) 
values ('Spanish - Medicaid','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);

insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) 
values ('English - Ombudsman','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);

insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) 
values ('Spanish - Ombudsman','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);

insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) 
values ('English - Medicaid','Inbound', 1, 'N', 'Seconds', 1, 0);

insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) 
values ('Spanish - Medicaid','Inbound', 1, 'N', 'Seconds', 1, 0);

insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) 
values ('English - Ombudsman','Inbound', 1, 'N', 'Seconds', 1, 0);

insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) 
values ('Spanish - Ombudsman','Inbound', 1, 'N', 'Seconds', 1, 0);


commit;

-- Agent Routing groups

update cc_c_agent_rtg_grp
set project_name = 'Health First Colorado Enrollment'
, program_name = 'Health First Colorado'
where agent_routing_group_type = 'Precision Queue'
and project_name = 'Health Colorado'
and program_name = 'Health Colorado'
and agent_routing_group_number in
(
5167
,5168
,5178
,5337
,5338
);

update cc_c_agent_rtg_grp
set project_name = 'Health First Colorado Enrollment'
, program_name = 'CHP+'
where agent_routing_group_type = 'Precision Queue'
and project_name = 'Health Colorado'
and program_name = 'Health Colorado'
and agent_routing_group_number in
(
5169
,5170
);

update cc_c_agent_rtg_grp
set project_name = 'Health First Colorado Enrollment'
where agent_routing_group_type = 'Precision Queue'
and project_name = 'Health Colorado'
and agent_routing_group_number in
(
5171
,5172
,5173
,5174
);

commit;

-- contact queues

update cc_c_contact_queue
set project_name = 'Health First Colorado Enrollment'
where project_name = 'Health Colorado';

update cc_c_contact_queue
set program_name = 'Health First Colorado'
where program_name = 'Health Colorado';

update cc_c_contact_queue
set program_name = 'CHP+'
where queue_number in
(
6153
,6156
,6157
,6158
,6159
,6160
);

update cc_c_contact_queue set unit_of_work_name = 'English - Medicaid' where queue_number = '6163';
update cc_c_contact_queue set unit_of_work_name = 'English - Medicaid' where queue_number = '6170';
update cc_c_contact_queue set unit_of_work_name = 'Spanish - Medicaid' where queue_number = '6171';
update cc_c_contact_queue set unit_of_work_name = 'English - Medicaid' where queue_number = '6172';
update cc_c_contact_queue set unit_of_work_name = 'Spanish - Medicaid' where queue_number = '6173';
update cc_c_contact_queue set unit_of_work_name = 'Spanish - Medicaid' where queue_number = '6174';
update cc_c_contact_queue set unit_of_work_name = 'English - Medicaid' where queue_number = '7218';
update cc_c_contact_queue set unit_of_work_name = 'Spanish - Medicaid' where queue_number = '7219';
update cc_c_contact_queue set unit_of_work_name = 'English - Ombudsman' where queue_number = '6203';
update cc_c_contact_queue set unit_of_work_name = 'English - Ombudsman' where queue_number = '6210';
update cc_c_contact_queue set unit_of_work_name = 'Spanish - Ombudsman' where queue_number = '6211';
update cc_c_contact_queue set unit_of_work_name = 'English - Ombudsman' where queue_number = '6212';
update cc_c_contact_queue set unit_of_work_name = 'Spanish - Ombudsman' where queue_number = '6213';
update cc_c_contact_queue set unit_of_work_name = 'Spanish - Ombudsman' where queue_number = '6214';


update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'Health First Colorado Enrollment' and program_name = 'CHP+')
where queue_number in
(
6153
,6156
,6157
,6158
,6159
,6160
);

update cc_s_contact_queue set unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'English - Medicaid') where queue_number = '6163';
update cc_s_contact_queue set unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'English - Medicaid') where queue_number = '6170';
update cc_s_contact_queue set unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'Spanish - Medicaid') where queue_number = '6171';
update cc_s_contact_queue set unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'English - Medicaid') where queue_number = '6172';
update cc_s_contact_queue set unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'Spanish - Medicaid') where queue_number = '6173';
update cc_s_contact_queue set unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'Spanish - Medicaid') where queue_number = '6174';
update cc_s_contact_queue set unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'English - Medicaid') where queue_number = '7218';
update cc_s_contact_queue set unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'Spanish - Medicaid') where queue_number = '7219';
update cc_s_contact_queue set unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'English - Ombudsman') where queue_number = '6203';
update cc_s_contact_queue set unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'English - Ombudsman') where queue_number = '6210';
update cc_s_contact_queue set unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'Spanish - Ombudsman') where queue_number = '6211';
update cc_s_contact_queue set unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'English - Ombudsman') where queue_number = '6212';
update cc_s_contact_queue set unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'Spanish - Ombudsman') where queue_number = '6213';
update cc_s_contact_queue set unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'Spanish - Ombudsman') where queue_number = '6214';


update cc_d_contact_queue set d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'English - Medicaid') where queue_number = '6163';
update cc_d_contact_queue set d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'English - Medicaid') where queue_number = '6170';
update cc_d_contact_queue set d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'Spanish - Medicaid') where queue_number = '6171';
update cc_d_contact_queue set d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'English - Medicaid') where queue_number = '6172';
update cc_d_contact_queue set d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'Spanish - Medicaid') where queue_number = '6173';
update cc_d_contact_queue set d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'Spanish - Medicaid') where queue_number = '6174';
update cc_d_contact_queue set d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'English - Medicaid') where queue_number = '7218';
update cc_d_contact_queue set d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'Spanish - Medicaid') where queue_number = '7219';
update cc_d_contact_queue set d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'English - Ombudsman') where queue_number = '6203';
update cc_d_contact_queue set d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'English - Ombudsman') where queue_number = '6210';
update cc_d_contact_queue set d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'Spanish - Ombudsman') where queue_number = '6211';
update cc_d_contact_queue set d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'English - Ombudsman') where queue_number = '6212';
update cc_d_contact_queue set d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'Spanish - Ombudsman') where queue_number = '6213';
update cc_d_contact_queue set d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'Spanish - Ombudsman') where queue_number = '6214';

update cc_d_contact_queue set d_program_id = (select program_id from cc_d_program where program_name = 'CHP+') where queue_number = '6153';
update cc_d_contact_queue set d_program_id = (select program_id from cc_d_program where program_name = 'CHP+') where queue_number = '6156';
update cc_d_contact_queue set d_program_id = (select program_id from cc_d_program where program_name = 'CHP+') where queue_number = '6157';
update cc_d_contact_queue set d_program_id = (select program_id from cc_d_program where program_name = 'CHP+') where queue_number = '6158';
update cc_d_contact_queue set d_program_id = (select program_id from cc_d_program where program_name = 'CHP+') where queue_number = '6159';
update cc_d_contact_queue set d_program_id = (select program_id from cc_d_program where program_name = 'CHP+') where queue_number = '6160';

commit;


-- Survey queue changes 08/28/18

insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) 
values ('Survey Start','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);

insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) 
values ('Survey Start','Inbound', 1, 'N', 'Seconds', 0, 1);

commit;

update cc_c_contact_queue
set queue_type = 'IVR Survey'
, Unit_of_work_name = 'Survey Start'
, project_name = 'Health First Colorado Enrollment'
, program_name = 'Health First Colorado'
, region_name = 'West'
, state_name = 'Colorado'
, service_seconds = 180
, interval_minutes = 15
where queue_number = '7337';

update cc_s_contact_queue
set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'Health First Colorado Enrollment' and program_name = 'Health First Colorado')
, queue_type = 'IVR Survey'
, unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'Survey Start')
, service_seconds = 180
, interval_minutes = 15
where queue_number = '7337';

update cc_d_contact_queue
set queue_type = 'IVR Survey'
, d_project_id = (select project_id from cc_d_project where project_name = 'Health First Colorado Enrollment')
, d_program_id = (select program_id from cc_d_program where program_name = 'Health First Colorado')
, d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'Survey Start')
, d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Colorado')
, service_seconds = 180
, interval_minutes = 15
where queue_number = '7337';

commit;












