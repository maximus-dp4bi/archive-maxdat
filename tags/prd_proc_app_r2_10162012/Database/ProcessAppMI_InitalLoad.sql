/* Delete Missing Information records for applications completed before 30 days */

Delete from process_app_mi_stg m
where exists ( select 1 from nyec_etl_process_app a where a.app_id = m.app_id and a.stage_done_date < '01-SEP-2012');

COMMIT;

/