select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{dcb0b1d5-2a62-4a3e-b799-440026fea32d}',
'{831f990d-6dc6-4730-ba08-34caffaff441}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{dcb0b1d5-2a62-4a3e-b799-440026fea32d}',
'{831f990d-6dc6-4730-ba08-34caffaff441}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{dcb0b1d5-2a62-4a3e-b799-440026fea32d}',
'{831f990d-6dc6-4730-ba08-34caffaff441}'
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{dcb0b1d5-2a62-4a3e-b799-440026fea32d}',
'{831f990d-6dc6-4730-ba08-34caffaff441}'
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{dcb0b1d5-2a62-4a3e-b799-440026fea32d}',
'{831f990d-6dc6-4730-ba08-34caffaff441}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{dcb0b1d5-2a62-4a3e-b799-440026fea32d}',
'{831f990d-6dc6-4730-ba08-34caffaff441}'
);


commit;
