-- NYHIX-14052 - Close batches missed while Kofac servers were unavailable (March 17 to 23, 2015).

-- Update ETL staging table to  mark batches as completed thathave completed.
-- Divided into sets of 1000 BATCH_GUIDs as required by Oracle.
-- NYHXMXDP DB

-- Part 3 of 3
update CORP_ETL_MFB_BATCH 
set 
  BATCH_COMPLETE_DT = to_date('2015-03-23 23:59:59','YYYY-MM-DD  HH24:MI:SS'),
  STG_LAST_UPDATE_DATE = sysdate,
  CURRENT_BATCH_MODULE_ID = 'N/A'
where 
  BATCH_COMPLETE_DT is null 
  and INSTANCE_STATUS = 'Active'
  and BATCH_GUID in (
    '{92e6b905-3b16-4a74-9882-16598a8b3080}',
    '{846c06ba-1bfb-441f-9bde-7b023e29598e}',
    '{1beeef93-f0f7-4367-9aad-77134ab9df72}',
    '{b9c74768-117a-4e7c-9f50-e2bf59a677b2}',
    '{47281310-ac83-443c-a457-9f3ace8d51a8}',
    '{c8949a5e-cd2d-404b-a31f-a44abde8f406}',
    '{e32b99b1-5443-4577-92ce-4d368342e9c2}',
    '{b63b2b82-c306-4cbf-a4a5-e62a1d2e0976}',
    '{3e3b7c64-cd4c-46de-8f10-561da27d8f94}',
    '{83c071fe-4fed-4374-b0d4-d32b73c7d09a}',
    '{cde6a1e2-b149-40dd-a846-1df60c810b2c}',
    '{9e87defd-086f-4879-a995-475bbf607b63}',
    '{2fae579e-64c5-4dca-b53e-dc7cc7ea6091}',
    '{247f60c0-58ce-469b-8583-e197c9245a4d}',
    '{027bbd34-37d0-4772-bf0c-ed411da1b61c}',
    '{8ce6b5fd-278e-4413-8e7c-c800eaca61ac}',
    '{0372cf38-2b03-4a53-992f-778a66e76b02}',
    '{345cdb06-7144-4a41-9043-caf993b6ef17}',
    '{a70db352-1e44-4f8c-a963-3595e6bf97ca}',
    '{abdac283-fff0-441f-843e-d67a4c583e12}',
    '{7a160160-d358-48cd-9c6e-f165de5d5ec1}',
    '{532175ec-a274-4d45-9231-9aaf827240ff}',
    '{3d29ed69-b377-4231-90a5-f7550f352732}',
    '{46012f91-1efe-4942-9a27-2907c0e48984}',
    '{1c6b36c4-06e3-46e5-ad20-9e0ec221bea4}',
    '{e7c8d6fd-e5ca-4e6c-a61b-c46fbd157c91}',
    '{df352729-302b-41c6-8bc8-d6eb5e5371b4}',
    '{b7445572-0b92-4dcf-b98d-56226613f362}',
    '{cec327db-eb14-47a5-b736-0f75fbd9b8ca}',
    '{950f85b9-ba4a-4e48-9317-009d8fee74bc}',
    '{ab0616a9-152b-4051-ac28-127cb50a3b30}',
    '{5af0fc40-3ac3-48b0-8fe6-2312eb6709f2}',
    '{05522b52-569d-4a28-9568-e1c99ab97022}',
    '{dcea8081-c9d6-49ce-a062-a098f7f9a7b5}',
    '{67c8bfb8-7d9a-41af-a1f7-d420c66fa7fc}',
    '{1cf694d3-6b6c-42bd-90b8-6b4c6b4414f4}',
    '{ba8bcbf3-5523-4311-bcf0-2cb01fc3109a}',
    '{02330f6f-e4c1-473f-b6ab-6b556081ebb8}',
    '{39c91243-9d7f-4a4f-a967-bf184d2871cf}',
    '{d23544b9-adbd-4347-9e7b-dc5b3731c8d3}',
    '{edbef283-9ee2-4cfb-8479-700be0a80cb9}',
    '{7382b5a4-9fce-4928-b43a-65c2bd0f888f}',
    '{6b9de52e-a092-4d57-a8ac-6a93ceacf26e}',
    '{f14053fb-1ea8-4e05-8d21-2b4d6db307e7}',
    '{594e1235-4221-4a5e-bb60-dd3a85d385f3}',
    '{0be008f5-3e82-4150-9cd1-cb84dd8db11f}',
    '{fc796e38-984b-419f-8a3e-ca0ce3f0b45d}',
    '{1542bd52-8b54-4186-a8aa-b0b71246ea19}',
    '{b7605dfe-68c5-4469-9f12-6397996eec4a}',
    '{5c504b35-3c3e-4b47-8940-bc0ae42f9bd8}',
    '{89247373-c4cc-4aed-9a55-b61ade86d9b1}',
    '{45177d68-7144-4c09-9ec5-ff9b4e305cc6}',
    '{ea3c6cf1-d27b-458e-8055-9f674c70169d}',
    '{26405f28-5592-4c83-8e00-c9b6cae71821}',
    '{9f4ad145-d063-4d80-8a4b-12d77c8fe07d}',
    '{923538db-b697-4c00-ba9a-e73417bdefdb}',
    '{2d5d935a-ffe3-4cc7-87db-cd20f78bdcb3}',
    '{1afb4b8f-8471-48aa-b435-be7fe1c2a706}',
    '{338e6ae7-7282-4d69-a858-f4a12fdd1a7d}',
    '{7958640f-6da2-4055-a0af-db893817a286}',
    '{3214b520-ec45-4c98-a3f8-ed90212065c4}',
    '{3d563cfe-5033-4bb4-a8ce-6b0933bcdceb}',
    '{29bc38f2-2f07-4663-8f17-630204197049}',
    '{92a84583-dc19-4ec3-95df-eefe986a0af0}',
    '{a5573404-d672-4968-82e9-666c446c465c}',
    '{fa1d6d32-bda8-4a9b-a2c7-e22b1ed0b668}',
    '{9403a7b1-fd59-45f5-8589-265929eb9f0a}',
    '{f69518a6-2145-49e4-b55a-7c06cba052ea}',
    '{dbf2beab-ef69-4504-a104-72d9800231b6}',
    '{b9f102ea-d9cc-4ca6-bb0c-f9cfdf3e16ae}',
    '{df1a940a-64b7-4823-ad45-88ba95d93b68}',
    '{890ee3b1-781f-4b65-a75c-a2f8c7fab2f8}',
    '{fb79e72d-c6cb-4049-829d-1c946c518498}',
    '{a7c661b3-5ea9-4d21-8459-6be3bb9d6ca7}',
    '{df32cfef-72c3-4f40-95c9-574a0ba93c44}',
    '{d2511553-4a3c-49c1-ae40-9d468d476f91}',
    '{70167189-6cbf-4dfb-b363-bb8429933a87}',
    '{7e7377bf-0d6a-4bc1-a386-bdccfa2d9834}',
    '{c1aafcbe-ddd2-466a-a4ff-e1aad1fed183}',
    '{cf14e234-4108-4a46-a313-92d57c266a4f}',
    '{533fbc04-b5b7-477f-9058-7511c6fc661b}',
    '{6a789fff-e74c-4a3f-9901-ccc33ac5bb4b}',
    '{154342ac-5497-43c7-a213-366d7c988950}',
    '{84c94c99-9a2f-400b-849d-7a6bec8ae7f7}',
    '{34c35ff2-0f39-4482-9219-8333437b8c56}',
    '{b8827171-fd95-4d95-a1a8-b2595dffc6ea}',
    '{57a150a6-a1b0-4586-942e-157f5093ef2a}',
    '{8929d1c7-b632-4e87-a04b-ad8a8ef7c173}',
    '{2653ce3b-7373-4230-97d1-804926c7af62}',
    '{d1e7aa4f-32b4-4516-8af9-9e0316d35669}',
    '{5c2a6358-0391-4a03-ba08-d9b260b725e5}',
    '{ac9613fc-acb9-4605-bd80-ea9ce68c7d00}',
    '{518ed7a6-f5b2-490b-b395-682e3abd7a48}',
    '{61280b09-6685-4085-a11d-eb45fa854c88}',
    '{43eed008-604b-40b2-b8c9-b342525ee482}',
    '{c607f487-904c-49f9-954e-103aa5ff9839}',
    '{2236ecc4-0ef0-4f38-95c9-b530bb101b51}',
    '{e5905c18-6b60-488b-826a-7af781d51e23}',
    '{8bdfc5fc-ba9a-428d-b9a4-4d089e289b3a}',
    '{3a30b4b3-9651-45f9-a14c-e335b25aebde}',
    '{9759f8c9-e618-430f-a522-6a96b292ba27}',
    '{8c3c01af-8918-4273-9424-cfc522ced2b4}',
    '{3554f85d-3625-4f29-92b2-fb257e92a0d6}',
    '{2ca949f8-d125-4e9f-9777-03f87214b559}',
    '{6899ff37-9db5-45e2-a91f-eab09bd64f1c}',
    '{e91ae926-19f2-4a99-87f5-44f064969a09}',
    '{eff82cdb-5c44-4a05-880c-563930688c8e}',
    '{0183ad7e-8589-46da-8daf-1bf9fb99a5a9}',
    '{51eb79ee-6e98-48ca-ab2e-dcbc3a46f605}',
    '{ea597587-0880-4304-8893-37da52d0e740}',
    '{29d74707-cc10-48ba-8c88-4a9478a7ad4e}',
    '{d3e6e083-a93a-4dcc-a385-b387b623f35c}',
    '{1630b88b-c38e-4e74-954e-37a9d77f29c9}',
    '{223ab039-c9a0-48c2-b518-371de85922c1}',
    '{aa3c54b6-344f-4302-8585-4df55ee29a62}',
    '{df5a5eae-fe75-49f1-a346-f82da79bec46}',
    '{7606fb50-eb59-4143-8e45-66cc5a6c5244}',
    '{3094911d-ee00-4dde-874e-24e821b0fe56}',
    '{aca522c2-942f-49c5-8a22-9bc63ef91679}',
    '{5a6cae5c-4666-4731-a480-f07e57a74df5}',
    '{86e853f5-de29-4592-a715-dc0696017ed9}',
    '{a2876a87-2223-46b4-bc36-b3d0035bf8a4}',
    '{8cfbb1b7-6545-4caf-bc38-0147aa00919a}',
    '{fcdf5a33-16cf-49bb-a1cb-71682cf4ad11}',
    '{bec50a0a-796f-47bd-834c-8b34f3487dd3}',
    '{aeda483a-ebe7-40b4-9c24-340bf8d0b5fd}',
    '{d4223b7a-684c-443c-863f-ba947deec121}',
    '{9f21fc2d-52c3-49fa-b559-9c74087c2593}',
    '{71f0ad01-3b4f-4b98-800b-c71e22354076}',
    '{554139ca-01a9-491d-9c84-00668f9b6704}',
    '{c5fde42c-6bd4-4def-a25b-288352715da3}',
    '{1c6815b6-1e56-4924-9bdf-fddf6b410cd4}',
    '{a1bbd7c8-0094-4671-b013-0baa5d23feaf}',
    '{67f90250-12d7-4474-8fe2-c971c31a3cb7}',
    '{a76a651a-e609-4d02-a5f7-385ffc8c112a}',
    '{5aaca560-0cd2-4c6a-9953-8b62aab1ac9d}',
    '{1013329b-afbd-44f6-b413-e83d824ea412}',
    '{c8c7f20b-51de-436b-ae80-62f06259dad4}',
    '{cdec78dd-32d6-44a8-9ad0-4ab69f5e5886}',
    '{ba9fdda7-8e83-451d-b563-3cd0ea9eaadf}',
    '{f0f62282-f354-4aaa-a090-e7a625eb629a}',
    '{a9c32834-da6f-49c2-819e-c7dae0ff75fc}',
    '{577fe1e7-062b-4638-bc0c-54110ca872e0}',
    '{c1932ca9-54c1-4e41-9048-94526c44eb65}',
    '{c8f15bc7-31d4-4404-8279-28dd61294287}',
    '{f1534f97-f074-45e7-8c71-160abd840422}',
    '{ab34817f-8a8f-4661-be75-ec16f9a1487d}',
    '{24956410-e408-4ec2-8a32-f5e30bd0495a}',
    '{dc8f143a-077b-4e23-b506-abdde1cab681}',
    '{e1fa237e-30b0-432e-94f5-32641313503b}',
    '{757902d0-a9f5-4d13-890c-76db601c3e4c}',
    '{e6cf155e-34b8-4cd1-8ed2-fe7577fa6239}',
    '{0b23a354-8e14-42de-8048-590fd4062ec3}',
    '{4ca981d7-df45-4a9d-bd8d-dc8533eceb1b}',
    '{c4a53ab0-2b21-4b31-96b9-5be41ac4e312}',
    '{13b0b0ea-bfa1-4063-9801-8b1964b64993}',
    '{7989643c-3eed-4153-8a40-7c7f018b04ea}',
    '{06bc6dd0-8221-4c19-95f8-8ed100a8904c}',
    '{a68bd9d5-9574-4192-95be-f24ccf666fc4}',
    '{ec393571-3fdf-4397-a53c-af1dd65c8711}',
    '{b9c28fd6-8cab-4ec0-9d53-2fd9899a1c6a}',
    '{131f2b64-90b5-48d5-a029-4799bf91af89}',
    '{0bffc850-5a73-4444-b69e-3d48f1659907}',
    '{f9721d44-76cd-41c6-a33e-d037c5b4c7f0}',
    '{198fc52e-2a75-4cb8-8f17-86fdb490044e}',
    '{ad537be2-47b6-420e-ad0f-c0168329d1cf}',
    '{93ffa142-1939-443a-b068-353f9714b3db}',
    '{ef5b37d5-37df-4850-b184-9ffac3624345}',
    '{d6583c9b-d272-4918-874f-8b05c3bfb12c}',
    '{5e7eed6a-9b7a-4ab6-b19c-78e08222560e}',
    '{0a9c3137-36e8-4d05-b99f-2c82cc56af62}',
    '{2101c184-be67-4570-ae1a-c0840162184b}',
    '{3cfee0bc-18a6-4e92-9845-1883a25ed694}',
    '{0a8a4a47-daf3-41f9-adee-d6da4b8e843b}',
    '{96ccd311-ed88-472b-9e15-bf7555c51e31}',
    '{0619f5bc-b372-49ee-be25-77576d6d51a1}',
    '{d74be8f6-46ca-45c6-bbc4-070d68bd92fb}',
    '{56b88055-eddd-4771-8111-34a5f079ee56}',
    '{4c44abe3-3ad7-4623-85e8-94eed7e1b448}',
    '{b1fa736f-7c6c-4e0b-92ab-9c434bc01043}',
    '{e66c4ef9-f83b-4ebc-ad14-e69f4a1fd6e3}',
    '{cec22701-0cfc-437a-824d-16ce9e37d7d8}',
    '{525a4d6b-0346-4ec1-80aa-16a79b262b62}',
    '{13cbf1fe-fe96-4427-ac5c-57ecdd4e983e}',
    '{927b0e9a-c32e-46f2-9e45-35a829fe2717}',
    '{bea5b73b-edab-42fb-9572-bec46d33122b}',
    '{ea072bdb-32dd-44a6-881c-69cf13553c6d}',
    '{6cb7ea66-0109-4a9b-b82a-dfdd19f5093f}',
    '{eccf4c96-1708-4230-90a5-79deb5bb5545}',
    '{bce2c0c6-2c39-403e-815c-ad9c5441d235}',
    '{74d8fc0c-16d6-46a8-9fed-7014218e3fd9}',
    '{9add62b8-f3a0-450d-9fc8-e44fed20dfb5}',
    '{6e5daa32-e03a-41e8-aa2c-579e784ea5c3}',
    '{c062d8a1-8b03-4fab-b75f-7b0898a5251c}',
    '{69f11cc7-2b9f-4a75-b2a6-621ca2900d43}',
    '{40653e64-6b9a-41ea-8f57-459377578eaf}',
    '{eefa6791-647f-4bd0-b4d8-03cf8543268c}',
    '{266e5bc9-a24d-422e-94cf-4568055a27ba}',
    '{349f1c0e-a127-42b1-bce3-f549fb46bb74}',
    '{97597a6f-172d-476e-bc57-aaf0697eb721}',
    '{37d8bfd8-1998-4314-a57e-6b31c17596ac}',
    '{5f6689a8-e0fe-4e20-ba5a-cea964739175}',
    '{d1b01ff5-755d-47b2-8afb-e47166cc065e}',
    '{3e367e7c-1333-40aa-9d16-75e05d201ca0}',
    '{51d4ddbb-2d33-44a2-bfe7-ce8d0f426ab4}',
    '{4e06d715-4499-4683-a5a4-58406966806f}',
    '{7a688e45-1894-46cc-9c2c-a16ad742d868}',
    '{1160297b-5812-48a0-9cf6-3d38435c39cf}',
    '{6bfc9b28-0a91-4a14-8085-f16785d7277f}',
    '{85dcbb45-476a-4612-a28b-ed62839d3bfb}',
    '{5b6e01db-fdd3-4223-914b-10ae90a1ba14}',
    '{5e3aa549-86af-49c8-8e0e-dea0e19c98cc}',
    '{bf128983-90fe-47a5-953e-0765d65584ff}',
    '{bb91b2fb-927b-4910-84e6-9fe8bb8bc7cf}',
    '{50a38ee9-8808-4a0e-b265-918098e201b3}',
    '{6b2ad43f-e054-44ac-8d09-0e142831d4ee}',
    '{4d0822f6-196c-4bfb-9f08-fcaa53cdddf8}',
    '{d30548ce-46fb-4586-a906-f5544d1b705b}',
    '{0d135386-0e8c-4ef0-b834-38c8a211b6cd}',
    '{fa1c37e8-a812-4597-ace3-9da0c0f60a80}',
    '{cf5e6c74-afd1-4e7e-913b-41b98bcaa086}',
    '{9f112b2e-971f-4e2c-b440-1b43cca3ca24}',
    '{23ca27fa-5115-4aa4-8752-4f257f24bd53}',
    '{1c758835-e7c0-4fa8-81d7-1f3ac2155a06}',
    '{014ff982-8972-4d1f-9991-6930fb4a1d6e}',
    '{81b777d0-1a4a-4b48-bd49-9b065b195034}',
    '{70d94522-bfa3-458a-b3f0-4ae4d8b30690}',
    '{40ccba6a-afe2-4a53-8358-6b61df4a3d30}',
    '{c3ab4b43-3d39-4e4b-8525-3763c4b22c3a}',
    '{99070d06-824b-48a8-abb6-89e3ed0c6c1c}',
    '{7242143f-1380-49df-9c45-e629aef6b498}',
    '{2815e304-98be-4fc7-b443-9d612b4c083d}',
    '{b548d46a-8b3e-4c7c-88ab-3eb05a237a91}',
    '{21bb64e0-39ba-4ae8-9387-5090bba534a1}',
    '{fd5bb003-ba00-4c54-8787-dd85f9527623}',
    '{652d2959-b5e9-4afc-aaec-a8cd1651d0e7}',
    '{af1f1787-76ce-4f16-92bd-5daaccbdf72b}',
    '{146864cd-afb8-4f95-a9b9-4e264afb0829}',
    '{fa4d89fa-c433-4bf7-ac83-b20fbd0dd39a}',
    '{7d871661-e9d6-4328-a1c4-b840508eaed8}',
    '{f6fa5525-8051-4144-a18c-d8101965b53c}',
    '{7c80730d-7df9-4006-baef-28a90f209301}',
    '{773e080f-2d50-401c-a899-c10181b78f9a}',
    '{493e2891-6699-453b-b2ee-162cd1ba4fff}',
    '{ecd073d4-4923-49f3-a4f8-1e07faf1e7a8}',
    '{05932d27-64c4-4595-b0bf-36e9201846c4}',
    '{e5470a97-0469-431e-b040-08fd71765240}',
    '{d9b05dd9-5b1a-424f-8c56-c07227dbbd26}',
    '{828b7181-de5b-40b6-b321-242cf42a7f10}',
    '{e45e6ac4-e3de-4d0e-b094-6d001680160b}',
    '{8234e8bf-ddf5-4d40-bdee-4d8fb93e8bee}',
    '{88207e92-e65a-4bde-804f-8170e1106fae}',
    '{951126b9-6071-4243-9573-e1d9099cac72}',
    '{11f4f226-01a3-4ad8-b1eb-dc9fe50d8998}',
    '{e04216a4-5d4a-4abc-8177-3a874b72da7c}',
    '{3a726f4c-8526-4c72-b1f8-2df1b716da73}',
    '{0d982002-bc33-4347-853b-205e46272b93}',
    '{2e071d82-5c3f-4c2f-8804-396570c6a738}',
    '{1120e861-6bba-4382-9afc-e4777bc7d8b1}',
    '{23156c23-ed6e-4c5b-a841-651ed56da0a6}',
    '{3db623c4-5ff8-4c9d-b0ae-9d236f13d73f}',
    '{ed417853-b557-48aa-9528-a9e68a90c4ea}',
    '{ae03af4f-ca1c-4807-80eb-4103abcdc125}',
    '{89fdfdf2-0978-4e38-985f-d050b2f9b8ea}',
    '{6d3bbe59-7b3c-4b7d-8af6-2b4bc3359ae1}',
    '{e59b4adb-0c5e-482a-8c1a-327860c06da2}',
    '{81dcbc38-1e0d-4f5a-b9bc-02e9f2b385d3}',
    '{fcdee094-ff8e-4b52-98a9-939802b8ea09}',
    '{049d94cb-882a-4836-8d13-b7101a6924a0}',
    '{87dcbc77-53be-463a-adda-b3074332b6cd}',
    '{d9eac137-53bb-4fd6-9e9f-769f7f8433d0}',
    '{cd3eed35-d0dd-486e-bb9d-b9cfd29c91e7}',
    '{75336bad-9ec3-4266-8162-020ceffc5a3c}',
    '{5ebd85bd-ad0b-4175-95f0-770423cf2b4e}',
    '{8752cbab-351f-42ca-bd2e-6e0a4ad7b5a1}',
    '{ed5b0f3c-c630-4be2-960d-062f38a30ad9}',
    '{b18d2144-a495-4c3c-9430-6069dfac99be}',
    '{e6a3dec5-cad2-4b7d-82f6-d449e6909f77}',
    '{8cc3f919-b117-4fa6-ba2c-e6284bdc85c6}',
    '{abb08910-f282-4ee6-8e48-029e2da6b204}',
    '{7e737164-368d-4c4c-a275-808c3e7e83b2}',
    '{6ed30cca-e006-48fb-a108-ff761c714f0a}',
    '{25699bd1-15df-444d-9898-d9e1e965600b}',
    '{2176465d-54a6-4be9-9eed-c3ac766f5d08}',
    '{55d2ffa0-41b0-4e68-a289-b07ced21acc0}',
    '{4c63c1fd-c712-4359-95a2-263e6f34d073}',
    '{572a6464-43d0-4c90-8ed6-0b0d466e4d46}',
    '{a2fb1dec-64a7-4302-9c75-ebdf51013c7b}',
    '{2b2037ee-5c2e-45c1-a293-381e1ef6e172}',
    '{5c65f485-f240-4c93-ba29-b1bdc5dd1bc9}',
    '{c183cf55-ee8e-4e2f-a4be-4aa5f320f6f9}',
    '{22d1f304-5853-4684-ad6b-69b574d75b90}',
    '{418ead54-b6ff-42b9-b52a-dc46a43a92a7}',
    '{384d32b2-9cc0-4770-b89d-f2d9d6f469d4}',
    '{b4bb43b1-e8ef-49c1-8b43-a3dd2c4ce110}',
    '{df9d0103-c3d8-46c8-81c3-9da8397c8805}',
    '{f38a300d-b20c-43f7-9dbe-bef0d81fdb25}',
    '{9221c8ad-969d-4c6d-82cb-ee66d237d734}',
    '{4982f12c-49f6-4f29-9adf-25278bba5668}',
    '{3608a98f-4f41-4d01-932e-d9c5d688eade}',
    '{460708a8-37c4-4bee-a46b-139aaea6faaf}',
    '{02dda4e5-901a-4098-990d-593ae9eea8ec}',
    '{3dc22f5e-bc93-46ba-a613-671ae57d7dc5}',
    '{73aa3c23-bc47-49d0-860b-e1b848c04ee5}',
    '{650df715-b140-44b4-8f50-a69f1f0c839d}',
    '{f73f0d6f-51c9-43a6-9e13-827c1e89e2a6}',
    '{ce18373a-02a7-432b-820e-3e7ab952e23e}',
    '{06f499e3-08d2-4750-8eca-f28bf1362435}',
    '{2d6f31c7-9fc8-406c-bf13-f4a483a8a17d}',
    '{6f97afe7-8191-453e-8137-50aa3ad8c7ea}',
    '{b63224a3-1c98-4159-84f4-89a369fe1da9}',
    '{bc9810df-4926-41cf-bd78-50b5c5fda2b3}',
    '{8fafd38f-409e-4ee7-b934-4fe751e2658f}',
    '{3703310f-377a-4611-93f7-99fe2cb326d4}',
    '{4898ce77-46bd-4d5e-9445-dc052432deb5}',
    '{e3c983bc-07eb-44a6-81de-657d2c104506}',
    '{71583ce9-2e9b-4ab2-9117-226bc7e60c21}',
    '{0d203b59-9062-49e8-b882-904094f81753}',
    '{c2af3e89-6276-4527-8405-550ceef793af}',
    '{aebada3a-5b0f-4ab6-900f-367fbb53b694}',
    '{945077a6-f520-4125-9957-d6cb351dceef}',
    '{602ddfc4-a8dc-4346-8df6-e4b2eb2ad1fb}',
    '{6a588f73-3ae0-4521-9079-214fb507d16c}',
    '{06d1c7da-3876-47a2-a64d-45055b84c389}',
    '{9e5f51fb-7098-4a25-a291-5d2b273d4ec4}',
    '{d9ee4407-af0d-4047-b8a6-896bcdd9589d}',
    '{b6004b24-36fd-4623-96ee-fd89dce0427a}',
    '{242b128a-422b-422c-870e-32b3c6e636af}',
    '{2d02587b-2f69-4b08-b8dd-20379014987f}',
    '{cadbd399-bb81-49aa-a335-034f3a0e3cbb}',
    '{9d379eb1-eb68-4831-9320-e188d95b6e19}',
    '{7cab6c21-cc7d-4ade-9a0b-822dbbeb5007}',
    '{24756f59-2ad1-4f6b-8fd5-a39b11d4f982}',
    '{a93e15dc-009c-4843-a129-299fac334dfb}',
    '{4b61d779-7bc5-457d-a434-a7ae5aa508ba}',
    '{7b54f299-0cd1-4b1f-8e14-afc23e6921d9}',
    '{7996ef11-9df7-4d60-a60b-515553cfd4e9}',
    '{20e7ba92-1778-4774-9ba7-1a88c119f630}',
    '{9ed2b111-4c76-4197-9133-a90752493f7e}',
    '{fe03311b-c45d-4b6a-837c-4bb50a36ad48}',
    '{699f21fb-b1bc-48b0-a95e-2e5f8597c373}',
    '{6fa7a4e3-a966-418f-b244-adee137d5dee}',
    '{61225fd8-0be0-4998-a295-f0762e3e0b6c}',
    '{e4c7835f-b899-4d9c-b719-5bcbcc7fdf81}',
    '{d34e77dd-a8a7-4d81-bcef-028a49ed736d}',
    '{567bfd0c-a0c1-4fb7-930f-8d5301f8c184}',
    '{d51e4800-0ea0-4ad1-9a63-14b29189df62}',
    '{a16b2619-baf6-416b-bd56-23bbf94e64cb}',
    '{a1ee9ad4-f164-4f17-b7ca-bb1bf82e6499}',
    '{55ee610e-e085-427b-9107-9a66bb1a2dcf}',
    '{03e3d142-19e4-4cbe-9f2d-5d009f4ac981}',
    '{b59c14bc-6df7-4229-9d1b-cf31296f1632}',
    '{b7bf3d04-9444-49df-a2c8-bbd0e0848b93}',
    '{abf24315-006c-46e4-82c6-6748118c96c4}',
    '{76984302-e4a9-4d3f-a2ce-c45f0f2c83e7}',
    '{2fcd27e4-4b04-4ac7-ad7b-61d5db416433}',
    '{cea8d1b4-63ce-4432-a419-fd6611560936}',
    '{244d5564-5b1c-48a2-9afc-ea7b4a23e6de}',
    '{9736705d-8a4c-489d-8e8d-e47587fbacc3}',
    '{b5c28f78-4706-410a-adcb-a63c137f697d}',
    '{b54a1c25-3b52-4d1f-8f6e-e06af3b0cf91}',
    '{7c27451d-0f7f-4ed0-ba3d-1211cf5376c8}');

-- Verify 362 rows updated and then commit.