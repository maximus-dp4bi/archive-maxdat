select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{a21f3687-7dbb-4151-b692-5aa66d2ae1d8}',
'{eb4033e3-a060-4b45-b95a-98134cb4c758}',
'{d5b7d5ab-5778-4c46-b28b-411bf0ed82e3}',
'{5daee93e-f705-4be1-a2cc-269098afb757}',
'{e68ff397-e157-45c1-a777-8da9187f0f12}',
'{04f3b406-8a8c-414f-8ee5-4cf2c5beda66}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{a21f3687-7dbb-4151-b692-5aa66d2ae1d8}',
'{eb4033e3-a060-4b45-b95a-98134cb4c758}',
'{d5b7d5ab-5778-4c46-b28b-411bf0ed82e3}',
'{5daee93e-f705-4be1-a2cc-269098afb757}',
'{e68ff397-e157-45c1-a777-8da9187f0f12}',
'{04f3b406-8a8c-414f-8ee5-4cf2c5beda66}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{a21f3687-7dbb-4151-b692-5aa66d2ae1d8}',
'{eb4033e3-a060-4b45-b95a-98134cb4c758}',
'{d5b7d5ab-5778-4c46-b28b-411bf0ed82e3}',
'{5daee93e-f705-4be1-a2cc-269098afb757}',
'{e68ff397-e157-45c1-a777-8da9187f0f12}',
'{04f3b406-8a8c-414f-8ee5-4cf2c5beda66}'
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{a21f3687-7dbb-4151-b692-5aa66d2ae1d8}',
'{eb4033e3-a060-4b45-b95a-98134cb4c758}',
'{d5b7d5ab-5778-4c46-b28b-411bf0ed82e3}',
'{5daee93e-f705-4be1-a2cc-269098afb757}',
'{e68ff397-e157-45c1-a777-8da9187f0f12}',
'{04f3b406-8a8c-414f-8ee5-4cf2c5beda66}'
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{a21f3687-7dbb-4151-b692-5aa66d2ae1d8}',
'{eb4033e3-a060-4b45-b95a-98134cb4c758}',
'{d5b7d5ab-5778-4c46-b28b-411bf0ed82e3}',
'{5daee93e-f705-4be1-a2cc-269098afb757}',
'{e68ff397-e157-45c1-a777-8da9187f0f12}',
'{04f3b406-8a8c-414f-8ee5-4cf2c5beda66}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{a21f3687-7dbb-4151-b692-5aa66d2ae1d8}',
'{eb4033e3-a060-4b45-b95a-98134cb4c758}',
'{d5b7d5ab-5778-4c46-b28b-411bf0ed82e3}',
'{5daee93e-f705-4be1-a2cc-269098afb757}',
'{e68ff397-e157-45c1-a777-8da9187f0f12}',
'{04f3b406-8a8c-414f-8ee5-4cf2c5beda66}'
);


commit;
