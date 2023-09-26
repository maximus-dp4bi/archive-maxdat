alter session set current_schema = MAXDAT;
---- NYHIX-36652 
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-HRA2017-12-02-12-11-49-484',
'NYSOH-FAX-12/4/2017-12:28:50 PM');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-HRA2017-12-02-12-11-49-484',
'NYSOH-FAX-12/4/2017-12:28:50 PM');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-HRA2017-12-02-12-11-49-484',
'NYSOH-FAX-12/4/2017-12:28:50 PM');
 
select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-HRA2017-12-02-12-11-49-484',
'NYSOH-FAX-12/4/2017-12:28:50 PM');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-HRA2017-12-02-12-11-49-484',
'NYSOH-FAX-12/4/2017-12:28:50 PM');
commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-HRA2017-12-02-12-11-49-484',
'NYSOH-FAX-12/4/2017-12:28:50 PM');
 