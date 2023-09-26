alter session set current_schema = MAXDAT;
----  NYHIX-41437, NYHIX-41434, NYHIX-41485
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('707667-6/11/2018-1:24:32 PM-139890',
 '707663-6/11/2018-1:18:57 PM-139890',
 '709006-6/13/2018-3:23:06 PM-149459');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('707667-6/11/2018-1:24:32 PM-139890',
 '707663-6/11/2018-1:18:57 PM-139890',
 '709006-6/13/2018-3:23:06 PM-149459');

commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('707667-6/11/2018-1:24:32 PM-139890',
 '707663-6/11/2018-1:18:57 PM-139890',
 '709006-6/13/2018-3:23:06 PM-149459');


select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('707667-6/11/2018-1:24:32 PM-139890',
 '707663-6/11/2018-1:18:57 PM-139890',
 '709006-6/13/2018-3:23:06 PM-149459');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('707667-6/11/2018-1:24:32 PM-139890',
 '707663-6/11/2018-1:18:57 PM-139890',
 '709006-6/13/2018-3:23:06 PM-149459');

commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('707667-6/11/2018-1:24:32 PM-139890',
 '707663-6/11/2018-1:18:57 PM-139890',
 '709006-6/13/2018-3:23:06 PM-149459');


