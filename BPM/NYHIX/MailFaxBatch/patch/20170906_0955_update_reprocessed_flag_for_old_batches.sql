alter session set current_schema = MAXDAT;
---- NYHIX-33729
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-8/26/2017-3:18:24 PM',
 '591094-8/28/2017-8:14:18 AM-13400');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-8/26/2017-3:18:24 PM',
 '591094-8/28/2017-8:14:18 AM-13400');

commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-8/26/2017-3:18:24 PM',
 '591094-8/28/2017-8:14:18 AM-13400');

 
select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-8/26/2017-3:18:24 PM',
 '591094-8/28/2017-8:14:18 AM-13400');


update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-8/26/2017-3:18:24 PM',
 '591094-8/28/2017-8:14:18 AM-13400');
commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-8/26/2017-3:18:24 PM',
 '591094-8/28/2017-8:14:18 AM-13400');

