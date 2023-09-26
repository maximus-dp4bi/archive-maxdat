UPDATE NYHX_ETL_IDR_INCIDENTS
SET incident_about = 'Individual'
    ,stg_last_update_date = sysdate
WHERE incident_id  in(29604432,29604791,29605513);

COMMIT;