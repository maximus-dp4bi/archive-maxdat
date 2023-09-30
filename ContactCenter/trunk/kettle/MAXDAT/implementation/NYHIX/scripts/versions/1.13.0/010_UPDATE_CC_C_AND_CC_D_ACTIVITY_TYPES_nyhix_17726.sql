update cc_c_activity_type
set activity_type_category = 'Training', is_paid_flag = 1, is_available_flag = 0, is_ready_flag = 0, is_absence_flag = 0
where trim(activity_type_name) in ('Siebel UI CBT', 'Account Creation CBT');

update cc_c_activity_type
set activity_type_category = 'Training', is_paid_flag = 1, is_available_flag = 0, is_ready_flag = 0, is_absence_flag = 0
where trim(activity_type_name) like 'Essential Plan%DISRP%';

update cc_c_activity_type
set activity_type_category = 'Other Not Ready', is_paid_flag = 1, is_available_flag = 0, is_ready_flag = 0, is_absence_flag = 0
where trim(activity_type_name) in ('Downstate APR', 'Upstate APR', 'PE Segments');

update cc_d_activity_type
set activity_type_category = 'Training', is_paid_flag = 1, is_available_flag = 0, is_ready_flag = 0, is_absence_flag = 0
where trim(activity_type_name) in ('Siebel UI CBT', 'Account Creation CBT');

update cc_d_activity_type
set activity_type_category = 'Training', is_paid_flag = 1, is_available_flag = 0, is_ready_flag = 0, is_absence_flag = 0
where trim(activity_type_name) like 'Essential Plan%DISRP%';

update cc_d_activity_type
set activity_type_category = 'Other Not Ready', is_paid_flag = 1, is_available_flag = 0, is_ready_flag = 0, is_absence_flag = 0
where trim(activity_type_name) in ('Downstate APR', 'Upstate APR', 'PE Segments');

commit;
