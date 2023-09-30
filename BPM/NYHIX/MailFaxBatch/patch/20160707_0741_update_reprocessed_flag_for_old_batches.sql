select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{69b20454-94d5-4dab-868f-842a7ae5a324}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{69b20454-94d5-4dab-868f-842a7ae5a324}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{69b20454-94d5-4dab-868f-842a7ae5a324}'
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{69b20454-94d5-4dab-868f-842a7ae5a324}'
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{69b20454-94d5-4dab-868f-842a7ae5a324}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{69b20454-94d5-4dab-868f-842a7ae5a324}'
);


commit;
