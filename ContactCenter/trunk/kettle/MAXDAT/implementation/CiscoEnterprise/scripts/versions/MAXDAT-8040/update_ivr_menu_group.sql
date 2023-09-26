update cc_c_ivr_menu_group set ivr_menu_group_name = 'FLG_CARRIER_CareFirst', project_name = 'MD HBE', program_name = 'CSC' where ivr_sub_menu_name = 'FLG_CARRIER_CareFirst' and ivr_menu_name = 'MDHIX_ENT_OE_18_v1.0';
update cc_c_ivr_menu_group set ivr_menu_group_name = 'FLG_CARRIER_Kaiser', project_name = 'MD HBE', program_name = 'CSC' where ivr_sub_menu_name = 'FLG_CARRIER_Kaiser' and ivr_menu_name = 'MDHIX_ENT_OE_18_v1.0';
update cc_c_ivr_menu_group set ivr_menu_group_name = 'FLG_HealthChoice Helpline', project_name = 'MD HBE', program_name = 'CSC' where ivr_sub_menu_name = 'FLG_HealthChoice Helpline' and ivr_menu_name = 'MDHIX_ENT_OE_18_v1.0';
update cc_c_ivr_menu_group set ivr_menu_group_name = 'FLG_SHOP_MENU', project_name = 'MD HBE', program_name = 'CSC' where ivr_sub_menu_name = 'FLG_SHOP_MENU' and ivr_menu_name = 'MDHIX_ENT_OE_18_v1.0';

commit;