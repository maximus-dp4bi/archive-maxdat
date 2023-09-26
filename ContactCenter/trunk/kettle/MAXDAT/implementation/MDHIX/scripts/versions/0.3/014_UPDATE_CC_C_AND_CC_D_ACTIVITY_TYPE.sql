update cc_c_activity_type
set is_paid_flag = 1
,activity_type_category = 'Meeting'
where activity_type_name in
( 'QA/Ops Huddle'
, 'Supervisor/Lead Coaching'
);

update cc_d_activity_type
 set is_paid_flag = 1
,activity_type_category = 'Meeting'
where activity_type_name in
( 'QA/Ops Huddle'
, 'Supervisor/Lead Coaching'
);

commit;