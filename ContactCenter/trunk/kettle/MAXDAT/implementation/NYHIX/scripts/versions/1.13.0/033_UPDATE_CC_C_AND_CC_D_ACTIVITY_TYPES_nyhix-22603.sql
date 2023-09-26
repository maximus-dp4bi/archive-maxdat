alter session set current_schema = MAXDAT;

update cc_c_activity_type
set activity_type_category = 'Other Not Ready'
, is_paid_flag = 1
where activity_type_name in 
(
  'Account Correction (VDOCS)'
); 

update cc_c_activity_type
set activity_type_category = 'Training'
, is_paid_flag = 1
where activity_type_name in 
(
  'Training -Cayuga'
, 'Training - City Hall'
, 'Training - Garnet'
); 

commit;

update cc_d_activity_type
set activity_type_category = 'Other Not Ready'
, is_paid_flag = 1
where activity_type_name in 
(
  'Account Correction (VDOCS)'
); 

update cc_d_activity_type
set activity_type_category = 'Training'
, is_paid_flag = 1
where activity_type_name in 
(
  'Training -Cayuga'
, 'Training - City Hall'
, 'Training - Garnet'
);

commit;