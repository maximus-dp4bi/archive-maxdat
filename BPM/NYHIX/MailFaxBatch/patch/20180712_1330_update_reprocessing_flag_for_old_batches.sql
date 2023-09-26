alter session set current_schema = MAXDAT;
----  NYHIX-42012
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in ('716476-7/3/2018-9:31:03 AM-146953','NYSOH-FAX-NavCAC2018-07-02-16-37-45-211');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in ('716476-7/3/2018-9:31:03 AM-146953','NYSOH-FAX-NavCAC2018-07-02-16-37-45-211');

commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in ('716476-7/3/2018-9:31:03 AM-146953','NYSOH-FAX-NavCAC2018-07-02-16-37-45-211');

select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in ('716476-7/3/2018-9:31:03 AM-146953','NYSOH-FAX-NavCAC2018-07-02-16-37-45-211');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in ('716476-7/3/2018-9:31:03 AM-146953','NYSOH-FAX-NavCAC2018-07-02-16-37-45-211');

commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in ('716476-7/3/2018-9:31:03 AM-146953','NYSOH-FAX-NavCAC2018-07-02-16-37-45-211');
