alter session set current_schema = maxdat_pa;

update cc_c_activity_type
set activity_type_category = 'Available', is_paid_flag = 1, is_available_flag = 1, is_ready_flag = 1, is_productive = 1
where activity_type_name = 'System_Default_Activity_Code';

update cc_d_activity_type
set activity_type_category = 'Available', is_paid_flag = 1, is_available_flag = 1, is_ready_flag = 1, is_productive = 1
where activity_type_name = 'System_Default_Activity_Code';

commit;