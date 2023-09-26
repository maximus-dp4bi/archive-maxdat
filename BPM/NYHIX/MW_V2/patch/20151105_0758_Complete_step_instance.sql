-- NYHIX-18424   complete a single step instance that shows completed in MAXe but still has a status of claimed in MAXDAT

update corp_etl_mw_v2
set complete_date = to_date('05-MAR-14 07:09:58','dd-MON-yy hh24:mi:ss'),
instance_end_date = to_date('05-MAR-14 07:09:58','dd-MON-yy hh24:mi:ss'),
task_status = 'COMPLETED'
where task_id = 1092781;
