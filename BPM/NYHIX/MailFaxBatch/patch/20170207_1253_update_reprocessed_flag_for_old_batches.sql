alter session set current_schema = MAXDAT;

select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('460304-1/6/2017-8:28:13 AM-125405',
'NYSOH-FAX-12/29/2016-2:06:32 PM',
'NYSOH-FAX-HRA2016-12-31-12-05-45-647');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('460304-1/6/2017-8:28:13 AM-125405',
'NYSOH-FAX-12/29/2016-2:06:32 PM',
'NYSOH-FAX-HRA2016-12-31-12-05-45-647');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('460304-1/6/2017-8:28:13 AM-125405',
'NYSOH-FAX-12/29/2016-2:06:32 PM',
'NYSOH-FAX-HRA2016-12-31-12-05-45-647');


select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('460304-1/6/2017-8:28:13 AM-125405',
'NYSOH-FAX-12/29/2016-2:06:32 PM',
'NYSOH-FAX-HRA2016-12-31-12-05-45-647');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('460304-1/6/2017-8:28:13 AM-125405',
'NYSOH-FAX-12/29/2016-2:06:32 PM',
'NYSOH-FAX-HRA2016-12-31-12-05-45-647');
commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('460304-1/6/2017-8:28:13 AM-125405',
'NYSOH-FAX-12/29/2016-2:06:32 PM',
'NYSOH-FAX-HRA2016-12-31-12-05-45-647');
