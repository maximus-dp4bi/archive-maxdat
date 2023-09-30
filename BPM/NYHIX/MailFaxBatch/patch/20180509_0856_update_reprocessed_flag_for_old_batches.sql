alter session set current_schema = MAXDAT;
----  NYHIX-40494, NYHIX-40493 
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-5/4/2018-1:22:31 PM',
'NYSOH-FAX-5/4/2018-2:15:18 PM',
'694051-5/4/2018-2:52:43 PM-139890',
'693983-5/4/2018-1:55:19 PM-146953');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-5/4/2018-1:22:31 PM',
'NYSOH-FAX-5/4/2018-2:15:18 PM',
'694051-5/4/2018-2:52:43 PM-139890',
'693983-5/4/2018-1:55:19 PM-146953');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-5/4/2018-1:22:31 PM',
'NYSOH-FAX-5/4/2018-2:15:18 PM',
'694051-5/4/2018-2:52:43 PM-139890',
'693983-5/4/2018-1:55:19 PM-146953');

select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-5/4/2018-1:22:31 PM',
'NYSOH-FAX-5/4/2018-2:15:18 PM',
'694051-5/4/2018-2:52:43 PM-139890',
'693983-5/4/2018-1:55:19 PM-146953');


update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-5/4/2018-1:22:31 PM',
'NYSOH-FAX-5/4/2018-2:15:18 PM',
'694051-5/4/2018-2:52:43 PM-139890',
'693983-5/4/2018-1:55:19 PM-146953');

commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-5/4/2018-1:22:31 PM',
'NYSOH-FAX-5/4/2018-2:15:18 PM');






 