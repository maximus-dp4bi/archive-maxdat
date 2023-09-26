select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{d8537d6f-cef0-49bf-afc1-91dbb7098dfd}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{d8537d6f-cef0-49bf-afc1-91dbb7098dfd}'

);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{d8537d6f-cef0-49bf-afc1-91dbb7098dfd}'
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{d8537d6f-cef0-49bf-afc1-91dbb7098dfd}'

);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{d8537d6f-cef0-49bf-afc1-91dbb7098dfd}'

);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{d8537d6f-cef0-49bf-afc1-91dbb7098dfd}'

);

commit;