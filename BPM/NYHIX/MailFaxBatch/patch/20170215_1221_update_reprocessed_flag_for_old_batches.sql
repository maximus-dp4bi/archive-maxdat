alter session set current_schema = MAXDAT;

select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('486243-2/14/2017-1:19:53 PM-116630',
'486277-2/14/2017-1:32:43 PM-116630');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('486243-2/14/2017-1:19:53 PM-116630',
'486277-2/14/2017-1:32:43 PM-116630');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('486243-2/14/2017-1:19:53 PM-116630',
'486277-2/14/2017-1:32:43 PM-116630');


select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('486243-2/14/2017-1:19:53 PM-116630',
'486277-2/14/2017-1:32:43 PM-116630');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('486243-2/14/2017-1:19:53 PM-116630',
'486277-2/14/2017-1:32:43 PM-116630');
commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('486243-2/14/2017-1:19:53 PM-116630',
'486277-2/14/2017-1:32:43 PM-116630');
