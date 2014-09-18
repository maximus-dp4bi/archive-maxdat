truncate table corp_etl_manage_work;

update step_instance_stg
set mw_processed = 'N'
where trunc(create_ts) > to_date('08/25/2013','mm/dd/yyyy');

commit;
