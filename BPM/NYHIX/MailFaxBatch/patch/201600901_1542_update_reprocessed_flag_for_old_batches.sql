select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{77d33d89-adc1-46a6-b8e1-2b7b144dcd03}',
'{dae246fe-2e40-482b-a6a9-0f728162905f}',
'{8a1defe2-93d6-4294-8cf5-cec274a3ff65}',
'{aa63212b-ebcf-4e17-a249-f72e4cf26594}',
'{2087957d-7b32-4d1e-a540-24b827b94eb3}',
'{3ebf7655-93d3-4c88-a8d2-07848a38c28b}',
'{4c4329a9-c79e-4da7-b8b4-965b0a4e0d0f}',
'{13a68f6d-05b0-44b9-b815-5e9c883f4c42}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{77d33d89-adc1-46a6-b8e1-2b7b144dcd03}',
'{dae246fe-2e40-482b-a6a9-0f728162905f}',
'{8a1defe2-93d6-4294-8cf5-cec274a3ff65}',
'{aa63212b-ebcf-4e17-a249-f72e4cf26594}',
'{2087957d-7b32-4d1e-a540-24b827b94eb3}',
'{3ebf7655-93d3-4c88-a8d2-07848a38c28b}',
'{4c4329a9-c79e-4da7-b8b4-965b0a4e0d0f}',
'{13a68f6d-05b0-44b9-b815-5e9c883f4c42}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{77d33d89-adc1-46a6-b8e1-2b7b144dcd03}',
'{dae246fe-2e40-482b-a6a9-0f728162905f}',
'{8a1defe2-93d6-4294-8cf5-cec274a3ff65}',
'{aa63212b-ebcf-4e17-a249-f72e4cf26594}',
'{2087957d-7b32-4d1e-a540-24b827b94eb3}',
'{3ebf7655-93d3-4c88-a8d2-07848a38c28b}',
'{4c4329a9-c79e-4da7-b8b4-965b0a4e0d0f}',
'{13a68f6d-05b0-44b9-b815-5e9c883f4c42}'
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{77d33d89-adc1-46a6-b8e1-2b7b144dcd03}',
'{dae246fe-2e40-482b-a6a9-0f728162905f}',
'{8a1defe2-93d6-4294-8cf5-cec274a3ff65}',
'{aa63212b-ebcf-4e17-a249-f72e4cf26594}',
'{2087957d-7b32-4d1e-a540-24b827b94eb3}',
'{3ebf7655-93d3-4c88-a8d2-07848a38c28b}',
'{4c4329a9-c79e-4da7-b8b4-965b0a4e0d0f}',
'{13a68f6d-05b0-44b9-b815-5e9c883f4c42}'
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{77d33d89-adc1-46a6-b8e1-2b7b144dcd03}',
'{dae246fe-2e40-482b-a6a9-0f728162905f}',
'{8a1defe2-93d6-4294-8cf5-cec274a3ff65}',
'{aa63212b-ebcf-4e17-a249-f72e4cf26594}',
'{2087957d-7b32-4d1e-a540-24b827b94eb3}',
'{3ebf7655-93d3-4c88-a8d2-07848a38c28b}',
'{4c4329a9-c79e-4da7-b8b4-965b0a4e0d0f}',
'{13a68f6d-05b0-44b9-b815-5e9c883f4c42}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{77d33d89-adc1-46a6-b8e1-2b7b144dcd03}',
'{dae246fe-2e40-482b-a6a9-0f728162905f}',
'{8a1defe2-93d6-4294-8cf5-cec274a3ff65}',
'{aa63212b-ebcf-4e17-a249-f72e4cf26594}',
'{2087957d-7b32-4d1e-a540-24b827b94eb3}',
'{3ebf7655-93d3-4c88-a8d2-07848a38c28b}',
'{4c4329a9-c79e-4da7-b8b4-965b0a4e0d0f}',
'{13a68f6d-05b0-44b9-b815-5e9c883f4c42}'
);


commit;
