alter session set current_schema = MAXDAT;
---- NYHIX-31604
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-5/22/2017-6:16:30 PM',
 '539446-5/23/2017-11:42:10 AM-127619');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-5/22/2017-6:16:30 PM',
 '539446-5/23/2017-11:42:10 AM-127619');

commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-5/22/2017-6:16:30 PM',
 '539446-5/23/2017-11:42:10 AM-127619');

 
select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-5/22/2017-6:16:30 PM',
 '539446-5/23/2017-11:42:10 AM-127619');


update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-5/22/2017-6:16:30 PM',
 '539446-5/23/2017-11:42:10 AM-127619');
commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-5/22/2017-6:16:30 PM',
 '539446-5/23/2017-11:42:10 AM-127619');
