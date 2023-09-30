update cc_c_activity_type
set activity_type_category = 'Training'
, is_paid_flag = 1
where activity_type_name in 
(
  'Training - Hudson'
, 'Training - Shawangunk'
, 'Training - Lark'
);



update cc_d_activity_type
set activity_type_category = 'Training'
, is_paid_flag = 1
where activity_type_name in 
(
  'Training - Hudson'
, 'Training - Shawangunk'
, 'Training - Lark'
);

commit;