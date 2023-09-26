update cc_c_activity_type 
set activity_type_description = 'MAXIMUS Training'
, activity_type_category = 'Training'
, is_paid_flag =1
where activity_type_name = 'MAXIMUS Training';

update cc_d_activity_type 
set activity_type_desc = 'MAXIMUS Training'
, activity_type_category = 'Training'
, is_paid_flag =1
where activity_type_name = 'MAXIMUS Training';

commit;


update cc_c_activity_type 
set activity_type_description = 'Client Requested Training'
, activity_type_category = 'Training'
, is_paid_flag =1
where activity_type_name = 'Client Requested Training';

update cc_d_activity_type 
set activity_type_desc = 'Client Requested Training'
, activity_type_category = 'Training'
, is_paid_flag =1
where activity_type_name = 'Client Requested Training';

commit;
