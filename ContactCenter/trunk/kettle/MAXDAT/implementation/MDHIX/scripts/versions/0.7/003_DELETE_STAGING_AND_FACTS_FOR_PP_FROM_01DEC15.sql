delete from cc_f_actuals_queue_interval
where f_call_center_actls_intrvl_id in (select f_call_center_actls_intrvl_id from cc_f_actuals_queue_interval f, cc_d_dates d
where f.d_date_id = d.d_date_id
and d.d_date >= '01-DEC-15');


delete from cc_f_acd_queue_interval
where f_cc_acd_queue_intrvl_id in (select f_cc_acd_queue_intrvl_id from cc_f_acd_queue_interval f, cc_d_dates d
where f.d_date_id = d.d_date_id
and d.d_date >= '01-DEC-15');

delete from cc_f_acd_agent_interval
where f_cc_acd_agent_intrvl_id in (select f_cc_acd_agent_intrvl_id from cc_f_acd_agent_interval f, cc_d_dates d
where f.d_date_id = d.d_date_id
and d.d_date >= '01-DEC-15');


delete from cc_s_acd_interval
where trunc(interval_date) >= '01-DEC-15';

delete from cc_s_acd_queue_interval
where trunc(interval_date) >= '01-DEC-15';

delete from cc_s_acd_agent_interval
where trunc(interval_date) >= '01-DEC-15';


commit;
