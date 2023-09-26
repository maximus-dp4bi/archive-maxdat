select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{f844a04a-d965-47d4-b073-d1b40722b129}',
'{d5e88931-eaa4-4042-b603-b7143ab100e5}',
'{ebe68876-92eb-49f3-bfa3-838582f1255f}',
'{5ee81526-59ff-4966-96cb-d280c99047ea}',
'{84592328-0699-49f6-8e89-68394ca15226}',
'{6ae9ac5c-0c02-4e9c-9fba-148fde6566fb}',
'{4cea276e-77b0-40bd-b2b1-1f2e20de7c3c}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{f844a04a-d965-47d4-b073-d1b40722b129}',
'{d5e88931-eaa4-4042-b603-b7143ab100e5}',
'{ebe68876-92eb-49f3-bfa3-838582f1255f}',
'{5ee81526-59ff-4966-96cb-d280c99047ea}',
'{84592328-0699-49f6-8e89-68394ca15226}',
'{6ae9ac5c-0c02-4e9c-9fba-148fde6566fb}',
'{4cea276e-77b0-40bd-b2b1-1f2e20de7c3c}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{f844a04a-d965-47d4-b073-d1b40722b129}',
'{d5e88931-eaa4-4042-b603-b7143ab100e5}',
'{ebe68876-92eb-49f3-bfa3-838582f1255f}',
'{5ee81526-59ff-4966-96cb-d280c99047ea}',
'{84592328-0699-49f6-8e89-68394ca15226}',
'{6ae9ac5c-0c02-4e9c-9fba-148fde6566fb}',
'{4cea276e-77b0-40bd-b2b1-1f2e20de7c3c}'
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{f844a04a-d965-47d4-b073-d1b40722b129}',
'{d5e88931-eaa4-4042-b603-b7143ab100e5}',
'{ebe68876-92eb-49f3-bfa3-838582f1255f}',
'{5ee81526-59ff-4966-96cb-d280c99047ea}',
'{84592328-0699-49f6-8e89-68394ca15226}',
'{6ae9ac5c-0c02-4e9c-9fba-148fde6566fb}',
'{4cea276e-77b0-40bd-b2b1-1f2e20de7c3c}'
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{f844a04a-d965-47d4-b073-d1b40722b129}',
'{d5e88931-eaa4-4042-b603-b7143ab100e5}',
'{ebe68876-92eb-49f3-bfa3-838582f1255f}',
'{5ee81526-59ff-4966-96cb-d280c99047ea}',
'{84592328-0699-49f6-8e89-68394ca15226}',
'{6ae9ac5c-0c02-4e9c-9fba-148fde6566fb}',
'{4cea276e-77b0-40bd-b2b1-1f2e20de7c3c}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{f844a04a-d965-47d4-b073-d1b40722b129}',
'{d5e88931-eaa4-4042-b603-b7143ab100e5}',
'{ebe68876-92eb-49f3-bfa3-838582f1255f}',
'{5ee81526-59ff-4966-96cb-d280c99047ea}',
'{84592328-0699-49f6-8e89-68394ca15226}',
'{6ae9ac5c-0c02-4e9c-9fba-148fde6566fb}',
'{4cea276e-77b0-40bd-b2b1-1f2e20de7c3c}'
);

commit;
