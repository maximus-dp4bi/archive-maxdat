alter session set current_schema = MAXDAT;
---- NYHIX-28760
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('463254-1/11/2017-3:37:08 PM-125405',
'NYSOH-FAX-1/11/2017-3:32:50 PM');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('463254-1/11/2017-3:37:08 PM-125405',
'NYSOH-FAX-1/11/2017-3:32:50 PM');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('463254-1/11/2017-3:37:08 PM-125405',
'NYSOH-FAX-1/11/2017-3:32:50 PM');

select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('463254-1/11/2017-3:37:08 PM-125405',
'NYSOH-FAX-1/11/2017-3:32:50 PM');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('463254-1/11/2017-3:37:08 PM-125405',
'NYSOH-FAX-1/11/2017-3:32:50 PM');
commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('463254-1/11/2017-3:37:08 PM-125405',
'NYSOH-FAX-1/11/2017-3:32:50 PM');

