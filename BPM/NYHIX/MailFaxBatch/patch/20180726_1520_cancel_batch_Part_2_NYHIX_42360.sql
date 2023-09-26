alter session set current_schema = MAXDAT;
----  NYHIX-42360 - Part 2
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from CORP_ETL_MFB_BATCH_STG
where batch_name = '723653-7/24/2018-10:08:57 AM-139890'
and   cemfbb_id = 4431699;

update CORP_ETL_MFB_BATCH_STG
set reprocessed_flag = 'N',
    cancel_dt = null,
    cancel_by = null,
    cancel_reason = null,
    cancel_method = null,
    instance_status = 'Active',
    instance_status_dt = to_date('07/24/2018 10:09:13','MM/DD/YYYY HH24:MI:SS'),
    complete_dt = null,
    current_step = null,
    stg_last_update_date = to_date('07/24/2018 13:06:26','MM/DD/YYYY HH24:MI:SS'),
    stg_done_date = null
where batch_name = '723653-7/24/2018-10:08:57 AM-139890'
and   cemfbb_id = 4431699;

commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from CORP_ETL_MFB_BATCH_STG
where batch_name = ('723653-7/24/2018-10:08:57 AM-139890')
and   cemfbb_id = 4431699;

------------
select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name = '723653-7/24/2018-10:08:57 AM-139890'
and   cemfbb_id = 4431699;

update corp_etl_mfb_batch
set reprocessed_flag = 'N',
    cancel_dt = null,
    cancel_by = null,
    cancel_reason = null,
    cancel_method = null,
    instance_status = 'Active',
    instance_status_dt = to_date('07/24/2018 10:09:13','MM/DD/YYYY HH24:MI:SS'),
    complete_dt = null,
    current_step = null,
    stg_last_update_date = to_date('07/24/2018 13:06:26','MM/DD/YYYY HH24:MI:SS'),
    stg_done_date = null
where batch_name = '723653-7/24/2018-10:08:57 AM-139890'
and   cemfbb_id = 4431699;

commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name = '723653-7/24/2018-10:08:57 AM-139890'
and   cemfbb_id = 4431699;
