alter session set current_schema = MAXDAT;
----  NYHIX-37834
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-1/25/2018-12:33:50 PM',
 'NYSOH-FAX-1/25/2018-11:47:03 AM');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-1/25/2018-12:33:50 PM',
 'NYSOH-FAX-1/25/2018-11:47:03 AM');

commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-1/25/2018-12:33:50 PM',
 'NYSOH-FAX-1/25/2018-11:47:03 AM');


select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-1/25/2018-12:33:50 PM',
 'NYSOH-FAX-1/25/2018-11:47:03 AM');


update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-1/25/2018-12:33:50 PM',
 'NYSOH-FAX-1/25/2018-11:47:03 AM');

 commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-1/25/2018-12:33:50 PM',
 'NYSOH-FAX-1/25/2018-11:47:03 AM');





 