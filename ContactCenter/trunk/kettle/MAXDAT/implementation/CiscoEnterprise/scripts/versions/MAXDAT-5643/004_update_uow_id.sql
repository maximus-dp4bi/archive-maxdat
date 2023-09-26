alter session set current_schema = cisco_enterprise_cc;


--Update July 2017 data

MERGE INTO cc_f_acd_agent_interval faai
using ( select a.f_cc_acd_agent_intrvl_id, b.d_unit_of_work_id from cc_f_acd_agent_interval a, cc_d_contact_queue b, cc_d_project c, cc_d_dates d
where b.d_contact_queue_id = a.d_contact_queue_id
and a.d_project_id = c.project_id
and a.d_date_id = d.d_date_id
and d.d_month_name = 'July'
and d.d_year = '2017'
and c.project_name = 'SCEB'
) sq
ON (faai.f_cc_acd_agent_intrvl_id = sq.f_cc_acd_agent_intrvl_id)
WHEN matched THEN UPDATE SET faai.D_UNIT_OF_WORK_ID = sq.d_unit_of_work_id;

commit;

--Update Aug 2017 data

MERGE INTO cc_f_acd_agent_interval faai
using ( select a.f_cc_acd_agent_intrvl_id, b.d_unit_of_work_id from cc_f_acd_agent_interval a, cc_d_contact_queue b, cc_d_project c, cc_d_dates d
where b.d_contact_queue_id = a.d_contact_queue_id
and a.d_project_id = c.project_id
and a.d_date_id = d.d_date_id
and d.d_month_name = 'August'
and d.d_year = '2017'
and c.project_name = 'SCEB'
) sq
ON (faai.f_cc_acd_agent_intrvl_id = sq.f_cc_acd_agent_intrvl_id)
WHEN matched THEN UPDATE SET faai.D_UNIT_OF_WORK_ID = sq.d_unit_of_work_id;

commit;