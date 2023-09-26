--Select * From CC_D_ACTIVITY_TYPE a where A.ACTIVITY_TYPE_CATEGORY = 'Unknown';
--Select * From CC_C_ACTIVITY_TYPE a where A.ACTIVITY_TYPE_CATEGORY = 'Unknown';


update CC_D_ACTIVITY_TYPE a
set activity_type_category = 'Unscheduled Unpaid Time Off', is_paid_flag = 0, is_available_flag = 0, is_ready_flag = 0, is_absence_flag = 1
where A.ACTIVITY_TYPE_CATEGORY = 'Unknown' and a.activity_type_name = 'No Call/No Show';
--
update CC_D_ACTIVITY_TYPE a 
set activity_type_category = 'Other Not Ready', is_paid_flag = 1, is_available_flag = 0, is_ready_flag = 0, is_absence_flag = 0 
where A.ACTIVITY_TYPE_CATEGORY = 'Unknown' and a.activity_type_name = 'DATA ENTRY';
--
update CC_D_ACTIVITY_TYPE a
set activity_type_category = 'Available', is_paid_flag = 1, is_available_flag = 1, is_ready_flag = 1, is_absence_flag = 0
where A.ACTIVITY_TYPE_CATEGORY = 'Unknown' and a.activity_type_name = 'CES English Escalation ';
--
update CC_D_ACTIVITY_TYPE a
set activity_type_category = 'Available', is_paid_flag = 1, is_available_flag = 1, is_ready_flag = 1, is_absence_flag = 0
where A.ACTIVITY_TYPE_CATEGORY = 'Unknown' and a.activity_type_name = 'CES Spanish Escalation ';
--
update CC_C_ACTIVITY_TYPE a
set activity_type_category = 'Unscheduled Unpaid Time Off', is_paid_flag = 0, is_available_flag = 0, is_ready_flag = 0, is_absence_flag = 1
where A.ACTIVITY_TYPE_CATEGORY = 'Unknown' and a.activity_type_name = 'No Call/No Show';
--
update CC_C_ACTIVITY_TYPE a 
set activity_type_category = 'Other Not Ready', is_paid_flag = 1, is_available_flag = 0, is_ready_flag = 0, is_absence_flag = 0 
where A.ACTIVITY_TYPE_CATEGORY = 'Unknown' and a.activity_type_name = 'DATA ENTRY';
--
update CC_C_ACTIVITY_TYPE a
set activity_type_category = 'Available', is_paid_flag = 1, is_available_flag = 1, is_ready_flag = 1, is_absence_flag = 0
where A.ACTIVITY_TYPE_CATEGORY = 'Unknown' and a.activity_type_name = 'CES English Escalation ';
--
update CC_C_ACTIVITY_TYPE a
set activity_type_category = 'Available', is_paid_flag = 1, is_available_flag = 1, is_ready_flag = 1, is_absence_flag = 0
where A.ACTIVITY_TYPE_CATEGORY = 'Unknown' and a.activity_type_name = 'CES Spanish Escalation ';
--
COMMIT;
