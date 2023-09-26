delete from cc_f_agent_by_date
where f_agent_by_date_id in (select f_agent_by_date_id from cc_f_agent_by_date f, cc_d_dates d
where f.d_date_id = d.d_date_id
and d.d_date >= '01-APR-15');

commit;

delete from cc_f_agent_activity_by_date
where f_agent_activity_by_date_id in (select f_agent_activity_by_date_id from cc_f_agent_activity_by_date f, cc_d_dates d
where f.d_date_id = d.d_date_id
and d.d_date >= '01-APR-15');

commit;

delete from cc_f_actuals_queue_interval
where f_call_center_actls_intrvl_id in (select f_call_center_actls_intrvl_id from cc_f_actuals_queue_interval f, cc_d_dates d
where f.d_date_id = d.d_date_id
and d.d_date >= '01-APR-15');

commit;