alter session set current_schema = MAXDAT;
----  NYHIX-37372, NYHIX-37451
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-NavCAC2018-01-08-11-44-39-548',
'650634-1/8/2018-2:15:42 PM-89436');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-NavCAC2018-01-08-11-44-39-548',
'650634-1/8/2018-2:15:42 PM-89436');

commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-NavCAC2018-01-08-11-44-39-548',
'650634-1/8/2018-2:15:42 PM-89436');


select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-NavCAC2018-01-08-11-44-39-548',
'650634-1/8/2018-2:15:42 PM-89436');


update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-NavCAC2018-01-08-11-44-39-548',
'650634-1/8/2018-2:15:42 PM-89436');

 commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-NavCAC2018-01-08-11-44-39-548',
'650634-1/8/2018-2:15:42 PM-89436');


 