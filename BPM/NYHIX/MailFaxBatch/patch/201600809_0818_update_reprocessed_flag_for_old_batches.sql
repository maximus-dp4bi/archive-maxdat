select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{e2243ba8-4e42-4d98-a1ed-fe9c44dbf871}',
'{5dbbdb4b-c68c-4355-95a3-e02096a2047c}',
'{469fa256-5c5c-4404-9a55-cb96198cd7a5}',
'{df01c938-4e3d-459e-a8da-fb1c7d885a4a}',
'{d51a7a98-f9b6-467a-908f-ad75d32723a6}',
'{d4dd1504-9f97-4f17-86a4-9eda086a9b3f}',
'{9e3a481a-67e4-42c5-a014-93ec98dd68d7}',
'{447d6475-f8e0-4308-8c43-216294049e51}',
'{738e1e53-78b8-48c6-8baa-1a86ab3d80fd}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{e2243ba8-4e42-4d98-a1ed-fe9c44dbf871}',
'{5dbbdb4b-c68c-4355-95a3-e02096a2047c}',
'{469fa256-5c5c-4404-9a55-cb96198cd7a5}',
'{df01c938-4e3d-459e-a8da-fb1c7d885a4a}',
'{d51a7a98-f9b6-467a-908f-ad75d32723a6}',
'{d4dd1504-9f97-4f17-86a4-9eda086a9b3f}',
'{9e3a481a-67e4-42c5-a014-93ec98dd68d7}',
'{447d6475-f8e0-4308-8c43-216294049e51}',
'{738e1e53-78b8-48c6-8baa-1a86ab3d80fd}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{e2243ba8-4e42-4d98-a1ed-fe9c44dbf871}',
'{5dbbdb4b-c68c-4355-95a3-e02096a2047c}',
'{469fa256-5c5c-4404-9a55-cb96198cd7a5}',
'{df01c938-4e3d-459e-a8da-fb1c7d885a4a}',
'{d51a7a98-f9b6-467a-908f-ad75d32723a6}',
'{d4dd1504-9f97-4f17-86a4-9eda086a9b3f}',
'{9e3a481a-67e4-42c5-a014-93ec98dd68d7}',
'{447d6475-f8e0-4308-8c43-216294049e51}',
'{738e1e53-78b8-48c6-8baa-1a86ab3d80fd}'
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{e2243ba8-4e42-4d98-a1ed-fe9c44dbf871}',
'{5dbbdb4b-c68c-4355-95a3-e02096a2047c}',
'{469fa256-5c5c-4404-9a55-cb96198cd7a5}',
'{df01c938-4e3d-459e-a8da-fb1c7d885a4a}',
'{d51a7a98-f9b6-467a-908f-ad75d32723a6}',
'{d4dd1504-9f97-4f17-86a4-9eda086a9b3f}',
'{9e3a481a-67e4-42c5-a014-93ec98dd68d7}',
'{447d6475-f8e0-4308-8c43-216294049e51}',
'{738e1e53-78b8-48c6-8baa-1a86ab3d80fd}'
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{e2243ba8-4e42-4d98-a1ed-fe9c44dbf871}',
'{5dbbdb4b-c68c-4355-95a3-e02096a2047c}',
'{469fa256-5c5c-4404-9a55-cb96198cd7a5}',
'{df01c938-4e3d-459e-a8da-fb1c7d885a4a}',
'{d51a7a98-f9b6-467a-908f-ad75d32723a6}',
'{d4dd1504-9f97-4f17-86a4-9eda086a9b3f}',
'{9e3a481a-67e4-42c5-a014-93ec98dd68d7}',
'{447d6475-f8e0-4308-8c43-216294049e51}',
'{738e1e53-78b8-48c6-8baa-1a86ab3d80fd}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{e2243ba8-4e42-4d98-a1ed-fe9c44dbf871}',
'{5dbbdb4b-c68c-4355-95a3-e02096a2047c}',
'{469fa256-5c5c-4404-9a55-cb96198cd7a5}',
'{df01c938-4e3d-459e-a8da-fb1c7d885a4a}',
'{d51a7a98-f9b6-467a-908f-ad75d32723a6}',
'{d4dd1504-9f97-4f17-86a4-9eda086a9b3f}',
'{9e3a481a-67e4-42c5-a014-93ec98dd68d7}',
'{447d6475-f8e0-4308-8c43-216294049e51}',
'{738e1e53-78b8-48c6-8baa-1a86ab3d80fd}'
);


commit;
