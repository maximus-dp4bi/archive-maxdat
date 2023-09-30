alter session set current_schema = MAXDAT;
----  NYHIX-38179
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('662168-2/8/2018-2:20:56 PM-139890',
'662227-2/8/2018-3:18:13 PM-139890');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('662168-2/8/2018-2:20:56 PM-139890',
'662227-2/8/2018-3:18:13 PM-139890');

commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('662168-2/8/2018-2:20:56 PM-139890',
'662227-2/8/2018-3:18:13 PM-139890');


select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('662168-2/8/2018-2:20:56 PM-139890',
'662227-2/8/2018-3:18:13 PM-139890');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('662168-2/8/2018-2:20:56 PM-139890',
'662227-2/8/2018-3:18:13 PM-139890');
 commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('662168-2/8/2018-2:20:56 PM-139890',
'662227-2/8/2018-3:18:13 PM-139890');





 