alter session set current_schema = MAXDAT;
---- NYHIX-36743, NYHIX-36851, NYHIX-36867
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-HRA2017-12-14-12-06-21-063',
'NYSOH-FAX-12/15/2017-3:30:09 PM',
'NYSOH-FAX-12/18/2017-2:43:57 PM',
'NYSOH-FAX-12/16/2017-10:53:41 AM');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-HRA2017-12-14-12-06-21-063',
'NYSOH-FAX-12/15/2017-3:30:09 PM',
'NYSOH-FAX-12/18/2017-2:43:57 PM',
'NYSOH-FAX-12/16/2017-10:53:41 AM');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-HRA2017-12-14-12-06-21-063',
'NYSOH-FAX-12/15/2017-3:30:09 PM',
'NYSOH-FAX-12/18/2017-2:43:57 PM',
'NYSOH-FAX-12/16/2017-10:53:41 AM');

 
select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-HRA2017-12-14-12-06-21-063',
'NYSOH-FAX-12/15/2017-3:30:09 PM',
'NYSOH-FAX-12/18/2017-2:43:57 PM',
'NYSOH-FAX-12/16/2017-10:53:41 AM');


update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-HRA2017-12-14-12-06-21-063',
'NYSOH-FAX-12/15/2017-3:30:09 PM',
'NYSOH-FAX-12/18/2017-2:43:57 PM',
'NYSOH-FAX-12/16/2017-10:53:41 AM');
commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-HRA2017-12-14-12-06-21-063',
'NYSOH-FAX-12/15/2017-3:30:09 PM',
'NYSOH-FAX-12/18/2017-2:43:57 PM',
'NYSOH-FAX-12/16/2017-10:53:41 AM');


 