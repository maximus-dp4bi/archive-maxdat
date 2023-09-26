alter session set current_schema = MAXDAT;
----  NYHIX-42669
select 'Before corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag, cancel_dt, cancel_by, cancel_reason, cancel_method, instance_status, instance_status_dt, complete_dt, current_step, stg_last_update_date, stg_done_date
from CORP_ETL_MFB_BATCH_STG
where batch_name = ('NYSOH-FAX-8/2/2018-4:32:57 PM');

update CORP_ETL_MFB_BATCH_STG
set reprocessed_flag = 'Y'
where batch_name = ('NYSOH-FAX-8/2/2018-4:32:57 PM');

commit;

select 'After corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag, cancel_dt, cancel_by, cancel_reason, cancel_method, instance_status, instance_status_dt, complete_dt, current_step, stg_last_update_date, stg_done_date
from CORP_ETL_MFB_BATCH_STG
where batch_name = ('NYSOH-FAX-8/2/2018-4:32:57 PM');

------------
select 'Before corp_etl_mfb_batch', batch_id, batch_name, reprocessed_flag, cancel_dt, cancel_by, cancel_reason, cancel_method, instance_status, instance_status_dt, complete_dt, current_step, stg_last_update_date, stg_done_date
from corp_etl_mfb_batch
where batch_name = ('NYSOH-FAX-8/2/2018-4:32:57 PM');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name = ('NYSOH-FAX-8/2/2018-4:32:57 PM');

commit;

select 'After corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag, cancel_dt, cancel_by, cancel_reason, cancel_method, instance_status, instance_status_dt, complete_dt, current_step, stg_last_update_date, stg_done_date
from corp_etl_mfb_batch
where batch_name = ('NYSOH-FAX-8/2/2018-4:32:57 PM');

