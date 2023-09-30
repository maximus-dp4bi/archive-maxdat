execute MAXDAT_ADMIN.SHUTDOWN_JOBS;

delete from maxdat.bpm_update_event_queue where bsl_id=16 and
 IDENTIFIER in (
'{040fef8b-2dec-4b36-9087-f038afd35de0}',
'{05e90e04-c5a6-4c4d-a15f-8153e157d0c5}',
'{07293fe4-ac1b-47e3-9807-73a6aa65aabb}',
'{07985ad2-4244-4691-b9ab-37e41ecc85f6}',
'{093fcf52-0a04-4d25-9284-1f984bc290ef}',
'{09bbbb41-af58-498e-be50-ab5c1e594d84}',
'{09d77eb8-7dcc-445a-b067-226281f31cf8}',
'{0a78f503-e890-47c3-b8cf-0693e7d432df}',
'{0a98e20e-6cb3-420d-9892-1fb3d7db40c3}',
'{0b2be116-9bdb-4c2c-ab51-3f424022cfb4}',
'{0d2a40e0-a4af-45c1-a524-eb1ee84c9b47}',
'{0d4f618b-b682-4bdc-a864-385137b07110}',
'{0f270695-d6c8-42b8-9fb9-f8de3e2ad218}',
'{109b96fb-1204-45bd-98fe-c57b8cd770bd}',
'{12e74a44-402d-4c46-ab92-7e34de4f2dd3}',
'{13095398-c9d1-4655-a776-ca4fb25cebe0}',
'{1379e8f9-0479-4588-9178-75c5d81827cf}',
'{13f4a35e-0ecc-4429-9edc-64aa65d5561a}',
'{147bda32-0444-4d56-94d7-3ba611563aef}',
'{16e85295-b297-48eb-b525-e1d0b6651093}',
'{16ee7b5d-6a59-45a9-8bbc-a3e3e9abfa49}',
'{174335ea-905d-4845-acf4-b1e1e07c5f99}',
'{181aab9e-2d18-46f0-96fc-a401b322c3a9}',
'{1980ad30-958e-4cb0-840a-bf963209e793}',
'{1ab876bc-67b2-41e4-b18e-42c157dd4742}',
'{1b4bcee8-9912-4b1a-b8d1-4db6fc19bc70}',
'{1ba0fa91-8db1-463f-a0b7-560c7568c77a}',
'{1d17d41c-3547-4f63-8a55-ce162ede1783}',
'{1f117efa-3e3b-4ee3-afc3-d005fd7159e3}',
'{20cabeb9-7bd2-493b-b571-4aeae66a544a}',
'{220cc0b5-7248-4340-ac38-ff9937ffd63a}',
'{22160f52-89f9-4729-a4f7-a4a18e2c47e3}',
'{225f81da-ca93-4f62-84df-d9ca77987a52}',
'{226efbee-8fb6-4407-b5a9-14cae092965d}',
'{22d6c4fd-b011-4874-8c12-35f4be1108de}',
'{23e7ae8d-fa9c-4cfa-967f-63284d75a2dd}',
'{2561307b-f8c7-47c4-8a79-6d588f7a86c8}',
'{25adf7b3-e561-4929-8237-f3d5d28060f5}',
'{27fbe595-b0a4-4dc1-8083-622303698aa5}',
'{28f27f56-904b-4b31-b7d2-b3761f8e211f}',
'{2ad310e5-3382-42b3-9978-4a75953f41f0}',
'{2b9d066e-5683-438e-8807-4fb09a35ffb4}',
'{2db1bf04-a8b6-4ece-8fe4-e218db2f9449}',
'{2f0b7134-9c1b-42ce-8286-bb69af75c20b}',
'{2f24035b-ee24-4cf9-90b1-d0dc0bc9a860}',
'{3047989d-340d-45dd-9d5f-942e00ef0872}',
'{30c9f78f-dee9-41b2-bbcb-a2c937023f68}',
'{319183bc-4f18-4a62-8250-382cd643c121}',
'{345ebc97-7053-4dd5-86ad-1c870156f9fa}',
'{3472840d-7a91-4180-a7c9-8f4bf7eb4ea5}',
'{3561c301-6850-4643-9156-1d7f1c32f080}',
'{35dffdcd-5584-4c45-8aab-f1758d2260c9}',
'{3690b0be-8414-4253-be54-3dfa6cc5abb8}',
'{370ac7d7-1f81-4737-b365-ebba1a735eed}',
'{37303177-d021-43a5-8033-5e7dd9e50ac6}',
'{373d2cd6-e571-4129-b28f-ac860d3f1c95}',
'{38ea6e73-d096-44a8-970d-d19825a9b005}',
'{3a80bba0-b6ac-4cc0-aae1-2e61371cbb0e}',
'{3ec3ec33-5395-48f5-90e5-13f3b123aa86}',
'{3fcdef65-e9c0-4242-96ae-a6f1c87c1dd8}',
'{3fdcb906-f31a-4d0b-bcda-7df04a5fae91}',
'{41ce80f6-c749-40b1-b9a2-8ba81790cc94}',
'{42494f60-4a66-4efc-8674-cdb4734dc2a5}',
'{4483bf94-4e68-4fd3-9722-7ba65ccc6742}',
'{4622543b-1d8e-4c18-83f3-50ecf2502b8c}',
'{462f3ae9-b1ff-41b7-a6af-b4870b986580}',
'{46729e1b-968d-45d7-a1a1-ced4f59b76b0}',
'{46b1329d-a4ea-4c3a-b0d0-1812b8feff91}',
'{48d34046-aa08-4ce4-8c34-493146c91388}',
'{493c16c7-f210-461b-a2c2-d952416e217d}',
'{4a76ec44-023a-4dc8-8b2a-d2c3c80a8af7}',
'{4acf3728-07bb-4dcc-8597-820dccbd7e7f}',
'{4b08dc8b-aef8-4124-96b8-a6f8a6cac515}',
'{4beaee39-efe6-4838-82ea-a91873450f8b}',
'{4c099141-454f-49b2-9b70-bd70cc76fc63}',
'{4c6a8266-3862-4d5c-931c-4b667e52907c}',
'{4ceb120d-9d5f-48ed-9556-3a83478d4aed}',
'{4fad7eef-3556-4956-8df8-e5203dd9be4b}',
'{5047179c-bae8-40c5-b650-4fea54c85203}',
'{51c89a62-b9ca-4efd-ac6f-5fecd3e81d83}',
'{522fc867-6058-4ae9-8453-531688836124}',
'{526d3a04-afed-4499-a29e-c62dbcbd21e8}',
'{5282e9a9-44d6-463c-9ab6-b09b6fe3f5b1}',
'{55e57205-c31c-4e44-941e-735848015020}',
'{56ea28fe-0740-48ab-8ac0-fc9d59dbe752}',
'{56ecd235-efb4-45fc-ad24-0b2e34b10b7e}',
'{57b147c8-c6d5-4115-bf1c-9158a7f13892}',
'{586a884e-2881-49a9-8c3d-8787a8019c56}',
'{5873d479-c6de-4dff-96c4-bce054501a3a}',
'{592c7a5f-ac1f-4034-bb99-3c11a39f8c95}',
'{5ae8b316-232a-428f-9fb0-861806e6566b}',
'{5bbf7d21-fae9-4c75-8983-f8cb2a0f7131}',
'{5c57df81-729f-4371-a58d-150577189c29}',
'{5d78c231-c4d6-4344-be63-b571f731a904}',
'{5e19420d-36ad-4cff-bd1c-e3336cd65213}',
'{5f342a27-9ad3-4164-b539-177d0db53232}',
'{60914525-1861-41ed-9c9a-6ed04a02e2cd}',
'{612b826d-5bdc-4b96-bbff-0cd53e55814c}',
'{613b0357-284c-478f-a7c3-12541b79d80b}',
'{627321b4-59b0-4233-b739-32fdddee668a}',
'{63caaa4c-740c-4b79-96c6-052005295032}',
'{640203d0-5024-448d-94b9-3330c5c03893}',
'{6403c017-8075-4d2b-951c-b618471c7b7a}',
'{668ff83a-8ee2-4c4d-9ef8-059c0b78f883}',
'{6696a1f6-df57-41fc-a454-b4cb626f7dcc}',
'{66c70a84-053b-43df-907e-a4fa86192be3}',
'{68753a77-2aef-423e-88ea-9f0b0582af5a}',
'{6a13992e-659a-4096-80a3-78d4d006d0c7}',
'{6aad914c-2ab1-4bac-80e3-ed67df6a4f1e}',
'{6f91cc69-aa8a-4a70-a977-2601cc4e0c57}',
'{6fc76a80-7686-4ed3-9c38-e0a853d77d3f}',
'{70a3da09-80aa-4324-8300-fa279bc06aea}',
'{7291b7fc-5ab1-4679-aa8b-7cbc84dfbd2b}',
'{729ff17c-671c-4aa4-8045-7b6f4579bd4a}',
'{74075ab4-5698-4f24-bbcc-7f4f37fdbcfc}',
'{74b20080-5d97-4abb-a043-b473f63d0d8d}',
'{75052ecd-b52e-4d27-a656-d97801e04f38}',
'{760ec76b-e168-434b-bdf0-65f73d6382cd}',
'{78397a42-74a8-4db4-acc0-e4f43382e34f}',
'{78a66f49-9277-4d91-ad2f-c24ee244651d}',
'{7a7925d6-1b46-40ba-b789-48c638554d52}',
'{7b5c1755-2f44-462f-8548-d39423fbe09d}',
'{7d7ed00a-2fcf-445d-9b14-b9a21be9970b}',
'{7ed3dab5-c055-4452-8c75-b66ce0ee1096}',
'{80644f7a-cd83-4245-8a0c-639407bfe001}',
'{8200ebdc-e844-4a58-945d-e01dea31a718}',
'{823b42c4-9a37-4ad6-80bd-a91970ed9d77}',
'{8352c004-7e5f-49af-a748-7a4935bde079}',
'{838b5296-9cd4-4643-90c8-497bf7088d89}',
'{84a7878e-ed8f-4ee8-b09f-ba68e35e0ac7}',
'{85565005-82f2-4804-97e3-af3844d03106}',
'{86487b90-44ca-4abf-895c-11a650d4de14}',
'{8667a94d-af42-4f55-a5c7-f68ff511ddb0}',
'{871e0ecd-2233-40d6-9b68-a2de85242d01}',
'{87b7ec4d-8ea5-4483-85dc-72b0436530d4}',
'{8c0e8d96-83d8-45c4-999d-b0299eebbb32}',
'{8ce56019-5696-42ee-8e85-7e7e82b684ed}',
'{8d8348c5-2500-41be-afb6-782bd132a7dc}',
'{8da84da1-523f-4caa-b34d-84babfb4fa55}',
'{8f3ae0e3-127a-4980-9d79-8600119ff4e6}',
'{90143f2f-2ba0-4bf8-abd7-dab8266a081c}',
'{90ae63d5-ba46-4805-bc33-50c47a0d1fe6}',
'{90f72c43-8a12-4cbb-9428-741c087cb46e}',
'{9180a98d-4b98-4bec-9cd9-b94ea1d7378f}',
'{9200d6c4-74aa-45f2-af56-2f1af9302960}',
'{922c29b9-9b65-4dae-a1a6-82d5ae062716}',
'{96b73e37-0c8a-49b1-a1f4-a950db0f1915}',
'{96e4f35e-efe8-4a10-9c87-b6f4e610c97a}',
'{96ff3a16-ced9-4ca6-9705-77c8a10c10ce}',
'{988b1465-2191-4a82-a40c-349923cadc1a}',
'{990e30e0-7898-47ea-9e92-ce1761fd7168}',
'{99c4a400-c00b-4c5f-a3f3-363f042b20f7}',
'{9c6920cd-e999-4cf3-9436-8b229b0d4a78}',
'{9d668503-eddd-4888-a24b-c6c9671dec54}',
'{9da8034a-bd26-422d-bf3e-7129f448b161}',
'{9e5e3dad-31a2-416c-ba38-980b05c91189}',
'{9e821c39-7b32-4b7c-a2e0-50d999b8d62a}',
'{9f4cfc7d-5dc9-4958-a05a-2a877ea26d7b}',
'{9f642253-7428-45a8-8314-76d1bbb2bc95}',
'{a0d027ce-6f96-4968-a280-97d106779492}',
'{a0f09f3c-8eb1-4676-a078-bbc9f82cf169}',
'{a13207c0-45df-4cb5-aca3-4b8e1e60f066}',
'{a1960453-063d-47d9-ab79-85f933319458}',
'{a232970f-14bd-4654-907a-74bd560e812d}',
'{a3b71464-0832-4723-a269-21c1df8add41}',
'{a7e602a0-f4a9-4888-b26d-63b691dcb768}',
'{a884228b-6280-48e7-bc27-df88539ce368}',
'{a975ed0c-29b7-4ce4-8868-8b4783eb9521}',
'{ab67ad14-ce5a-41c6-a0b6-5de61670da2c}',
'{abbff97b-aecb-4264-aca2-a66442fbe495}',
'{af0bef37-4eef-49ac-9a4a-a4287ad2ca3c}',
'{af21a6fc-b02b-4b96-9cc7-527b8cba3c96}',
'{afa6d089-48bf-443b-b2c8-7a6cfe48d11e}',
'{b1c2de96-f17d-4e2d-a799-b3431d8a935c}',
'{b40c606c-c950-4c0b-9ae4-cfdcf6443aa9}',
'{b5760017-fa82-457c-810d-17d00fc83496}',
'{b785200e-58fb-4bd1-a4e4-47f74c36fecf}',
'{b837b3c2-9aa9-4e0f-8a73-a7961c19035f}',
'{b85c087d-4916-49cd-9fc7-145602f18e75}',
'{b94d3eed-2aaf-4d1b-9989-019cf9e21233}',
'{b9ac28b6-ceb9-42cf-957d-d34d1cd3acfa}',
'{ba27a797-c6a8-4c25-bc95-12e66654d659}',
'{bb256bef-f08d-4026-a0fc-426fbd1fb8e8}',
'{be885577-abd0-442f-8160-2b6c98c3bdc8}',
'{bf2adde3-c246-4b7e-9dcb-b10b97dcb1f1}',
'{c0552dce-40bd-43fa-b651-3ee022ad40bf}',
'{c07a7330-a7ea-445a-a502-00be187c411d}',
'{c0b22e3e-6131-4d6c-b053-04f58a8c1234}',
'{c0f90189-f077-4c79-a80c-dc71b2289e29}',
'{c109fedd-bf63-49b2-baa7-45e989f33c63}',
'{c133195f-a3d4-49d0-9b7e-fc89d9a9f0a2}',
'{c143b646-0d5c-4c20-8f4f-668162ebf8d6}',
'{c35e6c46-f76b-4ec5-af8a-54303f4177a1}',
'{c3a2a9aa-43d4-46ce-a1bd-b6714c12e740}',
'{c423f73b-068f-4765-aca0-54f26048059b}',
'{c5d28606-3a35-4ddd-adff-3fda3fd8de83}',
'{c774d08d-56e4-4021-8e66-a04177e3bb9a}',
'{c7ca2409-ffc9-492a-a49b-e67a154add91}',
'{c86ba784-544b-44a3-9308-f38bbb034a37}',
'{c97ff574-fde8-4071-866d-aa24b47989b0}',
'{ca5212af-ef84-4efe-a46d-9e407a6c74a8}',
'{cd360867-d604-4e45-bac7-081158421f49}',
'{ce2677bd-461d-4dd3-a02e-81bf84952aef}',
'{d0853d2b-496a-4185-89d0-42cc26c714d4}',
'{d10ac57d-b8df-4623-a088-1d472fe7ff17}',
'{d198ed6b-de57-4131-ad89-aa8d7055e84f}',
'{d2ce2250-afd9-49dc-a6d1-1974c309b0ca}',
'{d63890ad-60c0-4d47-9900-561040cb4270}',
'{d744ec43-b868-4548-85fe-b779008cdbcd}',
'{d8d0c931-e8a8-4fb4-9a68-033ead6cb4b9}',
'{d9023f19-b838-40e9-927b-5cc16f8d626f}',
'{dba92e5b-bd9c-4c5e-ad57-82879a0d66b6}',
'{dcab18e0-3440-4e4e-8fa7-2c33d21c8b6b}',
'{dd278ec9-ef86-44ea-86f2-4be2ea084bb2}',
'{dd2c577f-3504-4f70-964f-40aa637e204d}',
'{dd8e7352-47f1-415d-b147-df21e4119269}',
'{df842c8a-2631-465a-bcce-c3fcb85524aa}',
'{dfe9e19d-9974-4b21-bae4-b4d7a5f79918}',
'{e01dfb5f-8484-4dcb-9b2a-e3fa9e0674f2}',
'{e03b6d7b-8968-4bfa-99e2-7bebfeeb74fd}',
'{e0aac9d6-8812-4647-b41f-839db130fb79}',
'{e0af2d78-912d-4c61-aeab-e494100d0ebe}',
'{e219e860-733d-4ca6-9064-cfb29d3b9323}',
'{e2920283-b332-48dc-b9ca-5899e08aaafc}',
'{e4780633-8eae-4380-8d58-4c351b06349c}',
'{e58a9c84-7a4d-4d3d-94fa-459796fa3889}',
'{e5e0600e-23ef-442c-93ca-4cc4b37ffa32}',
'{e6b3ab36-831a-4d37-a4c3-e509319853af}',
'{e731d2a2-2ea8-4ef3-ba2a-05c127290b78}',
'{ea1f8f0a-fff1-4e68-bf1a-04c8c9bca6d7}',
'{ead13768-73ee-4899-8003-ed373d250d97}',
'{eb206cf3-7516-428c-9c80-21a873838a73}',
'{eb990d32-d79c-4540-ac86-5d1fe390a9f1}',
'{ec6015db-0e3b-444d-a8a0-efb4131d491d}',
'{ef84761e-8bd3-4131-bdd6-7d979650fb1f}',
'{f0db8429-0775-49cd-9fe5-0eb0f26d7ee9}',
'{f1c90204-44bf-4efe-8b31-47b961c9ee93}',
'{f2c33a23-edf7-49e6-841d-8114da26e7c8}',
'{f2cfa6dd-669e-4df0-97d1-993c66b77377}',
'{f3f19574-599a-41c1-b7cd-d0af231f0f55}',
'{f6b02f07-66b7-4aac-9ea4-efceeb7589bd}',
'{f796b1f6-75f2-47ee-b20a-381417b388b0}',
'{f7beb1cc-85b8-4724-9990-cd077f6d6084}',
'{f8caf48a-77a6-4b6a-95f3-82c150de7eab}',
'{f9221910-3f3e-43d9-a5fd-ab41cc419c8b}',
'{f9ee20d1-dc5f-418d-9569-e22c062b2c9f}',
'{fc13278d-3590-408f-a2f5-f2b8e1490dc5}',
'{ff5e7e84-13ac-40fc-ab01-7f39432564ac}',
'{ffea1ec7-3411-401d-9e25-d3eac84a58d3}');
commit;

execute MAXDAT_ADMIN.STARTUP_JOBS;

