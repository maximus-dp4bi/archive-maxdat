update cc_c_activity_type
set activity_type_category = 'Other Not Ready', is_paid_flag = 1, is_available_flag = 0, is_ready_flag = 0, is_absence_flag = 0
where trim(activity_type_name) = 'Mail Room Processor';

update cc_c_activity_type
set activity_type_category = 'Scheduled PTO', is_paid_flag = 1, is_available_flag = 0, is_ready_flag = 0, is_absence_flag = 1
where trim(activity_type_name) = 'Vacation'
and activity_type_id = 341;

commit;


update cc_d_activity_type
set activity_type_category = 'Other Not Ready', is_paid_flag = 1, is_available_flag = 0, is_ready_flag = 0, is_absence_flag = 0
where trim(activity_type_name) = 'Mail Room Processor';

update cc_d_activity_type
set activity_type_category = 'Scheduled PTO', is_paid_flag = 1, is_available_flag = 0, is_ready_flag = 0, is_absence_flag = 1
where trim(activity_type_name) = 'Vacation'
and d_activity_type_id = 341;

commit;