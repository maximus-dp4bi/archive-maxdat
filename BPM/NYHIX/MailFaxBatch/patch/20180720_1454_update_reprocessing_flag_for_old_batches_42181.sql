alter session set current_schema = MAXDAT;
----  NYHIX-42297
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in ('NYSOH-FAX-HRA2018-07-10-12-01-40-239');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in ('NYSOH-FAX-HRA2018-07-10-12-01-40-239');

commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in ('NYSOH-FAX-HRA2018-07-10-12-01-40-239');

select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in ('NYSOH-FAX-HRA2018-07-10-12-01-40-239');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in ('NYSOH-FAX-HRA2018-07-10-12-01-40-239');

commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in ('NYSOH-FAX-HRA2018-07-10-12-01-40-239');
