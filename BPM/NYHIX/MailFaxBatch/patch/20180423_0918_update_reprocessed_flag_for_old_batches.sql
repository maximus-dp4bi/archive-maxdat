alter session set current_schema = MAXDAT;
----  NYHIX-39878, NYHIX-39954, NYHIX-40015
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('682624-4/9/2018-10:39:56 AM-149087',
'679182-3/29/2018-2:43:04 PM-149087',
'685409-4/16/2018-11:58:46 AM-139890',
'NYSOH-FAX-4/16/2018-10:38:37 AM',
'686781-4/18/2018-10:57:19 AM-139895');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('682624-4/9/2018-10:39:56 AM-149087',
'679182-3/29/2018-2:43:04 PM-149087',
'685409-4/16/2018-11:58:46 AM-139890',
'NYSOH-FAX-4/16/2018-10:38:37 AM',
'686781-4/18/2018-10:57:19 AM-139895');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('682624-4/9/2018-10:39:56 AM-149087',
'679182-3/29/2018-2:43:04 PM-149087',
'685409-4/16/2018-11:58:46 AM-139890',
'NYSOH-FAX-4/16/2018-10:38:37 AM',
'686781-4/18/2018-10:57:19 AM-139895');



select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('682624-4/9/2018-10:39:56 AM-149087',
'679182-3/29/2018-2:43:04 PM-149087',
'685409-4/16/2018-11:58:46 AM-139890',
'NYSOH-FAX-4/16/2018-10:38:37 AM',
'686781-4/18/2018-10:57:19 AM-139895');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('682624-4/9/2018-10:39:56 AM-149087',
'679182-3/29/2018-2:43:04 PM-149087',
'685409-4/16/2018-11:58:46 AM-139890',
'NYSOH-FAX-4/16/2018-10:38:37 AM',
'686781-4/18/2018-10:57:19 AM-139895');
commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('682624-4/9/2018-10:39:56 AM-149087',
'679182-3/29/2018-2:43:04 PM-149087',
'685409-4/16/2018-11:58:46 AM-139890',
'NYSOH-FAX-4/16/2018-10:38:37 AM',
'686781-4/18/2018-10:57:19 AM-139895');





 