alter session set current_schema = MAXDAT;
---- NYHIX-31192
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('526086-5/2/2017-9:14:31 AM-127635');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('526086-5/2/2017-9:14:31 AM-127635');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('526086-5/2/2017-9:14:31 AM-127635');

 
select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('526086-5/2/2017-9:14:31 AM-127635');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('526086-5/2/2017-9:14:31 AM-127635');
commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('526086-5/2/2017-9:14:31 AM-127635');