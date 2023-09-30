alter session set current_schema = MAXDAT;
---- NYHIX-30418
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-DOHManualNotice2017-03-22-17-16-38-439',
'NYSOH-FAX-NavCAC2017-03-23-23-49-59-950',
'NYSOH-FAX-3/28/2017-12:47:07 PM');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-DOHManualNotice2017-03-22-17-16-38-439',
'NYSOH-FAX-NavCAC2017-03-23-23-49-59-950',
'NYSOH-FAX-3/28/2017-12:47:07 PM');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-DOHManualNotice2017-03-22-17-16-38-439',
'NYSOH-FAX-NavCAC2017-03-23-23-49-59-950',
'NYSOH-FAX-3/28/2017-12:47:07 PM');
 
select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-DOHManualNotice2017-03-22-17-16-38-439',
'NYSOH-FAX-NavCAC2017-03-23-23-49-59-950',
'NYSOH-FAX-3/28/2017-12:47:07 PM');
 
update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-DOHManualNotice2017-03-22-17-16-38-439',
'NYSOH-FAX-NavCAC2017-03-23-23-49-59-950',
'NYSOH-FAX-3/28/2017-12:47:07 PM');
commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-DOHManualNotice2017-03-22-17-16-38-439',
'NYSOH-FAX-NavCAC2017-03-23-23-49-59-950',
'NYSOH-FAX-3/28/2017-12:47:07 PM');

