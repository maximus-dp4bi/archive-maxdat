alter session set current_schema = MAXDAT;
---- NYHIX-33155
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('574569-7/28/2017-7:34:21 PM-137034');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('574569-7/28/2017-7:34:21 PM-137034');

commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('574569-7/28/2017-7:34:21 PM-137034');

 
select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('574569-7/28/2017-7:34:21 PM-137034');


update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('574569-7/28/2017-7:34:21 PM-137034');

commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('574569-7/28/2017-7:34:21 PM-137034');
