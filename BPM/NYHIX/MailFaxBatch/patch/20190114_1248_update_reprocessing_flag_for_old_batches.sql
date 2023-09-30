alter session set current_schema = MAXDAT;
----  NYHIX-46515/46450/46659/46595
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name -- 3 records
from CORP_ETL_MFB_BATCH_STG
where batch_name in ('788029-12/27/2018-5:25:47 PM-140860','791991-1/7/2019-3:53:39 PM-150802',
'NYSOH-FAX-1/4/2019-4:43:27 PM',
'NYSOH-FAX-1/4/2019-3:30:32 PM','NYSOH-FAX-12/31/2018-9:45:17 AM'
);

update CORP_ETL_MFB_BATCH_STG
set reprocessed_flag = 'Y'
where batch_name in ('788029-12/27/2018-5:25:47 PM-140860','791991-1/7/2019-3:53:39 PM-150802',
'NYSOH-FAX-1/4/2019-4:43:27 PM',
'NYSOH-FAX-1/4/2019-3:30:32 PM','NYSOH-FAX-12/31/2018-9:45:17 AM'
);
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from CORP_ETL_MFB_BATCH_STG
where batch_name in  ('788029-12/27/2018-5:25:47 PM-140860','791991-1/7/2019-3:53:39 PM-150802',
'NYSOH-FAX-1/4/2019-4:43:27 PM',
'NYSOH-FAX-1/4/2019-3:30:32 PM','NYSOH-FAX-12/31/2018-9:45:17 AM'
);
--------------------------------
select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name  
from corp_etl_mfb_batch
where batch_name in  ('788029-12/27/2018-5:25:47 PM-140860','791991-1/7/2019-3:53:39 PM-150802',
'NYSOH-FAX-1/4/2019-4:43:27 PM',
'NYSOH-FAX-1/4/2019-3:30:32 PM','NYSOH-FAX-12/31/2018-9:45:17 AM'
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in  ('788029-12/27/2018-5:25:47 PM-140860','791991-1/7/2019-3:53:39 PM-150802',
'NYSOH-FAX-1/4/2019-4:43:27 PM',
'NYSOH-FAX-1/4/2019-3:30:32 PM','NYSOH-FAX-12/31/2018-9:45:17 AM'
);

commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in ('788029-12/27/2018-5:25:47 PM-140860','791991-1/7/2019-3:53:39 PM-150802',
'NYSOH-FAX-1/4/2019-4:43:27 PM',
'NYSOH-FAX-1/4/2019-3:30:32 PM','NYSOH-FAX-12/31/2018-9:45:17 AM'
);