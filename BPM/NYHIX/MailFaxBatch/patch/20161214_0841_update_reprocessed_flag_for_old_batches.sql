select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('442112-11/28/2016-3:37:47 PM-123207',
'441865-11/28/2016-11:08:02 AM-123207',
'444567-12/5/2016-1:36:25 PM-123207');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('442112-11/28/2016-3:37:47 PM-123207',
'441865-11/28/2016-11:08:02 AM-123207',
'444567-12/5/2016-1:36:25 PM-123207');

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('442112-11/28/2016-3:37:47 PM-123207',
'441865-11/28/2016-11:08:02 AM-123207',
'444567-12/5/2016-1:36:25 PM-123207');
commit;

select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('442112-11/28/2016-3:37:47 PM-123207',
'441865-11/28/2016-11:08:02 AM-123207',
'444567-12/5/2016-1:36:25 PM-123207');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('442112-11/28/2016-3:37:47 PM-123207',
'441865-11/28/2016-11:08:02 AM-123207',
'444567-12/5/2016-1:36:25 PM-123207');
 
select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('442112-11/28/2016-3:37:47 PM-123207',
'441865-11/28/2016-11:08:02 AM-123207',
'444567-12/5/2016-1:36:25 PM-123207');
commit;
