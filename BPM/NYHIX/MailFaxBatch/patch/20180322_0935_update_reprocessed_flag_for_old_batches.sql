alter session set current_schema = MAXDAT;
----  NYHIX-39092 
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('673621-3/14/2018-6:24:18 PM-146953',
'673519-3/14/2018-3:39:32 PM-139895',
'NYSOH-FAX-3/15/2018-12:54:49 PM');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('673621-3/14/2018-6:24:18 PM-146953',
'673519-3/14/2018-3:39:32 PM-139895',
'NYSOH-FAX-3/15/2018-12:54:49 PM');

commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('673621-3/14/2018-6:24:18 PM-146953',
'673519-3/14/2018-3:39:32 PM-139895',
'NYSOH-FAX-3/15/2018-12:54:49 PM');



select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('673621-3/14/2018-6:24:18 PM-146953',
'673519-3/14/2018-3:39:32 PM-139895',
'NYSOH-FAX-3/15/2018-12:54:49 PM');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('673621-3/14/2018-6:24:18 PM-146953',
'673519-3/14/2018-3:39:32 PM-139895',
'NYSOH-FAX-3/15/2018-12:54:49 PM');

commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('673621-3/14/2018-6:24:18 PM-146953',
'673519-3/14/2018-3:39:32 PM-139895',
'NYSOH-FAX-3/15/2018-12:54:49 PM');





 