alter session set current_schema = MAXDAT;

update cc_c_activity_type
set activity_type_category = 'Available'
, is_paid_flag = 1
where activity_type_name in 
(
'CSS III - Mandarin/Cantonese'
);

update cc_c_activity_type
set activity_type_category = 'Other Not Ready'
, is_paid_flag = 1
where activity_type_name in 
(
'Defect Task'
,'NYSOH Support Inbox'
, 'Reschedule Hearing'
);

commit;


update cc_d_activity_type
set activity_type_category = 'Available'
, is_paid_flag = 1
where activity_type_name in 
(
'CSS III - Mandarin/Cantonese'
);

update cc_d_activity_type
set activity_type_category = 'Other Not Ready'
, is_paid_flag = 1
where activity_type_name in 
(
'Defect Task'
,'NYSOH Support Inbox'
, 'Reschedule Hearing'
);


commit;