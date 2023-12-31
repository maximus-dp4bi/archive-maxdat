alter session set current_schema = MAXDAT;
----  NYHIX-39270,  NYHIX-39165, NYHIX-39191
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('674857-3/19/2018-11:37:41 AM-137034',
'674668-3/19/2018-8:55:13 AM-139895',
'674662-3/19/2018-8:52:16 AM-146953',
'674724-3/19/2018-9:42:29 AM-149459',
'675047-3/19/2018-2:51:05 PM-146953',
'675709-3/20/2018-2:45:49 PM-146953',
'675447-3/20/2018-11:42:57 AM-146953',
'675619-3/20/2018-2:04:27 PM-146953');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('674857-3/19/2018-11:37:41 AM-137034',
'674668-3/19/2018-8:55:13 AM-139895',
'674662-3/19/2018-8:52:16 AM-146953',
'674724-3/19/2018-9:42:29 AM-149459',
'675047-3/19/2018-2:51:05 PM-146953',
'675709-3/20/2018-2:45:49 PM-146953',
'675447-3/20/2018-11:42:57 AM-146953',
'675619-3/20/2018-2:04:27 PM-146953');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('674857-3/19/2018-11:37:41 AM-137034',
'674668-3/19/2018-8:55:13 AM-139895',
'674662-3/19/2018-8:52:16 AM-146953',
'674724-3/19/2018-9:42:29 AM-149459',
'675047-3/19/2018-2:51:05 PM-146953',
'675709-3/20/2018-2:45:49 PM-146953',
'675447-3/20/2018-11:42:57 AM-146953',
'675619-3/20/2018-2:04:27 PM-146953');



select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('674857-3/19/2018-11:37:41 AM-137034',
'674668-3/19/2018-8:55:13 AM-139895',
'674662-3/19/2018-8:52:16 AM-146953',
'674724-3/19/2018-9:42:29 AM-149459',
'675047-3/19/2018-2:51:05 PM-146953',
'675709-3/20/2018-2:45:49 PM-146953',
'675447-3/20/2018-11:42:57 AM-146953',
'675619-3/20/2018-2:04:27 PM-146953');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('674857-3/19/2018-11:37:41 AM-137034',
'674668-3/19/2018-8:55:13 AM-139895',
'674662-3/19/2018-8:52:16 AM-146953',
'674724-3/19/2018-9:42:29 AM-149459',
'675047-3/19/2018-2:51:05 PM-146953',
'675709-3/20/2018-2:45:49 PM-146953',
'675447-3/20/2018-11:42:57 AM-146953',
'675619-3/20/2018-2:04:27 PM-146953');
commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('674857-3/19/2018-11:37:41 AM-137034',
'674668-3/19/2018-8:55:13 AM-139895',
'674662-3/19/2018-8:52:16 AM-146953',
'674724-3/19/2018-9:42:29 AM-149459',
'675047-3/19/2018-2:51:05 PM-146953',
'675709-3/20/2018-2:45:49 PM-146953',
'675447-3/20/2018-11:42:57 AM-146953',
'675619-3/20/2018-2:04:27 PM-146953');




 