select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id
from maxdat.corp_etl_mfb_batch_stg
where batch_name in ('436163-11/9/2016-2:42:13 PM-116630',
                     '435996-11/9/2016-1:07:34 PM-125350',
                     '435815-11/9/2016-10:47:48 AM-123207');

update maxdat.corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in ('436163-11/9/2016-2:42:13 PM-116630',
                   '435996-11/9/2016-1:07:34 PM-125350',
                   '435815-11/9/2016-10:47:48 AM-123207');

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id
from maxdat.corp_etl_mfb_batch_stg
where batch_name in ('436163-11/9/2016-2:42:13 PM-116630',
                     '435996-11/9/2016-1:07:34 PM-125350',
                     '435815-11/9/2016-10:47:48 AM-123207');
commit;


select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id
from maxdat.corp_etl_mfb_batch
where batch_name in ('436163-11/9/2016-2:42:13 PM-116630',
                     '435996-11/9/2016-1:07:34 PM-125350',
                     '435815-11/9/2016-10:47:48 AM-123207');

update maxdat.corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in ('436163-11/9/2016-2:42:13 PM-116630',
                   '435996-11/9/2016-1:07:34 PM-125350',
                   '435815-11/9/2016-10:47:48 AM-123207');

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id
from maxdat.corp_etl_mfb_batch
where batch_name in ('436163-11/9/2016-2:42:13 PM-116630',
                     '435996-11/9/2016-1:07:34 PM-125350',
                     '435815-11/9/2016-10:47:48 AM-123207');
commit;
