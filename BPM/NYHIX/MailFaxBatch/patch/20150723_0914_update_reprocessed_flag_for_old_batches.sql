select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{056e817d-069a-4c3a-9f7b-5f7fa30ed5d4}',
'{0dd3bca6-18d0-4aac-9828-e6bcfdfc48d7}',
'{0e609836-1458-48cc-9207-277eb87e86e6}',
'{22aca03d-82fd-4c86-8471-8202cb05f22b}',
'{2fc3946c-8339-4be4-984c-b3591e11709f}',
'{32aee02e-0be9-4f3a-81a1-499d4bd19591}',
'{3d49fcec-e6cc-412a-83cd-25f571d87371}',
'{566427e5-4ddf-418a-b9f4-27a46f5c065a}',
'{5ba2e772-4415-4645-808b-8106949b8ca4}',
'{96985e08-6c08-40bc-9bf2-cdfe4361506f}',
'{a74e0051-856b-415a-a880-2d1812861921}',
'{a77cea59-5254-45e4-b64d-ee386a8d125f}',
'{f55e2dec-79a1-4c5e-bf19-cc3b5b913586}',
'{fe21d088-324c-4700-bc0e-7301538fe0ec}',
'{00344b98-48c4-49ab-b8ea-983d10756c10}',
'{08b593f7-b147-4c51-be91-f4a35691b322}',
'{0faf58d7-54a6-4e96-b141-f5d38314a06a}',
'{1505319d-4bc2-46fe-aa94-7af99c887e01}',
'{2039965f-a5ff-4e1a-ab61-40efc2b256d6}',
'{266a814e-1b7e-4fa8-9dd8-15d74af720e5}',
'{30d47a94-c0f6-47a5-a194-c8021c0e4fd0}',
'{34196655-4141-487a-bc85-4a3c8e637f3e}',
'{3ab5ef45-d860-45c2-b5f4-b3a6ab172922}',
'{415b81da-9cf5-4865-87fa-aee664d72f9d}',
'{5153a73a-594c-429d-8a42-a1906e98235c}',
'{61f6ab45-9dbf-4f30-8466-af40b6192d39}',
'{6b32f1d4-2b71-45a3-9a8a-3770bacbd5de}',
'{70faa75d-771e-4cab-b147-e785132221a7}',
'{78b8602f-836e-4140-9a70-bf910d399919}',
'{7d70ca6e-9efe-4c10-8d8f-a7c663bc1bd1}',
'{98bdac30-c0b4-4ed1-95e9-b042f4a4d5a1}',
'{9a6c94f3-5788-4820-a900-a6a46cad8a14}',
'{9bd78ff3-01c6-4d48-b051-56bdf13b1164}',
'{a2cc6d4e-940f-4b65-b3b5-46e583b91a26}',
'{d5327d28-efbc-4dbe-b600-857a385785cd}',
'{09e6be40-8578-42de-9aa9-7070067ad4e7}',
'{20378180-b8b8-4b33-8ddf-458f97cb8c2f}',
'{6f01ed6a-f21c-4e96-8b22-984b9329eee0}',
'{ad37d043-94d0-43a3-8f42-38c353f68e9e}',
'{b0b40969-f1b8-4bfd-aa42-b636ddf754c3}',
'{c884f03f-b096-45ff-a76d-593cb9c175de}',
'{f1447fa3-3e1e-4d93-87c5-6701ebd061b8}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{056e817d-069a-4c3a-9f7b-5f7fa30ed5d4}',
'{0dd3bca6-18d0-4aac-9828-e6bcfdfc48d7}',
'{0e609836-1458-48cc-9207-277eb87e86e6}',
'{22aca03d-82fd-4c86-8471-8202cb05f22b}',
'{2fc3946c-8339-4be4-984c-b3591e11709f}',
'{32aee02e-0be9-4f3a-81a1-499d4bd19591}',
'{3d49fcec-e6cc-412a-83cd-25f571d87371}',
'{566427e5-4ddf-418a-b9f4-27a46f5c065a}',
'{5ba2e772-4415-4645-808b-8106949b8ca4}',
'{96985e08-6c08-40bc-9bf2-cdfe4361506f}',
'{a74e0051-856b-415a-a880-2d1812861921}',
'{a77cea59-5254-45e4-b64d-ee386a8d125f}',
'{f55e2dec-79a1-4c5e-bf19-cc3b5b913586}',
'{fe21d088-324c-4700-bc0e-7301538fe0ec}',
'{00344b98-48c4-49ab-b8ea-983d10756c10}',
'{08b593f7-b147-4c51-be91-f4a35691b322}',
'{0faf58d7-54a6-4e96-b141-f5d38314a06a}',
'{1505319d-4bc2-46fe-aa94-7af99c887e01}',
'{2039965f-a5ff-4e1a-ab61-40efc2b256d6}',
'{266a814e-1b7e-4fa8-9dd8-15d74af720e5}',
'{30d47a94-c0f6-47a5-a194-c8021c0e4fd0}',
'{34196655-4141-487a-bc85-4a3c8e637f3e}',
'{3ab5ef45-d860-45c2-b5f4-b3a6ab172922}',
'{415b81da-9cf5-4865-87fa-aee664d72f9d}',
'{5153a73a-594c-429d-8a42-a1906e98235c}',
'{61f6ab45-9dbf-4f30-8466-af40b6192d39}',
'{6b32f1d4-2b71-45a3-9a8a-3770bacbd5de}',
'{70faa75d-771e-4cab-b147-e785132221a7}',
'{78b8602f-836e-4140-9a70-bf910d399919}',
'{7d70ca6e-9efe-4c10-8d8f-a7c663bc1bd1}',
'{98bdac30-c0b4-4ed1-95e9-b042f4a4d5a1}',
'{9a6c94f3-5788-4820-a900-a6a46cad8a14}',
'{9bd78ff3-01c6-4d48-b051-56bdf13b1164}',
'{a2cc6d4e-940f-4b65-b3b5-46e583b91a26}',
'{d5327d28-efbc-4dbe-b600-857a385785cd}',
'{09e6be40-8578-42de-9aa9-7070067ad4e7}',
'{20378180-b8b8-4b33-8ddf-458f97cb8c2f}',
'{6f01ed6a-f21c-4e96-8b22-984b9329eee0}',
'{ad37d043-94d0-43a3-8f42-38c353f68e9e}',
'{b0b40969-f1b8-4bfd-aa42-b636ddf754c3}',
'{c884f03f-b096-45ff-a76d-593cb9c175de}',
'{f1447fa3-3e1e-4d93-87c5-6701ebd061b8}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{056e817d-069a-4c3a-9f7b-5f7fa30ed5d4}',
'{0dd3bca6-18d0-4aac-9828-e6bcfdfc48d7}',
'{0e609836-1458-48cc-9207-277eb87e86e6}',
'{22aca03d-82fd-4c86-8471-8202cb05f22b}',
'{2fc3946c-8339-4be4-984c-b3591e11709f}',
'{32aee02e-0be9-4f3a-81a1-499d4bd19591}',
'{3d49fcec-e6cc-412a-83cd-25f571d87371}',
'{566427e5-4ddf-418a-b9f4-27a46f5c065a}',
'{5ba2e772-4415-4645-808b-8106949b8ca4}',
'{96985e08-6c08-40bc-9bf2-cdfe4361506f}',
'{a74e0051-856b-415a-a880-2d1812861921}',
'{a77cea59-5254-45e4-b64d-ee386a8d125f}',
'{f55e2dec-79a1-4c5e-bf19-cc3b5b913586}',
'{fe21d088-324c-4700-bc0e-7301538fe0ec}',
'{00344b98-48c4-49ab-b8ea-983d10756c10}',
'{08b593f7-b147-4c51-be91-f4a35691b322}',
'{0faf58d7-54a6-4e96-b141-f5d38314a06a}',
'{1505319d-4bc2-46fe-aa94-7af99c887e01}',
'{2039965f-a5ff-4e1a-ab61-40efc2b256d6}',
'{266a814e-1b7e-4fa8-9dd8-15d74af720e5}',
'{30d47a94-c0f6-47a5-a194-c8021c0e4fd0}',
'{34196655-4141-487a-bc85-4a3c8e637f3e}',
'{3ab5ef45-d860-45c2-b5f4-b3a6ab172922}',
'{415b81da-9cf5-4865-87fa-aee664d72f9d}',
'{5153a73a-594c-429d-8a42-a1906e98235c}',
'{61f6ab45-9dbf-4f30-8466-af40b6192d39}',
'{6b32f1d4-2b71-45a3-9a8a-3770bacbd5de}',
'{70faa75d-771e-4cab-b147-e785132221a7}',
'{78b8602f-836e-4140-9a70-bf910d399919}',
'{7d70ca6e-9efe-4c10-8d8f-a7c663bc1bd1}',
'{98bdac30-c0b4-4ed1-95e9-b042f4a4d5a1}',
'{9a6c94f3-5788-4820-a900-a6a46cad8a14}',
'{9bd78ff3-01c6-4d48-b051-56bdf13b1164}',
'{a2cc6d4e-940f-4b65-b3b5-46e583b91a26}',
'{d5327d28-efbc-4dbe-b600-857a385785cd}',
'{09e6be40-8578-42de-9aa9-7070067ad4e7}',
'{20378180-b8b8-4b33-8ddf-458f97cb8c2f}',
'{6f01ed6a-f21c-4e96-8b22-984b9329eee0}',
'{ad37d043-94d0-43a3-8f42-38c353f68e9e}',
'{b0b40969-f1b8-4bfd-aa42-b636ddf754c3}',
'{c884f03f-b096-45ff-a76d-593cb9c175de}',
'{f1447fa3-3e1e-4d93-87c5-6701ebd061b8}'
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{056e817d-069a-4c3a-9f7b-5f7fa30ed5d4}',
'{0dd3bca6-18d0-4aac-9828-e6bcfdfc48d7}',
'{0e609836-1458-48cc-9207-277eb87e86e6}',
'{22aca03d-82fd-4c86-8471-8202cb05f22b}',
'{2fc3946c-8339-4be4-984c-b3591e11709f}',
'{32aee02e-0be9-4f3a-81a1-499d4bd19591}',
'{3d49fcec-e6cc-412a-83cd-25f571d87371}',
'{566427e5-4ddf-418a-b9f4-27a46f5c065a}',
'{5ba2e772-4415-4645-808b-8106949b8ca4}',
'{96985e08-6c08-40bc-9bf2-cdfe4361506f}',
'{a74e0051-856b-415a-a880-2d1812861921}',
'{a77cea59-5254-45e4-b64d-ee386a8d125f}',
'{f55e2dec-79a1-4c5e-bf19-cc3b5b913586}',
'{fe21d088-324c-4700-bc0e-7301538fe0ec}',
'{00344b98-48c4-49ab-b8ea-983d10756c10}',
'{08b593f7-b147-4c51-be91-f4a35691b322}',
'{0faf58d7-54a6-4e96-b141-f5d38314a06a}',
'{1505319d-4bc2-46fe-aa94-7af99c887e01}',
'{2039965f-a5ff-4e1a-ab61-40efc2b256d6}',
'{266a814e-1b7e-4fa8-9dd8-15d74af720e5}',
'{30d47a94-c0f6-47a5-a194-c8021c0e4fd0}',
'{34196655-4141-487a-bc85-4a3c8e637f3e}',
'{3ab5ef45-d860-45c2-b5f4-b3a6ab172922}',
'{415b81da-9cf5-4865-87fa-aee664d72f9d}',
'{5153a73a-594c-429d-8a42-a1906e98235c}',
'{61f6ab45-9dbf-4f30-8466-af40b6192d39}',
'{6b32f1d4-2b71-45a3-9a8a-3770bacbd5de}',
'{70faa75d-771e-4cab-b147-e785132221a7}',
'{78b8602f-836e-4140-9a70-bf910d399919}',
'{7d70ca6e-9efe-4c10-8d8f-a7c663bc1bd1}',
'{98bdac30-c0b4-4ed1-95e9-b042f4a4d5a1}',
'{9a6c94f3-5788-4820-a900-a6a46cad8a14}',
'{9bd78ff3-01c6-4d48-b051-56bdf13b1164}',
'{a2cc6d4e-940f-4b65-b3b5-46e583b91a26}',
'{d5327d28-efbc-4dbe-b600-857a385785cd}',
'{09e6be40-8578-42de-9aa9-7070067ad4e7}',
'{20378180-b8b8-4b33-8ddf-458f97cb8c2f}',
'{6f01ed6a-f21c-4e96-8b22-984b9329eee0}',
'{ad37d043-94d0-43a3-8f42-38c353f68e9e}',
'{b0b40969-f1b8-4bfd-aa42-b636ddf754c3}',
'{c884f03f-b096-45ff-a76d-593cb9c175de}',
'{f1447fa3-3e1e-4d93-87c5-6701ebd061b8}'
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{056e817d-069a-4c3a-9f7b-5f7fa30ed5d4}',
'{0dd3bca6-18d0-4aac-9828-e6bcfdfc48d7}',
'{0e609836-1458-48cc-9207-277eb87e86e6}',
'{22aca03d-82fd-4c86-8471-8202cb05f22b}',
'{2fc3946c-8339-4be4-984c-b3591e11709f}',
'{32aee02e-0be9-4f3a-81a1-499d4bd19591}',
'{3d49fcec-e6cc-412a-83cd-25f571d87371}',
'{566427e5-4ddf-418a-b9f4-27a46f5c065a}',
'{5ba2e772-4415-4645-808b-8106949b8ca4}',
'{96985e08-6c08-40bc-9bf2-cdfe4361506f}',
'{a74e0051-856b-415a-a880-2d1812861921}',
'{a77cea59-5254-45e4-b64d-ee386a8d125f}',
'{f55e2dec-79a1-4c5e-bf19-cc3b5b913586}',
'{fe21d088-324c-4700-bc0e-7301538fe0ec}',
'{00344b98-48c4-49ab-b8ea-983d10756c10}',
'{08b593f7-b147-4c51-be91-f4a35691b322}',
'{0faf58d7-54a6-4e96-b141-f5d38314a06a}',
'{1505319d-4bc2-46fe-aa94-7af99c887e01}',
'{2039965f-a5ff-4e1a-ab61-40efc2b256d6}',
'{266a814e-1b7e-4fa8-9dd8-15d74af720e5}',
'{30d47a94-c0f6-47a5-a194-c8021c0e4fd0}',
'{34196655-4141-487a-bc85-4a3c8e637f3e}',
'{3ab5ef45-d860-45c2-b5f4-b3a6ab172922}',
'{415b81da-9cf5-4865-87fa-aee664d72f9d}',
'{5153a73a-594c-429d-8a42-a1906e98235c}',
'{61f6ab45-9dbf-4f30-8466-af40b6192d39}',
'{6b32f1d4-2b71-45a3-9a8a-3770bacbd5de}',
'{70faa75d-771e-4cab-b147-e785132221a7}',
'{78b8602f-836e-4140-9a70-bf910d399919}',
'{7d70ca6e-9efe-4c10-8d8f-a7c663bc1bd1}',
'{98bdac30-c0b4-4ed1-95e9-b042f4a4d5a1}',
'{9a6c94f3-5788-4820-a900-a6a46cad8a14}',
'{9bd78ff3-01c6-4d48-b051-56bdf13b1164}',
'{a2cc6d4e-940f-4b65-b3b5-46e583b91a26}',
'{d5327d28-efbc-4dbe-b600-857a385785cd}',
'{09e6be40-8578-42de-9aa9-7070067ad4e7}',
'{20378180-b8b8-4b33-8ddf-458f97cb8c2f}',
'{6f01ed6a-f21c-4e96-8b22-984b9329eee0}',
'{ad37d043-94d0-43a3-8f42-38c353f68e9e}',
'{b0b40969-f1b8-4bfd-aa42-b636ddf754c3}',
'{c884f03f-b096-45ff-a76d-593cb9c175de}',
'{f1447fa3-3e1e-4d93-87c5-6701ebd061b8}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{056e817d-069a-4c3a-9f7b-5f7fa30ed5d4}',
'{0dd3bca6-18d0-4aac-9828-e6bcfdfc48d7}',
'{0e609836-1458-48cc-9207-277eb87e86e6}',
'{22aca03d-82fd-4c86-8471-8202cb05f22b}',
'{2fc3946c-8339-4be4-984c-b3591e11709f}',
'{32aee02e-0be9-4f3a-81a1-499d4bd19591}',
'{3d49fcec-e6cc-412a-83cd-25f571d87371}',
'{566427e5-4ddf-418a-b9f4-27a46f5c065a}',
'{5ba2e772-4415-4645-808b-8106949b8ca4}',
'{96985e08-6c08-40bc-9bf2-cdfe4361506f}',
'{a74e0051-856b-415a-a880-2d1812861921}',
'{a77cea59-5254-45e4-b64d-ee386a8d125f}',
'{f55e2dec-79a1-4c5e-bf19-cc3b5b913586}',
'{fe21d088-324c-4700-bc0e-7301538fe0ec}',
'{00344b98-48c4-49ab-b8ea-983d10756c10}',
'{08b593f7-b147-4c51-be91-f4a35691b322}',
'{0faf58d7-54a6-4e96-b141-f5d38314a06a}',
'{1505319d-4bc2-46fe-aa94-7af99c887e01}',
'{2039965f-a5ff-4e1a-ab61-40efc2b256d6}',
'{266a814e-1b7e-4fa8-9dd8-15d74af720e5}',
'{30d47a94-c0f6-47a5-a194-c8021c0e4fd0}',
'{34196655-4141-487a-bc85-4a3c8e637f3e}',
'{3ab5ef45-d860-45c2-b5f4-b3a6ab172922}',
'{415b81da-9cf5-4865-87fa-aee664d72f9d}',
'{5153a73a-594c-429d-8a42-a1906e98235c}',
'{61f6ab45-9dbf-4f30-8466-af40b6192d39}',
'{6b32f1d4-2b71-45a3-9a8a-3770bacbd5de}',
'{70faa75d-771e-4cab-b147-e785132221a7}',
'{78b8602f-836e-4140-9a70-bf910d399919}',
'{7d70ca6e-9efe-4c10-8d8f-a7c663bc1bd1}',
'{98bdac30-c0b4-4ed1-95e9-b042f4a4d5a1}',
'{9a6c94f3-5788-4820-a900-a6a46cad8a14}',
'{9bd78ff3-01c6-4d48-b051-56bdf13b1164}',
'{a2cc6d4e-940f-4b65-b3b5-46e583b91a26}',
'{d5327d28-efbc-4dbe-b600-857a385785cd}',
'{09e6be40-8578-42de-9aa9-7070067ad4e7}',
'{20378180-b8b8-4b33-8ddf-458f97cb8c2f}',
'{6f01ed6a-f21c-4e96-8b22-984b9329eee0}',
'{ad37d043-94d0-43a3-8f42-38c353f68e9e}',
'{b0b40969-f1b8-4bfd-aa42-b636ddf754c3}',
'{c884f03f-b096-45ff-a76d-593cb9c175de}',
'{f1447fa3-3e1e-4d93-87c5-6701ebd061b8}'
);

commit;