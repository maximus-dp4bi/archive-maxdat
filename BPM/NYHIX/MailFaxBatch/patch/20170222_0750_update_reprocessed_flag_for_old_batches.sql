alter session set current_schema = MAXDAT;
---- NYHIX-29351
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('478608-2/3/2017-12:56:18 PM-132973');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('478608-2/3/2017-12:56:18 PM-132973');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('478608-2/3/2017-12:56:18 PM-132973');

select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('478608-2/3/2017-12:56:18 PM-132973');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('478608-2/3/2017-12:56:18 PM-132973');
commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('478608-2/3/2017-12:56:18 PM-132973');


