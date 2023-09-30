update cc_c_activity_type
set activity_type_category = 'Other Not Ready'
where activity_type_name = 'Data Entry';

commit;

update cc_d_activity_type
set activity_type_category = 'Other Not Ready'
where activity_type_name = 'Data Entry';

commit;