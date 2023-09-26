alter session set current_schema = MAXDAT;
----  NYHIX-39825, NYHIX-39866, NYHIX-39881
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('683461-4/10/2018-2:13:47 PM-146953',
'NYSOH-FAX-4/2/2018-10:31:24 AM',
'NYSOH-FAX-4/12/2018-8:35:31 AM');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('683461-4/10/2018-2:13:47 PM-146953',
'NYSOH-FAX-4/2/2018-10:31:24 AM',
'NYSOH-FAX-4/12/2018-8:35:31 AM');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('683461-4/10/2018-2:13:47 PM-146953',
'NYSOH-FAX-4/2/2018-10:31:24 AM',
'NYSOH-FAX-4/12/2018-8:35:31 AM');


select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('683461-4/10/2018-2:13:47 PM-146953',
'NYSOH-FAX-4/2/2018-10:31:24 AM',
'NYSOH-FAX-4/12/2018-8:35:31 AM');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('683461-4/10/2018-2:13:47 PM-146953',
'NYSOH-FAX-4/2/2018-10:31:24 AM',
'NYSOH-FAX-4/12/2018-8:35:31 AM');
commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('683461-4/10/2018-2:13:47 PM-146953',
'NYSOH-FAX-4/2/2018-10:31:24 AM',
'NYSOH-FAX-4/12/2018-8:35:31 AM');







 