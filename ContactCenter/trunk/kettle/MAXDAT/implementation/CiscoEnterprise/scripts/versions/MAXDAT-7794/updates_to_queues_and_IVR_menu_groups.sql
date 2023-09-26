insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) 
values ('SHOP','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);

insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) 
values ('SHOP','Inbound', 1, 'N', 'Seconds', 0, 1);

commit;


update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'SHOP', project_name = 'MD HBE', program_name = 'CSC', region_name = 'Eastern', state_name = 'Maryland', service_seconds = 30, interval_minutes = 15 where queue_number = '7355';
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'SHOP', project_name = 'MD HBE', program_name = 'CSC', region_name = 'Eastern', state_name = 'Maryland', service_seconds = 30, interval_minutes = 15 where queue_number = '7356';
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'SHOP', project_name = 'MD HBE', program_name = 'CSC', region_name = 'Eastern', state_name = 'Maryland', service_seconds = 30, interval_minutes = 15 where queue_number = '7357';
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'SHOP', project_name = 'MD HBE', program_name = 'CSC', region_name = 'Eastern', state_name = 'Maryland', service_seconds = 30, interval_minutes = 15 where queue_number = '7358';
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'SHOP', project_name = 'MD HBE', program_name = 'CSC', region_name = 'Eastern', state_name = 'Maryland', service_seconds = 30, interval_minutes = 15 where queue_number = '7359';
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'SHOP', project_name = 'MD HBE', program_name = 'CSC', region_name = 'Eastern', state_name = 'Maryland', service_seconds = 30, interval_minutes = 15 where queue_number = '7360';



update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'MD HBE' and program_name = 'CSC'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'SHOP'), service_seconds = 30, interval_minutes = 15 where queue_number = '7355';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'MD HBE' and program_name = 'CSC'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'SHOP'), service_seconds = 30, interval_minutes = 15 where queue_number = '7356';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'MD HBE' and program_name = 'CSC'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'SHOP'), service_seconds = 30, interval_minutes = 15 where queue_number = '7357';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'MD HBE' and program_name = 'CSC'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'SHOP'), service_seconds = 30, interval_minutes = 15 where queue_number = '7358';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'MD HBE' and program_name = 'CSC'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'SHOP'), service_seconds = 30, interval_minutes = 15 where queue_number = '7359';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'MD HBE' and program_name = 'CSC'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'SHOP'), service_seconds = 30, interval_minutes = 15 where queue_number = '7360';



update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'MD HBE'), d_program_id = (select program_id from cc_d_program where program_name = 'CSC'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'SHOP'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Maryland'), service_seconds = 30, interval_minutes = 15 where queue_number = '7355';
update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'MD HBE'), d_program_id = (select program_id from cc_d_program where program_name = 'CSC'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'SHOP'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Maryland'), service_seconds = 30, interval_minutes = 15 where queue_number = '7356';
update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'MD HBE'), d_program_id = (select program_id from cc_d_program where program_name = 'CSC'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'SHOP'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Maryland'), service_seconds = 30, interval_minutes = 15 where queue_number = '7357';
update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'MD HBE'), d_program_id = (select program_id from cc_d_program where program_name = 'CSC'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'SHOP'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Maryland'), service_seconds = 30, interval_minutes = 15 where queue_number = '7358';
update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'MD HBE'), d_program_id = (select program_id from cc_d_program where program_name = 'CSC'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'SHOP'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Maryland'), service_seconds = 30, interval_minutes = 15 where queue_number = '7359';
update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'MD HBE'), d_program_id = (select program_id from cc_d_program where program_name = 'CSC'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'SHOP'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Maryland'), service_seconds = 30, interval_minutes = 15 where queue_number = '7360';



commit;


update cc_c_ivr_menu_group set ivr_menu_group_name = 'FLG_CARRIER_CareFirst', project_name = 'MD HBE', program_name = 'CSC' where ivr_sub_menu_name = 'FLG_CARRIER_CareFirst' and ivr_menu_name = 'MDHIX_ENT_NEW_18_v3.2';
update cc_c_ivr_menu_group set ivr_menu_group_name = 'FLG_CARRIER_Kaiser', project_name = 'MD HBE', program_name = 'CSC' where ivr_sub_menu_name = 'FLG_CARRIER_Kaiser' and ivr_menu_name = 'MDHIX_ENT_NEW_18_v3.2';
update cc_c_ivr_menu_group set ivr_menu_group_name = 'FLG_SHOP_MENU', project_name = 'MD HBE', program_name = 'CSC' where ivr_sub_menu_name = 'FLG_SHOP_MENU' and ivr_menu_name = 'MDHIX_ENT_NEW_18_v3.2';

commit;