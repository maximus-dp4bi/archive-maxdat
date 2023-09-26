select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('448215-12/12/2016-3:33:08 PM-125420',
'448362-12/13/2016-9:11:27 AM-129457',
'449004-12/13/2016-3:15:18 PM-125420',
'450358-12/15/2016-3:21:48 PM-129457');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('448215-12/12/2016-3:33:08 PM-125420',
'448362-12/13/2016-9:11:27 AM-129457',
'449004-12/13/2016-3:15:18 PM-125420',
'450358-12/15/2016-3:21:48 PM-129457');

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('448215-12/12/2016-3:33:08 PM-125420',
'448362-12/13/2016-9:11:27 AM-129457',
'449004-12/13/2016-3:15:18 PM-125420',
'450358-12/15/2016-3:21:48 PM-129457');
commit;

select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('448215-12/12/2016-3:33:08 PM-125420',
'448362-12/13/2016-9:11:27 AM-129457',
'449004-12/13/2016-3:15:18 PM-125420',
'450358-12/15/2016-3:21:48 PM-129457');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('448215-12/12/2016-3:33:08 PM-125420',
'448362-12/13/2016-9:11:27 AM-129457',
'449004-12/13/2016-3:15:18 PM-125420',
'450358-12/15/2016-3:21:48 PM-129457');

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('448215-12/12/2016-3:33:08 PM-125420',
'448362-12/13/2016-9:11:27 AM-129457',
'449004-12/13/2016-3:15:18 PM-125420',
'450358-12/15/2016-3:21:48 PM-129457');
commit;
