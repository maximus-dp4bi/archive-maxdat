select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-HRA2016-11-16-12-02-53-267',
'439086-11/17/2016-12:30:06 PM-123207',
'439132-11/17/2016-1:13:10 PM-123207',
'439387-11/18/2016-9:01:23 AM-127619',
'NYSOH-FAX-11/17/2016-5:42:53 PM',
'439707-11/18/2016-1:26:14 PM-116630');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-HRA2016-11-16-12-02-53-267',
'439086-11/17/2016-12:30:06 PM-123207',
'439132-11/17/2016-1:13:10 PM-123207',
'439387-11/18/2016-9:01:23 AM-127619',
'NYSOH-FAX-11/17/2016-5:42:53 PM',
'439707-11/18/2016-1:26:14 PM-116630');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-HRA2016-11-16-12-02-53-267',
'439086-11/17/2016-12:30:06 PM-123207',
'439132-11/17/2016-1:13:10 PM-123207',
'439387-11/18/2016-9:01:23 AM-127619',
'NYSOH-FAX-11/17/2016-5:42:53 PM',
'439707-11/18/2016-1:26:14 PM-116630');

select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-HRA2016-11-16-12-02-53-267',
'439086-11/17/2016-12:30:06 PM-123207',
'439132-11/17/2016-1:13:10 PM-123207',
'439387-11/18/2016-9:01:23 AM-127619',
'NYSOH-FAX-11/17/2016-5:42:53 PM',
'439707-11/18/2016-1:26:14 PM-116630');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-HRA2016-11-16-12-02-53-267',
'439086-11/17/2016-12:30:06 PM-123207',
'439132-11/17/2016-1:13:10 PM-123207',
'439387-11/18/2016-9:01:23 AM-127619',
'NYSOH-FAX-11/17/2016-5:42:53 PM',
'439707-11/18/2016-1:26:14 PM-116630');
commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-HRA2016-11-16-12-02-53-267',
'439086-11/17/2016-12:30:06 PM-123207',
'439132-11/17/2016-1:13:10 PM-123207',
'439387-11/18/2016-9:01:23 AM-127619',
'NYSOH-FAX-11/17/2016-5:42:53 PM',
'439707-11/18/2016-1:26:14 PM-116630');

