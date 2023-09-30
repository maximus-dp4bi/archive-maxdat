alter session set current_schema = MAXDAT;
----  NYHIX-42198
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from CORP_ETL_MFB_BATCH_STG
where batch_name = ('NYSOH-FAX-7/12/2018-11:38:58 AM')

update CORP_ETL_MFB_BATCH_STG
set reprocessed_flag = 'Y',
    cancel_dt = to_date('07/16/2018 00:00:00','MM/DD/YYYY HH24:MI:SS'),
    cancel_by = 'NYHIX-42198',
    cancel_reason = 'Inactivated',
    cancel_method = 'Exception',
    instance_status = 'Complete',
    instance_status_dt = to_date('07/16/2018 00:00:00','MM/DD/YYYY HH24:MI:SS'),
    complete_dt = to_date('07/16/2018 00:00:00','MM/DD/YYYY HH24:MI:SS'),
    current_step = 'End - Cancelled',
    stg_last_update_date = sysdate,
    stg_done_date = sysdate
where batch_name = ('NYSOH-FAX-7/12/2018-11:38:58 AM');

commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from CORP_ETL_MFB_BATCH_STG
where batch_name = ('NYSOH-FAX-7/12/2018-11:38:58 AM');

------------
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name = ('NYSOH-FAX-7/12/2018-11:38:58 AM')

update corp_etl_mfb_batch
set reprocessed_flag = 'Y',
    cancel_dt = to_date('07/16/2018 00:00:00','MM/DD/YYYY HH24:MI:SS'),
    cancel_by = 'NYHIX-42198',
    cancel_reason = 'Inactivated',
    cancel_method = 'Exception',
    instance_status = 'Complete',
    instance_status_dt = to_date('07/16/2018 00:00:00','MM/DD/YYYY HH24:MI:SS'),
    complete_dt = to_date('07/16/2018 00:00:00','MM/DD/YYYY HH24:MI:SS'),
    current_step = 'End - Cancelled',
    stg_last_update_date = sysdate,
    stg_done_date = sysdate
where batch_name = ('NYSOH-FAX-7/12/2018-11:38:58 AM');

commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name = ('NYSOH-FAX-7/12/2018-11:38:58 AM');
