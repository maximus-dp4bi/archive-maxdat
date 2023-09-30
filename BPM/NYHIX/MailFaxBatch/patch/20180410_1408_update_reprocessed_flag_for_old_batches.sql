alter session set current_schema = MAXDAT;
----  NYHIX-39742
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-4/6/2018-2:31:19 PM',
'681620-4/5/2018-9:41:05 AM-89436');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-4/6/2018-2:31:19 PM',
'681620-4/5/2018-9:41:05 AM-89436');

commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-4/6/2018-2:31:19 PM',
'681620-4/5/2018-9:41:05 AM-89436');


select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-4/6/2018-2:31:19 PM',
'681620-4/5/2018-9:41:05 AM-89436');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-4/6/2018-2:31:19 PM',
'681620-4/5/2018-9:41:05 AM-89436');

commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-4/6/2018-2:31:19 PM',
'681620-4/5/2018-9:41:05 AM-89436');






 