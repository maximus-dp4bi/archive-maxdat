select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('459383-1/4/2017-4:07:17 PM-116630',
 '458862-1/4/2017-9:58:04 AM-116630');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('459383-1/4/2017-4:07:17 PM-116630',
 '458862-1/4/2017-9:58:04 AM-116630');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('459383-1/4/2017-4:07:17 PM-116630',
 '458862-1/4/2017-9:58:04 AM-116630');


select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('459383-1/4/2017-4:07:17 PM-116630',
 '458862-1/4/2017-9:58:04 AM-116630');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('459383-1/4/2017-4:07:17 PM-116630',
 '458862-1/4/2017-9:58:04 AM-116630');
commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('459383-1/4/2017-4:07:17 PM-116630',
 '458862-1/4/2017-9:58:04 AM-116630');



