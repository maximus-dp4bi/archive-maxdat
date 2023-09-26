alter session set current_schema = cisco_enterprise_cc;

update cc_f_agent_by_date a
set a.d_agent_id = (select d_agent_id from cc_d_agent where first_name = 'Scheridan' and last_name = 'Beach')
where a.d_agent_id in (select d_agent_id from cc_d_agent where first_name = 'Scherinda' and last_name = 'Beach');

update cc_f_agent_activity_by_date a
set a.d_agent_id = (select d_agent_id from cc_d_agent where first_name = 'Scheridan' and last_name = 'Beach')
where a.d_agent_id in (select d_agent_id from cc_d_agent where first_name = 'Scherinda' and last_name = 'Beach');

update cc_f_acd_agent_interval a
set a.d_agent_id = (select d_agent_id from cc_d_agent where first_name = 'Scheridan' and last_name = 'Beach')
where a.d_agent_id in (select d_agent_id from cc_d_agent where first_name = 'Scherinda' and last_name = 'Beach');

update cc_f_actuals_queue_interval a
set a.d_agent_id = (select d_agent_id from cc_d_agent where first_name = 'Scheridan' and last_name = 'Beach')
where a.d_agent_id in (select d_agent_id from cc_d_agent where first_name = 'Scherinda' and last_name = 'Beach');

commit;