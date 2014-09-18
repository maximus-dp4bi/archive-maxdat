update corp_etl_mfb_batch set batch_complete_dt=sysdate,stg_last_update_date=sysdate,current_batch_module_id='N/A'
where batch_complete_dt is null and instance_status='Active'
and batch_name in(
'NYSOH-MAIL - 1/17/2014 - 9:49:40 AM - 59152-26826');
commit;





