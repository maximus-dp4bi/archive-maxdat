alter session set current_schema = MAXDAT;
----  NYHIX-37020, NYHIX-37008
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-12/27/2017-8:44:42 AM',
 'NYSOH-FAX-HRA2017-12-26-12-05-01-768');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-12/27/2017-8:44:42 AM',
 'NYSOH-FAX-HRA2017-12-26-12-05-01-768');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-12/27/2017-8:44:42 AM',
 'NYSOH-FAX-HRA2017-12-26-12-05-01-768');

select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-12/27/2017-8:44:42 AM',
 'NYSOH-FAX-HRA2017-12-26-12-05-01-768');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-12/27/2017-8:44:42 AM',
 'NYSOH-FAX-HRA2017-12-26-12-05-01-768');
 commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-12/27/2017-8:44:42 AM',
 'NYSOH-FAX-HRA2017-12-26-12-05-01-768');




 