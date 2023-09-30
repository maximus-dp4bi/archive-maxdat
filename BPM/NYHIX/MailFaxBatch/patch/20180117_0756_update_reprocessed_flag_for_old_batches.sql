alter session set current_schema = MAXDAT;
----  NYHIX-37519, NYHIX-37502
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('651721-1/10/2018-7:03:34 PM-149079',
 'NYSOH-FAX-1/12/2018-1:46:35 PM');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('651721-1/10/2018-7:03:34 PM-149079',
 'NYSOH-FAX-1/12/2018-1:46:35 PM');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('651721-1/10/2018-7:03:34 PM-149079',
 'NYSOH-FAX-1/12/2018-1:46:35 PM');



select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('651721-1/10/2018-7:03:34 PM-149079',
 'NYSOH-FAX-1/12/2018-1:46:35 PM');



update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('651721-1/10/2018-7:03:34 PM-149079',
 'NYSOH-FAX-1/12/2018-1:46:35 PM');
 commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('651721-1/10/2018-7:03:34 PM-149079',
 'NYSOH-FAX-1/12/2018-1:46:35 PM');




 