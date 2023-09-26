select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{2a8ad25c-48e9-4419-a132-d87db9d89d6a}',
'{2f029f5c-1d12-4186-9234-a58d6c4ebdf0}',
'{c7a20fcd-f071-4654-ba35-de55b00e68a4}',
'{6aff864a-1c74-48b2-83df-057f805cd2da}',
'{43c67905-844a-4f8e-82c9-f5c41c6cd714}',
'{4dc7297b-6aaf-491f-bd67-a59e21fa37a5}',
'{01780401-883f-4f13-9108-2e10a393ff62}',
'{03fbaf5a-ea72-4f50-af6d-724da0ffe5e9}',
'{59a61126-dde8-4e7d-8a67-c1a0d69102b4}',
'{eddb6a4e-ff1d-43c6-ba0d-8b4e69ea2fd1}',
'{2a1828ff-6cbb-4ad4-8caf-7818e8c51521}',
'{4f4a6c0e-d15f-4f47-b383-9889323cfe8b}',
'{8414014d-d420-428f-a726-0a8a6da2c9b4}',
'{e87fb108-18f5-4e8f-94dd-6f03bcdb54f1}',
'{567e724e-b67a-4590-b6b8-2e3ceca4f0c5}');


update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{2a8ad25c-48e9-4419-a132-d87db9d89d6a}',
'{2f029f5c-1d12-4186-9234-a58d6c4ebdf0}',
'{c7a20fcd-f071-4654-ba35-de55b00e68a4}',
'{6aff864a-1c74-48b2-83df-057f805cd2da}',
'{43c67905-844a-4f8e-82c9-f5c41c6cd714}',
'{4dc7297b-6aaf-491f-bd67-a59e21fa37a5}',
'{01780401-883f-4f13-9108-2e10a393ff62}',
'{03fbaf5a-ea72-4f50-af6d-724da0ffe5e9}',
'{59a61126-dde8-4e7d-8a67-c1a0d69102b4}',
'{eddb6a4e-ff1d-43c6-ba0d-8b4e69ea2fd1}',
'{2a1828ff-6cbb-4ad4-8caf-7818e8c51521}',
'{4f4a6c0e-d15f-4f47-b383-9889323cfe8b}',
'{8414014d-d420-428f-a726-0a8a6da2c9b4}',
'{e87fb108-18f5-4e8f-94dd-6f03bcdb54f1}',
'{567e724e-b67a-4590-b6b8-2e3ceca4f0c5}');

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{2a8ad25c-48e9-4419-a132-d87db9d89d6a}',
'{2f029f5c-1d12-4186-9234-a58d6c4ebdf0}',
'{c7a20fcd-f071-4654-ba35-de55b00e68a4}',
'{6aff864a-1c74-48b2-83df-057f805cd2da}',
'{43c67905-844a-4f8e-82c9-f5c41c6cd714}',
'{4dc7297b-6aaf-491f-bd67-a59e21fa37a5}',
'{01780401-883f-4f13-9108-2e10a393ff62}',
'{03fbaf5a-ea72-4f50-af6d-724da0ffe5e9}',
'{59a61126-dde8-4e7d-8a67-c1a0d69102b4}',
'{eddb6a4e-ff1d-43c6-ba0d-8b4e69ea2fd1}',
'{2a1828ff-6cbb-4ad4-8caf-7818e8c51521}',
'{4f4a6c0e-d15f-4f47-b383-9889323cfe8b}',
'{8414014d-d420-428f-a726-0a8a6da2c9b4}',
'{e87fb108-18f5-4e8f-94dd-6f03bcdb54f1}',
'{567e724e-b67a-4590-b6b8-2e3ceca4f0c5}');

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{2a8ad25c-48e9-4419-a132-d87db9d89d6a}',
'{2f029f5c-1d12-4186-9234-a58d6c4ebdf0}',
'{c7a20fcd-f071-4654-ba35-de55b00e68a4}',
'{6aff864a-1c74-48b2-83df-057f805cd2da}',
'{43c67905-844a-4f8e-82c9-f5c41c6cd714}',
'{4dc7297b-6aaf-491f-bd67-a59e21fa37a5}',
'{01780401-883f-4f13-9108-2e10a393ff62}',
'{03fbaf5a-ea72-4f50-af6d-724da0ffe5e9}',
'{59a61126-dde8-4e7d-8a67-c1a0d69102b4}',
'{eddb6a4e-ff1d-43c6-ba0d-8b4e69ea2fd1}',
'{2a1828ff-6cbb-4ad4-8caf-7818e8c51521}',
'{4f4a6c0e-d15f-4f47-b383-9889323cfe8b}',
'{8414014d-d420-428f-a726-0a8a6da2c9b4}',
'{e87fb108-18f5-4e8f-94dd-6f03bcdb54f1}',
'{567e724e-b67a-4590-b6b8-2e3ceca4f0c5}');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{2a8ad25c-48e9-4419-a132-d87db9d89d6a}',
'{2f029f5c-1d12-4186-9234-a58d6c4ebdf0}',
'{c7a20fcd-f071-4654-ba35-de55b00e68a4}',
'{6aff864a-1c74-48b2-83df-057f805cd2da}',
'{43c67905-844a-4f8e-82c9-f5c41c6cd714}',
'{4dc7297b-6aaf-491f-bd67-a59e21fa37a5}',
'{01780401-883f-4f13-9108-2e10a393ff62}',
'{03fbaf5a-ea72-4f50-af6d-724da0ffe5e9}',
'{59a61126-dde8-4e7d-8a67-c1a0d69102b4}',
'{eddb6a4e-ff1d-43c6-ba0d-8b4e69ea2fd1}',
'{2a1828ff-6cbb-4ad4-8caf-7818e8c51521}',
'{4f4a6c0e-d15f-4f47-b383-9889323cfe8b}',
'{8414014d-d420-428f-a726-0a8a6da2c9b4}',
'{e87fb108-18f5-4e8f-94dd-6f03bcdb54f1}',
'{567e724e-b67a-4590-b6b8-2e3ceca4f0c5}');

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{2a8ad25c-48e9-4419-a132-d87db9d89d6a}',
'{2f029f5c-1d12-4186-9234-a58d6c4ebdf0}',
'{c7a20fcd-f071-4654-ba35-de55b00e68a4}',
'{6aff864a-1c74-48b2-83df-057f805cd2da}',
'{43c67905-844a-4f8e-82c9-f5c41c6cd714}',
'{4dc7297b-6aaf-491f-bd67-a59e21fa37a5}',
'{01780401-883f-4f13-9108-2e10a393ff62}',
'{03fbaf5a-ea72-4f50-af6d-724da0ffe5e9}',
'{59a61126-dde8-4e7d-8a67-c1a0d69102b4}',
'{eddb6a4e-ff1d-43c6-ba0d-8b4e69ea2fd1}',
'{2a1828ff-6cbb-4ad4-8caf-7818e8c51521}',
'{4f4a6c0e-d15f-4f47-b383-9889323cfe8b}',
'{8414014d-d420-428f-a726-0a8a6da2c9b4}',
'{e87fb108-18f5-4e8f-94dd-6f03bcdb54f1}',
'{567e724e-b67a-4590-b6b8-2e3ceca4f0c5}');

commit;
