select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{1f9176a3-3f3b-479b-a053-89623dcf962f}',
'{912edd6c-7edc-4b10-8933-a693d0f06b6c}',
'{c055fca8-d906-4185-83cb-a1a2bc7fc21b}',
'{08bb8798-4f3c-414d-9dd6-61b9ab4f179f}',
'{e898bab5-0217-43e8-8de1-feb17b50469b}',
'{ca2cedd0-af52-4b67-8cc4-5e126975a560}',
'{a47fb6af-efcd-45c7-8038-a65d2022942e}',
'{ddb443e9-729a-454b-8e77-ab0b71c325c0}',
'{9c14efc6-7da1-4b5e-bbb8-79dac7cad1e7}',
'{1fcccf85-277e-4dbe-a0da-8b8b664ea079}' 
);


update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{1f9176a3-3f3b-479b-a053-89623dcf962f}',
'{912edd6c-7edc-4b10-8933-a693d0f06b6c}',
'{c055fca8-d906-4185-83cb-a1a2bc7fc21b}',
'{08bb8798-4f3c-414d-9dd6-61b9ab4f179f}',
'{e898bab5-0217-43e8-8de1-feb17b50469b}',
'{ca2cedd0-af52-4b67-8cc4-5e126975a560}',
'{a47fb6af-efcd-45c7-8038-a65d2022942e}',
'{ddb443e9-729a-454b-8e77-ab0b71c325c0}',
'{9c14efc6-7da1-4b5e-bbb8-79dac7cad1e7}',
'{1fcccf85-277e-4dbe-a0da-8b8b664ea079}' 
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{1f9176a3-3f3b-479b-a053-89623dcf962f}',
'{912edd6c-7edc-4b10-8933-a693d0f06b6c}',
'{c055fca8-d906-4185-83cb-a1a2bc7fc21b}',
'{08bb8798-4f3c-414d-9dd6-61b9ab4f179f}',
'{e898bab5-0217-43e8-8de1-feb17b50469b}',
'{ca2cedd0-af52-4b67-8cc4-5e126975a560}',
'{a47fb6af-efcd-45c7-8038-a65d2022942e}',
'{ddb443e9-729a-454b-8e77-ab0b71c325c0}',
'{9c14efc6-7da1-4b5e-bbb8-79dac7cad1e7}',
'{1fcccf85-277e-4dbe-a0da-8b8b664ea079}' 
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{1f9176a3-3f3b-479b-a053-89623dcf962f}',
'{912edd6c-7edc-4b10-8933-a693d0f06b6c}',
'{c055fca8-d906-4185-83cb-a1a2bc7fc21b}',
'{08bb8798-4f3c-414d-9dd6-61b9ab4f179f}',
'{e898bab5-0217-43e8-8de1-feb17b50469b}',
'{ca2cedd0-af52-4b67-8cc4-5e126975a560}',
'{a47fb6af-efcd-45c7-8038-a65d2022942e}',
'{ddb443e9-729a-454b-8e77-ab0b71c325c0}',
'{9c14efc6-7da1-4b5e-bbb8-79dac7cad1e7}',
'{1fcccf85-277e-4dbe-a0da-8b8b664ea079}' 
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{1f9176a3-3f3b-479b-a053-89623dcf962f}',
'{912edd6c-7edc-4b10-8933-a693d0f06b6c}',
'{c055fca8-d906-4185-83cb-a1a2bc7fc21b}',
'{08bb8798-4f3c-414d-9dd6-61b9ab4f179f}',
'{e898bab5-0217-43e8-8de1-feb17b50469b}',
'{ca2cedd0-af52-4b67-8cc4-5e126975a560}',
'{a47fb6af-efcd-45c7-8038-a65d2022942e}',
'{ddb443e9-729a-454b-8e77-ab0b71c325c0}',
'{9c14efc6-7da1-4b5e-bbb8-79dac7cad1e7}',
'{1fcccf85-277e-4dbe-a0da-8b8b664ea079}' 
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{1f9176a3-3f3b-479b-a053-89623dcf962f}',
'{912edd6c-7edc-4b10-8933-a693d0f06b6c}',
'{c055fca8-d906-4185-83cb-a1a2bc7fc21b}',
'{08bb8798-4f3c-414d-9dd6-61b9ab4f179f}',
'{e898bab5-0217-43e8-8de1-feb17b50469b}',
'{ca2cedd0-af52-4b67-8cc4-5e126975a560}',
'{a47fb6af-efcd-45c7-8038-a65d2022942e}',
'{ddb443e9-729a-454b-8e77-ab0b71c325c0}',
'{9c14efc6-7da1-4b5e-bbb8-79dac7cad1e7}',
'{1fcccf85-277e-4dbe-a0da-8b8b664ea079}' 
);


commit;
