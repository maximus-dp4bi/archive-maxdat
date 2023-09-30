delete from cc_c_ivr_menu_group
where IVR_SUB_MENU_NAME = 'ThankYou1_FORM'
and IVR_MENU_NAME = 'CARC_CHCO_MENU_NEW'
and IVR_MENU_GROUP_NAME = 'Unknown';

delete from cc_c_ivr_menu_group
where IVR_SUB_MENU_NAME = 'ThankYou_MSG'
and IVR_MENU_NAME = 'CARC_CHCO_MENU_NEW'
and IVR_MENU_GROUP_NAME = 'Unknown';

update cc_c_ivr_menu_group
set ivr_sub_menu_name = 'ThankYou1_FORM'
where ivr_sub_menu_name = 'ThankYou1_Form'
and project_name = 'CA HCO';

update cc_c_ivr_menu_group
set ivr_sub_menu_name = 'ThankYou_MSG'
where ivr_sub_menu_name = 'ThankYou_Msg'
and project_name = 'CA HCO';

update cc_c_ivr_menu_group
set ivr_menu_group_name = 'Unknown'
where ivr_sub_menu_name in ('ThankYou1_FORM', 'ThankYou_MSG')
and project_name = 'CA HCO';

commit;