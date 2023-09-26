select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{a3f3966f-ec99-42a5-91ba-d76a90e43b9e}', -- NYHIX-16552 
'{1de4f83b-cad6-4fca-ab97-2ce024fca41f}'  -- NYHIX-16701
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{a3f3966f-ec99-42a5-91ba-d76a90e43b9e}', -- NYHIX-16552 
'{1de4f83b-cad6-4fca-ab97-2ce024fca41f}'  -- NYHIX-16701
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{a3f3966f-ec99-42a5-91ba-d76a90e43b9e}', -- NYHIX-16552 
'{1de4f83b-cad6-4fca-ab97-2ce024fca41f}'  -- NYHIX-16701
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{a3f3966f-ec99-42a5-91ba-d76a90e43b9e}', -- NYHIX-16552 
'{1de4f83b-cad6-4fca-ab97-2ce024fca41f}'  -- NYHIX-16701
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{a3f3966f-ec99-42a5-91ba-d76a90e43b9e}', -- NYHIX-16552 
'{1de4f83b-cad6-4fca-ab97-2ce024fca41f}'  -- NYHIX-16701
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{a3f3966f-ec99-42a5-91ba-d76a90e43b9e}', -- NYHIX-16552 
'{1de4f83b-cad6-4fca-ab97-2ce024fca41f}'  -- NYHIX-16701
);

commit;
