alter session set nls_date_format = 'DD-MON-RR HH24:MI:SS';

alter session set current_schema = CISCO_ENTERPRISE_CC;

update cc_c_activity_type set activity_type_description = 'Break' , activity_type_category = 'Lunch and Break' , is_paid_flag = 1 , is_available_flag = 0 , is_ready_flag = 0 where activity_type_name = 'Break'; 
update cc_c_activity_type set activity_type_description = 'Lunch' , activity_type_category = 'Lunch and Break' , is_paid_flag = 0 , is_available_flag = 0 , is_ready_flag = 0 where activity_type_name = 'Lunch'; 
update cc_c_activity_type set activity_type_description = 'Meeting' , activity_type_category = 'Meeting' , is_paid_flag = 1 , is_available_flag = 0 , is_ready_flag = 0 where activity_type_name = 'Meeting'; 
update cc_c_activity_type set activity_type_description = 'Personal' , activity_type_category = 'Other Not Ready' , is_paid_flag = 1 , is_available_flag = 0 , is_ready_flag = 0 where activity_type_name = 'Personal'; 
update cc_c_activity_type set activity_type_description = 'Training' , activity_type_category = 'Training' , is_paid_flag = 1 , is_available_flag = 0 , is_ready_flag = 0 where activity_type_name = 'Training'; 
update cc_c_activity_type set activity_type_description = 'Phone or Network Issues' , activity_type_category = 'Other Not Ready' , is_paid_flag = 1 , is_available_flag = 0 , is_ready_flag = 0 where activity_type_name = 'System Issues'; 
update cc_c_activity_type set activity_type_description = 'End of Shift' , activity_type_category = 'Other Not Ready' , is_paid_flag = 0 , is_available_flag = 0 , is_ready_flag = 0 where activity_type_name = 'End of Shift'; 
update cc_c_activity_type set activity_type_description = 'Special Projects' , activity_type_category = 'Other Not Ready' , is_paid_flag = 1 , is_available_flag = 0 , is_ready_flag = 0 where activity_type_name = 'Special Projects'; 
update cc_c_activity_type set activity_type_description = 'Bathroom' , activity_type_category = 'Other Not Ready' , is_paid_flag = 1 , is_available_flag = 0 , is_ready_flag = 0 where activity_type_name = 'Bathroom'; 
update cc_c_activity_type set activity_type_description = 'Break' , activity_type_category = 'Lunch and Break' , is_paid_flag = 1 , is_available_flag = 0 , is_ready_flag = 0 where activity_type_name = 'Break 2'; 
update cc_c_activity_type set activity_type_description = 'Follow Up' , activity_type_category = 'Other Not Ready' , is_paid_flag = 1 , is_available_flag = 0 , is_ready_flag = 0 where activity_type_name = 'Follow Up'; 
update cc_c_activity_type set activity_type_description = 'Resource Center' , activity_type_category = 'Other Not Ready' , is_paid_flag = 1 , is_available_flag = 0 , is_ready_flag = 0 where activity_type_name = 'Resource Center'; 
update cc_c_activity_type set activity_type_description = 'Emergency' , activity_type_category = 'Other Not Ready' , is_paid_flag = 1 , is_available_flag = 0 , is_ready_flag = 0 where activity_type_name = 'Emergency'; 
update cc_c_activity_type set activity_type_description = 'Dropped Call-Call Back' , activity_type_category = 'Other Not Ready' , is_paid_flag = 1 , is_available_flag = 0 , is_ready_flag = 0 where activity_type_name = 'Dropped Call-Call Back'; 
update cc_c_activity_type set activity_type_description = 'ACW' , activity_type_category = 'Available' , is_paid_flag = 1 , is_available_flag = 1 , is_ready_flag = 1 where activity_type_name = 'ACW'; 
update cc_c_activity_type set activity_type_description = 'Voice Mail' , activity_type_category = 'Other Not Ready' , is_paid_flag = 1 , is_available_flag = 0 , is_ready_flag = 0 where activity_type_name = 'VM'; 
update cc_c_activity_type set activity_type_description = 'Subject Matter Expert' , activity_type_category = 'Other Not Ready' , is_paid_flag = 1 , is_available_flag = 0 , is_ready_flag = 0 where activity_type_name = 'SME'; 
update cc_c_activity_type set activity_type_description = 'Offline Work' , activity_type_category = 'Other Not Ready' , is_paid_flag = 1 , is_available_flag = 0 , is_ready_flag = 0 where activity_type_name = 'Offline Work'; 
update cc_c_activity_type set activity_type_description = 'Coaching' , activity_type_category = 'Training' , is_paid_flag = 1 , is_available_flag = 0 , is_ready_flag = 0 where activity_type_name = 'Coaching'; 

commit;

update cc_d_activity_type set activity_type_desc = 'Break' , activity_type_category = 'Lunch and Break' , is_paid_flag = 1 , is_available_flag = 0 , is_ready_flag = 0 where activity_type_name = 'Break';
update cc_d_activity_type set activity_type_desc = 'Lunch' , activity_type_category = 'Lunch and Break' , is_paid_flag = 0 , is_available_flag = 0 , is_ready_flag = 0 where activity_type_name = 'Lunch';
update cc_d_activity_type set activity_type_desc = 'Meeting' , activity_type_category = 'Meeting' , is_paid_flag = 1 , is_available_flag = 0 , is_ready_flag = 0 where activity_type_name = 'Meeting';
update cc_d_activity_type set activity_type_desc = 'Personal' , activity_type_category = 'Other Not Ready' , is_paid_flag = 1 , is_available_flag = 0 , is_ready_flag = 0 where activity_type_name = 'Personal';
update cc_d_activity_type set activity_type_desc = 'Training' , activity_type_category = 'Training' , is_paid_flag = 1 , is_available_flag = 0 , is_ready_flag = 0 where activity_type_name = 'Training';
update cc_d_activity_type set activity_type_desc = 'Phone or Network Issues' , activity_type_category = 'Other Not Ready' , is_paid_flag = 1 , is_available_flag = 0 , is_ready_flag = 0 where activity_type_name = 'System Issues';
update cc_d_activity_type set activity_type_desc = 'End of Shift' , activity_type_category = 'Other Not Ready' , is_paid_flag = 0 , is_available_flag = 0 , is_ready_flag = 0 where activity_type_name = 'End of Shift';
update cc_d_activity_type set activity_type_desc = 'Special Projects' , activity_type_category = 'Other Not Ready' , is_paid_flag = 1 , is_available_flag = 0 , is_ready_flag = 0 where activity_type_name = 'Special Projects';
update cc_d_activity_type set activity_type_desc = 'Bathroom' , activity_type_category = 'Other Not Ready' , is_paid_flag = 1 , is_available_flag = 0 , is_ready_flag = 0 where activity_type_name = 'Bathroom';
update cc_d_activity_type set activity_type_desc = 'Break' , activity_type_category = 'Lunch and Break' , is_paid_flag = 1 , is_available_flag = 0 , is_ready_flag = 0 where activity_type_name = 'Break 2';
update cc_d_activity_type set activity_type_desc = 'Follow Up' , activity_type_category = 'Other Not Ready' , is_paid_flag = 1 , is_available_flag = 0 , is_ready_flag = 0 where activity_type_name = 'Follow Up';
update cc_d_activity_type set activity_type_desc = 'Resource Center' , activity_type_category = 'Other Not Ready' , is_paid_flag = 1 , is_available_flag = 0 , is_ready_flag = 0 where activity_type_name = 'Resource Center';
update cc_d_activity_type set activity_type_desc = 'Emergency' , activity_type_category = 'Other Not Ready' , is_paid_flag = 1 , is_available_flag = 0 , is_ready_flag = 0 where activity_type_name = 'Emergency';
update cc_d_activity_type set activity_type_desc = 'Dropped Call-Call Back' , activity_type_category = 'Other Not Ready' , is_paid_flag = 1 , is_available_flag = 0 , is_ready_flag = 0 where activity_type_name = 'Dropped Call-Call Back';
update cc_d_activity_type set activity_type_desc = 'ACW' , activity_type_category = 'Available' , is_paid_flag = 1 , is_available_flag = 1 , is_ready_flag = 1 where activity_type_name = 'ACW';
update cc_d_activity_type set activity_type_desc = 'Voice Mail' , activity_type_category = 'Other Not Ready' , is_paid_flag = 1 , is_available_flag = 0 , is_ready_flag = 0 where activity_type_name = 'VM';
update cc_d_activity_type set activity_type_desc = 'Subject Matter Expert' , activity_type_category = 'Other Not Ready' , is_paid_flag = 1 , is_available_flag = 0 , is_ready_flag = 0 where activity_type_name = 'SME';
update cc_d_activity_type set activity_type_desc = 'Offline Work' , activity_type_category = 'Other Not Ready' , is_paid_flag = 1 , is_available_flag = 0 , is_ready_flag = 0 where activity_type_name = 'Offline Work';
update cc_d_activity_type set activity_type_desc = 'Coaching' , activity_type_category = 'Training' , is_paid_flag = 1 , is_available_flag = 0 , is_ready_flag = 0 where activity_type_name = 'Coaching';

commit;