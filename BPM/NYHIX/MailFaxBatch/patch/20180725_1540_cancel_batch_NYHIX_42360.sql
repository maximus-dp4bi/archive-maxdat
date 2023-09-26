alter session set current_schema = MAXDAT;
----  NYHIX-42360
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from CORP_ETL_MFB_BATCH_STG
where batch_name = ('723653-7/24/2018-10:08:57 AM-139890');

update CORP_ETL_MFB_BATCH_STG
set reprocessed_flag = 'Y',
    cancel_dt = to_date('07/25/2018 00:00:00','MM/DD/YYYY HH24:MI:SS'),
    cancel_by = 'NYHIX-42360',
    cancel_reason = 'Inactivated',
    cancel_method = 'Exception',
    instance_status = 'Complete',
    instance_status_dt = to_date('07/25/2018 00:00:00','MM/DD/YYYY HH24:MI:SS'),
    complete_dt = to_date('07/25/2018 00:00:00','MM/DD/YYYY HH24:MI:SS'),
    current_step = 'End - Cancelled',
    stg_last_update_date = sysdate,
    stg_done_date = sysdate
where batch_name = ('723653-7/24/2018-10:08:57 AM-139890');

commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from CORP_ETL_MFB_BATCH_STG
where batch_name = ('723653-7/24/2018-10:08:57 AM-139890');

------------
select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name = ('723653-7/24/2018-10:08:57 AM-139890');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y',
    cancel_dt = to_date('07/25/2018 00:00:00','MM/DD/YYYY HH24:MI:SS'),
    cancel_by = 'NYHIX-42360',
    cancel_reason = 'Inactivated',
    cancel_method = 'Exception',
    instance_status = 'Complete',
    instance_status_dt = to_date('07/25/2018 00:00:00','MM/DD/YYYY HH24:MI:SS'),
    complete_dt = to_date('07/25/2018 00:00:00','MM/DD/YYYY HH24:MI:SS'),
    current_step = 'End - Cancelled',
    stg_last_update_date = sysdate,
    stg_done_date = sysdate
where batch_name = ('723653-7/24/2018-10:08:57 AM-139890');

commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name = ('723653-7/24/2018-10:08:57 AM-139890');

------------
SELECT 'Before NYHIX_ETL_MAIL_FAX_DOC_V2', dcn, cancel_dt, cancel_by, asf_cancel_doc, cancel_reason, cancel_method,
       instance_status, instance_end_date, stg_done_date
FROM   NYHIX_ETL_MAIL_FAX_DOC_V2
WHERE  dcn in ('17158018','17158019');

update NYHIX_ETL_MAIL_FAX_DOC_V2 
set CANCEL_DT  = to_date('07/25/2018', 'mm/dd/yyyy') ,
CANCEL_BY = 'NYHIX-42360' ,
ASF_CANCEL_DOC = 'Y' ,
CANCEL_REASON = 'Inactivated' ,
CANCEL_METHOD = 'Exception' ,
INSTANCE_STATUS = 'Complete' ,
INSTANCE_END_DATE = to_date('07/25/2018', 'mm/dd/yyyy'), 
STG_DONE_DATE = to_date('07/25/2018', 'mm/dd/yyyy')
 where dcn in ('17158018','17158019');

commit;

SELECT 'After NYHIX_ETL_MAIL_FAX_DOC_V2', dcn, cancel_dt, cancel_by, asf_cancel_doc, cancel_reason, cancel_method,
       instance_status, instance_end_date, stg_done_date
FROM   NYHIX_ETL_MAIL_FAX_DOC_V2
WHERE  dcn in ('17158018','17158019');
