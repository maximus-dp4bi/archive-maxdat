update cc_c_activity_type
set activity_type_category = 'Other Not Ready'
, is_paid_flag = 1
where activity_type_name in
( 'Task Team - Defect'
, 'Task Team - Referrals'
, 'Task Team - Complaints Follow-up'
, 'Task Team - Activities'
, 'Task Team - Complaints'
, 'Task Team - Outbound Call'

);



update cc_d_activity_type
set activity_type_category = 'Other Not Ready'
, is_paid_flag = 1
where activity_type_name in
( 'Task Team - Defect'
, 'Task Team - Referrals'
, 'Task Team - Complaints Follow-up'
, 'Task Team - Activities'
, 'Task Team - Complaints'
, 'Task Team - Outbound Call'

);



commit;