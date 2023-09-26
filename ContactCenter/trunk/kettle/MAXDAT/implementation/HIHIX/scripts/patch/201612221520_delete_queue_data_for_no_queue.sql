alter session set nls_date_format = 'DD-MON-RR HH24:MI:SS';

alter session set current_schema = MAXDAT;


/*
select * from cc_f_actuals_queue_interval
where f_call_center_actls_intrvl_id in (select f_call_center_actls_intrvl_id from cc_f_actuals_queue_interval f, cc_d_dates d
where f.d_date_id = d.d_date_id
and d_date = '19-DEC-16'
and d_contact_queue_id in (65 ,109));

select * from cc_s_acd_interval
where interval_date = '19-DEC-16'
and contact_queue_id = 45;

*/

delete from cc_f_actuals_queue_interval
where f_call_center_actls_intrvl_id in (select f_call_center_actls_intrvl_id from cc_f_actuals_queue_interval f, cc_d_dates d
where f.d_date_id = d.d_date_id
and d_date = '19-DEC-16'
and d_contact_queue_id in (65 ,109));

delete from cc_s_acd_interval
where interval_date = '19-DEC-16'
and contact_queue_id = 45;

commit;