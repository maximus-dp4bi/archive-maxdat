alter session set current_schema = MAXDAT;
----  NYHIX-39402, NYHIX-39697
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('677375-3/26/2018-2:16:36 PM-139890',
'681124-4/4/2018-9:43:40 AM-139895',
'NYSOH-FAX-3/26/2018-9:08:54 AM');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('677375-3/26/2018-2:16:36 PM-139890',
'681124-4/4/2018-9:43:40 AM-139895',
'NYSOH-FAX-3/26/2018-9:08:54 AM');

commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('677375-3/26/2018-2:16:36 PM-139890',
'681124-4/4/2018-9:43:40 AM-139895',
'NYSOH-FAX-3/26/2018-9:08:54 AM');



select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('677375-3/26/2018-2:16:36 PM-139890',
'681124-4/4/2018-9:43:40 AM-139895',
'NYSOH-FAX-3/26/2018-9:08:54 AM');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('677375-3/26/2018-2:16:36 PM-139890',
'681124-4/4/2018-9:43:40 AM-139895',
'NYSOH-FAX-3/26/2018-9:08:54 AM');

commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('677375-3/26/2018-2:16:36 PM-139890',
'681124-4/4/2018-9:43:40 AM-139895',
'NYSOH-FAX-3/26/2018-9:08:54 AM');






 