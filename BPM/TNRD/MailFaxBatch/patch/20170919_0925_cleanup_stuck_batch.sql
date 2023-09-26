UPDATE corp_etl_mfb_batch
SET instance_status = 'Complete'
     ,instance_status_dt = sysdate
     ,complete_dt = sysdate
     ,stg_done_date = sysdate
     ,batch_complete_dt = sysdate
WHERE batch_id = 576097;  

commit;