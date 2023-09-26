select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-HRA2016-12-08-12-11-08-746',
'NYSOH-FAX-12/8/2016-3:34:22 PM',
'445600-12/7/2016-11:17:00 AM-129457',
'NYSOH-FAX-12/9/2016-11:12:17 AM',
'446208-12/8/2016-9:35:42 AM-129455',
'446635-12/8/2016-1:56:09 PM-127619');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-HRA2016-12-08-12-11-08-746',
'NYSOH-FAX-12/8/2016-3:34:22 PM',
'445600-12/7/2016-11:17:00 AM-129457',
'NYSOH-FAX-12/9/2016-11:12:17 AM',
'446208-12/8/2016-9:35:42 AM-129455',
'446635-12/8/2016-1:56:09 PM-127619');

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-HRA2016-12-08-12-11-08-746',
'NYSOH-FAX-12/8/2016-3:34:22 PM',
'445600-12/7/2016-11:17:00 AM-129457',
'NYSOH-FAX-12/9/2016-11:12:17 AM',
'446208-12/8/2016-9:35:42 AM-129455',
'446635-12/8/2016-1:56:09 PM-127619');
commit;

select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-HRA2016-12-08-12-11-08-746',
'NYSOH-FAX-12/8/2016-3:34:22 PM',
'445600-12/7/2016-11:17:00 AM-129457',
'NYSOH-FAX-12/9/2016-11:12:17 AM',
'446208-12/8/2016-9:35:42 AM-129455',
'446635-12/8/2016-1:56:09 PM-127619');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-HRA2016-12-08-12-11-08-746',
'NYSOH-FAX-12/8/2016-3:34:22 PM',
'445600-12/7/2016-11:17:00 AM-129457',
'NYSOH-FAX-12/9/2016-11:12:17 AM',
'446208-12/8/2016-9:35:42 AM-129455',
'446635-12/8/2016-1:56:09 PM-127619');
 
select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-HRA2016-12-08-12-11-08-746',
'NYSOH-FAX-12/8/2016-3:34:22 PM',
'445600-12/7/2016-11:17:00 AM-129457',
'NYSOH-FAX-12/9/2016-11:12:17 AM',
'446208-12/8/2016-9:35:42 AM-129455',
'446635-12/8/2016-1:56:09 PM-127619');
commit;
