alter session set current_schema = MAXDAT;
----  NYHIX-40695
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-5/14/2018-2:30:38 PM',
'NYSOH-FAX-5/14/2018-4:29:23 PM',
'NYSOH-FAX-NavCAC2018-05-14-16-15-51-998',
'697193-5/14/2018-11:46:26 AM-89436',
'NYSOH-FAX-NavCAC2018-05-14-12-27-21-115',
'NYSOH-FAX-NavCAC2018-05-14-11-51-09-193',
'NYSOH-FAX-NavCAC2018-05-14-12-12-50-959',
'NYSOH-FAX-NavCAC2018-05-14-17-53-13-384');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-5/14/2018-2:30:38 PM',
'NYSOH-FAX-5/14/2018-4:29:23 PM',
'NYSOH-FAX-NavCAC2018-05-14-16-15-51-998',
'697193-5/14/2018-11:46:26 AM-89436',
'NYSOH-FAX-NavCAC2018-05-14-12-27-21-115',
'NYSOH-FAX-NavCAC2018-05-14-11-51-09-193',
'NYSOH-FAX-NavCAC2018-05-14-12-12-50-959',
'NYSOH-FAX-NavCAC2018-05-14-17-53-13-384');

commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-5/14/2018-2:30:38 PM',
'NYSOH-FAX-5/14/2018-4:29:23 PM',
'NYSOH-FAX-NavCAC2018-05-14-16-15-51-998',
'697193-5/14/2018-11:46:26 AM-89436',
'NYSOH-FAX-NavCAC2018-05-14-12-27-21-115',
'NYSOH-FAX-NavCAC2018-05-14-11-51-09-193',
'NYSOH-FAX-NavCAC2018-05-14-12-12-50-959',
'NYSOH-FAX-NavCAC2018-05-14-17-53-13-384');


select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-5/14/2018-2:30:38 PM',
'NYSOH-FAX-5/14/2018-4:29:23 PM',
'NYSOH-FAX-NavCAC2018-05-14-16-15-51-998',
'697193-5/14/2018-11:46:26 AM-89436',
'NYSOH-FAX-NavCAC2018-05-14-12-27-21-115',
'NYSOH-FAX-NavCAC2018-05-14-11-51-09-193',
'NYSOH-FAX-NavCAC2018-05-14-12-12-50-959',
'NYSOH-FAX-NavCAC2018-05-14-17-53-13-384');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-5/14/2018-2:30:38 PM',
'NYSOH-FAX-5/14/2018-4:29:23 PM',
'NYSOH-FAX-NavCAC2018-05-14-16-15-51-998',
'697193-5/14/2018-11:46:26 AM-89436',
'NYSOH-FAX-NavCAC2018-05-14-12-27-21-115',
'NYSOH-FAX-NavCAC2018-05-14-11-51-09-193',
'NYSOH-FAX-NavCAC2018-05-14-12-12-50-959',
'NYSOH-FAX-NavCAC2018-05-14-17-53-13-384');

commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-5/14/2018-2:30:38 PM',
'NYSOH-FAX-5/14/2018-4:29:23 PM',
'NYSOH-FAX-NavCAC2018-05-14-16-15-51-998',
'697193-5/14/2018-11:46:26 AM-89436',
'NYSOH-FAX-NavCAC2018-05-14-12-27-21-115',
'NYSOH-FAX-NavCAC2018-05-14-11-51-09-193',
'NYSOH-FAX-NavCAC2018-05-14-12-12-50-959',
'NYSOH-FAX-NavCAC2018-05-14-17-53-13-384');





 