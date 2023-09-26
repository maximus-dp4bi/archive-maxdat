alter session set current_schema = MAXDAT;
---- NYHIX-NYHIX-30442
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('499985-3/20/2017-2:19:40 PM-127635');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in ('499985-3/20/2017-2:19:40 PM-127635');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('499985-3/20/2017-2:19:40 PM-127635');
 
select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('499985-3/20/2017-2:19:40 PM-127635');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('499985-3/20/2017-2:19:40 PM-127635');
commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('499985-3/20/2017-2:19:40 PM-127635');
