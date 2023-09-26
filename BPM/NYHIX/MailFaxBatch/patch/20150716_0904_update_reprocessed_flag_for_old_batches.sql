select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{4dc7297b-6aaf-491f-bd67-a59e21fa37a5}',
 '{2a1828ff-6cbb-4ad4-8caf-7818e8c51521}',
 '{4f4a6c0e-d15f-4f47-b383-9889323cfe8b}',
 '{01780401-883f-4f13-9108-2e10a393ff62}');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{4dc7297b-6aaf-491f-bd67-a59e21fa37a5}',
 '{2a1828ff-6cbb-4ad4-8caf-7818e8c51521}',
 '{4f4a6c0e-d15f-4f47-b383-9889323cfe8b}',
 '{01780401-883f-4f13-9108-2e10a393ff62}');

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{4dc7297b-6aaf-491f-bd67-a59e21fa37a5}',
 '{2a1828ff-6cbb-4ad4-8caf-7818e8c51521}',
 '{4f4a6c0e-d15f-4f47-b383-9889323cfe8b}',
 '{01780401-883f-4f13-9108-2e10a393ff62}');

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{4dc7297b-6aaf-491f-bd67-a59e21fa37a5}',
 '{2a1828ff-6cbb-4ad4-8caf-7818e8c51521}',
 '{4f4a6c0e-d15f-4f47-b383-9889323cfe8b}',
 '{01780401-883f-4f13-9108-2e10a393ff62}');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{4dc7297b-6aaf-491f-bd67-a59e21fa37a5}',
 '{2a1828ff-6cbb-4ad4-8caf-7818e8c51521}',
 '{4f4a6c0e-d15f-4f47-b383-9889323cfe8b}',
 '{01780401-883f-4f13-9108-2e10a393ff62}');

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{4dc7297b-6aaf-491f-bd67-a59e21fa37a5}',
 '{2a1828ff-6cbb-4ad4-8caf-7818e8c51521}',
 '{4f4a6c0e-d15f-4f47-b383-9889323cfe8b}',
 '{01780401-883f-4f13-9108-2e10a393ff62}');

commit;
