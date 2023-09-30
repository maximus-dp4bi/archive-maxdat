update corp_etl_mfb_batch set batch_complete_dt=sysdate,stg_last_update_date=sysdate,current_batch_module_id='N/A'
where batch_complete_dt is null and instance_status='Active'
and batch_name in(
'NYSOH-MAIL-4/3/2014-2:56:56 PM-68405-77055');
commit;





