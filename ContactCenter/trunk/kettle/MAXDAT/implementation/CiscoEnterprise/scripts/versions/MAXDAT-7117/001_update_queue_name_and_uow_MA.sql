update cc_c_contact_queue
set queue_name = 'VAHM_MAMH_1839_MBRAPPHIX_Q'
,unit_of_work_name = 'MBR APP HIX'
where queue_number = 7187;

commit;

insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt) values ('MBR APP HIX', 'INBOUND', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));

insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('MBR APP HIX', 'INBOUND_CALL', 166, 'N', 'Seconds');

commit;

update cc_s_contact_queue
set queue_name = 'VAHM_MAMH_1839_MBRAPPHIX_Q'
, unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'MBR APP HIX' )
where queue_number = 7187;


update cc_d_contact_queue
set queue_name = 'VAHM_MAMH_1839_MBRAPPHIX_Q'
, d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'MBR APP HIX' )
where queue_number = 7187;

commit;
