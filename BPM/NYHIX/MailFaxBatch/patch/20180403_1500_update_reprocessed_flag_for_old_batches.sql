alter session set current_schema = MAXDAT;
----  NYHIX-39591 
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('679781-3/30/2018-1:22:20 PM-146953',
'NYSOH-FAX-3/29/2018-4:24:14 PM');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('679781-3/30/2018-1:22:20 PM-146953',
'NYSOH-FAX-3/29/2018-4:24:14 PM');

commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('679781-3/30/2018-1:22:20 PM-146953',
'NYSOH-FAX-3/29/2018-4:24:14 PM');



select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('679781-3/30/2018-1:22:20 PM-146953',
'NYSOH-FAX-3/29/2018-4:24:14 PM');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('679781-3/30/2018-1:22:20 PM-146953',
'NYSOH-FAX-3/29/2018-4:24:14 PM');

commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('679781-3/30/2018-1:22:20 PM-146953',
'NYSOH-FAX-3/29/2018-4:24:14 PM');





 