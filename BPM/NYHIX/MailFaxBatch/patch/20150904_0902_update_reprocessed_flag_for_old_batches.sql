select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{338e852a-2c2a-4a77-9e53-70e6489ea708}',
'{36066176-3e06-46bb-86a2-7c5f8657636d}',
'{5784c51e-dbbd-41cc-97bb-35cc485563cf}',
'{98b1bdd6-a1e7-4f8d-b5ca-3abd58c99d5b}',
'{9cb96f9f-1349-44bf-ae3f-856eeef37993}',
'{126a3f10-d67a-4e56-8a68-6d9c34cab4a7}',
'{d8537f61-f563-46ab-8df2-c050f8e29d56}',
'{140a7a46-7b6d-4d13-9f9f-ecc297f3f224}',
'{e58744e1-abc5-490d-8cff-d8ed8f9c7211}',
'{abf3099b-2515-4397-879e-128d56daa6b4}',
'{9d747630-47c1-4ea9-9e9d-2091deec02a2}',
'{09977684-1d59-47e5-b7dd-ff803e681e80}',
'{2e26fbe1-4529-4a37-819c-8cc1a1537cdd}',
'{93246299-5c30-404c-8472-e094331c8a29}',
'{fe2f566d-f0b7-4f17-ba5f-d9a63c7ddbc5}',
'{e4f4cfad-4144-4089-95d9-704ecd5e3337}',
'{08a641ee-45cd-4f23-adb9-595657fb7aec}',
'{5dbff58c-0724-41de-8bd0-666e6cde2a9e}',
'{cf0788d5-fa72-4f5e-806d-24aa9bda236e}',
'{ef601c66-04db-4850-a9ef-56650c61fcd6}',
'{988c40d8-761e-4bfc-b850-de7e15f82195}',
'{fdc01d5b-9ca9-4a1b-819d-8643f88ab517}',
'{52042e0d-bd92-4abb-bcd5-5f27a82393cf}',
'{69a34c6e-fdd7-447d-882b-f4f0957aaf80}',
'{c90a5748-e84b-4330-bdb7-42082d11d8d8}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{338e852a-2c2a-4a77-9e53-70e6489ea708}',
'{36066176-3e06-46bb-86a2-7c5f8657636d}',
'{5784c51e-dbbd-41cc-97bb-35cc485563cf}',
'{98b1bdd6-a1e7-4f8d-b5ca-3abd58c99d5b}',
'{9cb96f9f-1349-44bf-ae3f-856eeef37993}',
'{126a3f10-d67a-4e56-8a68-6d9c34cab4a7}',
'{d8537f61-f563-46ab-8df2-c050f8e29d56}',
'{140a7a46-7b6d-4d13-9f9f-ecc297f3f224}',
'{e58744e1-abc5-490d-8cff-d8ed8f9c7211}',
'{abf3099b-2515-4397-879e-128d56daa6b4}',
'{9d747630-47c1-4ea9-9e9d-2091deec02a2}',
'{09977684-1d59-47e5-b7dd-ff803e681e80}',
'{2e26fbe1-4529-4a37-819c-8cc1a1537cdd}',
'{93246299-5c30-404c-8472-e094331c8a29}',
'{fe2f566d-f0b7-4f17-ba5f-d9a63c7ddbc5}',
'{e4f4cfad-4144-4089-95d9-704ecd5e3337}',
'{08a641ee-45cd-4f23-adb9-595657fb7aec}',
'{5dbff58c-0724-41de-8bd0-666e6cde2a9e}',
'{cf0788d5-fa72-4f5e-806d-24aa9bda236e}',
'{ef601c66-04db-4850-a9ef-56650c61fcd6}',
'{988c40d8-761e-4bfc-b850-de7e15f82195}',
'{fdc01d5b-9ca9-4a1b-819d-8643f88ab517}',
'{52042e0d-bd92-4abb-bcd5-5f27a82393cf}',
'{69a34c6e-fdd7-447d-882b-f4f0957aaf80}',
'{c90a5748-e84b-4330-bdb7-42082d11d8d8}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{338e852a-2c2a-4a77-9e53-70e6489ea708}',
'{36066176-3e06-46bb-86a2-7c5f8657636d}',
'{5784c51e-dbbd-41cc-97bb-35cc485563cf}',
'{98b1bdd6-a1e7-4f8d-b5ca-3abd58c99d5b}',
'{9cb96f9f-1349-44bf-ae3f-856eeef37993}',
'{126a3f10-d67a-4e56-8a68-6d9c34cab4a7}',
'{d8537f61-f563-46ab-8df2-c050f8e29d56}',
'{140a7a46-7b6d-4d13-9f9f-ecc297f3f224}',
'{e58744e1-abc5-490d-8cff-d8ed8f9c7211}',
'{abf3099b-2515-4397-879e-128d56daa6b4}',
'{9d747630-47c1-4ea9-9e9d-2091deec02a2}',
'{09977684-1d59-47e5-b7dd-ff803e681e80}',
'{2e26fbe1-4529-4a37-819c-8cc1a1537cdd}',
'{93246299-5c30-404c-8472-e094331c8a29}',
'{fe2f566d-f0b7-4f17-ba5f-d9a63c7ddbc5}',
'{e4f4cfad-4144-4089-95d9-704ecd5e3337}',
'{08a641ee-45cd-4f23-adb9-595657fb7aec}',
'{5dbff58c-0724-41de-8bd0-666e6cde2a9e}',
'{cf0788d5-fa72-4f5e-806d-24aa9bda236e}',
'{ef601c66-04db-4850-a9ef-56650c61fcd6}',
'{988c40d8-761e-4bfc-b850-de7e15f82195}',
'{fdc01d5b-9ca9-4a1b-819d-8643f88ab517}',
'{52042e0d-bd92-4abb-bcd5-5f27a82393cf}',
'{69a34c6e-fdd7-447d-882b-f4f0957aaf80}',
'{c90a5748-e84b-4330-bdb7-42082d11d8d8}'
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{338e852a-2c2a-4a77-9e53-70e6489ea708}',
'{36066176-3e06-46bb-86a2-7c5f8657636d}',
'{5784c51e-dbbd-41cc-97bb-35cc485563cf}',
'{98b1bdd6-a1e7-4f8d-b5ca-3abd58c99d5b}',
'{9cb96f9f-1349-44bf-ae3f-856eeef37993}',
'{126a3f10-d67a-4e56-8a68-6d9c34cab4a7}',
'{d8537f61-f563-46ab-8df2-c050f8e29d56}',
'{140a7a46-7b6d-4d13-9f9f-ecc297f3f224}',
'{e58744e1-abc5-490d-8cff-d8ed8f9c7211}',
'{abf3099b-2515-4397-879e-128d56daa6b4}',
'{9d747630-47c1-4ea9-9e9d-2091deec02a2}',
'{09977684-1d59-47e5-b7dd-ff803e681e80}',
'{2e26fbe1-4529-4a37-819c-8cc1a1537cdd}',
'{93246299-5c30-404c-8472-e094331c8a29}',
'{fe2f566d-f0b7-4f17-ba5f-d9a63c7ddbc5}',
'{e4f4cfad-4144-4089-95d9-704ecd5e3337}',
'{08a641ee-45cd-4f23-adb9-595657fb7aec}',
'{5dbff58c-0724-41de-8bd0-666e6cde2a9e}',
'{cf0788d5-fa72-4f5e-806d-24aa9bda236e}',
'{ef601c66-04db-4850-a9ef-56650c61fcd6}',
'{988c40d8-761e-4bfc-b850-de7e15f82195}',
'{fdc01d5b-9ca9-4a1b-819d-8643f88ab517}',
'{52042e0d-bd92-4abb-bcd5-5f27a82393cf}',
'{69a34c6e-fdd7-447d-882b-f4f0957aaf80}',
'{c90a5748-e84b-4330-bdb7-42082d11d8d8}'
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{338e852a-2c2a-4a77-9e53-70e6489ea708}',
'{36066176-3e06-46bb-86a2-7c5f8657636d}',
'{5784c51e-dbbd-41cc-97bb-35cc485563cf}',
'{98b1bdd6-a1e7-4f8d-b5ca-3abd58c99d5b}',
'{9cb96f9f-1349-44bf-ae3f-856eeef37993}',
'{126a3f10-d67a-4e56-8a68-6d9c34cab4a7}',
'{d8537f61-f563-46ab-8df2-c050f8e29d56}',
'{140a7a46-7b6d-4d13-9f9f-ecc297f3f224}',
'{e58744e1-abc5-490d-8cff-d8ed8f9c7211}',
'{abf3099b-2515-4397-879e-128d56daa6b4}',
'{9d747630-47c1-4ea9-9e9d-2091deec02a2}',
'{09977684-1d59-47e5-b7dd-ff803e681e80}',
'{2e26fbe1-4529-4a37-819c-8cc1a1537cdd}',
'{93246299-5c30-404c-8472-e094331c8a29}',
'{fe2f566d-f0b7-4f17-ba5f-d9a63c7ddbc5}',
'{e4f4cfad-4144-4089-95d9-704ecd5e3337}',
'{08a641ee-45cd-4f23-adb9-595657fb7aec}',
'{5dbff58c-0724-41de-8bd0-666e6cde2a9e}',
'{cf0788d5-fa72-4f5e-806d-24aa9bda236e}',
'{ef601c66-04db-4850-a9ef-56650c61fcd6}',
'{988c40d8-761e-4bfc-b850-de7e15f82195}',
'{fdc01d5b-9ca9-4a1b-819d-8643f88ab517}',
'{52042e0d-bd92-4abb-bcd5-5f27a82393cf}',
'{69a34c6e-fdd7-447d-882b-f4f0957aaf80}',
'{c90a5748-e84b-4330-bdb7-42082d11d8d8}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{338e852a-2c2a-4a77-9e53-70e6489ea708}',
'{36066176-3e06-46bb-86a2-7c5f8657636d}',
'{5784c51e-dbbd-41cc-97bb-35cc485563cf}',
'{98b1bdd6-a1e7-4f8d-b5ca-3abd58c99d5b}',
'{9cb96f9f-1349-44bf-ae3f-856eeef37993}',
'{126a3f10-d67a-4e56-8a68-6d9c34cab4a7}',
'{d8537f61-f563-46ab-8df2-c050f8e29d56}',
'{140a7a46-7b6d-4d13-9f9f-ecc297f3f224}',
'{e58744e1-abc5-490d-8cff-d8ed8f9c7211}',
'{abf3099b-2515-4397-879e-128d56daa6b4}',
'{9d747630-47c1-4ea9-9e9d-2091deec02a2}',
'{09977684-1d59-47e5-b7dd-ff803e681e80}',
'{2e26fbe1-4529-4a37-819c-8cc1a1537cdd}',
'{93246299-5c30-404c-8472-e094331c8a29}',
'{fe2f566d-f0b7-4f17-ba5f-d9a63c7ddbc5}',
'{e4f4cfad-4144-4089-95d9-704ecd5e3337}',
'{08a641ee-45cd-4f23-adb9-595657fb7aec}',
'{5dbff58c-0724-41de-8bd0-666e6cde2a9e}',
'{cf0788d5-fa72-4f5e-806d-24aa9bda236e}',
'{ef601c66-04db-4850-a9ef-56650c61fcd6}',
'{988c40d8-761e-4bfc-b850-de7e15f82195}',
'{fdc01d5b-9ca9-4a1b-819d-8643f88ab517}',
'{52042e0d-bd92-4abb-bcd5-5f27a82393cf}',
'{69a34c6e-fdd7-447d-882b-f4f0957aaf80}',
'{c90a5748-e84b-4330-bdb7-42082d11d8d8}'
);

commit;
