-- NYHIX-51673
alter session set current_schema = MAXDAT;

select 'Before corp_etl_mfb_batch', batch_id, batch_name, reprocessed_flag
from CORP_ETL_MFB_BATCH
where batch_name IN ('NYSOH_FAX-NavCAC2019-07-31-16-43-25-460','NYSOH_FAX-7/31/2019-12:42:06 PM','NYSOH_FAX-7/31/2019-11:50:39 AM');

update CORP_ETL_MFB_BATCH  -- 1 record
set reprocessed_flag = 'Y'
where batch_name IN ('NYSOH_FAX-NavCAC2019-07-31-16-43-25-460','NYSOH_FAX-7/31/2019-12:42:06 PM','NYSOH_FAX-7/31/2019-11:50:39 AM');

commit;

select 'After corp_etl_mfb_batch', batch_id, batch_name, reprocessed_flag
from CORP_ETL_MFB_BATCH
where batch_name IN ('NYSOH_FAX-NavCAC2019-07-31-16-43-25-460','NYSOH_FAX-7/31/2019-12:42:06 PM','NYSOH_FAX-7/31/2019-11:50:39 AM');

------------
select 'Before corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_name IN ('NYSOH_FAX-NavCAC2019-07-31-16-43-25-460','NYSOH_FAX-7/31/2019-12:42:06 PM','NYSOH_FAX-7/31/2019-11:50:39 AM');

update corp_etl_mfb_batch_stg  -- 2 records
set reprocessed_flag = 'Y'
where batch_name IN ('NYSOH_FAX-NavCAC2019-07-31-16-43-25-460','NYSOH_FAX-7/31/2019-12:42:06 PM','NYSOH_FAX-7/31/2019-11:50:39 AM');

commit;

select 'After corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag
from corp_etl_mfb_batch_stg  -- 1 record
where batch_name IN ('NYSOH_FAX-NavCAC2019-07-31-16-43-25-460','NYSOH_FAX-7/31/2019-12:42:06 PM','NYSOH_FAX-7/31/2019-11:50:39 AM');
