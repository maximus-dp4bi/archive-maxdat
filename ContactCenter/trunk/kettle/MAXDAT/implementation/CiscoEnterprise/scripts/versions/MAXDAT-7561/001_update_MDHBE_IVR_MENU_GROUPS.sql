alter session set current_schema = cisco_enterprise_cc;

update cc_c_ivr_menu_group 
set ivr_menu_group_name = 'FLG_HealthChoice Helpline', project_name = 'MD HBE', program_name = 'CSC' 
where ivr_sub_menu_name = 'FLG_HealthChoice Helpline' and ivr_menu_name in ('MDHIX_ENT_NEW_18_v2', 'MDHIX_ENT_NEW_18_v3', 'MDHIX_ENT_NEW_18_v3.1');


update cc_c_ivr_menu_group 
set ivr_menu_group_name = 'FLG_SHOP_MENU', project_name = 'MD HBE', program_name = 'CSC' 
where ivr_sub_menu_name = 'FLG_SHOP_MENU' and ivr_menu_name in ('MDHIX_ENT_NEW_18_v2', 'MDHIX_ENT_NEW_18_v3', 'MDHIX_ENT_NEW_18_v3.1');

update cc_c_ivr_menu_group
set ivr_menu_group_name = 'Unknown', project_name = 'Unknown', program_name = 'Unknown'
where ivr_menu_name in ('MDHIX_ENT_NEW_18_v2', 'MDHIX_ENT_NEW_18_v3')
and ivr_sub_menu_name = 'MEN_3_SHOP_MENU';

commit;
