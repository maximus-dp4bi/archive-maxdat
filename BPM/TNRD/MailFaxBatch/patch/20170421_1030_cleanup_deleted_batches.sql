UPDATE corp_etl_mfb_batch
SET instance_status = 'Complete'
    ,complete_dt = sysdate
    ,cancel_dt = sysdate
    ,cancel_by = 'TNERPS-2272'
    ,cancel_reason = 'Cleanup, batches not found in DMS'
    ,cancel_method = 'Normal'
    ,current_step = 'End - Cancelled'
    ,stg_done_date = sysdate
WHERE batch_id in(222878,
222851,
222871,
222845,
222900,
222882,
222886,
222573,
222520,
222528,
222589,
222498,
222530,
222523,
222505,
222527,
222500,
222504,
222508,
222566,
222568,
222872,
222883,
222876,
222844,
222743,
222572,
222532,
222737,
222739,
222569,
222729,
222507,
222518,
222531,
222521,
222570,
222506)
;
    
commit;