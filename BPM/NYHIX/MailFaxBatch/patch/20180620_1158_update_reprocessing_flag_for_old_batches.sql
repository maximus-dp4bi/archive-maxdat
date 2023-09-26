alter session set current_schema = MAXDAT;
----  NYHIX-41534, NYHIX-41556
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-6/15/2018-1:27:57 PM');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-6/15/2018-1:27:57 PM',
'710150-6/18/2018-8:44:00 AM-146953',
'710280-6/18/2018-12:55:49 PM-149459');

commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-6/15/2018-1:27:57 PM',
'710150-6/18/2018-8:44:00 AM-146953',
'710280-6/18/2018-12:55:49 PM-149459');


select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-6/15/2018-1:27:57 PM',
'710150-6/18/2018-8:44:00 AM-146953',
'710280-6/18/2018-12:55:49 PM-149459');


update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-6/15/2018-1:27:57 PM',
'710150-6/18/2018-8:44:00 AM-146953',
'710280-6/18/2018-12:55:49 PM-149459');

commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-6/15/2018-1:27:57 PM',
'710150-6/18/2018-8:44:00 AM-146953',
'710280-6/18/2018-12:55:49 PM-149459');


