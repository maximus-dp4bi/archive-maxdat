truncate table step_instance_stg;

truncate table corp_etl_manage_work;

/*select min(step_instance_history_id)-1 from step_instance_history
where trunc(create_ts)>=to_date('08/26/2013','mm/dd/yyyy')*/

update corp_etl_control
set value=263995
where name='MW_LAST_STEP_INST_HIST_ID';


update corp_etl_control
set value=1
where name='STEP_INST_HIST_MISSING_REC_LOOKBACK';


commit;