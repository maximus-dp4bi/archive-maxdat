alter session set current_schema = MAXDAT;
----  NYHIX-40867, NYHIX-40900, and NYHIX-40917
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('699546-5/21/2018-8:52:09 AM-89436',
'699863-5/21/2018-4:03:18 PM-146953',
'699431-5/18/2018-3:46:13 PM-139890');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('699546-5/21/2018-8:52:09 AM-89436',
'699863-5/21/2018-4:03:18 PM-146953',
'699431-5/18/2018-3:46:13 PM-139890');

commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('699546-5/21/2018-8:52:09 AM-89436',
'699863-5/21/2018-4:03:18 PM-146953',
'699431-5/18/2018-3:46:13 PM-139890');


select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('699546-5/21/2018-8:52:09 AM-89436',
'699863-5/21/2018-4:03:18 PM-146953',
'699431-5/18/2018-3:46:13 PM-139890');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('699546-5/21/2018-8:52:09 AM-89436',
'699863-5/21/2018-4:03:18 PM-146953',
'699431-5/18/2018-3:46:13 PM-139890');

commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('699546-5/21/2018-8:52:09 AM-89436',
'699863-5/21/2018-4:03:18 PM-146953',
'699431-5/18/2018-3:46:13 PM-139890');


