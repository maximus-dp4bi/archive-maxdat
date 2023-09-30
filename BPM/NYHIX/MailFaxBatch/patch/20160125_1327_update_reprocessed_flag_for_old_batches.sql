select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{801c0081-64ba-4872-89ca-d4d129ed7c51}',
'{a9e763f9-c7d9-4d53-b674-16772c52fe0c}',
'{254426e3-f863-459b-94e3-9c2debaa34bc}',
'{45642e18-ffa1-4372-a395-62ba45f45259}',
'{20ffe7c4-29c7-4907-b1f0-6873dd507515}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{801c0081-64ba-4872-89ca-d4d129ed7c51}',
'{a9e763f9-c7d9-4d53-b674-16772c52fe0c}',
'{254426e3-f863-459b-94e3-9c2debaa34bc}',
'{45642e18-ffa1-4372-a395-62ba45f45259}',
'{20ffe7c4-29c7-4907-b1f0-6873dd507515}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{801c0081-64ba-4872-89ca-d4d129ed7c51}',
'{a9e763f9-c7d9-4d53-b674-16772c52fe0c}',
'{254426e3-f863-459b-94e3-9c2debaa34bc}',
'{45642e18-ffa1-4372-a395-62ba45f45259}',
'{20ffe7c4-29c7-4907-b1f0-6873dd507515}'
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{801c0081-64ba-4872-89ca-d4d129ed7c51}',
'{a9e763f9-c7d9-4d53-b674-16772c52fe0c}',
'{254426e3-f863-459b-94e3-9c2debaa34bc}',
'{45642e18-ffa1-4372-a395-62ba45f45259}',
'{20ffe7c4-29c7-4907-b1f0-6873dd507515}'
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{801c0081-64ba-4872-89ca-d4d129ed7c51}',
'{a9e763f9-c7d9-4d53-b674-16772c52fe0c}',
'{254426e3-f863-459b-94e3-9c2debaa34bc}',
'{45642e18-ffa1-4372-a395-62ba45f45259}',
'{20ffe7c4-29c7-4907-b1f0-6873dd507515}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{801c0081-64ba-4872-89ca-d4d129ed7c51}',
'{a9e763f9-c7d9-4d53-b674-16772c52fe0c}',
'{254426e3-f863-459b-94e3-9c2debaa34bc}',
'{45642e18-ffa1-4372-a395-62ba45f45259}',
'{20ffe7c4-29c7-4907-b1f0-6873dd507515}'
);


commit;
