select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{e2eac751-873c-4e27-b320-d367ca3ed393}'  -- NYHIX-17017
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{e2eac751-873c-4e27-b320-d367ca3ed393}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{e2eac751-873c-4e27-b320-d367ca3ed393}'
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{e2eac751-873c-4e27-b320-d367ca3ed393}'
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{e2eac751-873c-4e27-b320-d367ca3ed393}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{e2eac751-873c-4e27-b320-d367ca3ed393}'
);

commit;
