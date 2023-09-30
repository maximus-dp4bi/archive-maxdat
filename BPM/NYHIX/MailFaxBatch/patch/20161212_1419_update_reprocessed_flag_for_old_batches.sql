select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-HRA2016-12-02-13-08-19-480',
'444090-12/2/2016-1:47:12 PM-125420',
'NYSOH-FAX-12/2/2016-3:49:14 PM',
'NYSOH-FAX-HRA2016-12-02-12-08-22-918');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-HRA2016-12-02-13-08-19-480',
'444090-12/2/2016-1:47:12 PM-125420',
'NYSOH-FAX-12/2/2016-3:49:14 PM',
'NYSOH-FAX-HRA2016-12-02-12-08-22-918');

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-HRA2016-12-02-13-08-19-480',
'444090-12/2/2016-1:47:12 PM-125420',
'NYSOH-FAX-12/2/2016-3:49:14 PM',
'NYSOH-FAX-HRA2016-12-02-12-08-22-918');
commit;

select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-HRA2016-12-02-13-08-19-480',
'444090-12/2/2016-1:47:12 PM-125420',
'NYSOH-FAX-12/2/2016-3:49:14 PM',
'NYSOH-FAX-HRA2016-12-02-12-08-22-918');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-HRA2016-12-02-13-08-19-480',
'444090-12/2/2016-1:47:12 PM-125420',
'NYSOH-FAX-12/2/2016-3:49:14 PM',
'NYSOH-FAX-HRA2016-12-02-12-08-22-918');
 
select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-HRA2016-12-02-13-08-19-480',
'444090-12/2/2016-1:47:12 PM-125420',
'NYSOH-FAX-12/2/2016-3:49:14 PM',
'NYSOH-FAX-HRA2016-12-02-12-08-22-918');
commit;
