update cc_s_acd_interval set interval_id = interval_id+2 where interval_date = '03-Nov-2013';
update cc_f_actuals_queue_interval set d_interval_id = d_interval_id + 2 where d_date_id = (select d_date_id from cc_d_dates where d_date = '03-Nov-2013');

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) VALUES ('0.1.3.1','000','000_UPDATE_INTERVAL_ID');

commit;

