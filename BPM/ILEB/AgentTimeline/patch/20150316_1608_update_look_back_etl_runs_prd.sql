update corp_etl_control
set value = 5
where name = 'WFM_NUM_ETL_RUNS_LOOK_BACK';

commit;