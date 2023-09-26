UPDATE corp_etl_proc_letters
SET stage_done_date = null
WHERE status = 'Errored'
AND instance_status = 'Active'
AND stage_done_date IS NOT NULL;

UPDATE corp_etl_proc_letters
SET stage_done_date = stg_last_update_date
WHERE instance_status = 'Complete'
AND stage_done_date is  null;

COMMIT;