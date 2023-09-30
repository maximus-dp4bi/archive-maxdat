alter session set current_schema = MAXDAT;
---- NYHIX-32122 & NYHIX-32146 
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-HRA2017-06-10-12-06-57-574',
 'NYSOH-FAX-6/14/2017-10:43:13 AM');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-HRA2017-06-10-12-06-57-574',
 'NYSOH-FAX-6/14/2017-10:43:13 AM');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-HRA2017-06-10-12-06-57-574',
 'NYSOH-FAX-6/14/2017-10:43:13 AM');

 
select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-HRA2017-06-10-12-06-57-574',
 'NYSOH-FAX-6/14/2017-10:43:13 AM');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-HRA2017-06-10-12-06-57-574',
 'NYSOH-FAX-6/14/2017-10:43:13 AM');
commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-HRA2017-06-10-12-06-57-574',
 'NYSOH-FAX-6/14/2017-10:43:13 AM');