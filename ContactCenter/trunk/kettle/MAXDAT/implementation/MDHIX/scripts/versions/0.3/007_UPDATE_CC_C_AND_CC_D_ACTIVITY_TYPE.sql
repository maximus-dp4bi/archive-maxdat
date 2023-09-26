update cc_c_activity_type
set is_paid_flag = 0
where activity_type_name = 'Lunch';

update cc_d_activity_type
set is_paid_flag = 0
where activity_type_name = 'Lunch';

commit;