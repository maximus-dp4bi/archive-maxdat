select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{3707c66e-3dc7-4a6d-b686-ba140fc3bfa0}',
'{fe1e3572-fef6-4ce6-9bef-89eb494b38f4}',
'{aad80ed7-b64c-45cd-bdca-bec36f87bae1}',
'{d2de5799-c533-4821-ae57-d4d4ee91c673}',
'{79c21feb-0b84-4f65-9c51-b0f50e52ed8c}',
'{e57bfc23-5024-4f60-9974-1e0d6639697c}',
'{4eb0de56-a56e-4348-bf09-9cdd100c1811}',
'{a12c0e69-2bee-476a-ba26-d26672e6bb73}',
'{be4e57dc-ef27-47c8-a5e1-836e92f9575f}',
'{d18ae0a5-3529-4e59-84cd-659bbc9a565d}',
'{63d41f3c-e1ea-433f-997b-90dcdc335894}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{3707c66e-3dc7-4a6d-b686-ba140fc3bfa0}',
'{fe1e3572-fef6-4ce6-9bef-89eb494b38f4}',
'{aad80ed7-b64c-45cd-bdca-bec36f87bae1}',
'{d2de5799-c533-4821-ae57-d4d4ee91c673}',
'{79c21feb-0b84-4f65-9c51-b0f50e52ed8c}',
'{e57bfc23-5024-4f60-9974-1e0d6639697c}',
'{4eb0de56-a56e-4348-bf09-9cdd100c1811}',
'{a12c0e69-2bee-476a-ba26-d26672e6bb73}',
'{be4e57dc-ef27-47c8-a5e1-836e92f9575f}',
'{d18ae0a5-3529-4e59-84cd-659bbc9a565d}',
'{63d41f3c-e1ea-433f-997b-90dcdc335894}'
);



select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{3707c66e-3dc7-4a6d-b686-ba140fc3bfa0}',
'{fe1e3572-fef6-4ce6-9bef-89eb494b38f4}',
'{aad80ed7-b64c-45cd-bdca-bec36f87bae1}',
'{d2de5799-c533-4821-ae57-d4d4ee91c673}',
'{79c21feb-0b84-4f65-9c51-b0f50e52ed8c}',
'{e57bfc23-5024-4f60-9974-1e0d6639697c}',
'{4eb0de56-a56e-4348-bf09-9cdd100c1811}',
'{a12c0e69-2bee-476a-ba26-d26672e6bb73}',
'{be4e57dc-ef27-47c8-a5e1-836e92f9575f}',
'{d18ae0a5-3529-4e59-84cd-659bbc9a565d}',
'{63d41f3c-e1ea-433f-997b-90dcdc335894}'
);



select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{3707c66e-3dc7-4a6d-b686-ba140fc3bfa0}',
'{fe1e3572-fef6-4ce6-9bef-89eb494b38f4}',
'{aad80ed7-b64c-45cd-bdca-bec36f87bae1}',
'{d2de5799-c533-4821-ae57-d4d4ee91c673}',
'{79c21feb-0b84-4f65-9c51-b0f50e52ed8c}',
'{e57bfc23-5024-4f60-9974-1e0d6639697c}',
'{4eb0de56-a56e-4348-bf09-9cdd100c1811}',
'{a12c0e69-2bee-476a-ba26-d26672e6bb73}',
'{be4e57dc-ef27-47c8-a5e1-836e92f9575f}',
'{d18ae0a5-3529-4e59-84cd-659bbc9a565d}',
'{63d41f3c-e1ea-433f-997b-90dcdc335894}'
);



update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{3707c66e-3dc7-4a6d-b686-ba140fc3bfa0}',
'{fe1e3572-fef6-4ce6-9bef-89eb494b38f4}',
'{aad80ed7-b64c-45cd-bdca-bec36f87bae1}',
'{d2de5799-c533-4821-ae57-d4d4ee91c673}',
'{79c21feb-0b84-4f65-9c51-b0f50e52ed8c}',
'{e57bfc23-5024-4f60-9974-1e0d6639697c}',
'{4eb0de56-a56e-4348-bf09-9cdd100c1811}',
'{a12c0e69-2bee-476a-ba26-d26672e6bb73}',
'{be4e57dc-ef27-47c8-a5e1-836e92f9575f}',
'{d18ae0a5-3529-4e59-84cd-659bbc9a565d}',
'{63d41f3c-e1ea-433f-997b-90dcdc335894}'
);



select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{3707c66e-3dc7-4a6d-b686-ba140fc3bfa0}',
'{fe1e3572-fef6-4ce6-9bef-89eb494b38f4}',
'{aad80ed7-b64c-45cd-bdca-bec36f87bae1}',
'{d2de5799-c533-4821-ae57-d4d4ee91c673}',
'{79c21feb-0b84-4f65-9c51-b0f50e52ed8c}',
'{e57bfc23-5024-4f60-9974-1e0d6639697c}',
'{4eb0de56-a56e-4348-bf09-9cdd100c1811}',
'{a12c0e69-2bee-476a-ba26-d26672e6bb73}',
'{be4e57dc-ef27-47c8-a5e1-836e92f9575f}',
'{d18ae0a5-3529-4e59-84cd-659bbc9a565d}',
'{63d41f3c-e1ea-433f-997b-90dcdc335894}'
);



commit;
