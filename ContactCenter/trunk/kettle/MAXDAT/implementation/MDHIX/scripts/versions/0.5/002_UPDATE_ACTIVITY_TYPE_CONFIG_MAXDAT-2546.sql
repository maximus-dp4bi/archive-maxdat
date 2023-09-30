update cc_c_activity_type
set activity_type_category = 'Meeting'
, is_paid_flag = 1
where activity_type_name = 'One On One Meeting' ;

update cc_d_activity_type
set activity_type_category = 'Meeting'
, is_paid_flag = 1
where activity_type_name = 'One On One Meeting' ;

commit;