alter session set current_schema = MAXDAT;
----  NYHIX-37607
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-1/17/2018-9:10:39 AM',
 '654103-1/17/2018-3:22:41 PM-149079');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-1/17/2018-9:10:39 AM',
 '654103-1/17/2018-3:22:41 PM-149079');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-1/17/2018-9:10:39 AM',
 '654103-1/17/2018-3:22:41 PM-149079');


select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-1/17/2018-9:10:39 AM',
 '654103-1/17/2018-3:22:41 PM-149079');


update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-1/17/2018-9:10:39 AM',
 '654103-1/17/2018-3:22:41 PM-149079');
 commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-1/17/2018-9:10:39 AM',
 '654103-1/17/2018-3:22:41 PM-149079');




 