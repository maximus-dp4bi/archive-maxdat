alter session set current_schema = MAXDAT;
----  NYHIX-42611
select 'Before corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag, cancel_dt, cancel_by, cancel_reason, cancel_method, instance_status, instance_status_dt, complete_dt, current_step, stg_last_update_date, stg_done_date
from CORP_ETL_MFB_BATCH_STG
where batch_name = ('NYSOH-FAX-7/25/2018-3:13:04 PM');

update CORP_ETL_MFB_BATCH_STG
set reprocessed_flag = 'Y',
    cancel_dt = to_date('08/06/2018','MM/DD/YYYY'),
    cancel_by = 'NYHIX-42611',
    cancel_reason = 'Reprocessed',
    cancel_method = 'Exception',
    instance_status = 'Complete',
    instance_status_dt = to_date('08/06/2018','MM/DD/YYYY'),
    complete_dt = to_date('08/06/2018','MM/DD/YYYY'),
    current_step = 'End - Cancelled',
    stg_last_update_date = sysdate,
    stg_done_date = sysdate
where batch_name = ('NYSOH-FAX-7/25/2018-3:13:04 PM');

commit;

select 'After corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag, cancel_dt, cancel_by, cancel_reason, cancel_method, instance_status, instance_status_dt, complete_dt, current_step, stg_last_update_date, stg_done_date
from CORP_ETL_MFB_BATCH_STG
where batch_name = ('NYSOH-FAX-7/25/2018-3:13:04 PM');

------------
select 'Before corp_etl_mfb_batch', batch_id, batch_name, reprocessed_flag, cancel_dt, cancel_by, cancel_reason, cancel_method, instance_status, instance_status_dt, complete_dt, current_step, stg_last_update_date, stg_done_date
from corp_etl_mfb_batch
where batch_name = ('NYSOH-FAX-7/25/2018-3:13:04 PM');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y',
    cancel_dt = to_date('07/25/2018','MM/DD/YYYY'),
    cancel_by = 'NYHIX-42611',
    cancel_reason = 'Reprocessed',
    cancel_method = 'Exception',
    instance_status = 'Complete',
    instance_status_dt = to_date('07/25/2018','MM/DD/YYYY'),
    complete_dt = to_date('07/25/2018','MM/DD/YYYY'),
    current_step = 'End - Cancelled',
    stg_last_update_date = sysdate,
    stg_done_date = sysdate
where batch_name = ('NYSOH-FAX-7/25/2018-3:13:04 PM');

commit;

select 'After corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag, cancel_dt, cancel_by, cancel_reason, cancel_method, instance_status, instance_status_dt, complete_dt, current_step, stg_last_update_date, stg_done_date
from corp_etl_mfb_batch
where batch_name = ('NYSOH-FAX-7/25/2018-3:13:04 PM');

