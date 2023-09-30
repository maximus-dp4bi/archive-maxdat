select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{d4d7e1db-3582-47f6-bf44-ff698f65e0b1}',
'{f07131fc-29e2-49a0-ab15-42f585abf62a}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{d4d7e1db-3582-47f6-bf44-ff698f65e0b1}',
'{f07131fc-29e2-49a0-ab15-42f585abf62a}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{d4d7e1db-3582-47f6-bf44-ff698f65e0b1}',
'{f07131fc-29e2-49a0-ab15-42f585abf62a}'
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{d4d7e1db-3582-47f6-bf44-ff698f65e0b1}',
'{f07131fc-29e2-49a0-ab15-42f585abf62a}'
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{d4d7e1db-3582-47f6-bf44-ff698f65e0b1}',
'{f07131fc-29e2-49a0-ab15-42f585abf62a}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{d4d7e1db-3582-47f6-bf44-ff698f65e0b1}',
'{f07131fc-29e2-49a0-ab15-42f585abf62a}'
);

commit;
