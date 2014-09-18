 update cc_f_actuals_queue_interval set d_contact_queue_id = 111 where d_contact_queue_id = 40;
 update cc_f_actuals_queue_interval set d_contact_queue_id = 111 where d_contact_queue_id = 19;	
 update cc_f_actuals_queue_interval set d_contact_queue_id = 112 where d_contact_queue_id = 41;	
 update cc_f_actuals_queue_interval set d_contact_queue_id = 112 where d_contact_queue_id = 20;	
 update cc_f_actuals_queue_interval set d_contact_queue_id = 113 where d_contact_queue_id = 42;	
 update cc_f_actuals_queue_interval set d_contact_queue_id = 113 where d_contact_queue_id = 21;	
 update cc_f_actuals_queue_interval set d_contact_queue_id = 114 where d_contact_queue_id = 43;	
 update cc_f_actuals_queue_interval set d_contact_queue_id = 114 where d_contact_queue_id = 22;	
 update cc_f_actuals_queue_interval set d_contact_queue_id = 115 where d_contact_queue_id = 44;	
 update cc_f_actuals_queue_interval set d_contact_queue_id = 115 where d_contact_queue_id = 23;	
 update cc_f_actuals_queue_interval set d_contact_queue_id = 117 where d_contact_queue_id = 46;	
 update cc_f_actuals_queue_interval set d_contact_queue_id = 117 where d_contact_queue_id = 25;	
 update cc_f_actuals_queue_interval set d_contact_queue_id = 116 where d_contact_queue_id = 45;	
 update cc_f_actuals_queue_interval set d_contact_queue_id = 116 where d_contact_queue_id = 24;	
 update cc_f_actuals_queue_interval set d_contact_queue_id = 118 where d_contact_queue_id = 47;	
 update cc_f_actuals_queue_interval set d_contact_queue_id = 118 where d_contact_queue_id = 26;	
 update cc_f_actuals_queue_interval set d_contact_queue_id = 119 where d_contact_queue_id = 48;	
 update cc_f_actuals_queue_interval set d_contact_queue_id = 119 where d_contact_queue_id = 27;	
 update cc_f_actuals_queue_interval set d_contact_queue_id = 120 where d_contact_queue_id = 49;	
 update cc_f_actuals_queue_interval set d_contact_queue_id = 120 where d_contact_queue_id = 28;	
 update cc_f_actuals_queue_interval set d_contact_queue_id = 121 where d_contact_queue_id = 50;	
 update cc_f_actuals_queue_interval set d_contact_queue_id = 121 where d_contact_queue_id = 29;	
 update cc_f_actuals_queue_interval set d_contact_queue_id = 122 where d_contact_queue_id = 51;	
 update cc_f_actuals_queue_interval set d_contact_queue_id = 122 where d_contact_queue_id = 30;	
 update cc_f_actuals_queue_interval set d_contact_queue_id = 123 where d_contact_queue_id = 52;	
 update cc_f_actuals_queue_interval set d_contact_queue_id = 123 where d_contact_queue_id = 31;	
 update cc_f_actuals_queue_interval set d_contact_queue_id = 125 where d_contact_queue_id = 54;	
 update cc_f_actuals_queue_interval set d_contact_queue_id = 125 where d_contact_queue_id = 33;	
 update cc_f_actuals_queue_interval set d_contact_queue_id = 124 where d_contact_queue_id = 53;	
 update cc_f_actuals_queue_interval set d_contact_queue_id = 124 where d_contact_queue_id = 32;	
 update cc_f_actuals_queue_interval set d_contact_queue_id = 126 where d_contact_queue_id = 55;	
 update cc_f_actuals_queue_interval set d_contact_queue_id = 126 where d_contact_queue_id = 34;	
 update cc_f_actuals_queue_interval set d_contact_queue_id = 127 where d_contact_queue_id = 56;	
 update cc_f_actuals_queue_interval set d_contact_queue_id = 127 where d_contact_queue_id = 35;	
 update cc_f_actuals_queue_interval set d_contact_queue_id = 128 where d_contact_queue_id = 57;	
 update cc_f_actuals_queue_interval set d_contact_queue_id = 128 where d_contact_queue_id = 36;	

 delete from cc_d_contact_queue where record_eff_dt = '15-SEP-13';
 delete from cc_d_contact_queue where record_eff_dt = '26-SEP-13';
 
INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) VALUES ('0.1.4.1','000','000_UPDATE_CC_F_ACTUALS_QUEUE_INTERVAL');

commit;

