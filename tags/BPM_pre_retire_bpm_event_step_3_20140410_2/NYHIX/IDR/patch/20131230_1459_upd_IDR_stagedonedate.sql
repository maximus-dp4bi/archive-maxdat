UPDATE NYHX_ETL_IDR_INCIDENTS
SET stage_done_date = NULL
WHERE stage_done_date IS NOT NULL;

commit;