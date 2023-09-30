alter session set current_schema = cisco_enterprise_cc;

update cc_c_contact_queue set queue_type = 'Inbound', unit_of_work_name = 'MEDICAID', project_name = 'MD HBE', program_name = 'CSC', region_name = 'Eastern', state_name = 'Maryland', service_seconds = 30, interval_minutes = 15 where queue_number = 8337;

update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'MD HBE' and program_name = 'CSC'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'MEDICAID'), service_seconds = 30, interval_minutes = 15 where queue_number = '8337';

update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'MD HBE'), d_program_id = (select program_id from cc_d_program where program_name = 'CSC'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'MEDICAID'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Maryland'),service_seconds= 20, interval_minutes = 15 where queue_number = '8337';


Insert into CC_C_IVR_MENU_GROUP (IVR_MENU_GROUP_NAME,IVR_MENU_NAME,IVR_SUB_MENU_NAME,PROJECT_NAME,PROGRAM_NAME) values ('FLG_CARRIER_CareFirst','MDHIX_ENT_20_v2','FLG_CARRIER_CareFirst','MD HBE','CSC');
Insert into CC_C_IVR_MENU_GROUP (IVR_MENU_GROUP_NAME,IVR_MENU_NAME,IVR_SUB_MENU_NAME,PROJECT_NAME,PROGRAM_NAME) values ('FLG_CARRIER_Kaiser','MDHIX_ENT_20_v2','FLG_CARRIER_Kaiser','MD HBE','CSC');
Insert into CC_C_IVR_MENU_GROUP (IVR_MENU_GROUP_NAME,IVR_MENU_NAME,IVR_SUB_MENU_NAME,PROJECT_NAME,PROGRAM_NAME) values ('FLG_HealthChoice Helpline','MDHIX_ENT_20_v2','FLG_HealthChoice Helpline','MD HBE','CSC');

/*
update cc_c_ivr_menu_group set ivr_menu_group_name = 'FLG_CARRIER_CareFirst', project_name = 'MD HBE', program_name = 'CSC' where ivr_sub_menu_name = 'FLG_CARRIER_CareFirst' and ivr_menu_name = 'MDHIX_ENT_20_v2';
update cc_c_ivr_menu_group set ivr_menu_group_name = 'FLG_CARRIER_Kaiser', project_name = 'MD HBE', program_name = 'CSC' where ivr_sub_menu_name = 'FLG_CARRIER_Kaiser' and ivr_menu_name = 'MDHIX_ENT_20_v2';
update cc_c_ivr_menu_group set ivr_menu_group_name = 'FLG_HealthChoice Helpline', project_name = 'MD HBE', program_name = 'CSC' where ivr_sub_menu_name = 'FLG_HealthChoice Helpline' and ivr_menu_name = 'MDHIX_ENT_20_v2';
*/

commit;