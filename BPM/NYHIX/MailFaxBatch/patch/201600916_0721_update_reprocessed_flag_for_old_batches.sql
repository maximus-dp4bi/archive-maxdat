select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{1d0c81ab-2273-4601-b02c-65e85b46d0a5}',
'{ace49cf0-342b-4a40-8b30-6b8340e02267}',
'{51a6ecc5-bb77-4a64-b07b-445d958fa0dd}',
'{daa169ad-ea4f-42f9-9ef0-3584c88ef646}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{1d0c81ab-2273-4601-b02c-65e85b46d0a5}',
'{ace49cf0-342b-4a40-8b30-6b8340e02267}',
'{51a6ecc5-bb77-4a64-b07b-445d958fa0dd}',
'{daa169ad-ea4f-42f9-9ef0-3584c88ef646}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{1d0c81ab-2273-4601-b02c-65e85b46d0a5}',
'{ace49cf0-342b-4a40-8b30-6b8340e02267}',
'{51a6ecc5-bb77-4a64-b07b-445d958fa0dd}',
'{daa169ad-ea4f-42f9-9ef0-3584c88ef646}'
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{1d0c81ab-2273-4601-b02c-65e85b46d0a5}',
'{ace49cf0-342b-4a40-8b30-6b8340e02267}',
'{51a6ecc5-bb77-4a64-b07b-445d958fa0dd}',
'{daa169ad-ea4f-42f9-9ef0-3584c88ef646}'
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{1d0c81ab-2273-4601-b02c-65e85b46d0a5}',
'{ace49cf0-342b-4a40-8b30-6b8340e02267}',
'{51a6ecc5-bb77-4a64-b07b-445d958fa0dd}',
'{daa169ad-ea4f-42f9-9ef0-3584c88ef646}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{1d0c81ab-2273-4601-b02c-65e85b46d0a5}',
'{ace49cf0-342b-4a40-8b30-6b8340e02267}',
'{51a6ecc5-bb77-4a64-b07b-445d958fa0dd}',
'{daa169ad-ea4f-42f9-9ef0-3584c88ef646}'
);


commit;
