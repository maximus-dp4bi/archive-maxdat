alter session set current_schema = MAXDAT;
----  NYHIX-37272, NYHIX-37216
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('649342-1/4/2018-8:48:49 AM-144776',
'NYSOH-FAX-NavCAC2018-01-03-12-31-09-936',
'648742-1/2/2018-7:15:30 PM-147105');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('649342-1/4/2018-8:48:49 AM-144776',
'NYSOH-FAX-NavCAC2018-01-03-12-31-09-936',
'648742-1/2/2018-7:15:30 PM-147105');

commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('649342-1/4/2018-8:48:49 AM-144776',
'NYSOH-FAX-NavCAC2018-01-03-12-31-09-936',
'648742-1/2/2018-7:15:30 PM-147105');


select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('649342-1/4/2018-8:48:49 AM-144776',
'NYSOH-FAX-NavCAC2018-01-03-12-31-09-936',
'648742-1/2/2018-7:15:30 PM-147105');


update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('649342-1/4/2018-8:48:49 AM-144776',
'NYSOH-FAX-NavCAC2018-01-03-12-31-09-936',
'648742-1/2/2018-7:15:30 PM-147105');

 commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('649342-1/4/2018-8:48:49 AM-144776',
'NYSOH-FAX-NavCAC2018-01-03-12-31-09-936',
'648742-1/2/2018-7:15:30 PM-147105');



 