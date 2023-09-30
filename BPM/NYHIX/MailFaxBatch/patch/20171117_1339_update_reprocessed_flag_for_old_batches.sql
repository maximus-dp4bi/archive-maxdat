alter session set current_schema = MAXDAT;
---- NYHIX-36132, NYHIX-36105, NYHIX-36212, NYHIX-36180
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-11/15/2017-8:06:31 AM',
'NYSOH-FAX-11/14/2017-10:28:12 AM',
'NYSOH-FAX-11/14/2017-1:07:01 PM',
'NYSOH-FAX-11/14/2017-9:56:28 AM',
'NYSOH-FAX-11/11/2017-1:43:56 PM',
'632770-11/13/2017-9:19:47 AM-140777',
'NYSOH-FAX-11/10/2017-4:07:14 PM',
'632594-11/10/2017-2:35:39 PM-127619',
'633460-11/14/2017-11:13:02 AM-144776');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-11/15/2017-8:06:31 AM',
'NYSOH-FAX-11/14/2017-10:28:12 AM',
'NYSOH-FAX-11/14/2017-1:07:01 PM',
'NYSOH-FAX-11/14/2017-9:56:28 AM',
'NYSOH-FAX-11/11/2017-1:43:56 PM',
'632770-11/13/2017-9:19:47 AM-140777',
'NYSOH-FAX-11/10/2017-4:07:14 PM',
'632594-11/10/2017-2:35:39 PM-127619',
'633460-11/14/2017-11:13:02 AM-144776');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-11/15/2017-8:06:31 AM',
'NYSOH-FAX-11/14/2017-10:28:12 AM',
'NYSOH-FAX-11/14/2017-1:07:01 PM',
'NYSOH-FAX-11/14/2017-9:56:28 AM',
'NYSOH-FAX-11/11/2017-1:43:56 PM',
'632770-11/13/2017-9:19:47 AM-140777',
'NYSOH-FAX-11/10/2017-4:07:14 PM',
'632594-11/10/2017-2:35:39 PM-127619',
'633460-11/14/2017-11:13:02 AM-144776');
 
select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-11/15/2017-8:06:31 AM',
'NYSOH-FAX-11/14/2017-10:28:12 AM',
'NYSOH-FAX-11/14/2017-1:07:01 PM',
'NYSOH-FAX-11/14/2017-9:56:28 AM',
'NYSOH-FAX-11/11/2017-1:43:56 PM',
'632770-11/13/2017-9:19:47 AM-140777',
'NYSOH-FAX-11/10/2017-4:07:14 PM',
'632594-11/10/2017-2:35:39 PM-127619',
'633460-11/14/2017-11:13:02 AM-144776');


update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-11/15/2017-8:06:31 AM',
'NYSOH-FAX-11/14/2017-10:28:12 AM',
'NYSOH-FAX-11/14/2017-1:07:01 PM',
'NYSOH-FAX-11/14/2017-9:56:28 AM',
'NYSOH-FAX-11/11/2017-1:43:56 PM',
'632770-11/13/2017-9:19:47 AM-140777',
'NYSOH-FAX-11/10/2017-4:07:14 PM',
'632594-11/10/2017-2:35:39 PM-127619',
'633460-11/14/2017-11:13:02 AM-144776');
 
commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-11/15/2017-8:06:31 AM',
'NYSOH-FAX-11/14/2017-10:28:12 AM',
'NYSOH-FAX-11/14/2017-1:07:01 PM',
'NYSOH-FAX-11/14/2017-9:56:28 AM',
'NYSOH-FAX-11/11/2017-1:43:56 PM',
'632770-11/13/2017-9:19:47 AM-140777',
'NYSOH-FAX-11/10/2017-4:07:14 PM',
'632594-11/10/2017-2:35:39 PM-127619',
'633460-11/14/2017-11:13:02 AM-144776');
 