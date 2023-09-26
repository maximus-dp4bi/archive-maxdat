alter session set current_schema = cisco_enterprise_cc;

update cc_c_ivr_menu_group
set ivr_menu_group_name = 'Calls Received in IVR', project_name = 'KS CH', program_name = 'KS CH'
where ivr_menu_name = 'KSTP_KSCH_MENU_May2016'
and ivr_sub_menu_name = 'start';

update cc_c_ivr_menu_group
set ivr_menu_group_name = 'Calls Entering IVR Main Menu', project_name = 'KS CH', program_name = 'KS CH'
where ivr_menu_name = 'KSTP_KSCH_MENU_May2016'
and ivr_sub_menu_name = 'FLG_MAIN_MENU';


update cc_c_ivr_menu_group
set ivr_menu_group_name = 'Main Menu Option 1 Selected - Family '||chr(38)||' Child', project_name = 'KS CH', program_name = 'KS CH'
where ivr_menu_name = 'KSTP_KSCH_MENU_May2016'
and ivr_sub_menu_name = 'FLG_MM_2_FAMILY_MED_MENU';

update cc_c_ivr_menu_group
set ivr_menu_group_name = 'Main Menu Option 2 Selected - Elderly '||chr(38)||' Disabilities', project_name = 'KS CH', program_name = 'KS CH'
where ivr_menu_name = 'KSTP_KSCH_MENU_May2016'
and ivr_sub_menu_name = 'FLG_MM_3_ELDERLY_DISABILITIES_MENU';

update cc_c_ivr_menu_group
set ivr_menu_group_name = 'Main Menu Option 3 Selected - General Questions', project_name = 'KS CH', program_name = 'KS CH'
where ivr_menu_name = 'KSTP_KSCH_MENU_May2016'
and ivr_sub_menu_name = 'FLG_MM_4_GENERAL_INFO_MENU';

update cc_c_ivr_menu_group
set ivr_menu_group_name = 'Main Menu Option 4 Selected - Application Status', project_name = 'KS CH', program_name = 'KS CH'
where ivr_menu_name = 'KSTP_KSCH_MENU_May2016'
and ivr_sub_menu_name = 'FLG_MM_1_AUTOAPP';

update cc_c_ivr_menu_group
set ivr_menu_group_name = 'App Status Returned to Agent Match Found', project_name = 'KS CH', program_name = 'KS CH'
where ivr_menu_name = 'KSTP_KSCH_MENU_May2016'
and ivr_sub_menu_name = 'FLG_ARRCMENU_AGENT';

update cc_c_ivr_menu_group
set ivr_menu_group_name = 'App Status Returned to Agent No Match Found', project_name = 'KS CH', program_name = 'KS CH'
where ivr_menu_name = 'KSTP_KSCH_MENU_May2016'
and ivr_sub_menu_name = 'FLG_ARNMENU_AGENT';

update cc_c_ivr_menu_group
set ivr_menu_group_name = 'App Status Returned to Agent Mulitiple Matches Found', project_name = 'KS CH', program_name = 'KS CH'
where ivr_menu_name = 'KSTP_KSCH_MENU_May2016'
and ivr_sub_menu_name = 'FLG_RETURN_MULTIPLE_MATCH';


commit;