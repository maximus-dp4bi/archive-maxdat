alter session set current_schema = MAXDAT;
----  NYHIX-38117
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('660028-2/2/2018-11:00:30 AM-132972');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('660028-2/2/2018-11:00:30 AM-132972');

commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('660028-2/2/2018-11:00:30 AM-132972');

select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('660028-2/2/2018-11:00:30 AM-132972');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('660028-2/2/2018-11:00:30 AM-132972');
 commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('660028-2/2/2018-11:00:30 AM-132972');





 