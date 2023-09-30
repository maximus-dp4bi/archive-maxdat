alter session set current_schema = MAXDAT;
----  NYHIX-39755
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('682516-4/9/2018-9:17:34 AM-139890',
 '682413-4/6/2018-7:05:20 PM-150802');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('682516-4/9/2018-9:17:34 AM-139890',
 '682413-4/6/2018-7:05:20 PM-150802');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('682516-4/9/2018-9:17:34 AM-139890',
 '682413-4/6/2018-7:05:20 PM-150802');



select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('682516-4/9/2018-9:17:34 AM-139890',
 '682413-4/6/2018-7:05:20 PM-150802');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('682516-4/9/2018-9:17:34 AM-139890',
 '682413-4/6/2018-7:05:20 PM-150802');
commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('682516-4/9/2018-9:17:34 AM-139890',
 '682413-4/6/2018-7:05:20 PM-150802');







 