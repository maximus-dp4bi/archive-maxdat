alter session set current_schema = MAXDAT;
---- NYHIX-29498
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-NavCAC2017-02-09-10-04-07-920',
'482284-2/8/2017-2:35:02 PM-125405');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-NavCAC2017-02-09-10-04-07-920',
'482284-2/8/2017-2:35:02 PM-125405');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-NavCAC2017-02-09-10-04-07-920',
'482284-2/8/2017-2:35:02 PM-125405');

select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-NavCAC2017-02-09-10-04-07-920',
'482284-2/8/2017-2:35:02 PM-125405');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-NavCAC2017-02-09-10-04-07-920',
'482284-2/8/2017-2:35:02 PM-125405');
commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-NavCAC2017-02-09-10-04-07-920',
'482284-2/8/2017-2:35:02 PM-125405');

