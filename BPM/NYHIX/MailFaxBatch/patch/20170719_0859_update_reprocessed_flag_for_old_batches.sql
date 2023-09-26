alter session set current_schema = MAXDAT;
---- NYHIX-32883
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('567065-7/13/2017-9:25:21 AM-125405',
'NYSOH-FAX-HRA2017-07-15-12-02-20-897',
'NYSOH-FAX-HRA2017-07-11-13-03-07-766');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('567065-7/13/2017-9:25:21 AM-125405',
'NYSOH-FAX-HRA2017-07-15-12-02-20-897',
'NYSOH-FAX-HRA2017-07-11-13-03-07-766');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('567065-7/13/2017-9:25:21 AM-125405',
'NYSOH-FAX-HRA2017-07-15-12-02-20-897',
'NYSOH-FAX-HRA2017-07-11-13-03-07-766');

 
select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('567065-7/13/2017-9:25:21 AM-125405',
'NYSOH-FAX-HRA2017-07-15-12-02-20-897',
'NYSOH-FAX-HRA2017-07-11-13-03-07-766');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('567065-7/13/2017-9:25:21 AM-125405',
'NYSOH-FAX-HRA2017-07-15-12-02-20-897',
'NYSOH-FAX-HRA2017-07-11-13-03-07-766');
commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('567065-7/13/2017-9:25:21 AM-125405',
'NYSOH-FAX-HRA2017-07-15-12-02-20-897',
'NYSOH-FAX-HRA2017-07-11-13-03-07-766');