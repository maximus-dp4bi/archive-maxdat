select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from maxdat.corp_etl_mfb_batch_stg
where batch_name in ('NYSOH-FAX-11/14/2016-9:08:16 AM',
'NYSOH-FAX-11/14/2016-2:29:53 PM',
'437278-11/14/2016-1:08:17 PM-123207',
'NYSOH-FAX-11/15/2016-3:40:37 PM',
'438190-11/16/2016-8:44:15 AM-125422',
'NYSOH-FAX-NavCAC2016-11-15-10-53-46-174');

update maxdat.corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in ('NYSOH-FAX-11/14/2016-9:08:16 AM',
'NYSOH-FAX-11/14/2016-2:29:53 PM',
'437278-11/14/2016-1:08:17 PM-123207',
'NYSOH-FAX-11/15/2016-3:40:37 PM',
'438190-11/16/2016-8:44:15 AM-125422',
'NYSOH-FAX-NavCAC2016-11-15-10-53-46-174');

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from maxdat.corp_etl_mfb_batch_stg
where batch_name in ('NYSOH-FAX-11/14/2016-9:08:16 AM',
'NYSOH-FAX-11/14/2016-2:29:53 PM',
'437278-11/14/2016-1:08:17 PM-123207',
'NYSOH-FAX-11/15/2016-3:40:37 PM',
'438190-11/16/2016-8:44:15 AM-125422',
'NYSOH-FAX-NavCAC2016-11-15-10-53-46-174');
commit;

select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from maxdat.corp_etl_mfb_batch
where batch_name in ('NYSOH-FAX-11/14/2016-9:08:16 AM',
'NYSOH-FAX-11/14/2016-2:29:53 PM',
'437278-11/14/2016-1:08:17 PM-123207',
'NYSOH-FAX-11/15/2016-3:40:37 PM',
'438190-11/16/2016-8:44:15 AM-125422',
'NYSOH-FAX-NavCAC2016-11-15-10-53-46-174');

update maxdat.corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in ('NYSOH-FAX-11/14/2016-9:08:16 AM',
'NYSOH-FAX-11/14/2016-2:29:53 PM',
'437278-11/14/2016-1:08:17 PM-123207',
'NYSOH-FAX-11/15/2016-3:40:37 PM',
'438190-11/16/2016-8:44:15 AM-125422',
'NYSOH-FAX-NavCAC2016-11-15-10-53-46-174');

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from maxdat.corp_etl_mfb_batch
where batch_name in ('NYSOH-FAX-11/14/2016-9:08:16 AM',
'NYSOH-FAX-11/14/2016-2:29:53 PM',
'437278-11/14/2016-1:08:17 PM-123207',
'NYSOH-FAX-11/15/2016-3:40:37 PM',
'438190-11/16/2016-8:44:15 AM-125422',
'NYSOH-FAX-NavCAC2016-11-15-10-53-46-174');
commit;
