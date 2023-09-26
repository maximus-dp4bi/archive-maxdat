alter session set current_schema = cisco_enterprise_cc;

update cc_c_ivr_menu_group set ivr_menu_group_name = 'FLG_CARRIER_UHC', project_name = 'MD HBE', program_name = 'CSC' where ivr_sub_menu_name = 'FLG_CARRIER_UHC' and ivr_menu_name = 'MDHIX_ENT_20_v3';

commit;