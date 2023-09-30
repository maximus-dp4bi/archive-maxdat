update cc_c_activity_type
set activity_type_category = 'Other Not Ready'
, is_paid_flag = 1
where activity_type_name in 
(
  'Printing Rescans'
, 'Logging Live Checks' 
, 'Logging Voter Registration'
, 'Storage'
, 'Scanning'
, 'Logging NYSOH Apps'
, 'Appeal Letters'
, 'Evidence Packets'
);

update cc_c_activity_type
set activity_type_category = 'Training'
, is_paid_flag = 1
where activity_type_name in 
(
'Training - Washington Park'
);

commit;

update cc_d_activity_type
set activity_type_category = 'Other Not Ready'
, is_paid_flag = 1
where activity_type_name in 
(
  'Printing Rescans'
, 'Logging Live Checks' 
, 'Logging Voter Registration'
, 'Storage'
, 'Scanning'
, 'Logging NYSOH Apps'
, 'Appeal Letters'
, 'Evidence Packets'  
);


update cc_d_activity_type
set activity_type_category = 'Training'
, is_paid_flag = 1
where activity_type_name in 
(
'Training - Washington Park'
);


commit;