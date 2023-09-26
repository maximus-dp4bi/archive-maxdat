update cc_c_activity_type
set activity_type_category = 'Training'
, is_paid_flag = 1
where activity_type_name = 'Coaching';

update cc_c_activity_type
set activity_type_category = 'Scheduled Unpaid Time Off'
, is_absence_flag = 1
where activity_type_name = 'VTO';

update cc_d_activity_type
set activity_type_category = 'Training'
, is_paid_flag = 1
where activity_type_name = 'Coaching';

update cc_d_activity_type
set activity_type_category = 'Scheduled Unpaid Time Off'
, is_absence_flag = 1
where activity_type_name = 'VTO';

commit;