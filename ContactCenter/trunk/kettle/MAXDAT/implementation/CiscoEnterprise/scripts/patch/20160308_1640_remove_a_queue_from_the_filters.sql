delete from cc_c_filter
where value = '5398';

commit;

delete from cc_f_actuals_queue_interval where f_call_center_actls_intrvl_id in
(
select f_call_center_actls_intrvl_id from cc_f_actuals_queue_interval f, cc_d_contact_queue d
where f.d_contact_queue_id = d.d_contact_queue_id
and f.queue_number = '5398');

delete from cc_f_acd_queue_interval where f_cc_acd_queue_intrvl_id in
(
select f_cc_acd_queue_intrvl_id from cc_f_acd_queue_interval f, cc_d_contact_queue d
where f.d_contact_queue_id = d.d_contact_queue_id
and f.queue_number = '5398');

commit;