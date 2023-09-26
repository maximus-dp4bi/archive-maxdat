update cc_c_activity_type
set activity_type_category = 'Training', is_paid_flag = 1, is_available_flag = 0, is_ready_flag = 0, is_absence_flag = 0
where activity_type_name in ('Return Mail Refresher Classroom Training', 'ABSORB DSIRP training', 'Returned Mail Training', 'MPSD Training', 'Classroom DSIRP training');

commit;

update cc_c_activity_type
set activity_type_category = 'Other Not Ready', is_paid_flag = 1, is_available_flag = 0, is_ready_flag = 0, is_absence_flag = 0
where activity_type_name in ('Focus Group', '30 Day Check In ');

commit;

update cc_d_activity_type
set activity_type_category = 'Training', is_paid_flag = 1, is_available_flag = 0, is_ready_flag = 0, is_absence_flag = 0
where activity_type_name in ('Return Mail Refresher Classroom Training', 'ABSORB DSIRP training', 'Returned Mail Training', 'MPSD Training', 'Classroom DSIRP training');

commit;

update cc_d_activity_type
set activity_type_category = 'Other Not Ready', is_paid_flag = 1, is_available_flag = 0, is_ready_flag = 0, is_absence_flag = 0
where activity_type_name in ('Focus Group', '30 Day Check In ');

commit;