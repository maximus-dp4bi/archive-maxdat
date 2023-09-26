alter session set current_schema = MAXDAT;
----  NYHIX-42198
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from D_MFB_CURRENT
where batch_name in ('NYSOH-FAX-7/12/2018-11:38:58 AM')

update D_MFB_CURRENT
set reprocessed_flag = 'Y',
    cancel_dt = TO_DATE('07/16/2018','MM/DD/YYYY'),
    cancel_by = 'NYHIX-42198',
    cancel_reason = 'Inactivated',
    cancel_method = 'Exception'
where batch_name in ('NYSOH-FAX-7/12/2018-11:38:58 AM');

commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from D_MFB_CURRENT
where batch_name in ('NYSOH-FAX-7/12/2018-11:38:58 AM');

select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from CORP_ETL_MFB_BATCH_STG
where batch_name in ('NYSOH-FAX-7/12/2018-11:38:58 AM')

update CORP_ETL_MFB_BATCH_STG
set reprocessed_flag = 'Y',
    cancel_dt = TO_DATE('07/16/2018','MM/DD/YYYY'),
    cancel_by = 'NYHIX-42198',
    cancel_reason = 'Inactivated',
    cancel_method = 'Exception'
where batch_name in ('NYSOH-FAX-7/12/2018-11:38:58 AM');

commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from CORP_ETL_MFB_BATCH_STG
where batch_name in ('NYSOH-FAX-7/12/2018-11:38:58 AM');
