-- THIS UPDATE SHOULD AFFECT 2,723 ROWS IN PRD
update corp_etl_mfb_batch a
set CANCEL_DT = NULL
,   CANCEL_BY =  NULL
,   CANCEL_REASON = NULL
,   CANCEL_METHOD = NULL
,   INSTANCE_STATUS = 'Active'
,   COMPLETE_DT = NULL
,   INSTANCE_STATUS_DT = (select max(instance_status_dt) from corp_etl_mfb_batch_stg b where b.batch_guid = a.batch_guid)
WHERE CANCEL_BY = 'UPD11_020'
AND CANCEL_DT > TO_DATE('07/01/2017','mm/dd/yyyy');
and batch_guid = (select distinct batch_guid from corp_etl_mfb_batch_stg b where b.batch_guid = a.batch_guid)

COMMIT;
