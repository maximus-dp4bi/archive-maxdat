alter session set current_schema = MAXDAT;
----  NYHIX-38424 
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-2/17/2018-6:25:26 PM');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-2/17/2018-6:25:26 PM');

commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-2/17/2018-6:25:26 PM');


select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-2/17/2018-6:25:26 PM');


update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-2/17/2018-6:25:26 PM');
 commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-2/17/2018-6:25:26 PM');






 