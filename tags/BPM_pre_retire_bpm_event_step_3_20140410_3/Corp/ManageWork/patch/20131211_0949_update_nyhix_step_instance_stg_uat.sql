update step_instance_stg
set mw_processed = 'Y'
where trunc(create_ts) < to_date('08/26/2013','mm/dd/yyyy');
commit;
