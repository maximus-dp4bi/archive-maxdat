update corp_etl_control
set value = '23:59:58'
where name = 'MEA_SCHEDULE_START';

update corp_etl_control
set value = '23:59:59'
where name = 'MEA_SCHEDULE_END';

delete from corp_etl_list_lkup
where name = 'LAST_ETL_COMP_PIVOT'
and value = 'ProcessManageEnroll_RUNALL';


commit;