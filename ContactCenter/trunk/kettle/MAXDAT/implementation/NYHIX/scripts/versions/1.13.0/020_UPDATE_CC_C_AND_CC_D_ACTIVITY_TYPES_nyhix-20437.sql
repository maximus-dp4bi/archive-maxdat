alter session set current_schema = MAXDAT;

update cc_c_activity_type
set activity_type_category = 'Training'
, is_paid_flag = 1
where activity_type_name in 
(
'Training - Empire'
, 'Training- Cayuga'
);

update cc_c_activity_type
set activity_type_category = 'NYEC'
, is_paid_flag = 1
where activity_type_name in 
(
'NYEC Mailroom'
);


update cc_c_activity_type
set activity_type_category = 'Other Not Ready'
, is_paid_flag = 0
where activity_type_name in 
(
'INACTIVE'
);

update cc_c_activity_type
set activity_type_category = 'Available'
, is_paid_flag = 1
where activity_type_name in 
(
'CSS IV - Task Team (DEMAND)'
);

update cc_c_activity_type
set activity_type_category = 'Other Not Ready'
, is_paid_flag = 1
where activity_type_name in 
(
'Agents must select event from list'
);

commit;




update cc_d_activity_type
set activity_type_category = 'Training'
, is_paid_flag = 1
where activity_type_name in 
(
'Training - Empire'
, 'Training- Cayuga'
);

update cc_d_activity_type
set activity_type_category = 'NYEC'
, is_paid_flag = 1
where activity_type_name in 
(
'NYEC Mailroom'
);


update cc_d_activity_type
set activity_type_category = 'Other Not Ready'
, is_paid_flag = 0
where activity_type_name in 
(
'INACTIVE'
);

update cc_d_activity_type
set activity_type_category = 'Available'
, is_paid_flag = 1
where activity_type_name in 
(
'CSS IV - Task Team (DEMAND)'
);

update cc_d_activity_type
set activity_type_category = 'Other Not Ready'
, is_paid_flag = 1
where activity_type_name in 
(
'Agents must select event from list'
);


commit;

