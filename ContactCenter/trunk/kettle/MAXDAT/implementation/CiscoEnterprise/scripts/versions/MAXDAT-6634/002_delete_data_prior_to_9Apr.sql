alter session set current_schema = cisco_enterprise_cc;

delete from cc_f_agent_by_date
where f_agent_by_date_id in (
select f_agent_by_date_id from cc_f_agent_by_date f, cc_d_dates g, cc_d_project_targets a, cc_d_project b, cc_d_program e
where f.d_project_targets_id = a.d_project_targets_id
and a.project_id = b.project_id
and f.d_program_id = e.program_id
and b.project_name = 'MIEB'
and e.program_name = 'Multiple - Provider Support Services'
and f.d_Date_id = g.d_date_id
and g.d_date < '09-APR-18');

delete from cc_f_agent_activity_by_date
where f_agent_activity_by_date_id in (
select f_agent_activity_by_date_id from cc_f_agent_activity_by_date f, cc_d_dates g, cc_d_project b, cc_d_program e
where f.d_project_id = b.project_id 
and b.project_name = 'MIEB'
and f.d_program_id = e.program_id
and e.program_name = 'Multiple - Provider Support Services'
and f.d_Date_id = g.d_date_id
and g.d_date < '09-APR-18');

delete from cc_f_acd_agent_interval
where f_cc_acd_agent_intrvl_id in (
select f_cc_acd_agent_intrvl_id from cc_f_acd_agent_interval a, cc_d_contact_queue b, cc_c_contact_queue c, cc_d_dates d
where a.d_contact_queue_id = b.d_contact_queue_id
and b.queue_number = c.queue_number 
and c.project_name = 'MIEB'
and c.program_name = 'Multiple - Provider Support Services'
and a.d_Date_id = d.d_date_id
and d.d_date < '09-APR-18');

delete from cc_f_acd_queue_interval
where f_cc_acd_queue_intrvl_id in (
select f_cc_acd_queue_intrvl_id from cc_f_acd_queue_interval a, cc_d_contact_queue b, cc_c_contact_queue c, cc_d_dates d
where a.d_contact_queue_id = b.d_contact_queue_id
and b.queue_number = c.queue_number 
and c.project_name = 'MIEB'
and c.program_name = 'Multiple - Provider Support Services'
and a.d_Date_id = d.d_date_id
and d.d_date < '09-APR-18');

delete from cc_f_actuals_queue_interval
where f_call_center_actls_intrvl_id in (
select f_call_center_actls_intrvl_id from cc_f_actuals_queue_interval a, cc_d_contact_queue b, cc_c_contact_queue c, cc_d_dates d
where a.d_contact_queue_id = b.d_contact_queue_id
and b.queue_number = c.queue_number 
and c.project_name = 'MIEB'
and c.program_name = 'Multiple - Provider Support Services'
and a.d_Date_id = d.d_date_id
and d.d_date < '09-APR-18');

delete from cc_f_agent_rtg_grp_interval
where f_agent_rtg_grp_interval_id in (
select f_agent_rtg_grp_interval_id from cc_f_agent_rtg_grp_interval f, cc_d_dates g, cc_c_agent_rtg_grp c
where F.agent_routing_group_id = c.C_AGENT_ROUTING_GROUP_ID 
and c.project_name = 'MIEB'
and C.Program_Name = 'Multiple - Provider Support Services'
and f.d_Date_id = g.d_date_id
and g.d_date < '09-APR-18');

delete from cc_f_term_call_vm
where f_term_call_vm_id in (select f_term_call_vm_id from cc_f_term_call_vm a, cc_c_contact_queue b, cc_d_dates c
where a.queue_number = b.queue_number
and b.project_name = 'MIEB'
and b.program_name = 'Multiple - Provider Support Services'
and a.d_date_id = c.d_date_id
and c.d_date < '09-APR-18');

delete from cc_f_call 
where f_call_id in (select f_call_id from cc_f_call a, cc_c_contact_queue b, cc_d_dates c
where a.queue_number = b.queue_number
and b.project_name = 'MIEB'
and b.program_name = 'Multiple - Provider Support Services'
and a.d_date_id = c.d_date_id
and c.d_date < '09-APR-18');

delete from cc_s_call_detail
where call_detail_id in (select call_detail_id from cc_s_call_detail a, cc_c_contact_queue b
where a.queue_number = b.queue_number
and b.project_name = 'MIEB'
and b.program_name = 'Multiple - Provider Support Services'
and a.call_date < '09-APR-18');

delete from cc_s_term_call_vm
where term_call_vm_id in (select term_call_vm_id from cc_s_term_call_vm a, cc_c_contact_queue b
where a.call_type_id = b.queue_number
and b.project_name = 'MIEB'
and b.program_name = 'Multiple - Provider Support Services'
and a.interval_date < '09-APR-18');

delete from cc_s_agent_rtg_grp_interval
where agent_rtg_grp_interval_id in 
(select agent_rtg_grp_interval_id from cc_s_agent_rtg_grp_interval a, cc_c_agent_rtg_grp c
where a.agent_routing_group_id = c.C_AGENT_ROUTING_GROUP_ID 
and c.project_name = 'MIEB'
and c.program_name = 'Multiple - Provider Support Services'
and trunc(interval_date) < '09-APR-18');

delete from cc_s_acd_interval
where acd_interval_id in 
(select acd_interval_id from cc_s_acd_interval a, cc_s_contact_queue b, cc_c_contact_queue c
where a.contact_queue_id = b.contact_queue_id
and b.queue_number = c.queue_number
and c.project_name = 'MIEB'
and c.program_name = 'Multiple - Provider Support Services'
and trunc(interval_date) < '09-APR-18');

delete from cc_s_acd_queue_interval
where acd_queue_interval_id in 
(select acd_queue_interval_id from cc_s_acd_queue_interval a, cc_s_contact_queue b, cc_c_contact_queue c
where a.contact_queue_id = b.contact_queue_id
and b.queue_number = c.queue_number
and c.project_name = 'MIEB'
and c.program_name = 'Multiple - Provider Support Services'
and trunc(interval_date) < '09-APR-18');

delete from cc_s_acd_agent_interval
where acd_agent_interval_id in 
(select acd_agent_interval_id from cc_s_acd_agent_interval a, cc_s_contact_queue b, cc_c_contact_queue c
where a.contact_queue_id = b.contact_queue_id
and b.queue_number = c.queue_number
and c.project_name = 'MIEB'
and c.program_name = 'Multiple - Provider Support Services'
and trunc(interval_date) < '09-APR-18');

delete from cc_f_actuals_ivr_interval
where f_actuals_ivr_interval_id in (
 select f_actuals_ivr_interval_id
from cc_f_actuals_ivr_interval aii
join cc_d_project pj on pj.project_id = aii.d_project_id
join cc_d_program pg on pg.program_id = aii.d_program_id
join cc_d_dates d on d.d_date_id = Aii.D_Date_Id
where pj.project_name = 'MIEB'
and pg.program_name = 'Multiple - Provider Support Services'
and trunc(d.d_date) < '09-APR-18');

delete from cc_f_ivr_self_service_usage 
where ivr_self_service_usage_id in (
 select ivr_self_service_usage_id
from cc_f_ivr_self_service_usage aii
join cc_d_project pj on pj.project_id = aii.d_project_id
join cc_d_program pg on pg.program_id = aii.d_program_id
join cc_d_dates d on d.d_date_id = Aii.D_Date_Id
where pj.project_name = 'MIEB'
and pg.program_name = 'Multiple - Provider Support Services'
and trunc(d.d_date) < '09-APR-18'
);

delete from cc_s_ivr_response
where trunc(call_date) < '09-APR-18'
and project_name = 'MIEB' and program_name = 'Multiple - Provider Support Services';

commit;

