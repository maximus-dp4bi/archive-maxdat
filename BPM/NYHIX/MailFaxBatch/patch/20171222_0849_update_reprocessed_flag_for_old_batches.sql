alter session set current_schema = MAXDAT;
---- NYHIX-36907, NYHIX-36936 
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-12/19/2017-1:17:46 PM 12/19/2017 1:17:46 PM',
 'NYSOH-FAX-12/20/2017-2:22:44 PM');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-12/19/2017-1:17:46 PM 12/19/2017 1:17:46 PM',
 'NYSOH-FAX-12/20/2017-2:22:44 PM');

commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-12/19/2017-1:17:46 PM 12/19/2017 1:17:46 PM',
 'NYSOH-FAX-12/20/2017-2:22:44 PM');


select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-12/19/2017-1:17:46 PM 12/19/2017 1:17:46 PM',
 'NYSOH-FAX-12/20/2017-2:22:44 PM');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-12/19/2017-1:17:46 PM 12/19/2017 1:17:46 PM',
 'NYSOH-FAX-12/20/2017-2:22:44 PM');
 commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-12/19/2017-1:17:46 PM 12/19/2017 1:17:46 PM',
 'NYSOH-FAX-12/20/2017-2:22:44 PM');


 