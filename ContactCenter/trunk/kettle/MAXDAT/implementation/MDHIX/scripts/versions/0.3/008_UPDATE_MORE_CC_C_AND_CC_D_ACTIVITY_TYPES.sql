update cc_c_activity_type
set is_paid_flag = 1
where activity_type_name in
(
'System Issues'
,'Supervisor/Lead Caoching'
,'TTY Line'
,'QA Coaching'
,'QA Huddles'
,'A Team Ceremony'
,'Ops. Huddles'
);

update cc_c_activity_type
set activity_type_category = 'Other Not Ready'
where activity_type_name in
(
'System Issues'
,'Supervisor/Lead Caoching'
,'QA Coaching'
,'QA Huddles'
,'A Team Ceremony'
,'Ops. Huddles'
);

update cc_c_activity_type
set activity_type_category = 'Available'
, is_available_flag = 1
, is_ready_flag = 1
where activity_type_name = 'TTY Line';


update cc_d_activity_type
set is_paid_flag = 1
where activity_type_name in
(
'System Issues'
,'Supervisor/Lead Caoching'
,'TTY Line'
,'QA Coaching'
,'QA Huddles'
,'A Team Ceremony'
,'Ops. Huddles'
);

update cc_d_activity_type
set activity_type_category = 'Other Not Ready'
where activity_type_name in
(
'System Issues'
,'Supervisor/Lead Caoching'
,'QA Coaching'
,'QA Huddles'
,'A Team Ceremony'
,'Ops. Huddles'
);

update cc_d_activity_type
set activity_type_category = 'Available'
, is_available_flag = 1
, is_ready_flag = 1
where activity_type_name = 'TTY Line';

commit;

