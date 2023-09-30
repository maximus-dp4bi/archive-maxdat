alter session set current_schema = cisco_enterprise_cc;


-- Units of work

insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) 
values ('Assist','Escalation',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);

insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) 
values ('Assist Transfer','Transfer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);

insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) 
values ('Escalation Transfer','Transfer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);

insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) 
values ('Assist','Escalation', 1, 'N', 'Seconds', 1, 0);

insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) 
values ('Assist Transfer','Transfer', 1, 'N', 'Seconds', 1, 0);

insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) 
values ('Escalation Transfer','Transfer', 1, 'N', 'Seconds', 1, 0);

commit;

-- contact queues

update cc_c_contact_queue set queue_type = 'IVR', Unit_of_work_name = 'Main IVR', project_name = 'Medi-Cal For Families', program_name = 'Medi-Cal For Families Program - MFP', region_name = 'West', state_name = 'California', interval_minutes = 15 where queue_number = '7649';
update cc_c_contact_queue set queue_type = 'Escalation', Unit_of_work_name = 'Assist', project_name = 'Medi-Cal For Families', program_name = 'Medi-Cal For Families Program - MFP', region_name = 'West', state_name = 'California', interval_minutes = 15 where queue_number = '7730';
update cc_c_contact_queue set queue_type = 'Transfer', Unit_of_work_name = 'Assist Transfer', project_name = 'Medi-Cal For Families', program_name = 'Medi-Cal For Families Program - MFP', region_name = 'West', state_name = 'California', interval_minutes = 15 where queue_number = '7732';
update cc_c_contact_queue set queue_type = 'Escalation', Unit_of_work_name = 'Escalation', project_name = 'Medi-Cal For Families', program_name = 'Medi-Cal For Families Program - MFP', region_name = 'West', state_name = 'California', interval_minutes = 15 where queue_number = '7731';
update cc_c_contact_queue set queue_type = 'Transfer', Unit_of_work_name = 'Escalation Transfer', project_name = 'Medi-Cal For Families', program_name = 'Medi-Cal For Families Program - MFP', region_name = 'West', state_name = 'California', interval_minutes = 15 where queue_number = '7733';

update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'Medi-Cal For Families' and program_name = 'Medi-Cal For Families Program - MFP'), queue_type = 'IVR', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'Main IVR'), interval_minutes = 15 where queue_number = '7649';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'Medi-Cal For Families' and program_name = 'Medi-Cal For Families Program - MFP'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'Assist'), interval_minutes = 15 where queue_number = '7730';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'Medi-Cal For Families' and program_name = 'Medi-Cal For Families Program - MFP'), queue_type = 'Transfer', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'Assist Transfer'), interval_minutes = 15 where queue_number = '7732';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'Medi-Cal For Families' and program_name = 'Medi-Cal For Families Program - MFP'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'Escalation'), interval_minutes = 15 where queue_number = '7731';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'Medi-Cal For Families' and program_name = 'Medi-Cal For Families Program - MFP'), queue_type = 'Transfer', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'Escalation Transfer'), interval_minutes = 15 where queue_number = '7733';

update cc_d_contact_queue set queue_type = 'IVR', d_project_id = (select project_id from cc_d_project where project_name = 'Medi-Cal For Families'), d_program_id = (select program_id from cc_d_program where program_name = 'Medi-Cal For Families Program - MFP'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'Main IVR'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'California'),interval_minutes = 15 where queue_number = '7649';
update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'Medi-Cal For Families'), d_program_id = (select program_id from cc_d_program where program_name = 'Medi-Cal For Families Program - MFP'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'Assist'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'California'), interval_minutes = 15 where queue_number = '7730';
update cc_d_contact_queue set queue_type = 'Transfer', d_project_id = (select project_id from cc_d_project where project_name = 'Medi-Cal For Families'), d_program_id = (select program_id from cc_d_program where program_name = 'Medi-Cal For Families Program - MFP'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'Assist Transfer'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'California'),interval_minutes = 15 where queue_number = '7732';
update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'Medi-Cal For Families'), d_program_id = (select program_id from cc_d_program where program_name = 'Medi-Cal For Families Program - MFP'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'Escalation'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'California'),interval_minutes = 15 where queue_number = '7731';
update cc_d_contact_queue set queue_type = 'Transfer', d_project_id = (select project_id from cc_d_project where project_name = 'Medi-Cal For Families'), d_program_id = (select program_id from cc_d_program where program_name = 'Medi-Cal For Families Program - MFP'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'Escalation Transfer'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'California'),interval_minutes = 15 where queue_number = '7733';

commit;


