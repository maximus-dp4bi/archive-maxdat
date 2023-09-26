alter session set current_schema = MAXDAT;
---- NYHIX-31005
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('520849-4/25/2017-1:56:26 PM-132866');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('520849-4/25/2017-1:56:26 PM-132866');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('520849-4/25/2017-1:56:26 PM-132866');

 
select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('520849-4/25/2017-1:56:26 PM-132866');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('520849-4/25/2017-1:56:26 PM-132866');
commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('520849-4/25/2017-1:56:26 PM-132866');