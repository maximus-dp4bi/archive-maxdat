alter session set current_schema = MAXDAT;
----  NYHIX-39681
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('680613-4/3/2018-9:33:37 AM-146953',
'NYSOH-FAX-4/2/2018-2:50:45 PM',
'680460-4/2/2018-6:41:14 PM-149078',
'679873-3/30/2018-2:28:56 PM-149087',
'NYSOH-FAX-4/2/2018-1:56:57 PM');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('680613-4/3/2018-9:33:37 AM-146953',
'NYSOH-FAX-4/2/2018-2:50:45 PM',
'680460-4/2/2018-6:41:14 PM-149078',
'679873-3/30/2018-2:28:56 PM-149087',
'NYSOH-FAX-4/2/2018-1:56:57 PM');

commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('680613-4/3/2018-9:33:37 AM-146953',
'NYSOH-FAX-4/2/2018-2:50:45 PM',
'680460-4/2/2018-6:41:14 PM-149078',
'679873-3/30/2018-2:28:56 PM-149087',
'NYSOH-FAX-4/2/2018-1:56:57 PM');


select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('680613-4/3/2018-9:33:37 AM-146953',
'NYSOH-FAX-4/2/2018-2:50:45 PM',
'680460-4/2/2018-6:41:14 PM-149078',
'679873-3/30/2018-2:28:56 PM-149087',
'NYSOH-FAX-4/2/2018-1:56:57 PM');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('680613-4/3/2018-9:33:37 AM-146953',
'NYSOH-FAX-4/2/2018-2:50:45 PM',
'680460-4/2/2018-6:41:14 PM-149078',
'679873-3/30/2018-2:28:56 PM-149087',
'NYSOH-FAX-4/2/2018-1:56:57 PM');
commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('680613-4/3/2018-9:33:37 AM-146953',
'NYSOH-FAX-4/2/2018-2:50:45 PM',
'680460-4/2/2018-6:41:14 PM-149078',
'679873-3/30/2018-2:28:56 PM-149087',
'NYSOH-FAX-4/2/2018-1:56:57 PM');





 