alter session set current_schema = MAXDAT;
----  NYHIX-40633
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-5/11/2018-12:56:06 PM',
'NYSOH-FAX-NavCAC2018-05-11-13-30-59-405');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-5/11/2018-12:56:06 PM',
'NYSOH-FAX-NavCAC2018-05-11-13-30-59-405');

commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-5/11/2018-12:56:06 PM',
'NYSOH-FAX-NavCAC2018-05-11-13-30-59-405');


select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-5/11/2018-12:56:06 PM',
'NYSOH-FAX-NavCAC2018-05-11-13-30-59-405');


update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-5/11/2018-12:56:06 PM',
'NYSOH-FAX-NavCAC2018-05-11-13-30-59-405');


commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-5/11/2018-12:56:06 PM',
'NYSOH-FAX-NavCAC2018-05-11-13-30-59-405');







 