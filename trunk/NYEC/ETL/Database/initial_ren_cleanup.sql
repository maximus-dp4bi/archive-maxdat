--initial_ren_cleanup.sql

truncate table nyec_etl_monitor_renewal;
truncate table nyec_etl_monitor_renewal_tmp;
truncate table monitor_renewal_stg;

update corp_etl_control
set value = '0'
where name ='IR_LAST_APPLICATION_ID';

