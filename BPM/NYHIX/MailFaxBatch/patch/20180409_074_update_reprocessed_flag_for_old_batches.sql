alter session set current_schema = MAXDAT;
----  NYHIX-39541
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('679162-3/29/2018-2:28:46 PM-146953',
'NYSOH-FAX-3/29/2018-11:16:39 AM',
'679058-3/29/2018-1:15:13 PM-139890',
'678581-3/28/2018-3:24:25 PM-89436',
'678161-3/27/2018-7:33:17 PM-149087',
'678920-3/29/2018-10:09:40 AM-146953');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('679162-3/29/2018-2:28:46 PM-146953',
'NYSOH-FAX-3/29/2018-11:16:39 AM',
'679058-3/29/2018-1:15:13 PM-139890',
'678581-3/28/2018-3:24:25 PM-89436',
'678161-3/27/2018-7:33:17 PM-149087',
'678920-3/29/2018-10:09:40 AM-146953');

commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('679162-3/29/2018-2:28:46 PM-146953',
'NYSOH-FAX-3/29/2018-11:16:39 AM',
'679058-3/29/2018-1:15:13 PM-139890',
'678581-3/28/2018-3:24:25 PM-89436',
'678161-3/27/2018-7:33:17 PM-149087',
'678920-3/29/2018-10:09:40 AM-146953');



select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('679162-3/29/2018-2:28:46 PM-146953',
'NYSOH-FAX-3/29/2018-11:16:39 AM',
'679058-3/29/2018-1:15:13 PM-139890',
'678581-3/28/2018-3:24:25 PM-89436',
'678161-3/27/2018-7:33:17 PM-149087',
'678920-3/29/2018-10:09:40 AM-146953');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('679162-3/29/2018-2:28:46 PM-146953',
'NYSOH-FAX-3/29/2018-11:16:39 AM',
'679058-3/29/2018-1:15:13 PM-139890',
'678581-3/28/2018-3:24:25 PM-89436',
'678161-3/27/2018-7:33:17 PM-149087',
'678920-3/29/2018-10:09:40 AM-146953');

commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('679162-3/29/2018-2:28:46 PM-146953',
'NYSOH-FAX-3/29/2018-11:16:39 AM',
'679058-3/29/2018-1:15:13 PM-139890',
'678581-3/28/2018-3:24:25 PM-89436',
'678161-3/27/2018-7:33:17 PM-149087',
'678920-3/29/2018-10:09:40 AM-146953');






 