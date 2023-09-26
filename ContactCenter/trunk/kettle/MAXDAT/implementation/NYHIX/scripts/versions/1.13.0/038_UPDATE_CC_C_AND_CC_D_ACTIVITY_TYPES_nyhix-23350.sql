alter session set current_schema = MAXDAT;

update cc_c_activity_type
set activity_type_category = 'Training'
, is_paid_flag = 1
where activity_type_name in 
(
  'Training - Madison'
  , 'Training - Penn Station'
); 


update cc_c_activity_type
set activity_type_category = 'Scheduled PTO'
, is_paid_flag = 1
where activity_type_name in 
(
  'Bereavement'
);

 
update cc_d_activity_type
set activity_type_category = 'Training'
, is_paid_flag = 1
where activity_type_name in 
(
  'Training - Madison'
  , 'Training - Penn Station'
); 


update cc_d_activity_type
set activity_type_category = 'Scheduled PTO'
, is_paid_flag = 1
where activity_type_name in 
(
  'Bereavement'
); 


commit;