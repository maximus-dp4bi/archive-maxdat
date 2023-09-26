alter session set current_schema = MAXDAT;
----  NYHIX-38917 
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('670951-3/7/2018-9:10:45 AM-139890',
 '670760-3/6/2018-11:50:30 AM-139890',
 '670498-3/5/2018-4:52:24 PM-139890');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('670951-3/7/2018-9:10:45 AM-139890',
 '670760-3/6/2018-11:50:30 AM-139890',
 '670498-3/5/2018-4:52:24 PM-139890');

commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('670951-3/7/2018-9:10:45 AM-139890',
 '670760-3/6/2018-11:50:30 AM-139890',
 '670498-3/5/2018-4:52:24 PM-139890');



select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('670951-3/7/2018-9:10:45 AM-139890',
 '670760-3/6/2018-11:50:30 AM-139890',
 '670498-3/5/2018-4:52:24 PM-139890');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('670951-3/7/2018-9:10:45 AM-139890',
 '670760-3/6/2018-11:50:30 AM-139890',
 '670498-3/5/2018-4:52:24 PM-139890');

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('670951-3/7/2018-9:10:45 AM-139890',
 '670760-3/6/2018-11:50:30 AM-139890',
 '670498-3/5/2018-4:52:24 PM-139890');






 