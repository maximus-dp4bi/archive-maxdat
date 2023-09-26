alter session set current_schema = cisco_enterprise_cc;

update cc_c_ivr_menu_group
set ivr_menu_group_name = 'Transfer to CSR', project_name = 'CA HCO', program_name = 'Medi-Cal'
where ivr_sub_menu_name in ('CARC_FLG_CSR_ESMENU',
'CARC_FLG_CSR_FCMENU',
'CARC_FLG_CSR_MAILMENU',
'CARC_FLG_CSR_MATERIALSMENU',
'CARC_FLG_CSR_NUMENU1',
'CARC_FLG_CSR_NUMENU2',
'CARC_FLG_CSR_NZMENU',
'CARC_FLG_CSR_SITEMENU',
'CARC_FLG_CSR_SITESUBMENU',
'CARC_FLG_CSR_SSN',
'CaptureSSNDOB.CARC_FLG_CSR_SSN'
)
and ivr_menu_name = 'CARC_CHCO_MENU_NEW'
and ivr_menu_group_name <> 'Transfer to CSR';

commit;