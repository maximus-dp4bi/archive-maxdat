update corp_etl_mfb_batch set batch_complete_dt=sysdate,stg_last_update_date=sysdate,current_batch_module_id='N/A'
where batch_complete_dt is null and instance_status='Active'
and batch_name in(
'NYSOH-FAX2014-03-04-13-32-13-16');
commit;





