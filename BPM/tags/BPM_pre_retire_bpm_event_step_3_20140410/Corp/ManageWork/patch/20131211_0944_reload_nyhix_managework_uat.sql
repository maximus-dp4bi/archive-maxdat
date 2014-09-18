truncate table step_instance_stg;

truncate table corp_etl_manage_work;

update corp_etl_control
set value=0
where name='MW_LAST_STEP_INST_HIST_ID';

commit;