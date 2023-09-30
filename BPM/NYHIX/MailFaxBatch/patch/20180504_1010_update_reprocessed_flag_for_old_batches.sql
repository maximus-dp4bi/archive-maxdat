alter session set current_schema = MAXDAT;
----  NYHIX-40351
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('690365-4/25/2018-4:58:30 PM-149078');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('690365-4/25/2018-4:58:30 PM-149078');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('690365-4/25/2018-4:58:30 PM-149078');


select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('690365-4/25/2018-4:58:30 PM-149078');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('690365-4/25/2018-4:58:30 PM-149078');
commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('690365-4/25/2018-4:58:30 PM-149078');





 