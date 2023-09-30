select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{3a79a1e0-35ed-4249-8bb6-e9c70d55ed41}',
'{137121c8-f1ac-4fa7-8235-37616ba8a9bd}',
'{b2e588e9-5c38-4467-9cf1-b079e6ebc5cb}',
'{4ddd2e23-a78a-4039-8f52-ec62a301163c}',
'{d7a04a0b-8f51-428c-ad9a-4f88a2562718}' 
);


update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{3a79a1e0-35ed-4249-8bb6-e9c70d55ed41}',
'{137121c8-f1ac-4fa7-8235-37616ba8a9bd}',
'{b2e588e9-5c38-4467-9cf1-b079e6ebc5cb}',
'{4ddd2e23-a78a-4039-8f52-ec62a301163c}',
'{d7a04a0b-8f51-428c-ad9a-4f88a2562718}' 
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{3a79a1e0-35ed-4249-8bb6-e9c70d55ed41}',
'{137121c8-f1ac-4fa7-8235-37616ba8a9bd}',
'{b2e588e9-5c38-4467-9cf1-b079e6ebc5cb}',
'{4ddd2e23-a78a-4039-8f52-ec62a301163c}',
'{d7a04a0b-8f51-428c-ad9a-4f88a2562718}' 
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{3a79a1e0-35ed-4249-8bb6-e9c70d55ed41}',
'{137121c8-f1ac-4fa7-8235-37616ba8a9bd}',
'{b2e588e9-5c38-4467-9cf1-b079e6ebc5cb}',
'{4ddd2e23-a78a-4039-8f52-ec62a301163c}',
'{d7a04a0b-8f51-428c-ad9a-4f88a2562718}' 
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{3a79a1e0-35ed-4249-8bb6-e9c70d55ed41}',
'{137121c8-f1ac-4fa7-8235-37616ba8a9bd}',
'{b2e588e9-5c38-4467-9cf1-b079e6ebc5cb}',
'{4ddd2e23-a78a-4039-8f52-ec62a301163c}',
'{d7a04a0b-8f51-428c-ad9a-4f88a2562718}' 
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{3a79a1e0-35ed-4249-8bb6-e9c70d55ed41}',
'{137121c8-f1ac-4fa7-8235-37616ba8a9bd}',
'{b2e588e9-5c38-4467-9cf1-b079e6ebc5cb}',
'{4ddd2e23-a78a-4039-8f52-ec62a301163c}',
'{d7a04a0b-8f51-428c-ad9a-4f88a2562718}' 
);


commit;
