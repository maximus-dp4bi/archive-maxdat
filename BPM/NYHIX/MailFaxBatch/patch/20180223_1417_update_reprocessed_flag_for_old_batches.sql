alter session set current_schema = MAXDAT;
----  NYHIX-38472 
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-2/21/2018-3:18:13 PM',
'666642-2/21/2018-3:24:52 PM-139132',
'666450-2/21/2018-11:21:43 AM-139890',
'NYSOH-FAX-NavCAC2018-02-21-14-06-40-620',
'NYSOH-FAX-2/21/2018-1:43:10 PM',
'665705-2/20/2018-10:42:01 AM-139132',
'665856-2/20/2018-1:46:46 PM-139890',
'NYSOH-FAX-NavCAC2018-02-20-15-51-20-674');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-2/21/2018-3:18:13 PM',
'666642-2/21/2018-3:24:52 PM-139132',
'666450-2/21/2018-11:21:43 AM-139890',
'NYSOH-FAX-NavCAC2018-02-21-14-06-40-620',
'NYSOH-FAX-2/21/2018-1:43:10 PM',
'665705-2/20/2018-10:42:01 AM-139132',
'665856-2/20/2018-1:46:46 PM-139890',
'NYSOH-FAX-NavCAC2018-02-20-15-51-20-674');


commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-2/21/2018-3:18:13 PM',
'666642-2/21/2018-3:24:52 PM-139132',
'666450-2/21/2018-11:21:43 AM-139890',
'NYSOH-FAX-NavCAC2018-02-21-14-06-40-620',
'NYSOH-FAX-2/21/2018-1:43:10 PM',
'665705-2/20/2018-10:42:01 AM-139132',
'665856-2/20/2018-1:46:46 PM-139890',
'NYSOH-FAX-NavCAC2018-02-20-15-51-20-674');



select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-2/21/2018-3:18:13 PM',
'666642-2/21/2018-3:24:52 PM-139132',
'666450-2/21/2018-11:21:43 AM-139890',
'NYSOH-FAX-NavCAC2018-02-21-14-06-40-620',
'NYSOH-FAX-2/21/2018-1:43:10 PM',
'665705-2/20/2018-10:42:01 AM-139132',
'665856-2/20/2018-1:46:46 PM-139890',
'NYSOH-FAX-NavCAC2018-02-20-15-51-20-674');



update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-2/21/2018-3:18:13 PM',
'666642-2/21/2018-3:24:52 PM-139132',
'666450-2/21/2018-11:21:43 AM-139890',
'NYSOH-FAX-NavCAC2018-02-21-14-06-40-620',
'NYSOH-FAX-2/21/2018-1:43:10 PM',
'665705-2/20/2018-10:42:01 AM-139132',
'665856-2/20/2018-1:46:46 PM-139890',
'NYSOH-FAX-NavCAC2018-02-20-15-51-20-674');

 commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-2/21/2018-3:18:13 PM',
'666642-2/21/2018-3:24:52 PM-139132',
'666450-2/21/2018-11:21:43 AM-139890',
'NYSOH-FAX-NavCAC2018-02-21-14-06-40-620',
'NYSOH-FAX-2/21/2018-1:43:10 PM',
'665705-2/20/2018-10:42:01 AM-139132',
'665856-2/20/2018-1:46:46 PM-139890',
'NYSOH-FAX-NavCAC2018-02-20-15-51-20-674');







 