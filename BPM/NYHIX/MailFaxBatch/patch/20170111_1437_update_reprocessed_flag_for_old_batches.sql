select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('452215-12/20/2016-12:58:07 PM-116630');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('452215-12/20/2016-12:58:07 PM-116630');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('452215-12/20/2016-12:58:07 PM-116630');

select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('452215-12/20/2016-12:58:07 PM-116630');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('452215-12/20/2016-12:58:07 PM-116630');
commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('452215-12/20/2016-12:58:07 PM-116630');


