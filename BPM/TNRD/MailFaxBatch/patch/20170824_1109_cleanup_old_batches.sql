UPDATE corp_etl_mfb_batch
SET instance_status = 'Complete'
     ,instance_status_dt = sysdate
     ,complete_dt = sysdate
     ,cancel_dt = sysdate
     ,stg_done_date = sysdate
     ,cancel_reason = 'TNERPS-2997'
     ,cancel_by = 'TNERPS-2997'
     ,cancel_method = 'Normal'
WHERE  batch_id in(331448,
332427,
110071);   

UPDATE corp_etl_mfb_batch
SET instance_status = 'Complete'
     ,instance_status_dt = sysdate
     ,complete_dt = sysdate
     ,stg_done_date = sysdate
WHERE  batch_id in(321136,312310);  

commit;