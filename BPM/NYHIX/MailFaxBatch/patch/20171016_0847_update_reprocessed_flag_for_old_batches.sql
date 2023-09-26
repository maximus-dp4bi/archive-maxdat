alter session set current_schema = MAXDAT;
---- NYHIX-34885
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('615124-10/11/2017-1:11:04 PM-140835');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('615124-10/11/2017-1:11:04 PM-140835');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('615124-10/11/2017-1:11:04 PM-140835');
 
select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('615124-10/11/2017-1:11:04 PM-140835');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('615124-10/11/2017-1:11:04 PM-140835');
commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('615124-10/11/2017-1:11:04 PM-140835');
