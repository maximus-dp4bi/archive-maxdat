-- cc_c_activity_type and cc_d_activity_type

update cc_c_activity_type set ACTIVITY_TYPE_CATEGORY = 'Other Not Ready' where ACTIVITY_TYPE_NAME = 'Abandoned';
update cc_c_activity_type set ACTIVITY_TYPE_CATEGORY = 'Other Not Ready' where ACTIVITY_TYPE_NAME = 'Abandoned epChat';
update cc_c_activity_type set ACTIVITY_TYPE_CATEGORY = 'Other Not Ready' where ACTIVITY_TYPE_NAME = 'Not Ready';
update cc_c_activity_type set ACTIVITY_TYPE_CATEGORY = 'Working Contact' where ACTIVITY_TYPE_NAME = 'On Outbound Call';
update cc_c_activity_type set ACTIVITY_TYPE_CATEGORY = 'Other Not Ready' where ACTIVITY_TYPE_NAME = 'Special Project';
update cc_c_activity_type set ACTIVITY_TYPE_CATEGORY = 'Unknown' where ACTIVITY_TYPE_NAME = 'Login';
update cc_c_activity_type set ACTIVITY_TYPE_CATEGORY = 'Working Contact' where ACTIVITY_TYPE_NAME = 'ACW';
update cc_c_activity_type set ACTIVITY_TYPE_CATEGORY = 'Other Not Ready' where ACTIVITY_TYPE_NAME = 'Logged In';
update cc_c_activity_type set ACTIVITY_TYPE_CATEGORY = 'Meeting' where ACTIVITY_TYPE_NAME = 'Team Meeting';
update cc_c_activity_type set ACTIVITY_TYPE_CATEGORY = 'Training' where ACTIVITY_TYPE_NAME = 'Training';
update cc_c_activity_type set ACTIVITY_TYPE_CATEGORY = 'Other Not Ready' where ACTIVITY_TYPE_NAME = '603';
update cc_c_activity_type set ACTIVITY_TYPE_CATEGORY = 'Other Not Ready' where ACTIVITY_TYPE_NAME = '504';
update cc_c_activity_type set ACTIVITY_TYPE_CATEGORY = 'Other Not Ready' where ACTIVITY_TYPE_NAME = 'Abandoned epVmail';

update cc_c_activity_type set IS_AVAILABLE_FLAG = 1, IS_READY_FLAG = 1 where ACTIVITY_TYPE_NAME = 'After Call Work';
update cc_c_activity_type set IS_AVAILABLE_FLAG = 1, IS_READY_FLAG = 1 where ACTIVITY_TYPE_NAME = 'On Outbound Call';
update cc_c_activity_type set IS_AVAILABLE_FLAG = 1, IS_READY_FLAG = 1 where ACTIVITY_TYPE_NAME = 'ACW';



update cc_d_activity_type set ACTIVITY_TYPE_CATEGORY = 'Other Not Ready' where ACTIVITY_TYPE_NAME = 'Abandoned';
update cc_d_activity_type set ACTIVITY_TYPE_CATEGORY = 'Other Not Ready' where ACTIVITY_TYPE_NAME = 'Abandoned epChat';
update cc_d_activity_type set ACTIVITY_TYPE_CATEGORY = 'Other Not Ready' where ACTIVITY_TYPE_NAME = 'Not Ready';
update cc_d_activity_type set ACTIVITY_TYPE_CATEGORY = 'Working Contact' where ACTIVITY_TYPE_NAME = 'On Outbound Call';
update cc_d_activity_type set ACTIVITY_TYPE_CATEGORY = 'Other Not Ready' where ACTIVITY_TYPE_NAME = 'Special Project';
update cc_d_activity_type set ACTIVITY_TYPE_CATEGORY = 'Unknown' where ACTIVITY_TYPE_NAME = 'Login';
update cc_d_activity_type set ACTIVITY_TYPE_CATEGORY = 'Other Not Ready' where ACTIVITY_TYPE_NAME = 'Logged In';
update cc_d_activity_type set ACTIVITY_TYPE_CATEGORY = 'Meeting' where ACTIVITY_TYPE_NAME = 'Team Meeting';
update cc_d_activity_type set ACTIVITY_TYPE_CATEGORY = 'Training' where ACTIVITY_TYPE_NAME = 'Training';
update cc_d_activity_type set ACTIVITY_TYPE_CATEGORY = 'Working Contact' where ACTIVITY_TYPE_NAME = 'ACW';
update cc_d_activity_type set ACTIVITY_TYPE_CATEGORY = 'Other Not Ready' where ACTIVITY_TYPE_NAME = '603';
update cc_d_activity_type set ACTIVITY_TYPE_CATEGORY = 'Other Not Ready' where ACTIVITY_TYPE_NAME = '504';
update cc_d_activity_type set ACTIVITY_TYPE_CATEGORY = 'Other Not Ready' where ACTIVITY_TYPE_NAME = 'Abandoned epVmail';

update cc_d_activity_type set IS_AVAILABLE_FLAG = 0, IS_READY_FLAG = 0, IS_ABSENCE_FLAG = 0 where ACTIVITY_TYPE_NAME = 'Unknown';
update cc_d_activity_type set IS_AVAILABLE_FLAG = 1, IS_READY_FLAG = 1, IS_ABSENCE_FLAG = 0 where ACTIVITY_TYPE_NAME = 'After Call Work';
update cc_d_activity_type set IS_AVAILABLE_FLAG = 1, IS_READY_FLAG = 1, IS_ABSENCE_FLAG = 0 where ACTIVITY_TYPE_NAME = 'On Outbound Call';
update cc_d_activity_type set IS_AVAILABLE_FLAG = 1, IS_READY_FLAG = 1, IS_ABSENCE_FLAG = 0 where ACTIVITY_TYPE_NAME = 'ACW';

commit;