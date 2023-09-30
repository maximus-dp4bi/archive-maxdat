select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{a7c56878-823f-4643-93a4-5eae7efe5202}',
'{1289a2e2-d62d-4b78-b5fc-5e8d3be9c35a}',
'{34a753c2-dc13-44ab-9ace-e86f19ad3f67}',
'{a66f8d4f-e9df-47eb-80e8-90b48ef94b3c}',
'{4ce13241-b483-4e1e-b6f1-a497916f1ab1}',
'{a04a79f0-1f65-4bf3-b99b-a39e894504a5}',
'{c8831577-358e-4d70-87a8-afea3102f4a6}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{a7c56878-823f-4643-93a4-5eae7efe5202}',
'{1289a2e2-d62d-4b78-b5fc-5e8d3be9c35a}',
'{34a753c2-dc13-44ab-9ace-e86f19ad3f67}',
'{a66f8d4f-e9df-47eb-80e8-90b48ef94b3c}',
'{4ce13241-b483-4e1e-b6f1-a497916f1ab1}',
'{a04a79f0-1f65-4bf3-b99b-a39e894504a5}',
'{c8831577-358e-4d70-87a8-afea3102f4a6}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{a7c56878-823f-4643-93a4-5eae7efe5202}',
'{1289a2e2-d62d-4b78-b5fc-5e8d3be9c35a}',
'{34a753c2-dc13-44ab-9ace-e86f19ad3f67}',
'{a66f8d4f-e9df-47eb-80e8-90b48ef94b3c}',
'{4ce13241-b483-4e1e-b6f1-a497916f1ab1}',
'{a04a79f0-1f65-4bf3-b99b-a39e894504a5}',
'{c8831577-358e-4d70-87a8-afea3102f4a6}'
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{a7c56878-823f-4643-93a4-5eae7efe5202}',
'{1289a2e2-d62d-4b78-b5fc-5e8d3be9c35a}',
'{34a753c2-dc13-44ab-9ace-e86f19ad3f67}',
'{a66f8d4f-e9df-47eb-80e8-90b48ef94b3c}',
'{4ce13241-b483-4e1e-b6f1-a497916f1ab1}',
'{a04a79f0-1f65-4bf3-b99b-a39e894504a5}',
'{c8831577-358e-4d70-87a8-afea3102f4a6}'
);
update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{a7c56878-823f-4643-93a4-5eae7efe5202}',
'{1289a2e2-d62d-4b78-b5fc-5e8d3be9c35a}',
'{34a753c2-dc13-44ab-9ace-e86f19ad3f67}',
'{a66f8d4f-e9df-47eb-80e8-90b48ef94b3c}',
'{4ce13241-b483-4e1e-b6f1-a497916f1ab1}',
'{a04a79f0-1f65-4bf3-b99b-a39e894504a5}',
'{c8831577-358e-4d70-87a8-afea3102f4a6}'
);
select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{a7c56878-823f-4643-93a4-5eae7efe5202}',
'{1289a2e2-d62d-4b78-b5fc-5e8d3be9c35a}',
'{34a753c2-dc13-44ab-9ace-e86f19ad3f67}',
'{a66f8d4f-e9df-47eb-80e8-90b48ef94b3c}',
'{4ce13241-b483-4e1e-b6f1-a497916f1ab1}',
'{a04a79f0-1f65-4bf3-b99b-a39e894504a5}',
'{c8831577-358e-4d70-87a8-afea3102f4a6}'
);

commit;
