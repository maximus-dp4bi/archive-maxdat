select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{98fa7470-76e4-43fd-9fa0-065337dd1979}',
'{8668537c-5db0-4d93-bb09-ddf90b76db6a}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{98fa7470-76e4-43fd-9fa0-065337dd1979}',
'{8668537c-5db0-4d93-bb09-ddf90b76db6a}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{98fa7470-76e4-43fd-9fa0-065337dd1979}',
'{8668537c-5db0-4d93-bb09-ddf90b76db6a}'
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{98fa7470-76e4-43fd-9fa0-065337dd1979}',
'{8668537c-5db0-4d93-bb09-ddf90b76db6a}'
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{98fa7470-76e4-43fd-9fa0-065337dd1979}',
'{8668537c-5db0-4d93-bb09-ddf90b76db6a}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{98fa7470-76e4-43fd-9fa0-065337dd1979}',
'{8668537c-5db0-4d93-bb09-ddf90b76db6a}'
);

commit;
