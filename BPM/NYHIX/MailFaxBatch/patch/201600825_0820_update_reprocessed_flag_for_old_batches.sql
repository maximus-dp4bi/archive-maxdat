select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{ee01234d-9ddd-4cee-9416-a0a4b5c7ee3c}',
'{b44b895f-db6f-4429-a011-fbb2c855bef8}',
'{860032a8-c428-4d2b-8676-123d978cdfb4}',
'{c1118931-0f67-4492-a7ee-493d5f6e0fcf}',
'{5b31ace8-9d2c-4f20-b120-93e8aee8adc6}',
'{4c43018a-89c9-4cbb-8a75-d81cfa49b5cb}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{ee01234d-9ddd-4cee-9416-a0a4b5c7ee3c}',
'{b44b895f-db6f-4429-a011-fbb2c855bef8}',
'{860032a8-c428-4d2b-8676-123d978cdfb4}',
'{c1118931-0f67-4492-a7ee-493d5f6e0fcf}',
'{5b31ace8-9d2c-4f20-b120-93e8aee8adc6}',
'{4c43018a-89c9-4cbb-8a75-d81cfa49b5cb}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{ee01234d-9ddd-4cee-9416-a0a4b5c7ee3c}',
'{b44b895f-db6f-4429-a011-fbb2c855bef8}',
'{860032a8-c428-4d2b-8676-123d978cdfb4}',
'{c1118931-0f67-4492-a7ee-493d5f6e0fcf}',
'{5b31ace8-9d2c-4f20-b120-93e8aee8adc6}',
'{4c43018a-89c9-4cbb-8a75-d81cfa49b5cb}'
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{ee01234d-9ddd-4cee-9416-a0a4b5c7ee3c}',
'{b44b895f-db6f-4429-a011-fbb2c855bef8}',
'{860032a8-c428-4d2b-8676-123d978cdfb4}',
'{c1118931-0f67-4492-a7ee-493d5f6e0fcf}',
'{5b31ace8-9d2c-4f20-b120-93e8aee8adc6}',
'{4c43018a-89c9-4cbb-8a75-d81cfa49b5cb}'
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{ee01234d-9ddd-4cee-9416-a0a4b5c7ee3c}',
'{b44b895f-db6f-4429-a011-fbb2c855bef8}',
'{860032a8-c428-4d2b-8676-123d978cdfb4}',
'{c1118931-0f67-4492-a7ee-493d5f6e0fcf}',
'{5b31ace8-9d2c-4f20-b120-93e8aee8adc6}',
'{4c43018a-89c9-4cbb-8a75-d81cfa49b5cb}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{ee01234d-9ddd-4cee-9416-a0a4b5c7ee3c}',
'{b44b895f-db6f-4429-a011-fbb2c855bef8}',
'{860032a8-c428-4d2b-8676-123d978cdfb4}',
'{c1118931-0f67-4492-a7ee-493d5f6e0fcf}',
'{5b31ace8-9d2c-4f20-b120-93e8aee8adc6}',
'{4c43018a-89c9-4cbb-8a75-d81cfa49b5cb}'
);


commit;
