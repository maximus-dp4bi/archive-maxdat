truncate table step_instance_stg;

truncate table corp_etl_manage_work;

/*select min(step_instance_history_id) from step_instance_history
where trunc(create_ts)>=trunc(sysdate-16)*/

update corp_etl_control
set value=264960
where name='MW_LAST_STEP_INST_HIST_ID';

commit;

