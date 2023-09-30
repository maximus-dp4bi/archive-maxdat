select * from corp_etl_control
where name = 'MW_LAST_STEP_INST_HIST_ID';

update corp_etl_control
set value = 0
where name = 'MW_LAST_STEP_INST_HIST_ID';

commit;
