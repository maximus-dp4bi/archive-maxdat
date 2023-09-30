select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{fc461860-ef74-49ff-bfa8-768032032686}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{fc461860-ef74-49ff-bfa8-768032032686}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{fc461860-ef74-49ff-bfa8-768032032686}'
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{fc461860-ef74-49ff-bfa8-768032032686}'
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{fc461860-ef74-49ff-bfa8-768032032686}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{fc461860-ef74-49ff-bfa8-768032032686}'
);

commit;
