alter session set current_schema = MAXDAT;
---- NYHIX-34637, NYHIX-34638
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-NavCAC2017-09-30-13-10-17-132',
 'NYSOH-FAX-HRA2017-09-30-12-03-43-676');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-NavCAC2017-09-30-13-10-17-132',
 'NYSOH-FAX-HRA2017-09-30-12-03-43-676');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-NavCAC2017-09-30-13-10-17-132',
 'NYSOH-FAX-HRA2017-09-30-12-03-43-676');

 
select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-NavCAC2017-09-30-13-10-17-132',
 'NYSOH-FAX-HRA2017-09-30-12-03-43-676');


update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-NavCAC2017-09-30-13-10-17-132',
 'NYSOH-FAX-HRA2017-09-30-12-03-43-676');
commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-NavCAC2017-09-30-13-10-17-132',
 'NYSOH-FAX-HRA2017-09-30-12-03-43-676');
