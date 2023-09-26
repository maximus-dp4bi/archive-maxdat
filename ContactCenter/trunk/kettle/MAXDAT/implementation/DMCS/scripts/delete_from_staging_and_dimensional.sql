
delete from cc_f_actuals_queue_interval;

delete from cc_f_actuals_ivr_interval;

delete from cc_f_ivr_self_service_usage;

delete from cc_d_ivr_self_service_path
where d_ivr_self_service_path_id!=0;

delete from cc_d_contact_queue
where d_contact_queue_id!=0;

delete from cc_s_ivr_Self_Service_usage;

delete from cc_s_ivr_self_service_path;

delete from cc_s_ivr_interval;

delete from cc_s_acd_interval;

delete from cc_s_contact_queue;

delete from cc_s_acd_interval_period;



commit;

