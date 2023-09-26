update cc_c_activity_type
set activity_type_category = 'Other Not Ready'
, is_paid_flag = 1
where activity_type_name = '(  )';

update cc_c_activity_type
set activity_type_category = 'Available'
, is_paid_flag = 1
where activity_type_name = 'CSS IV Task Team';

update cc_d_activity_type
set activity_type_category = 'Other Not Ready'
, is_paid_flag = 1
where activity_type_name = '(  )';

update cc_d_activity_type
set activity_type_category = 'Available'
, is_paid_flag = 1
where activity_type_name = 'CSS IV Task Team';

commit;