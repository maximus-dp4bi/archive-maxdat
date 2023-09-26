update cc_c_activity_type
set activity_type_category = 'Other Not Ready', is_paid_flag = 1, is_available_flag = 0, is_ready_flag = 0, is_absence_flag = 0
where activity_type_name in  ('Retro Verification Document', 'Approved', 'Downstate SDE Application Registration', 'Upstate SDE Application Registration', 'VLP - G845', 'Data Entry Research - Immigration Docs', 'VLP - Follow Up', 'VLP - PRUCOL', 'VLP - Override', 'Image Assembly', 'Upstate QC Application Registration');

update cc_c_activity_type
set activity_type_category = 'NYEC', is_paid_flag = 1, is_available_flag = 0, is_ready_flag = 0, is_absence_flag = 0
where activity_type_name in ('Fair Hearing incidents', 'Fair Hearing Case Maintenance', 'Hold For WMS', 'Reactivation Reports', 'Reactivation APR', 'Upstate SDE WMS', 'Downstate SDE WMS', 'Reactivation DPR', 'Ren Kofax VAL Mail', 'Ren Kofax VAL Fax', 'Ren Kofax QC Fax', 'Ren Kofax QC Mail');

update cc_c_activity_type
set activity_type_category = 'Scheduled PTO', is_paid_flag = 1, is_available_flag = 0, is_ready_flag = 0, is_absence_flag = 0
where activity_type_name = 'July 2015 Holiday';

update cc_c_activity_type
set activity_type_category = 'FPBP', is_paid_flag = 1, is_available_flag = 0, is_ready_flag = 0, is_absence_flag = 0
where activity_type_name in ('Upstate DE FPPB MI', 'Upstate SDE FPBP', 'Downstate SDE FPBP', 'Downstate SDE FPPB MI', 'FPBP Kofax VAL Fax', 'FPBP Kofax QC Fax', 'FPBP Kofax VAL Mail', 'FPBP Kofax QC Mail', 'FPBP HSDE QC', 'Upstate SDE FPBP MI');


update cc_d_activity_type
set activity_type_category = 'Other Not Ready', is_paid_flag = 1, is_available_flag = 0, is_ready_flag = 0, is_absence_flag = 0
where activity_type_name in  ('Retro Verification Document', 'Approved', 'Downstate SDE Application Registration', 'Upstate SDE Application Registration', 'VLP - G845', 'Data Entry Research - Immigration Docs', 'VLP - Follow Up', 'VLP - PRUCOL', 'VLP - Override', 'Image Assembly', 'Upstate QC Application Registration');

update cc_d_activity_type
set activity_type_category = 'NYEC', is_paid_flag = 1, is_available_flag = 0, is_ready_flag = 0, is_absence_flag = 0
where activity_type_name in ('Fair Hearing incidents', 'Fair Hearing Case Maintenance', 'Hold For WMS', 'Reactivation Reports', 'Reactivation APR', 'Upstate SDE WMS', 'Downstate SDE WMS', 'Reactivation DPR', 'Ren Kofax VAL Mail', 'Ren Kofax VAL Fax', 'Ren Kofax QC Fax', 'Ren Kofax QC Mail');

update cc_d_activity_type
set activity_type_category = 'Scheduled PTO', is_paid_flag = 1, is_available_flag = 0, is_ready_flag = 0, is_absence_flag = 0
where activity_type_name = 'July 2015 Holiday';

update cc_d_activity_type
set activity_type_category = 'FPBP', is_paid_flag = 1, is_available_flag = 0, is_ready_flag = 0, is_absence_flag = 0
where activity_type_name in ('Upstate DE FPPB MI', 'Upstate SDE FPBP', 'Downstate SDE FPBP', 'Downstate SDE FPPB MI', 'FPBP Kofax VAL Fax', 'FPBP Kofax QC Fax', 'FPBP Kofax VAL Mail', 'FPBP Kofax QC Mail', 'FPBP HSDE QC', 'Upstate SDE FPBP MI');

commit;
