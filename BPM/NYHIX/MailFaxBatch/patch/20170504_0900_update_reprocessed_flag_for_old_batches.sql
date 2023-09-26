alter session set current_schema = MAXDAT;
---- NYHIX-31032
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('522588-4/27/2017-10:06:43 AM-121217');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('522588-4/27/2017-10:06:43 AM-121217');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('522588-4/27/2017-10:06:43 AM-121217');

 
select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('522588-4/27/2017-10:06:43 AM-121217');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('522588-4/27/2017-10:06:43 AM-121217');
commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('522588-4/27/2017-10:06:43 AM-121217');