alter session set current_schema = MAXDAT;
---- NYHIX-29818
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-2/15/2017-2:38:24 PM',
'496455-3/7/2017-11:24:47 AM-127619',
'NYSOH-FAX-3/6/2017-3:44:32 PM');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-2/15/2017-2:38:24 PM',
'496455-3/7/2017-11:24:47 AM-127619',
'NYSOH-FAX-3/6/2017-3:44:32 PM');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-2/15/2017-2:38:24 PM',
'496455-3/7/2017-11:24:47 AM-127619',
'NYSOH-FAX-3/6/2017-3:44:32 PM');

select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-2/15/2017-2:38:24 PM',
'496455-3/7/2017-11:24:47 AM-127619',
'NYSOH-FAX-3/6/2017-3:44:32 PM');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-2/15/2017-2:38:24 PM',
'496455-3/7/2017-11:24:47 AM-127619',
'NYSOH-FAX-3/6/2017-3:44:32 PM');
commit;
update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-2/15/2017-2:38:24 PM',
'496455-3/7/2017-11:24:47 AM-127619',
'NYSOH-FAX-3/6/2017-3:44:32 PM');
commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-2/15/2017-2:38:24 PM',
'496455-3/7/2017-11:24:47 AM-127619',
'NYSOH-FAX-3/6/2017-3:44:32 PM');


