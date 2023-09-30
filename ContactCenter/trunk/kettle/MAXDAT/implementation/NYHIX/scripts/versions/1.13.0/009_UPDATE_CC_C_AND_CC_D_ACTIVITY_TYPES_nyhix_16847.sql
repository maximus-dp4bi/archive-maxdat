update cc_c_activity_type
set activity_type_category = 'FPBP', is_paid_flag = 1, is_available_flag = 0, is_ready_flag = 0, is_absence_flag = 0
where trim(activity_type_name) in  ('Upstate SDE FPBP', 'Downstate SDE FPBP', 'Downstate QC FPPB MI', 'Upstate QC FPBP MI', 'Upstate QC FPBP', 'Downstate QC FPBP');

update cc_c_activity_type
set activity_type_category = 'NYEC', is_paid_flag = 1, is_available_flag = 0, is_ready_flag = 0, is_absence_flag = 0
where trim(activity_type_name) in ('Upstate QC WMS', 'Downstate QC WMS');

update cc_c_activity_type
set activity_type_category = 'Training', is_paid_flag = 1, is_available_flag = 0, is_ready_flag = 0, is_absence_flag = 0
where trim(activity_type_name) in ('Lang CBT', 'Siebel CBT');

update cc_c_activity_type
set activity_type_category = 'Other Not Ready', is_paid_flag = 1, is_available_flag = 0, is_ready_flag = 0, is_absence_flag = 0
where trim(activity_type_name) = 'Downstate QC Application Registration';


update cc_d_activity_type
set activity_type_category = 'FPBP', is_paid_flag = 1, is_available_flag = 0, is_ready_flag = 0, is_absence_flag = 0
where trim(activity_type_name) in  ('Upstate SDE FPBP', 'Downstate SDE FPBP', 'Downstate QC FPPB MI', 'Upstate QC FPBP MI', 'Upstate QC FPBP', 'Downstate QC FPBP');

update cc_d_activity_type
set activity_type_category = 'NYEC', is_paid_flag = 1, is_available_flag = 0, is_ready_flag = 0, is_absence_flag = 0
where trim(activity_type_name) in ('Upstate QC WMS', 'Downstate QC WMS');

update cc_d_activity_type
set activity_type_category = 'Training', is_paid_flag = 1, is_available_flag = 0, is_ready_flag = 0, is_absence_flag = 0
where trim(activity_type_name) in ('Lang CBT', 'Siebel CBT');

update cc_d_activity_type
set activity_type_category = 'Other Not Ready', is_paid_flag = 1, is_available_flag = 0, is_ready_flag = 0, is_absence_flag = 0
where trim(activity_type_name) = 'Downstate QC Application Registration';

commit;
