select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{57de662c-4760-438e-a2a4-9e24cee1085c}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{57de662c-4760-438e-a2a4-9e24cee1085c}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{57de662c-4760-438e-a2a4-9e24cee1085c}'
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{57de662c-4760-438e-a2a4-9e24cee1085c}'
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{57de662c-4760-438e-a2a4-9e24cee1085c}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{57de662c-4760-438e-a2a4-9e24cee1085c}'
);


commit;
