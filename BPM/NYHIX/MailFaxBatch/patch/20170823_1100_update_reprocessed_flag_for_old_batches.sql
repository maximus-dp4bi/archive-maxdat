alter session set current_schema = MAXDAT;
---- NYHIX-33514
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-8/20/2017-7:51:59 AM');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-8/20/2017-7:51:59 AM');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-8/20/2017-7:51:59 AM');

 
select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-8/20/2017-7:51:59 AM');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-8/20/2017-7:51:59 AM');
commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-8/20/2017-7:51:59 AM');

