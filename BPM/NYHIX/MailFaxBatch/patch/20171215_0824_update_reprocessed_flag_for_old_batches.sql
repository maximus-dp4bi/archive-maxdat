alter session set current_schema = MAXDAT;
---- NYHIX-36743 
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-12/12/2017-3:51:23 PM',
 '642325-12/12/2017-11:00:35 AM-144684',
 '642400-12/12/2017-12:25:08 PM-139890');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-12/12/2017-3:51:23 PM',
 '642325-12/12/2017-11:00:35 AM-144684',
 '642400-12/12/2017-12:25:08 PM-139890');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-12/12/2017-3:51:23 PM',
 '642325-12/12/2017-11:00:35 AM-144684',
 '642400-12/12/2017-12:25:08 PM-139890');
 
select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-12/12/2017-3:51:23 PM',
 '642325-12/12/2017-11:00:35 AM-144684',
 '642400-12/12/2017-12:25:08 PM-139890');


update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-12/12/2017-3:51:23 PM',
 '642325-12/12/2017-11:00:35 AM-144684',
 '642400-12/12/2017-12:25:08 PM-139890');
commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-12/12/2017-3:51:23 PM',
 '642325-12/12/2017-11:00:35 AM-144684',
 '642400-12/12/2017-12:25:08 PM-139890');

 