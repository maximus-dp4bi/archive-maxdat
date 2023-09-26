alter session set current_schema = MAXDAT;
----  NYHIX-42410
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name  -- 1 record
from CORP_ETL_MFB_BATCH_STG
where batch_name = 'NYSOH-FAX-7/23/2018-10:15:28 AM';

update CORP_ETL_MFB_BATCH_STG
set reprocessed_flag = 'Y'
where batch_name = 'NYSOH-FAX-7/23/2018-10:15:28 AM';

commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from CORP_ETL_MFB_BATCH_STG
where batch_name = 'NYSOH-FAX-7/23/2018-10:15:28 AM';

------------
select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name  -- 1 record
from corp_etl_mfb_batch
where batch_name = 'NYSOH-FAX-7/23/2018-10:15:28 AM';

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name = 'NYSOH-FAX-7/23/2018-10:15:28 AM';

commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name = 'NYSOH-FAX-7/23/2018-10:15:28 AM';

------------
SELECT 'Before NYHIX_ETL_MAIL_FAX_DOC_V2', dcn, cancel_dt, cancel_by, asf_cancel_doc, cancel_reason, cancel_method, instance_status, instance_end_date, stg_done_date  -- 1 record
FROM   NYHIX_ETL_MAIL_FAX_DOC_V2
WHERE  dcn = '17165241';

update NYHIX_ETL_MAIL_FAX_DOC_V2 
set CANCEL_DT  = to_date('07/27/2018 00:00:00', 'mm/dd/yyyy HH24:MI:SS') ,
	CANCEL_BY = 'NYHIX-42409' ,
	ASF_CANCEL_DOC = 'Y' ,
	CANCEL_REASON = 'Inactivated' ,
	CANCEL_METHOD = 'Exception' ,
	INSTANCE_STATUS = 'Complete' ,
	INSTANCE_END_DATE = to_date('07/27/2018 00:00:00', 'mm/dd/yyyy HH24:MI:SS'), 
	STG_DONE_DATE = to_date('07/27/2018 00:00:00', 'mm/dd/yyyy HH24:MI:SS')
where dcn = '17165241';

commit;

SELECT 'After NYHIX_ETL_MAIL_FAX_DOC_V2', dcn, cancel_dt, cancel_by, asf_cancel_doc, cancel_reason, cancel_method,
       instance_status, instance_end_date, stg_done_date
FROM   NYHIX_ETL_MAIL_FAX_DOC_V2
WHERE  = '17165241';
