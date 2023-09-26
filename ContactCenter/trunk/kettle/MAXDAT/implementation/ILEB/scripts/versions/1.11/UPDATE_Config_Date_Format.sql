update cc_c_unit_of_work
set record_eff_dt = to_date('1900/01/01', 'yyyy/mm/dd'), record_end_dt = to_date('2999/12/31', 'yyyy/mm/dd')
where unit_of_work_id between 141 and 150;

commit;

update cc_c_contact_queue
set record_eff_dt = to_date('1900/01/01', 'yyyy/mm/dd'), record_end_dt = to_date('2999/12/31', 'yyyy/mm/dd')
where c_contact_queue_id between 101 and 120;

commit;

update cc_c_project_config
set record_eff_dt = to_date('1900/01/01', 'yyyy/mm/dd'), record_end_dt = to_date('2999/12/31', 'yyyy/mm/dd')
where project_name = 'MIEB';

commit;

update cc_d_project_targets
set record_eff_dt = to_date('1900/01/01', 'yyyy/mm/dd'), record_end_dt = to_date('2199/12/31', 'yyyy/mm/dd')
where d_project_targets_id = 41;

commit;

