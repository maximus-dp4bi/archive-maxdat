select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from maxdat.corp_etl_mfb_batch_stg
where batch_name in ('436245-11/9/2016-3:34:04 PM-123207',
                     '436770-11/10/2016-2:00:32 PM-123207',
                     '436716-11/10/2016-1:22:07 PM-123207');
update maxdat.corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in ('436245-11/9/2016-3:34:04 PM-123207',
                     '436770-11/10/2016-2:00:32 PM-123207',
                     '436716-11/10/2016-1:22:07 PM-123207');
select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from maxdat.corp_etl_mfb_batch_stg
where batch_name in ('436245-11/9/2016-3:34:04 PM-123207',
                     '436770-11/10/2016-2:00:32 PM-123207',
                     '436716-11/10/2016-1:22:07 PM-123207');
commit;

select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from maxdat.corp_etl_mfb_batch
where batch_name in ('436245-11/9/2016-3:34:04 PM-123207',
                     '436770-11/10/2016-2:00:32 PM-123207',
                     '436716-11/10/2016-1:22:07 PM-123207');

update maxdat.corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in ('436245-11/9/2016-3:34:04 PM-123207',
                     '436770-11/10/2016-2:00:32 PM-123207',
                     '436716-11/10/2016-1:22:07 PM-123207');


select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from maxdat.corp_etl_mfb_batch
where batch_name in ('436245-11/9/2016-3:34:04 PM-123207',
                     '436770-11/10/2016-2:00:32 PM-123207',
                     '436716-11/10/2016-1:22:07 PM-123207');
commit;
