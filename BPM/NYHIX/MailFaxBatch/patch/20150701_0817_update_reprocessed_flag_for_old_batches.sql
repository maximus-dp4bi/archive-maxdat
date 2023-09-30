select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{7c905624-4a3c-4d3c-9fec-f740ac838e81}',
'{727d6b68-21f2-4e0a-8a0b-589bfca8c8b6}');


update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{7c905624-4a3c-4d3c-9fec-f740ac838e81}',
'{727d6b68-21f2-4e0a-8a0b-589bfca8c8b6}');

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{7c905624-4a3c-4d3c-9fec-f740ac838e81}',
'{727d6b68-21f2-4e0a-8a0b-589bfca8c8b6}');

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{7c905624-4a3c-4d3c-9fec-f740ac838e81}',
'{727d6b68-21f2-4e0a-8a0b-589bfca8c8b6}');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{7c905624-4a3c-4d3c-9fec-f740ac838e81}',
'{727d6b68-21f2-4e0a-8a0b-589bfca8c8b6}');

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{7c905624-4a3c-4d3c-9fec-f740ac838e81}',
'{727d6b68-21f2-4e0a-8a0b-589bfca8c8b6}');

commit;
