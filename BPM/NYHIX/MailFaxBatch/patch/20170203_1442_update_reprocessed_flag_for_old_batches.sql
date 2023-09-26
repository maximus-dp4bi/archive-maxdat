alter session set current_schema = MAXDAT;

select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('466738-1/18/2017-12:11:43 PM-105957',
 '466667-1/18/2017-11:45:36 AM-127635');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('466738-1/18/2017-12:11:43 PM-105957',
 '466667-1/18/2017-11:45:36 AM-127635');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('466738-1/18/2017-12:11:43 PM-105957',
 '466667-1/18/2017-11:45:36 AM-127635');


select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('466738-1/18/2017-12:11:43 PM-105957',
 '466667-1/18/2017-11:45:36 AM-127635');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('466738-1/18/2017-12:11:43 PM-105957',
 '466667-1/18/2017-11:45:36 AM-127635');
commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('466738-1/18/2017-12:11:43 PM-105957',
 '466667-1/18/2017-11:45:36 AM-127635');


