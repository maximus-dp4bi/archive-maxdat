update cc_c_activity_type
set activity_type_description = 'Time when agent logs out at the end of the day'
, is_paid_flag = 0
where activity_type_name = 'Home';


update cc_c_activity_type
set activity_type_description = 'Agents second break time'
, activity_type_category = 'Lunch and Break'
where activity_type_name = 'Break2';



update cc_d_activity_type
set activity_type_desc = 'Time when agent logs out at the end of the day'
, is_paid_flag = 0
where activity_type_name = 'Home';


update cc_d_activity_type
set activity_type_desc = 'Agents second break time'
, activity_type_category = 'Lunch and Break'
where activity_type_name = 'Break2';


commit;