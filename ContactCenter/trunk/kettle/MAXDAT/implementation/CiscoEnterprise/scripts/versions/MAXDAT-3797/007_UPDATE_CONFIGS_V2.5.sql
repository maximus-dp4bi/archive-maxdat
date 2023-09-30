update cc_c_contact_queue set queue_type = 'Transfer' , service_seconds = 30, interval_minutes = 15, unit_of_work_name = 'Agent Transfer to Insure Kids Now', project_name = 'GA IES', program_name = 'GA PeachCare CHIP', region_name = 'Eastern', state_name = 'Georgia' where queue_number = '6095';
update cc_c_contact_queue set queue_type = 'Transfer' , service_seconds = 30, interval_minutes = 15, unit_of_work_name = 'Agent Transfer to GA MED Powerline', project_name = 'GA IES', program_name = 'GA PeachCare CHIP', region_name = 'Eastern', state_name = 'Georgia' where queue_number = '6096';
update cc_c_contact_queue set queue_type = 'Transfer' , service_seconds = 30, interval_minutes = 15, unit_of_work_name = 'Agent Transfer to Bill2Pay Payment', project_name = 'GA IES', program_name = 'GA PeachCare CHIP', region_name = 'Eastern', state_name = 'Georgia' where queue_number = '6097';
update cc_c_contact_queue set queue_type = 'Inbound' , service_seconds = 30, interval_minutes = 15, unit_of_work_name = 'Outbound Dialer to P4HB Q', project_name = 'GA IES', program_name = 'GA Healthy Babies', region_name = 'Eastern', state_name = 'Georgia' where queue_number = '6098';
update cc_c_contact_queue set queue_type = 'Inbound' , service_seconds = 30, interval_minutes = 15, unit_of_work_name = 'Outbound Dialer to P4HB Q', project_name = 'GA IES', program_name = 'GA Healthy Babies', region_name = 'Eastern', state_name = 'Georgia' where queue_number = '6099';
update cc_c_contact_queue set queue_type = 'Inbound' , service_seconds = 30, interval_minutes = 15, unit_of_work_name = 'Outbound Dialer to Peachcare Q', project_name = 'GA IES', program_name = 'GA PeachCare CHIP', region_name = 'Eastern', state_name = 'Georgia' where queue_number = '6100';
update cc_c_contact_queue set queue_type = 'Inbound' , service_seconds = 30, interval_minutes = 15, unit_of_work_name = 'Outbound Dialer to Peachcare Q', project_name = 'GA IES', program_name = 'GA PeachCare CHIP', region_name = 'Eastern', state_name = 'Georgia' where queue_number = '6101';

commit;

insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_IGNORE',6102 );

commit;

insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt) values ('Agent Transfer to Insure Kids Now', 'TRANSFER', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt) values ('Agent Transfer to GA MED Powerline', 'TRANSFER', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt) values ('Agent Transfer to Bill2Pay Payment', 'TRANSFER', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt) values ('Outbound Dialer to P4HB Q', 'INBOUND_CALL', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt) values ('Outbound Dialer to Peachcare Q', 'INBOUND_CALL', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));

commit;

insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('Agent Transfer to Insure Kids Now', 'TRANSFER', 145, 'N', 'Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('Agent Transfer to GA MED Powerline', 'TRANSFER', 145, 'N', 'Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('Agent Transfer to Bill2Pay Payment', 'TRANSFER', 145, 'N', 'Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('Outbound Dialer to P4HB Q', 'INBOUND_CALL', 145, 'N', 'Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('Outbound Dialer to Peachcare Q', 'INBOUND_CALL', 145, 'N', 'Seconds');

commit;
