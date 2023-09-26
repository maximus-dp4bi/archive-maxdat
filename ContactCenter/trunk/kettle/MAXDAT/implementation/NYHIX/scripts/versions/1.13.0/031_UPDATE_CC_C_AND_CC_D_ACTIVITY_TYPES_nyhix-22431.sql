alter session set current_schema = MAXDAT;

update cc_c_activity_type
set activity_type_category = 'Other Not Ready'
, is_paid_flag = 1
where activity_type_name in 
(
  'VLP 3 - G845'
, 'VLP 4 - Override'
, 'Envelope Sorting'
, 'Refer To Account Review'
, 'Escalations'
, 'Data Entry Research '
, 'Dismissal Failed to Attend Hearing'
, 'Document Account Review'
, 'Expired Clock Document'
); 

update cc_c_activity_type
set activity_type_category = 'Available'
, is_paid_flag = 1
where activity_type_name in 
(
  'Team Lead (VDOCS)'
); 

update cc_c_activity_type
set activity_type_category = 'Training'
, is_paid_flag = 1
where activity_type_name in 
(
  'Training - Topaz'
);


commit;

update cc_d_activity_type
set activity_type_category = 'Other Not Ready'
, is_paid_flag = 1
where activity_type_name in 
(
  'VLP 3 - G845'
, 'VLP 4 - Override'
, 'Envelope Sorting'
, 'Refer To Account Review'
, 'Escalations'
, 'Data Entry Research '
, 'Dismissal Failed to Attend Hearing'
, 'Document Account Review'
, 'Expired Clock Document'
); 

update cc_d_activity_type
set activity_type_category = 'Available'
, is_paid_flag = 1
where activity_type_name in 
(
  'Team Lead (VDOCS)'
); 

update cc_d_activity_type
set activity_type_category = 'Training'
, is_paid_flag = 1
where activity_type_name in 
(
  'Training - Topaz'
);



commit;