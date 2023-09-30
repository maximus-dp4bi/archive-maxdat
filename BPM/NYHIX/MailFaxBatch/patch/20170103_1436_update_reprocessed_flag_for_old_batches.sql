select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('452413-12/20/2016-3:29:11 PM-129457',
'453353-12/22/2016-10:28:32 AM-129455');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('452413-12/20/2016-3:29:11 PM-129457',
'453353-12/22/2016-10:28:32 AM-129455');

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('452413-12/20/2016-3:29:11 PM-129457',
'453353-12/22/2016-10:28:32 AM-129455');
commit;

select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('452413-12/20/2016-3:29:11 PM-129457',
'453353-12/22/2016-10:28:32 AM-129455');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('452413-12/20/2016-3:29:11 PM-129457',
'453353-12/22/2016-10:28:32 AM-129455');
 
select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('452413-12/20/2016-3:29:11 PM-129457',
'453353-12/22/2016-10:28:32 AM-129455');
commit;
