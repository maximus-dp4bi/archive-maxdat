alter session set current_schema = MAXDAT;
----  NYHIX-40254, NYHIX-40206
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('691499-4/27/2018-3:27:07 PM-139895',
'691445-4/27/2018-2:52:37 PM-150802',
'690114-4/25/2018-1:17:12 PM-149421',
'690150-4/25/2018-1:40:05 PM-139895',
'690308-4/25/2018-3:47:13 PM-149459');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('691499-4/27/2018-3:27:07 PM-139895',
'691445-4/27/2018-2:52:37 PM-150802',
'690114-4/25/2018-1:17:12 PM-149421',
'690150-4/25/2018-1:40:05 PM-139895',
'690308-4/25/2018-3:47:13 PM-149459');

commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('691499-4/27/2018-3:27:07 PM-139895',
'691445-4/27/2018-2:52:37 PM-150802',
'690114-4/25/2018-1:17:12 PM-149421',
'690150-4/25/2018-1:40:05 PM-139895',
'690308-4/25/2018-3:47:13 PM-149459');


select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('691499-4/27/2018-3:27:07 PM-139895',
'691445-4/27/2018-2:52:37 PM-150802',
'690114-4/25/2018-1:17:12 PM-149421',
'690150-4/25/2018-1:40:05 PM-139895',
'690308-4/25/2018-3:47:13 PM-149459');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('691499-4/27/2018-3:27:07 PM-139895',
'691445-4/27/2018-2:52:37 PM-150802',
'690114-4/25/2018-1:17:12 PM-149421',
'690150-4/25/2018-1:40:05 PM-139895',
'690308-4/25/2018-3:47:13 PM-149459');

commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('691499-4/27/2018-3:27:07 PM-139895',
'691445-4/27/2018-2:52:37 PM-150802',
'690114-4/25/2018-1:17:12 PM-149421',
'690150-4/25/2018-1:40:05 PM-139895',
'690308-4/25/2018-3:47:13 PM-149459');




 