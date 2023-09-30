insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt) values ('STAR Plus NonFrew Transfer', 'TRANSFER', to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'));

insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('STAR Plus NonFrew Transfer', 'TRANSFER', 0, 'N', 'Seconds');

commit;

update cc_c_contact_queue set queue_type = 'Inbound' , unit_of_work_name = 'STAR Plus NonFrew EN', project_name = 'TX Enrollment Broker', program_name = 'EB' where queue_number = '12406';
update cc_c_contact_queue set queue_type = 'Inbound' , unit_of_work_name = 'STAR Plus NonFrew SP', project_name = 'TX Enrollment Broker', program_name = 'EB' where queue_number = '12407';
update cc_c_contact_queue set queue_type = 'Transfer' , unit_of_work_name = 'STAR Plus NonFrew Transfer', project_name = 'TX Enrollment Broker', program_name = 'EB' where queue_number = '12411';

commit;

insert into cc_c_filter(filter_type, value) values ('ACD_CALL_TYPE_ID_INC', 12406);
insert into cc_c_filter(filter_type, value) values ('ACD_CALL_TYPE_ID_INC', 12407);
insert into cc_c_filter(filter_type, value) values ('ACD_CALL_TYPE_ID_INC', 12411);

commit;

