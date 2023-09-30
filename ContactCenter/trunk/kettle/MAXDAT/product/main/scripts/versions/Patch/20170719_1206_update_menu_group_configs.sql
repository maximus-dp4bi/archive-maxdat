update cc_c_ivr_menu_group
set ivr_menu_group_name = 'General Contact'
where ivr_sub_menu_name in ('CARC_FLG_MMENU_CMENU', 'CARC_FLG_RETURNMM_CMENU', 'CARC_FLG_HCO_CMENU', 'CARC_FLG_MMCD_CMENU', 'CARC_FLG_DENTI_CMENU', 'CARC_FLG_FH_CMENU', 'CARC_FLG_RETURNCM_CSUBMENU', 'CARC_FLG_REPEAT_CSUBMENU')
and project_name = 'CA HCO';

update cc_c_ivr_menu_group
set ivr_menu_group_name = 'Enroll Info'
where ivr_sub_menu_name in ('CARC_FLG_MMENU_ENROLLMENU', 'CARC_FLG_HCO_ENROLLMENU', 'CARC_FLG_ENROLL_ENROLLMENU', 'CARC_FLG_FEEINFO_ENROLLMENU', 'CARC_FLG_PLANCHG_ENROLLMENU', 'CARC_FLG_CHOICEFORM_ENROLLMENU', 'CARC_FLG_RETURN_CHOICEMENU', 'CARC_FLG_REPEAT_CHOICEMENU', 'CARC_FLG_RETURN_FEEMENU', 'CARC_FLG_REPEAT_FEEMENU', 'CARC_FLG_RETURN_ENROLLSUBMENU', 'CARC_FLG_REPEAT_ENROLLSUBMENU', 'CARC_FLG_RETURN_PLANMENU', 'CARC_FLG_REPEAT_PLANMENU', 'CARC_FLG_RETURN_HCOMENU', 'CARC_FLG_REPEAT_HCOMENU')
and project_name = 'CA HCO';

update cc_c_ivr_menu_group
set ivr_menu_group_name = 'Status of Enroll'
where ivr_sub_menu_name in ('CARC_FLG_REPEAT_ESMENU')
and project_name = 'CA HCO';

update cc_c_ivr_menu_group
set ivr_menu_group_name = 'Exempt Req'
where ivr_sub_menu_name in ('CARC_FLG_RETURNMM_MDMENU', 'CARC_FLG_MEDREQ_MDMENU', 'CARC_FLG_DENTREQ_MDMENU', 'CARC_FLG_RETURNMEDDENT_MDSUBMENU')
and project_name = 'CA HCO';

update cc_c_ivr_menu_group
set ivr_menu_group_name = 'Send Req Mat'
where ivr_sub_menu_name in ('CARC_FLG_YES_MAILMENU')
and project_name = 'CA HCO';

commit;