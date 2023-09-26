alter session set current_schema = MAXDAT;
----  NYHIX-41122, and NYHIX-41181
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('703320-5/31/2018-9:10:21 AM-150837',
'NYSOH-FAX-6/1/2018-9:55:33 AM');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('703320-5/31/2018-9:10:21 AM-150837',
'NYSOH-FAX-6/1/2018-9:55:33 AM');

commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('703320-5/31/2018-9:10:21 AM-150837',
'NYSOH-FAX-6/1/2018-9:55:33 AM');


select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('703320-5/31/2018-9:10:21 AM-150837',
'NYSOH-FAX-6/1/2018-9:55:33 AM');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('703320-5/31/2018-9:10:21 AM-150837',
'NYSOH-FAX-6/1/2018-9:55:33 AM');

commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('703320-5/31/2018-9:10:21 AM-150837',
'NYSOH-FAX-6/1/2018-9:55:33 AM');

