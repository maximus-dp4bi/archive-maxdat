update cc_c_activity_type
set activity_type_category = 'Available'
, is_paid_flag = 1
, is_available_flag = 1
, is_ready_flag = 1
where activity_type_name in ('Predictive-Dialer', 'Responding to Chats', 'Wrap-Up');

update cc_d_activity_type
set activity_type_category = 'Available'
, is_paid_flag = 1
, is_available_flag = 1
, is_ready_flag = 1
where activity_type_name in ('Predictive-Dialer', 'Responding to Chats', 'Wrap-Up');

commit;