update cc_c_contact_queue set queue_name = 'ESS.EB_Xfr_SP_StarKids_Q' ,queue_type = 'Transfer' ,unit_of_work_name = 'STAR Plus NonFrew Transfer', project_name = 'TX Enrollment Broker', program_name = 'EB' where queue_number = '12418';

update cc_s_contact_queue set  queue_type = 'Transfer', unit_of_work_id =141 , project_config_id =1 where queue_number = '12418';

delete from cc_d_contact_queue where d_contact_queue_id = 13309;

update cc_d_contact_queue set queue_type = 'Transfer' , record_eff_dt =  to_date('1900/01/01', 'yyyy/mm/dd') where d_contact_queue_id = 13621;

commit;


insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_INC', '12418');

commit;
