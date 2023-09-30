alter session set current_schema = MAXDAT;

select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-1/11/2017-8:08:59 AM',
'462531-1/11/2017-8:29:57 AM-127619',
'461409-1/9/2017-1:59:34 PM-116630',
'461565-1/9/2017-4:09:54 PM-127619',
'461514-1/9/2017-3:19:02 PM-75002');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-1/11/2017-8:08:59 AM',
'462531-1/11/2017-8:29:57 AM-127619',
'461409-1/9/2017-1:59:34 PM-116630',
'461565-1/9/2017-4:09:54 PM-127619',
'461514-1/9/2017-3:19:02 PM-75002');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-1/11/2017-8:08:59 AM',
'462531-1/11/2017-8:29:57 AM-127619',
'461409-1/9/2017-1:59:34 PM-116630',
'461565-1/9/2017-4:09:54 PM-127619',
'461514-1/9/2017-3:19:02 PM-75002');


select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-1/11/2017-8:08:59 AM',
'462531-1/11/2017-8:29:57 AM-127619',
'461409-1/9/2017-1:59:34 PM-116630',
'461565-1/9/2017-4:09:54 PM-127619',
'461514-1/9/2017-3:19:02 PM-75002');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-1/11/2017-8:08:59 AM',
'462531-1/11/2017-8:29:57 AM-127619',
'461409-1/9/2017-1:59:34 PM-116630',
'461565-1/9/2017-4:09:54 PM-127619',
'461514-1/9/2017-3:19:02 PM-75002');
commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-1/11/2017-8:08:59 AM',
'462531-1/11/2017-8:29:57 AM-127619',
'461409-1/9/2017-1:59:34 PM-116630',
'461565-1/9/2017-4:09:54 PM-127619',
'461514-1/9/2017-3:19:02 PM-75002');


