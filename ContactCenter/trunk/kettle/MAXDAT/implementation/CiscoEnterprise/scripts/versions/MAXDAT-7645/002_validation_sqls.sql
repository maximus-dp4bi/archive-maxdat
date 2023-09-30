select distinct d_date from cc_f_agent_by_date f, cc_d_dates d, cc_d_project_targets a, cc_d_project b
where f.d_date_id = d.d_date_id
and f.d_project_targets_id = a.d_project_targets_id
and a.project_id = b.project_id
and b.project_name = 'IN EB'
order by d_date 


select distinct d_date from cc_f_agent_activity_by_date f, cc_d_dates d,  cc_d_project b
where f.d_date_id = d.d_date_id
and f.d_project_id = b.project_id
and b.project_name = 'IN EB'
order by d_date 

select distinct d_date from cc_f_acd_agent_interval a, cc_d_contact_queue b, cc_c_contact_queue c, cc_d_dates d
where a.d_date_id = d.d_date_id
and a.d_contact_queue_id = b.d_contact_queue_id
and b.queue_number = c.queue_number 
and c.project_name = 'IN EB'
order by d_date

select distinct d_date from cc_f_acd_queue_interval a, cc_d_contact_queue b, cc_c_contact_queue c, cc_d_dates d
where  a.d_date_id = d.d_date_id
and a.d_contact_queue_id = b.d_contact_queue_id
and b.queue_number = c.queue_number 
and c.project_name = 'IN EB'
order by d_date

select distinct d_date from cc_f_actuals_queue_interval a, cc_d_contact_queue b, cc_c_contact_queue c, cc_d_dates d
where a.d_contact_queue_id = b.d_contact_queue_id
and b.queue_number = c.queue_number 
and c.project_name = 'IN EB'
and a.d_date_id = d.d_date_id
order by d_date

select distinct d_date from cc_f_agent_rtg_grp_interval f, cc_d_dates g, cc_d_project b , cc_c_agent_rtg_grp c
where F.agent_routing_group_id = c.C_AGENT_ROUTING_GROUP_ID 
and b.project_name = c.project_name
and b.project_name = 'IN EB'
and f.d_date_id = g.d_date_id
order by d_date


select distinct d_date from cc_f_term_call_vm a, cc_c_contact_queue b, cc_d_dates c
where a.queue_number = b.queue_number
and b.project_name = 'IN EB'
and a.d_date_id = c.d_date_id
order by d_date

select distinct d_date from cc_f_call a, cc_c_contact_queue b, cc_d_dates c
where a.queue_number = b.queue_number
and b.project_name = 'IN EB'
and a.d_date_id = c.d_date_id
order by d_date
