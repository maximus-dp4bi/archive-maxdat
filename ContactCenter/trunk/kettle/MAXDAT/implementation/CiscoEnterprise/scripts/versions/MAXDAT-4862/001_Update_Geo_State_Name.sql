alter session set current_schema = cisco_enterprise_cc;

update cc_c_project_config
set state_name = 'District of Columbia'
where project_name = 'DC PDMS';

update cc_c_project_config
set region_name = 'Eastern'
where project_name = 'DC EB';

update cc_d_geography_master
set region_id = (select region_id from cc_d_region where region_name = 'Eastern')
where geography_name = 'District of Columbia';

update cc_c_contact_queue
set state_name = 'District of Columbia'
where project_name = 'DC PDMS';

update cc_d_contact_queue
set d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'District of Columbia')
where d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'DC');

update cc_f_acd_agent_interval
set d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'District of Columbia')
where d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'DC');

update cc_f_agent_activity_by_date
set d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'District of Columbia')
where d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'DC');

update cc_f_agent_by_date
set d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'District of Columbia')
where d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'DC');

commit;