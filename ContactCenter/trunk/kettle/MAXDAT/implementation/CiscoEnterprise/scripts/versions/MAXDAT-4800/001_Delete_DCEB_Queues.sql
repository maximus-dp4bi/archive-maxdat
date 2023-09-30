alter session set current_schema = cisco_enterprise_cc;

delete from cc_f_agent_by_date
where f_agent_by_date_id in (
select f_agent_by_date_id from cc_f_agent_by_date f, cc_d_dates g, cc_d_project_targets a, cc_d_project b
where f.d_project_targets_id = a.d_project_targets_id
and a.project_id = b.project_id
and b.project_name = 'DC EB'
and f.d_Date_id = g.d_date_id
and g.d_date <= '05-FEB-17');

delete from cc_f_agent_activity_by_date
where f_agent_activity_by_date_id in (
select f_agent_activity_by_date_id from cc_f_agent_activity_by_date f, cc_d_dates g, cc_d_project b
where f.d_project_id = b.project_id 
and b.project_name = 'DC EB'
and f.d_Date_id = g.d_date_id
and g.d_date <= '05-FEB-17');

delete from cc_f_acd_agent_interval
where f_cc_acd_agent_intrvl_id in (
select f_cc_acd_agent_intrvl_id from cc_f_acd_agent_interval a, cc_d_contact_queue b, cc_c_contact_queue c, cc_d_dates d
where a.d_contact_queue_id = b.d_contact_queue_id
and b.queue_number = c.queue_number 
and c.project_name = 'DC EB'
and a.d_Date_id = d.d_date_id
and d.d_date <= '05-FEB-17');

delete from cc_f_acd_queue_interval
where f_cc_acd_queue_intrvl_id in (
select f_cc_acd_queue_intrvl_id from cc_f_acd_queue_interval a, cc_d_contact_queue b, cc_c_contact_queue c, cc_d_dates d
where a.d_contact_queue_id = b.d_contact_queue_id
and b.queue_number = c.queue_number 
and c.project_name = 'DC EB'
and a.d_Date_id = d.d_date_id
and d.d_date <= '05-FEB-17');

delete from cc_f_actuals_queue_interval
where f_call_center_actls_intrvl_id in (
select f_call_center_actls_intrvl_id from cc_f_actuals_queue_interval a, cc_d_contact_queue b, cc_c_contact_queue c, cc_d_dates d
where a.d_contact_queue_id = b.d_contact_queue_id
and b.queue_number = c.queue_number 
and c.project_name = 'DC EB'
and a.d_Date_id = d.d_date_id
and d.d_date <= '05-FEB-17');

delete from cc_s_acd_interval
where acd_interval_id in 
(select acd_interval_id from cc_s_acd_interval a, cc_s_contact_queue b, cc_c_contact_queue c
where a.contact_queue_id = b.contact_queue_id
and b.queue_number = c.queue_number
and c.project_name = 'DC EB'
and trunc(interval_date) <= '05-FEB-17');

delete from cc_s_acd_queue_interval
where acd_queue_interval_id in 
(select acd_queue_interval_id from cc_s_acd_queue_interval a, cc_s_contact_queue b, cc_c_contact_queue c
where a.contact_queue_id = b.contact_queue_id
and b.queue_number = c.queue_number
and c.project_name = 'DC EB'
and trunc(interval_date) <= '05-FEB-17');

delete from cc_s_acd_agent_interval
where acd_agent_interval_id in 
(select acd_agent_interval_id from cc_s_acd_agent_interval a, cc_s_contact_queue b, cc_c_contact_queue c
where a.contact_queue_id = b.contact_queue_id
and b.queue_number = c.queue_number
and c.project_name = 'DC EB'
and trunc(interval_date) <= '05-FEB-17');

commit;
