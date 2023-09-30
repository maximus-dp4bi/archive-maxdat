update maxdat.CORP_ETL_MFB_BATCH cb
set 
  COMPLETE_DT = (select min(v2.create_dt) from d_nyhix_mfd_current_v2 v2 where cb.batch_name = v2.batch_name group by v2.batch_name),
  BATCH_COMPLETE_DT = (select min(v2.create_dt) from d_nyhix_mfd_current_v2 v2 where cb.batch_name = v2.batch_name group by v2.batch_name),
  STG_LAST_UPDATE_DATE = sysdate,
  CURRENT_BATCH_MODULE_ID = 'N/A'
where 
  BATCH_COMPLETE_DT is null 
  and INSTANCE_STATUS = 'Active'
  and BATCH_GUID in
('{016e5332-6fdb-4fb4-ab1d-58045d2476dc}',
'{024d57d9-288b-40e0-8a69-cd3bae137856}',
'{02ccd0c7-aff1-463b-9b5d-67b0e7db9ad6}',
'{04dbffcb-2c9c-4d94-aa1a-28871bdfb27f}',
'{074528a0-b8cb-4029-9a61-4452a98bc9e1}',
'{0a49d20e-52bd-4e0c-82c6-718d4c8de42f}',
'{0da665c8-d7a7-4d40-921e-5c6a57ecb3d0}',
'{0e1f480b-eaf6-492d-bb61-94c741e11635}',
'{124f8a64-6bc7-4f24-9ac8-c359df17a823}',
'{1328bf5a-bc29-49ce-b9eb-6a8949762c27}',
'{158e62f8-e7da-4a63-aa45-dfc12de8b8d3}',
'{15f8fdce-946a-4468-9ee3-eb6d497cd35b}',
'{17d66b0a-1385-4994-ae4a-3a04a6caecf7}',
'{1c0c51c5-932f-471c-980a-b9ee1781503e}',
'{1d73a5c3-fba1-4146-b325-4540873a6db7}',
'{1e5c4f46-ae90-412e-bac7-cb0cb535d113}',
'{1e950ed7-8c1c-4c2c-8b28-aea7be593923}',
'{2016efef-c1c7-4f20-80d9-43138966365d}',
'{2037b71f-c99b-4c50-b254-3f404e00f9f0}',
'{20a58983-67fc-456c-a085-91ab49d91e45}',
'{21c35682-16e5-4a06-994d-7e9aa073ae6e}',
'{21d762e3-cb91-46f2-a3be-b7c87333bc07}',
'{2616f362-5984-4c63-8c2f-dcdf2349330f}',
'{274890a1-b9cc-4c74-9a46-55c41046c7fb}',
'{2d07b1b1-d1d6-4ffa-b987-6b2334e50194}',
'{2e7114b3-d77f-49aa-885c-6e96f53d0829}',
'{2ffcb4ef-4c55-4ecf-a8d2-65e5f12718f0}',
'{31dbaedb-1fde-4223-be25-e6e9208445f1}',
'{32fe06ac-348c-4b82-850f-91122c813f1b}',
'{33afd199-ca90-45e9-8e52-5eeab9eac1ea}',
'{33e02fc0-0ed8-4027-a612-ed9b87ecad1f}',
'{34a369e6-f5c4-4be6-992c-65ec71e3f61a}',
'{35b1e392-2150-4ddc-94bc-945974b61b39}',
'{35b32536-607c-49fc-97a3-5f9283c098af}',
'{37abe5af-f3df-4cb3-9184-316a3e530ee6}',
'{385103be-9003-4fdc-b359-71f5492ddb9d}',
'{39ebd232-dfe1-4c6b-92a4-fad839abb480}',
'{3a47e25b-d544-4cea-bf1c-bab3a640e8fe}',
'{3aced400-e90f-471a-b31c-26ec6696be54}',
'{3b7b52ea-457b-4212-99e9-3506aa57f4da}',
'{3e39e497-0401-45af-9952-54f368def222}',
'{3e9c6a8f-1c7b-43a7-9b59-300b288a0901}',
'{3f7f1dcf-9e70-4e98-8ac8-58554b91ce16}',
'{42267c98-22bf-4a60-b81e-81abc0782c9b}',
'{42ae7314-876b-4c52-84f3-66cecb4b5b1a}',
'{43b4ee63-acf1-45ef-96f5-0ae0caece0af}',
'{4491462c-e01a-41bc-919c-81f84bdf9392}',
'{46bef716-8dd9-43dd-8430-7f5358c5ea6d}',
'{474bc53c-3ddc-48f6-b7bb-8ef4d91942b0}',
'{479bda11-300c-4cda-bb45-129626b1a81b}',
'{48467f27-605b-4429-a5c0-343954c53a2f}',
'{48da6f6b-adb6-444a-8948-2a22cddb3462}',
'{4c55586e-fdb0-48ac-a735-d9db4a5d0ae8}',
'{515bc21e-2eff-48a9-bebc-0484e77ef81d}',
'{51fb8965-4557-4d5f-a1c8-e68b618ca835}',
'{53605737-5da8-4868-9abd-951c57c34dcb}',
'{539d13e0-41ef-4db2-9c8d-6a8d4b09d21c}',
'{548303ea-6140-49f5-b2c4-718492cee4fd}',
'{550c0864-e1e6-4e45-94ff-b3bb77a10c4b}',
'{565981bd-ffa0-4667-8573-1300b9cc0125}',
'{59c19fa4-1751-403e-8108-b2e3f47462a5}',
'{5a3791b6-629c-4b71-9363-8fdba8827fb7}',
'{5d4b46c9-48aa-4f57-9481-b034856fe345}',
'{5eb7a1a9-8918-46e6-afd8-71d65fc3cbdc}',
'{6230dd0f-e427-43fc-b8cb-90dec6891c20}',
'{62c146da-ece9-43a2-806d-4bea5f226d9a}',
'{653402cd-da33-4f15-9326-d3512ee42e05}',
'{65f5de8f-735e-4fbb-b731-7d46fcd57102}',
'{671884a0-213d-4606-8ca0-2d6288dd128f}',
'{682cc842-d720-419c-9bad-1751fc7ebb02}',
'{69b06ddf-41fe-4447-934e-0b2fb489451c}',
'{69d3cf88-e2e2-4a43-85fb-370a25687fd2}',
'{6a1212a1-f7d2-4632-866e-05d58bf5edc3}',
'{6c92e7c1-3d35-40a1-b651-ae070e9a8974}',
'{6c9dcf48-6283-4f84-92fa-b0ce9812870c}',
'{6d0fa5c2-c633-4a8b-8bb0-1d6c930da159}',
'{6f07fa59-1c6b-4a55-bcff-43c0e6a2bc6f}',
'{6fd7097d-5e0b-460d-abbf-684ee6b48b71}',
'{6ffe8a90-bf05-474d-ada7-18343f675f7b}',
'{7111774a-75bb-41d0-80aa-127b66380454}',
'{724ab191-57b6-443b-ae12-ed1e0e8aadee}',
'{725d6d2e-e0b2-4fcd-8d31-684de0c8bcb5}',
'{72ee19ef-c03a-4768-806b-a10ebff3fb62}',
'{73a92a77-ab77-4036-951e-373e6ea17779}',
'{74075ab4-5698-4f24-bbcc-7f4f37fdbcfc}',
'{743f5aad-f0d2-4f84-946f-f10abeb5b1cc}',
'{7534e894-d216-4798-acdc-5addbf92b64d}',
'{7692f443-5a61-467b-8669-6feb752aaa99}',
'{769d7794-2765-4999-86be-aba0adaf1099}',
'{77c3b599-49b4-4c3d-9875-6df69025c339}',
'{784f5f78-6b63-4b8e-8fd0-2945c323b59e}',
'{78aeace3-8d3b-4945-8a98-1ae7e867cc5a}',
'{78c377bf-6088-4285-b67d-ba6ec6f6d0c1}',
'{7ad667a6-de84-421e-99e7-56c6d850efd2}',
'{7ada3cea-3424-47fb-a065-f8a49e5cce86}',
'{7d231af5-52e3-486e-bd11-4f7ab4d88363}',
'{816fdf5c-b7a9-48d7-944a-46bad62555da}',
'{825e4db3-871d-44fa-91c4-bc732e4c5023}',
'{830cd25c-c1d9-4da2-ae11-431710ebace3}',
'{84853199-e6c4-4dbb-84eb-5708ed938caf}',
'{86aad67e-6831-4bab-9376-2a8d6d44ebb2}',
'{8ae63821-24a7-44c1-bfc1-2210e1ef40c5}',
'{8b496de6-b529-4fda-bbeb-09e05623823f}',
'{8ffa0e44-76c8-4c0f-b174-4feca1a55559}',
'{900b02e4-25b8-47ca-9d6c-de0a2aedc434}',
'{90acdca8-f83d-4dcc-9907-c2a6b0106736}',
'{923846c0-0b81-4ee1-91a8-ba6fe50f324f}',
'{93af5e4d-f607-4177-a68a-837d8e5e727b}',
'{94031f8f-5cd1-4cf9-93aa-8aa0fcf673da}',
'{9492a856-d9c3-48ce-ba03-ae14785df671}',
'{94f99eeb-58a4-45a2-a88b-7faf9863f368}',
'{96290ea3-f1b1-4777-9ac1-617456532244}',
'{98925de4-d6ee-49e0-bfd0-7ac6ffad477e}',
'{98981865-8ff6-44a9-b5d1-dac47c9a516f}',
'{993e9bf7-84ae-4d24-9826-6d67e7e03a01}',
'{999be335-6eaa-4816-a982-7b2c61eeddef}',
'{9ae5f3b9-e099-4294-9d93-24034e518056}',
'{9bb7391e-a062-482a-86af-9beac28dd888}',
'{a139f292-ed6f-4522-a9ba-bdd2ab201f0a}',
'{a23e31fa-2255-48aa-a583-cee7147ef507}',
'{a37d5d89-ac0d-444d-b743-34cc8dce1470}',
'{a4472b98-ed3d-4d1b-964c-44eea6306fbe}',
'{a52b6f87-acec-448b-b93d-0e70d43d1cb1}',
'{a588fa88-e637-421c-b156-289b2ef26b61}',
'{a9dacb95-b858-451f-868a-139111fccc39}',
'{a9e1dd4a-c95c-46c3-88fc-844773cf1c8c}',
'{abb5393f-8812-4123-80de-ee108d630f1b}',
'{abd22cad-a7cd-45ce-8da2-883b6e915d60}',
'{ad6a1b0e-152c-4a35-8a81-e170056a64aa}',
'{ae1d755d-770c-4efd-9b27-c9235c227ed3}',
'{aeaeea4d-275a-4ce9-ad1c-4ccc2f8af8a6}',
'{b1a5d5f0-1c0c-4481-9a3a-aaf20e3cb90d}',
'{b398a581-c683-402a-a69a-488409bf851e}',
'{b3c19af0-3e88-4351-b393-e8bd1e5dd2e2}',
'{b41b8b9b-410d-4925-88ce-30f78890115b}',
'{b64699e8-5167-43c6-b521-a1a646339113}',
'{b933d308-5a6a-4ada-b513-a1c37b85310b}',
'{ba863ac8-f091-4539-99c1-93eb90d74c44}',
'{ba88e5ca-732c-41d1-9278-3c8a53b44795}',
'{ba9d6e02-b44e-4059-a464-ac1744325c95}',
'{beb0d59d-c09a-45c0-8207-4aba4984425f}',
'{bf0291b9-773d-4ab9-9f5f-dfc452420900}',
'{bfbc0ae0-2d18-4892-92a0-b3daf8a35692}',
'{c0293be9-8cf9-4fc1-bb21-30bd87289c3e}',
'{c4c9c62b-8ff7-441e-a063-ef0c06ebe994}',
'{c4e3beeb-4924-44ec-89b4-8183a64a091f}',
'{cad4e13c-250d-4644-b2fb-8c2ab2428d01}',
'{cb36b2cc-5bae-4696-8927-ea90315d426d}',
'{ccdcc485-ae13-4a12-bbcd-b74aa7afd944}',
'{cebd69a7-4669-4a8d-813c-0cc1807fa576}',
'{d1a1b132-8564-49c4-aa9c-2775d2e2f7dc}',
'{d3e5c053-1270-4a00-8946-ae420f34d935}',
'{d4ca35f4-b60a-47d9-b19b-648f73b796c8}',
'{d62512f0-05f2-4ed5-bc33-1133a638c5cc}',
'{dae79cfd-1abf-4fea-aea4-d99d81fd6c07}',
'{dc588e6d-a036-44a5-9233-793595afacee}',
'{dc64a07a-4dd5-4a76-9845-2394da63f466}',
'{dce40e9c-7fce-44fb-bb2c-ce13596f129d}',
'{dcfa5323-1db3-42f5-ac01-4b7490d63477}',
'{dd3badfa-55db-412a-b795-0bbe9b94522e}',
'{e09099ea-7eb3-4790-93db-57803d98fe31}',
'{e22f9ae6-3624-4e6b-91c1-5b86ba3e9361}',
'{e27170df-63dc-4e5a-90d7-efda046f116e}',
'{e274c71d-158b-408a-bed6-84839c668015}',
'{e3b8f8f7-cbb8-445c-9a34-010c5aa5b2f7}',
'{e545abc6-a311-4464-ab14-d3f9986b8804}',
'{e553b955-aa80-41e9-878f-b314f7798f12}',
'{e590e4a3-dfd1-40ac-a26c-3c3059872aa2}',
'{e77755e6-21b7-4661-8130-b430e28c7f35}',
'{e805775e-6360-4433-ad08-f0db60bcb78a}',
'{e898283b-b777-4182-83dd-2f6db32fa134}',
'{e8a12733-8a9f-48e9-93cb-97b950db97eb}',
'{e8ca7248-c5fe-469a-9cc4-62df58de7bf9}',
'{e962a907-1a91-4777-b959-3c520258cb27}',
'{e99dcf43-199d-42d9-8ab5-1b416eadeb4b}',
'{e9dc7922-222b-4c55-ac14-4aae5290c166}',
'{ea19c7db-8fb8-42ac-8ce1-e880bb89ea47}',
'{ec53e94b-41f0-42d6-993c-edc8fc45beb4}',
'{ed49cc56-a012-4aeb-b97f-8b0d2fc335d8}',
'{ee13f65a-70a9-4603-b569-fe9c7025d639}',
'{ee2e8e27-2387-4291-a613-63e12791794a}',
'{ee58ab01-2b39-4f48-a981-3abce77a1085}',
'{ef98f95e-bfbf-4e4d-8beb-e1a6c260cfc5}',
'{efdae154-d891-4098-89ef-f524266b096a}',
'{efea6394-aa57-4a72-b756-a6288a5ab3b4}',
'{f09e4b30-eff3-47a6-92dc-5d54ea18d572}',
'{f110cacb-e9bf-4c3e-8bc6-cb8e32fa547d}',
'{f1843f0b-cce3-4cdb-b120-a4647c52462e}',
'{f24aac63-de17-40fe-982d-4865b9485d76}',
'{f2a2e8b6-1eb1-4e50-af45-d4b512be5cf8}',
'{f2a7cf3f-c94b-4f5c-aebf-16f856adf677}',
'{f70f71bf-06d2-4ac7-bd1e-743d03007a5e}',
'{f7b23a9a-7bf3-4ce8-a0b9-b5df6897d4bd}',
'{f84ddb47-0779-4c53-bf9e-2c5a2c5707d6}',
'{f962b184-d988-4482-a117-1fee3b04785e}',
'{f97e3e26-e2d5-4a71-b143-2bb9ca87dbfc}',
'{f97e8996-5f19-43f9-963c-0abcdec20eb8}',
'{f9c23863-1897-48f0-be70-0f8fe0dad230}',
'{fb4d4d0c-e645-444c-991d-5e85fa66d1d6}',
'{fb4df314-9cde-4b36-969a-8a947f638db8}',
'{fd1694a7-f3ea-4888-b633-6b23fc511ece}',
'{fffdda5f-e16b-434b-8831-f994a22f8d94}',
'{557706f6-a619-4e37-a339-86463ca86001}',
'{e4045100-420f-4ae0-95f6-822d39c7082b}',
'{03123929-4423-40be-a90f-8e115b2225f6}',
'{087eef9a-190e-416d-8026-9e4302cf84aa}',
'{09964be1-cebb-4db4-8ea3-0708ad6ca56e}',
'{0ce1d5fa-c800-412a-81bd-ea39021df6b4}',
'{0d03ab8b-0239-4ce2-82ff-8ce8d7a0476e}',
'{0d075a32-8eed-4a4e-9f91-addaf0d0c143}',
'{0d657e67-3370-417e-bad5-f960e646a74c}',
'{0e6cba60-fe40-42c3-af3e-791bac1b9060}',
'{0fbb4976-a1b0-4a69-a891-8a95b1c6b607}',
'{10918a34-1c23-4fe7-8c18-6f065500a1e5}',
'{1d2147e5-5085-423f-8d1a-d2cb9bc3846b}',
'{1efc39a3-693b-4d0a-9ecd-8c19bdccdd97}',
'{22fef2bf-af03-4ab0-8fde-5dec620aca24}',
'{24b23753-b1e9-4731-b8bb-548fdd6851fd}',
'{27e8b8aa-57b3-453f-b6ba-ad00ea2018ed}',
'{2bebb7a9-42e2-47d8-a2ae-573c9a988e92}',
'{2ce11365-8046-4c00-9c25-df1b9ac15b05}',
'{2cf2b54f-edd2-4ff7-bbca-ef107ee15026}',
'{2dc17c23-0843-486a-8de9-eaaccab8f990}',
'{2e41b377-3c42-4489-98be-2bccbf3aabb9}',
'{30ac5c08-d99f-4e94-b81e-4f99736d5a92}',
'{30afc1e9-17ed-4c41-94ab-b58592e559f8}',
'{3437c461-e9d1-4b68-b18f-d31669b21f06}',
'{35820929-d06f-4358-9ffb-4d408fc02339}',
'{3c043fe5-6b41-4d3f-90dd-4c29336620ef}',
'{3fe2aee0-8399-4ea6-8157-40f42138dd46}',
'{4171b71c-69e0-4fd2-a182-4fd04aa78a33}',
'{471a7cf2-35ba-4962-8c56-47d4ae34e836}',
'{47fd9517-87fa-4d06-9d2b-5a8bf3786fc9}',
'{492618bc-5302-48f3-a87a-3ea46b0bc122}',
'{58022f3f-8391-435c-8087-afcc1eb9c53c}',
'{5b7e9c44-bf5e-4bb7-bed6-9ee4a32af8d8}',
'{5b8b1ebb-2235-4f0e-aa2f-7af7c2126afa}',
'{65af5b4c-796a-4b8a-aff6-414d65dd63fa}',
'{689033d2-8ba4-490e-88d5-4c44534c4ecd}',
'{6904f01d-4627-4f43-9dc0-5e547cfe356a}',
'{6a55faa2-e6fc-4043-b820-fc2486a97d0e}',
'{6a61f916-cda7-43e0-a6e9-a1199e615e6b}',
'{6c859d1b-d024-4382-8198-b921857b242d}',
'{6cd1c8ff-c270-47b0-9193-430309eb9fe5}',
'{6cf662ee-a581-49a5-b6aa-cd7a1a3b32cc}',
'{6e2614c3-a51f-49e2-aba7-f6e299e5f79a}',
'{712fd33c-a284-4d37-aa4a-61f293c50ef7}',
'{730c18d0-e860-45f9-91a1-9176be825054}',
'{758ab913-f551-475a-9a6a-0d383e9482a5}',
'{766d9d41-6f38-4bce-bb1d-174d66f28c4d}',
'{85f7b4bd-c183-4c24-8eaf-29d2da97c09b}',
'{8a65bf68-e5ab-4ece-9399-cc12574fdceb}',
'{8a9701f9-bcb9-49b7-9c83-69020a2faf08}',
'{8c062c89-ecb5-4519-82ee-87c297d757c3}',
'{93ddbdc4-0ada-4148-b901-54fe5708cfa1}',
'{9c15aeaf-3b58-4595-8b62-e3994ef38183}',
'{a7887e3e-63e5-492e-83d8-598b5db7df65}',
'{ae150edd-246c-4924-9f12-5d400a5e520d}',
'{b032965e-4a54-4bba-bf5b-d416a7697348}',
'{b3bb59eb-64fc-42d1-8bf6-b7d0ba5d1fd4}',
'{b495f2e8-204d-4125-842d-226127b91967}',
'{b83b964b-b6e2-49da-acc8-bc989ab9e7b9}',
'{b8c7f0ee-5ea2-4820-a030-d7b43bd46109}',
'{b8efcdfb-79d7-432c-8e16-bea967bf4b55}',
'{b93e6360-80fc-4d35-a41e-4aacc58021c9}',
'{c39060f9-6b3a-4c60-92ec-afe8978bc197}',
'{c89c7190-4f03-4e54-bec9-be31e1fe3996}',
'{cbbcc8c9-c200-4aef-b974-3c1de21510e7}',
'{ccaeffa4-cc2f-404e-94b5-8488beb00e4a}',
'{cea7a863-4010-4d4b-8fb4-740d79a754ff}',
'{d20ed9bb-2f93-473d-b95a-4f6b35a20364}',
'{d251d230-0b03-428b-a16b-762320128a32}',
'{d4cd1270-3da5-4503-9428-a7f434b88df4}',
'{d7055ce7-83a8-421e-8a13-51d2b0d5ca48}',
'{d930ddf8-bae7-4364-9f9d-6261da0bc496}',
'{db71ad34-020b-4853-80ec-b0844c938a46}',
'{de997f08-a419-4e8d-8270-4a25da86fe43}',
'{e28539b0-8d80-4394-b7c1-67f422148a6b}',
'{e6797b78-9182-41c5-b6c9-03f7339bb211}',
'{e9164f06-3811-4038-9a8b-ed7b23da40fa}',
'{e9bb9c06-73b1-4f9d-bf02-9ae2f7f66777}',
'{f0ab8a6b-035a-4a25-9fb2-101aced58ebc}',
'{f3b30c6b-68a8-4685-b631-e5653006a6b4}',
'{f3e2cd98-7bff-4c41-8c7e-7620358f7fca}',
'{f79d05e6-afb7-428e-b94e-d1ea96895718}',
'{03037dd3-9a33-4d29-b71c-e661ca86cfa1}');
commit;