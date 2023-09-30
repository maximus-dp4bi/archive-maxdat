--1. remove the queue configurations for project / program from the cc_c_lookup table for these queues:

delete from cc_c_lookup where lookup_key in
(select to_char(queue_number) from cc_c_contact_queue where queue_name in ('outbound_dialer_s', 'Outbound_Dialer_Spn_s'));

delete from cc_c_filter where value in
(select to_char(queue_number) from cc_c_contact_queue where queue_name in ('outbound_dialer_s', 'Outbound_Dialer_Spn_s'));

--2. delete all rows from cc_f_actuals_queue_interval for these queues
delete from cc_f_actuals_queue_interval where d_contact_queue_id in 
(select d_contact_queue_id from CC_d_CONTACT_QUEUE where queue_name in ('outbound_dialer_s', 'Outbound_Dialer_Spn_s'));

--3. remove these contact queues from cc_c_contact_queue and cc_d_contact_queue

delete from CC_C_CONTACT_QUEUE where queue_name in ('outbound_dialer_s', 'Outbound_Dialer_Spn_s');

delete from CC_D_CONTACT_QUEUE where queue_name in ('outbound_dialer_s', 'Outbound_Dialer_Spn_s');

commit;

/
