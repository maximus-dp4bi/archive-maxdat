select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in ('NYSOH-FAX-DOHManualNotice2017-10-04-16-25-21-765');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in ('NYSOH-FAX-DOHManualNotice2017-10-04-16-25-21-765');

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in ('NYSOH-FAX-DOHManualNotice2017-10-04-16-25-21-765');
commit;

select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in ('NYSOH-FAX-DOHManualNotice2017-10-04-16-25-21-765');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in  ('NYSOH-FAX-DOHManualNotice2017-10-04-16-25-21-765');
 
select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in  ('NYSOH-FAX-DOHManualNotice2017-10-04-16-25-21-765');
commit;
