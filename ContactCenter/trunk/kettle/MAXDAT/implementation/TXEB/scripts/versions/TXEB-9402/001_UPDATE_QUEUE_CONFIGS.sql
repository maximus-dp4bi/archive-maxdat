-- cc_c_contact_queue

update cc_c_contact_queue set queue_type = 'Inbound' ,unit_of_work_name = 'STAR Plus NonFrew EN', project_name = 'TX Enrollment Broker', program_name = 'EB' where queue_number = '12449';
update cc_c_contact_queue set queue_type = 'Inbound' ,unit_of_work_name = 'STAR Plus NonFrew SP', project_name = 'TX Enrollment Broker', program_name = 'EB' where queue_number = '12452';


-- cc_s_contact_queue

update cc_s_contact_queue set  queue_type = 'Inbound', unit_of_work_id =81 , project_config_id =1 where queue_number = '12449';
update cc_s_contact_queue set  queue_type = 'Inbound', unit_of_work_id =82 , project_config_id =1 where queue_number = '12452';

-- cc_d_contact_queue

update cc_d_contact_queue set queue_type = 'Inbound'  where queue_number = '12449';
update cc_d_contact_queue set queue_type = 'Inbound'  where queue_number = '12452';

commit;


insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_INC', '12449');
insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_INC', '12452');

commit;
