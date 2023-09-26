alter session set current_schema = MAXDAT;
----  NYHIX-38052
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('659999-2/2/2018-10:16:15 AM-139132',
'660198-2/2/2018-2:18:07 PM-149078');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('659999-2/2/2018-10:16:15 AM-139132',
'660198-2/2/2018-2:18:07 PM-149078');

commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('659999-2/2/2018-10:16:15 AM-139132',
'660198-2/2/2018-2:18:07 PM-149078');


select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('659999-2/2/2018-10:16:15 AM-139132',
'660198-2/2/2018-2:18:07 PM-149078');


update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('659999-2/2/2018-10:16:15 AM-139132',
'660198-2/2/2018-2:18:07 PM-149078');

 commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('659999-2/2/2018-10:16:15 AM-139132',
'660198-2/2/2018-2:18:07 PM-149078');





 