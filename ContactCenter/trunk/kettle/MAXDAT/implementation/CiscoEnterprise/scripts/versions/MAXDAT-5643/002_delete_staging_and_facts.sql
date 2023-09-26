alter session set current_schema = cisco_enterprise_cc;

delete from cc_f_actuals_queue_interval
where f_call_center_actls_intrvl_id in (select f_call_center_actls_intrvl_id from cc_f_actuals_queue_interval f, cc_d_dates d
where f.d_date_id = d.d_date_id
and d.d_date between '01-AUG-17' and '09-AUG-17');

delete from cc_f_acd_queue_interval
where f_cc_acd_queue_intrvl_id in (select f_cc_acd_queue_intrvl_id from cc_f_acd_queue_interval f, cc_d_dates d
where f.d_date_id = d.d_date_id
and d.d_date between '01-AUG-17' and '09-AUG-17');

delete from cc_s_acd_interval
where trunc(interval_date) between '01-AUG-17' and '09-AUG-17';

delete from cc_s_acd_queue_interval
where trunc(interval_date) between '01-AUG-17' and '09-AUG-17';

commit;

delete from cc_f_actuals_queue_interval
where f_call_center_actls_intrvl_id in (select f_call_center_actls_intrvl_id from cc_f_actuals_queue_interval f, cc_d_dates d
where f.d_date_id = d.d_date_id
and d.d_date between '10-JUL-17' and '31-JUL-17');

delete from cc_f_acd_queue_interval
where f_cc_acd_queue_intrvl_id in (select f_cc_acd_queue_intrvl_id from cc_f_acd_queue_interval f, cc_d_dates d
where f.d_date_id = d.d_date_id
and d.d_date between '10-JUL-17' and '31-JUL-17');

delete from cc_s_acd_interval
where trunc(interval_date) between '10-JUL-17' and '31-JUL-17';

delete from cc_s_acd_queue_interval
where trunc(interval_date) between '10-JUL-17' and '31-JUL-17';

commit;

