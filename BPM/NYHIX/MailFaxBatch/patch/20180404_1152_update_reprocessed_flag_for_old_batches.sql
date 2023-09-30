alter session set current_schema = MAXDAT;
----  NYHIX-39296
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('676504-3/22/2018-10:14:32 AM-139890',
'NYSOH-FAX-3/21/2018-5:58:19 PM',
'NYSOH-FAX-3/22/2018-7:51:06 AM',
'676548-3/22/2018-11:14:59 AM-146953');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('676504-3/22/2018-10:14:32 AM-139890',
'NYSOH-FAX-3/21/2018-5:58:19 PM',
'NYSOH-FAX-3/22/2018-7:51:06 AM',
'676548-3/22/2018-11:14:59 AM-146953');

commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('676504-3/22/2018-10:14:32 AM-139890',
'NYSOH-FAX-3/21/2018-5:58:19 PM',
'NYSOH-FAX-3/22/2018-7:51:06 AM',
'676548-3/22/2018-11:14:59 AM-146953');


select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('676504-3/22/2018-10:14:32 AM-139890',
'NYSOH-FAX-3/21/2018-5:58:19 PM',
'NYSOH-FAX-3/22/2018-7:51:06 AM',
'676548-3/22/2018-11:14:59 AM-146953');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('676504-3/22/2018-10:14:32 AM-139890',
'NYSOH-FAX-3/21/2018-5:58:19 PM',
'NYSOH-FAX-3/22/2018-7:51:06 AM',
'676548-3/22/2018-11:14:59 AM-146953');

commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('676504-3/22/2018-10:14:32 AM-139890',
'NYSOH-FAX-3/21/2018-5:58:19 PM',
'NYSOH-FAX-3/22/2018-7:51:06 AM',
'676548-3/22/2018-11:14:59 AM-146953');





 