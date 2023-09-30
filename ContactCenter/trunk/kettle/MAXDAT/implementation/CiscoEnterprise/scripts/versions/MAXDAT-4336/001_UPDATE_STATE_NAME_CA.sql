alter session set current_schema = cisco_enterprise_cc;

update cc_d_geography_master
set geography_name = 'California'
where geography_name = 'CA';

update cc_d_state
set state_name = 'California'
where state_name = 'CA';

update cc_c_project_config
set state_name = 'California'
where state_name = 'CA';

update cc_c_contact_queue
set state_name = 'California'
where state_name = 'CA';

commit;
