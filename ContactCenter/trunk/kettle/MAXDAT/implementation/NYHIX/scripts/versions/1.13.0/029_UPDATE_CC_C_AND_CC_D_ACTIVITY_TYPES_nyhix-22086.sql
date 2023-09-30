alter session set current_schema = MAXDAT;

update cc_c_activity_type
set activity_type_category = 'Available'
, is_paid_flag = 1
where activity_type_name in 
(
'CSS III - Cantonese'
, 'CSS III - Mandarin'
, 'CSS III - Russian'
, 'CSS III - Haitian Creole'
);

update cc_c_activity_type
set activity_type_category = 'Other Not Ready'
, is_paid_flag = 1
where activity_type_name in 
(
'ARU Team Lead'
,'ARU Task Team'
, 'ARU Team Lead - QC'
, 'ARU Wrap Up'
, 'HX Cases'
, 'Returned Mail Data Entry'
);

update cc_c_activity_type
set activity_type_category = 'Training'
, is_paid_flag = 1
where activity_type_name in 
(
'Training - The Egg'
);


commit;


update cc_d_activity_type
set activity_type_category = 'Available'
, is_paid_flag = 1
where activity_type_name in 
(
'CSS III - Cantonese'
, 'CSS III - Mandarin'
, 'CSS III - Russian'
, 'CSS III - Haitian Creole'
);

update cc_d_activity_type
set activity_type_category = 'Other Not Ready'
, is_paid_flag = 1
where activity_type_name in 
(
'ARU Team Lead'
,'ARU Task Team'
, 'ARU Team Lead - QC'
, 'ARU Wrap Up'
, 'HX Cases'
, 'Returned Mail Data Entry'
);

update cc_d_activity_type
set activity_type_category = 'Training'
, is_paid_flag = 1
where activity_type_name in 
(
'Training - The Egg'
);


commit;