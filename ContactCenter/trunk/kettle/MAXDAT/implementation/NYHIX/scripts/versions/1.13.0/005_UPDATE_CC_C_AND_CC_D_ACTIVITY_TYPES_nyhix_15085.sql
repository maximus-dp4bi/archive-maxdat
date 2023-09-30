update cc_c_activity_type
set activity_type_category = 'Training', is_paid_flag = 1, is_available_flag = 0, is_ready_flag = 0, is_absence_flag = 0
where activity_type_name in ('DMATCH Training', 'Retro Processing Training');

commit;

update cc_d_activity_type
set activity_type_category = 'Training', is_paid_flag = 1, is_available_flag = 0, is_ready_flag = 0, is_absence_flag = 0
where activity_type_name in ('DMATCH Training', 'Retro Processing Training');

commit;
