select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name = 'NYSOH-FAX-11/18/2016-6:58:05 PM';

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name = 'NYSOH-FAX-11/18/2016-6:58:05 PM';

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name = 'NYSOH-FAX-11/18/2016-6:58:05 PM';
commit;

select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name = 'NYSOH-FAX-11/18/2016-6:58:05 PM';

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name = 'NYSOH-FAX-11/18/2016-6:58:05 PM';

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name = 'NYSOH-FAX-11/18/2016-6:58:05 PM';
commit;
