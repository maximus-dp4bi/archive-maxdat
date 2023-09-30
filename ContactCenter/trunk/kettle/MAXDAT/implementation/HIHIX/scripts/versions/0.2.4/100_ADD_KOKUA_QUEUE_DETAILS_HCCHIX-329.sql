update cc_c_contact_queue
set queue_type='Inbound',
unit_of_work_name='Kokua'
where c_contact_queue_id=141;

update cc_c_contact_queue
set queue_type='Vmail',
unit_of_work_name='Voice Mail'
where queue_name like '%vmail';

insert into cc_c_unit_of_work(unit_of_work_name,record_eff_dt,record_end_dt)values ('Kokua',to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'));
insert into cc_c_unit_of_work(unit_of_work_name,record_eff_dt,record_end_dt)values ('Voice Mail',to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'));
insert into cc_c_unit_of_work(unit_of_work_name,record_eff_dt,record_end_dt)values ('WebChat Kokua',to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'));

commit;