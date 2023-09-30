--MAXDAT-3738

alter session set current_schema = folsom_shared_cc;

update cc_c_activity_type
set activity_type_category = 'Lunch and Break'
where activity_type_name in 
('Scheduled Break',
'Scheduled Lunch',
'Unsched_Break');

update cc_c_activity_type
set activity_type_category = 'Unknown'
where activity_type_name in (
'Unknown',
'System_Default_Activity_Code',
'Skillset_Default_Activity_Code',
'Not_Ready_Default_Reason_Code',
'NotRdy_Pull_Mode_Default_Code');

update cc_c_activity_type
set activity_type_category = 'Other Not Ready'
where activity_type_name in (
'Voicemail',
'IS_Problems',
'Intranet Page',
'Predictive_Dialer',
'Rtn_Mail_Outbnd',
'CC_Consolidated',
'Forms Processing',
'Floor Support',
'Research',
'Special Project',
'Post Processing',
'Default_ACW'
);

update cc_c_activity_type
set activity_type_category = 'Meeting'
where activity_type_name in (
'Staff_Meeting',
'HR',
'EOM'
);

update cc_c_activity_type
set activity_type_category = 'Coaching'
where activity_type_name in (
'Spv_Ld_Coach',
'Call_Assist',
'Mentor',
'Call_Coaching'
);

update cc_c_activity_type
set activity_type_category = 'Training'
where activity_type_name in (
'Training'
);

update cc_c_activity_type
set is_paid_flag = 1
where activity_type_name <> 'Scheduled Lunch';

/*update cc_c_activity_type
set is_paid_flag = 1
where activity_type_name in ('Training','Unknown');*/

commit;


update cc_d_activity_type
set activity_type_category = 'Lunch and Break'
where activity_type_name in 
('Scheduled Break',
'Scheduled Lunch',
'Unsched_Break');

update cc_d_activity_type
set activity_type_category = 'Unknown'
where activity_type_name in (
'Unknown',
'System_Default_Activity_Code',
'Skillset_Default_Activity_Code',
'Not_Ready_Default_Reason_Code',
'NotRdy_Pull_Mode_Default_Code');

update cc_d_activity_type
set activity_type_category = 'Other Not Ready'
where activity_type_name in (
'Voicemail',
'IS_Problems',
'Intranet Page',
'Predictive_Dialer',
'Rtn_Mail_Outbnd',
'CC_Consolidated',
'Forms Processing',
'Floor Support',
'Research',
'Special Project',
'Post Processing',
'Default_ACW'
);

update cc_d_activity_type
set activity_type_category = 'Meeting'
where activity_type_name in (
'Staff_Meeting',
'HR',
'EOM'
);

update cc_d_activity_type
set activity_type_category = 'Coaching'
where activity_type_name in (
'Spv_Ld_Coach',
'Call_Assist',
'Mentor',
'Call_Coaching'
);

update cc_d_activity_type
set activity_type_category = 'Training'
where activity_type_name in (
'Training'
);

update cc_d_activity_type
set is_paid_flag = 1
where activity_type_name <> 'Scheduled Lunch';

/*update cc_d_activity_type
set is_paid_flag = 1
where activity_type_name in ('Training','Unknown');*/

commit;