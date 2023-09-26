alter session set current_schema = MAXDAT;
----  NYHIX-41014
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-5/25/2018-8:32:34 PM',
'NYSOH-FAX-HRA2018-05-26-12-02-33-378');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-5/25/2018-8:32:34 PM',
'NYSOH-FAX-HRA2018-05-26-12-02-33-378');

commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-5/25/2018-8:32:34 PM',
'NYSOH-FAX-HRA2018-05-26-12-02-33-378');

select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-5/25/2018-8:32:34 PM',
'NYSOH-FAX-HRA2018-05-26-12-02-33-378');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-5/25/2018-8:32:34 PM',
'NYSOH-FAX-HRA2018-05-26-12-02-33-378');

commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-5/25/2018-8:32:34 PM',
'NYSOH-FAX-HRA2018-05-26-12-02-33-378');

