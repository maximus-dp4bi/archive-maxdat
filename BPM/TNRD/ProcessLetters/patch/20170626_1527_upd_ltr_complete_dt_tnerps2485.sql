
UPDATE corp_etl_proc_letters
SET complete_dt = mailed_dt
WHERE instance_status = 'Complete'
AND status = 'Mailed'
AND trunc(mailed_dt) != trunc(complete_dt);

COMMIT;