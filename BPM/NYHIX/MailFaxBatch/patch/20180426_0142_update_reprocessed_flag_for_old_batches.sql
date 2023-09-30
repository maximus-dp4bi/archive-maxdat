alter session set current_schema = MAXDAT;
----  NYHIX-40133
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('688809-4/23/2018-2:43:47 PM-146953',
'NYSOH-FAX-4/23/2018-9:58:24 AM',
'688476-4/23/2018-8:44:00 AM-89436');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('688809-4/23/2018-2:43:47 PM-146953',
'NYSOH-FAX-4/23/2018-9:58:24 AM',
'688476-4/23/2018-8:44:00 AM-89436');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('688809-4/23/2018-2:43:47 PM-146953',
'NYSOH-FAX-4/23/2018-9:58:24 AM',
'688476-4/23/2018-8:44:00 AM-89436');

select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('688809-4/23/2018-2:43:47 PM-146953',
'NYSOH-FAX-4/23/2018-9:58:24 AM',
'688476-4/23/2018-8:44:00 AM-89436');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('688809-4/23/2018-2:43:47 PM-146953',
'NYSOH-FAX-4/23/2018-9:58:24 AM',
'688476-4/23/2018-8:44:00 AM-89436');
commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('688809-4/23/2018-2:43:47 PM-146953',
'NYSOH-FAX-4/23/2018-9:58:24 AM',
'688476-4/23/2018-8:44:00 AM-89436');





 