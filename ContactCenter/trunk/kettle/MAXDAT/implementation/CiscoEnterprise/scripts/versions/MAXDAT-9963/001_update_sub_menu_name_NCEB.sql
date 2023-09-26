update cc_c_ivr_menu_group
set ivr_menu_group_name = 'Failed SSN Authentication'
, project_name = 'NCEB'
, program_name = 'Medicaid'
where ivr_menu_name = 'NCMO_NCEB_MAXe5_IVR_Prod'
and ivr_sub_menu_name = 'CaptureSSNDOB.NCEB_FLG_SSN_INVALID';

update cc_c_ivr_menu_group
set ivr_menu_group_name = 'Successful SSN Authentication'
, project_name = 'NCEB'
, program_name = 'Medicaid'
where ivr_menu_name = 'NCMO_NCEB_MAXe5_IVR_Prod'
and ivr_sub_menu_name = 'CaptureSSNDOB.NCEB_FLG_SSN_CORRECT';

update cc_c_ivr_menu_group
set ivr_menu_group_name = 'Failed NCID Authentication'
, project_name = 'NCEB'
, program_name = 'Medicaid'
where ivr_menu_name = 'NCMO_NCEB_MAXe5_IVR_Prod'
and ivr_sub_menu_name = 'CaptureMedicaidDOB.NCEB_FLG_MID_INVALID';

update cc_c_ivr_menu_group
set ivr_menu_group_name = 'Successful NCID Authentication'
, project_name = 'NCEB'
, program_name = 'Medicaid'
where ivr_menu_name = 'NCMO_NCEB_MAXe5_IVR_Prod'
and ivr_sub_menu_name = 'CaptureMedicaidDOB.NCEB_FLG_MID_CORRECT';

commit;