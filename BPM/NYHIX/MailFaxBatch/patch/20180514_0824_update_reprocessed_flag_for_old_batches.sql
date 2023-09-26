alter session set current_schema = MAXDAT;
----  NYHIX-40552
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-5/4/2018-6:26:32 PM',
'NYSOH-FAX-5/6/2018-3:14:49 PM');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-5/4/2018-6:26:32 PM',
'NYSOH-FAX-5/6/2018-3:14:49 PM');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-5/4/2018-6:26:32 PM',
'NYSOH-FAX-5/6/2018-3:14:49 PM');

select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-5/4/2018-6:26:32 PM',
'NYSOH-FAX-5/6/2018-3:14:49 PM');


update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-5/4/2018-6:26:32 PM',
'NYSOH-FAX-5/6/2018-3:14:49 PM');

commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-5/4/2018-6:26:32 PM',
'NYSOH-FAX-5/6/2018-3:14:49 PM');






 