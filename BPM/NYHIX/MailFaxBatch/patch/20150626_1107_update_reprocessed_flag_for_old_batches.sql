select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{be8f02fc-d175-4eb3-9a6a-906cf31a6fef}',
'{6425457f-e98b-4786-a0c7-d10a04c44547}');


update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{be8f02fc-d175-4eb3-9a6a-906cf31a6fef}',
'{6425457f-e98b-4786-a0c7-d10a04c44547}');

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{be8f02fc-d175-4eb3-9a6a-906cf31a6fef}',
'{6425457f-e98b-4786-a0c7-d10a04c44547}');

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{be8f02fc-d175-4eb3-9a6a-906cf31a6fef}',
'{6425457f-e98b-4786-a0c7-d10a04c44547}');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{be8f02fc-d175-4eb3-9a6a-906cf31a6fef}',
'{6425457f-e98b-4786-a0c7-d10a04c44547}');

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{be8f02fc-d175-4eb3-9a6a-906cf31a6fef}',
'{6425457f-e98b-4786-a0c7-d10a04c44547}');

commit;
