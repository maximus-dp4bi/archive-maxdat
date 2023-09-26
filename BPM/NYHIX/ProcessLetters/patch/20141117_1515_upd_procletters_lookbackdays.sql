       
update corp_etl_control
set value = '2'
 where name = 'PL_SUCCESSFUL_RUN_LOOK_BACK_DAYS';

commit;