alter session set current_schema = MAXDAT;
----  NYHIX-38116, and NYHIX-37805 
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('660968-2/6/2018-9:33:11 AM-139132',
'656342-1/23/2018-7:45:57 PM-147036',
'661090-2/6/2018-11:23:41 AM-134005');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('660968-2/6/2018-9:33:11 AM-139132',
'656342-1/23/2018-7:45:57 PM-147036',
'661090-2/6/2018-11:23:41 AM-134005');

commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('660968-2/6/2018-9:33:11 AM-139132',
'656342-1/23/2018-7:45:57 PM-147036',
'661090-2/6/2018-11:23:41 AM-134005');


select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('660968-2/6/2018-9:33:11 AM-139132',
'656342-1/23/2018-7:45:57 PM-147036',
'661090-2/6/2018-11:23:41 AM-134005');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('660968-2/6/2018-9:33:11 AM-139132',
'656342-1/23/2018-7:45:57 PM-147036',
'661090-2/6/2018-11:23:41 AM-134005');
 commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('660968-2/6/2018-9:33:11 AM-139132',
'656342-1/23/2018-7:45:57 PM-147036',
'661090-2/6/2018-11:23:41 AM-134005');





 