update cc_c_activity_type
set is_available_flag = 1
where activity_type_name in
(
'Special Handling Team Spanish'
, 'Special Handling Team English'
);


update cc_d_activity_type
set is_available_flag = 1
where activity_type_name in
(
'Special Handling Team Spanish'
, 'Special Handling Team English'
);

commit;