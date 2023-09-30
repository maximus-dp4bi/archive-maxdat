alter session set current_schema = cisco_enterprise_cc;

-- Units of work

insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('VAHM VTHX Inbound','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);

insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('VAHM VTHX Inbound','Inbound',1, 'N', 'Seconds', 1, 0);

commit;

-- contact queues

update cc_c_contact_queue set queue_type = 'Internal Transfer', Unit_of_work_name = 'VAHM VTHX Internal Transfer', project_name = 'VT HIX', program_name = 'Multiple', region_name = 'Eastern', state_name = 'Vermont', service_percent = 0, service_seconds = 24, interval_minutes = 15 where queue_number = 8955;
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'VAHM VTHX Inbound', project_name = 'VT HIX', program_name = 'Multiple', region_name = 'Eastern', state_name = 'Vermont', service_percent = 0, service_seconds = 24, interval_minutes = 15 where queue_number = 8956;
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'VAHM VTHX Inbound', project_name = 'VT HIX', program_name = 'Multiple', region_name = 'Eastern', state_name = 'Vermont', service_percent = 0, service_seconds = 24, interval_minutes = 15 where queue_number = 8957;
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'No Agent', project_name = 'VT HIX', program_name = 'Multiple', region_name = 'Eastern', state_name = 'Vermont', service_percent = 0, service_seconds = 24, interval_minutes = 15 where queue_number = 8958;
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'RONA', project_name = 'VT HIX', program_name = 'Multiple', region_name = 'Eastern', state_name = 'Vermont', service_percent = 0, service_seconds = 24, interval_minutes = 15 where queue_number = 8959;
update cc_c_contact_queue set queue_type = 'Internal Transfer', Unit_of_work_name = 'VAHM VTHX Internal Transfer', project_name = 'VT HIX', program_name = 'Multiple', region_name = 'Eastern', state_name = 'Vermont', service_percent = 0, service_seconds = 24, interval_minutes = 15 where queue_number = 8960;
update cc_c_contact_queue set queue_type = 'Internal Transfer', Unit_of_work_name = 'VAHM VTHX Internal Transfer', project_name = 'VT HIX', program_name = 'Multiple', region_name = 'Eastern', state_name = 'Vermont', service_percent = 0, service_seconds = 24, interval_minutes = 15 where queue_number = 8961;
update cc_c_contact_queue set queue_type = 'Internal Transfer', Unit_of_work_name = 'VAHM VTHX Internal Transfer', project_name = 'VT HIX', program_name = 'Multiple', region_name = 'Eastern', state_name = 'Vermont', service_percent = 0, service_seconds = 24, interval_minutes = 15 where queue_number = 8962;
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'VAHM VTHX Inbound', project_name = 'VT HIX', program_name = 'Multiple', region_name = 'Eastern', state_name = 'Vermont', service_percent = 0, service_seconds = 24, interval_minutes = 15 where queue_number = 8964;
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'VAHM VTHX Inbound', project_name = 'VT HIX', program_name = 'Multiple', region_name = 'Eastern', state_name = 'Vermont', service_percent = 0, service_seconds = 24, interval_minutes = 15 where queue_number = 8965;
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'No Agent', project_name = 'VT HIX', program_name = 'Multiple', region_name = 'Eastern', state_name = 'Vermont', service_percent = 0, service_seconds = 24, interval_minutes = 15 where queue_number = 8966;
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'RONA', project_name = 'VT HIX', program_name = 'Multiple', region_name = 'Eastern', state_name = 'Vermont', service_percent = 0, service_seconds = 24, interval_minutes = 15 where queue_number = 8967;
update cc_c_contact_queue set queue_type = 'Internal Transfer', Unit_of_work_name = 'VAHM VTHX Internal Transfer', project_name = 'VT HIX', program_name = 'Multiple', region_name = 'Eastern', state_name = 'Vermont', service_percent = 0, service_seconds = 24, interval_minutes = 15 where queue_number = 8968;
update cc_c_contact_queue set queue_type = 'Internal Transfer', Unit_of_work_name = 'VAHM VTHX Internal Transfer', project_name = 'VT HIX', program_name = 'Multiple', region_name = 'Eastern', state_name = 'Vermont', service_percent = 0, service_seconds = 24, interval_minutes = 15 where queue_number = 8969;
update cc_c_contact_queue set queue_type = 'Internal Transfer', Unit_of_work_name = 'VAHM VTHX Internal Transfer', project_name = 'VT HIX', program_name = 'Multiple', region_name = 'Eastern', state_name = 'Vermont', service_percent = 0, service_seconds = 24, interval_minutes = 15 where queue_number = 8970;
update cc_c_contact_queue set queue_type = 'Internal Transfer', Unit_of_work_name = 'VAHM VTHX Internal Transfer', project_name = 'VT HIX', program_name = 'Multiple', region_name = 'Eastern', state_name = 'Vermont', service_percent = 0, service_seconds = 24, interval_minutes = 15 where queue_number = 8971;
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'VAHM VTHX Inbound', project_name = 'VT HIX', program_name = 'Multiple', region_name = 'Eastern', state_name = 'Vermont', service_percent = 0, service_seconds = 24, interval_minutes = 15 where queue_number = 8972;
update cc_c_contact_queue set queue_type = 'Internal Transfer', Unit_of_work_name = 'VAHM VTHX Internal Transfer', project_name = 'VT HIX', program_name = 'Multiple', region_name = 'Eastern', state_name = 'Vermont', service_percent = 0, service_seconds = 24, interval_minutes = 15 where queue_number = 8973;
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'No Agent', project_name = 'VT HIX', program_name = 'Multiple', region_name = 'Eastern', state_name = 'Vermont', service_percent = 0, service_seconds = 24, interval_minutes = 15 where queue_number = 8974;
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'RONA', project_name = 'VT HIX', program_name = 'Multiple', region_name = 'Eastern', state_name = 'Vermont', service_percent = 0, service_seconds = 24, interval_minutes = 15 where queue_number = 8975;

commit;


-- Agent Routing groups

update cc_c_agent_rtg_grp 
set project_name = 'VT HIX', 
program_name = 'Multiple', 
region_name = 'Eastern', 
state_name = 'Vermont' 
where agent_routing_group_number in 
(5576,
5577,
5579,
5580,
5581
);

insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5576);
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5577);
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5579);
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5580);
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5581);

commit;

					