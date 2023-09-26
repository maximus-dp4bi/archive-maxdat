alter session set current_schema = MAXDAT;
----  NYHIX-38273
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('662979-2/12/2018-8:45:42 AM-139132',
'NYSOH-FAX-2/9/2018-3:56:50 PM');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('662979-2/12/2018-8:45:42 AM-139132',
'NYSOH-FAX-2/9/2018-3:56:50 PM');

commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('662979-2/12/2018-8:45:42 AM-139132',
'NYSOH-FAX-2/9/2018-3:56:50 PM');

select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('662979-2/12/2018-8:45:42 AM-139132',
'NYSOH-FAX-2/9/2018-3:56:50 PM');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('662979-2/12/2018-8:45:42 AM-139132',
'NYSOH-FAX-2/9/2018-3:56:50 PM');
 commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('662979-2/12/2018-8:45:42 AM-139132',
'NYSOH-FAX-2/9/2018-3:56:50 PM');





 