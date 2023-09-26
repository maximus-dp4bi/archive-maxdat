alter session set current_schema = MAXDAT;
---- NYHIX-33040 and NYHIX-33038
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-NavCAC2017-07-24-13-28-43-159',
 'NYSOH-FAX-NavCAC2017-07-25-16-02-03-836',
 'NYSOH-FAX-7/27/2017-11:53:27 AM');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-NavCAC2017-07-24-13-28-43-159',
 'NYSOH-FAX-NavCAC2017-07-25-16-02-03-836',
 'NYSOH-FAX-7/27/2017-11:53:27 AM');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-NavCAC2017-07-24-13-28-43-159',
 'NYSOH-FAX-NavCAC2017-07-25-16-02-03-836',
 'NYSOH-FAX-7/27/2017-11:53:27 AM');
 
select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-NavCAC2017-07-24-13-28-43-159',
 'NYSOH-FAX-NavCAC2017-07-25-16-02-03-836',
 'NYSOH-FAX-7/27/2017-11:53:27 AM');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-NavCAC2017-07-24-13-28-43-159',
 'NYSOH-FAX-NavCAC2017-07-25-16-02-03-836',
 'NYSOH-FAX-7/27/2017-11:53:27 AM');
commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-NavCAC2017-07-24-13-28-43-159',
 'NYSOH-FAX-NavCAC2017-07-25-16-02-03-836',
 'NYSOH-FAX-7/27/2017-11:53:27 AM');