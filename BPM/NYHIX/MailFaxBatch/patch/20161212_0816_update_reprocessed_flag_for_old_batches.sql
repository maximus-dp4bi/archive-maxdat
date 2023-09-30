select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in ('439559-11/18/2016-11:08:01 AM-127619');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in ('439559-11/18/2016-11:08:01 AM-127619');

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in ('439559-11/18/2016-11:08:01 AM-127619');
commit;

select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in ('439559-11/18/2016-11:08:01 AM-127619');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in  ('439559-11/18/2016-11:08:01 AM-127619');
 
select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in  ('439559-11/18/2016-11:08:01 AM-127619');
commit;
