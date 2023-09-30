alter session set current_schema = MAXDAT;
---- NYHIX-33564
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('589209-8/23/2017-12:31:25 PM-134005',
 '589180-8/23/2017-11:52:20 AM-134005');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('589209-8/23/2017-12:31:25 PM-134005',
 '589180-8/23/2017-11:52:20 AM-134005');

commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('589209-8/23/2017-12:31:25 PM-134005',
 '589180-8/23/2017-11:52:20 AM-134005');

 
select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('589209-8/23/2017-12:31:25 PM-134005',
 '589180-8/23/2017-11:52:20 AM-134005');


update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('589209-8/23/2017-12:31:25 PM-134005',
 '589180-8/23/2017-11:52:20 AM-134005');

commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('589209-8/23/2017-12:31:25 PM-134005',
 '589180-8/23/2017-11:52:20 AM-134005');


