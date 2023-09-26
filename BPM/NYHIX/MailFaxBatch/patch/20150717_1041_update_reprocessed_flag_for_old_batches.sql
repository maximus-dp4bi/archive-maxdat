select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{e967043b-1086-48ca-b58c-91abf3319512}');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{e967043b-1086-48ca-b58c-91abf3319512}');

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{e967043b-1086-48ca-b58c-91abf3319512}');

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{e967043b-1086-48ca-b58c-91abf3319512}');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{e967043b-1086-48ca-b58c-91abf3319512}');

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{e967043b-1086-48ca-b58c-91abf3319512}');

commit;
