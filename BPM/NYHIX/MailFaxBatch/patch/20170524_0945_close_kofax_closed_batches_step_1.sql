-- NYHIX-15955 - Close batches missed while Kofax servers were unavailable (May 19 to May 22 2017) including those created during the outage.

-- Get list of uncompleted batches in ETL staging table.
-- NYHXMXDP DB
/*
select '    ''' || BATCH_GUID || ''',' 
from CORP_ETL_MFB_BATCH 
where 
  BATCH_COMPLETE_DT is null 
  and COMPLETE_DT is null 
  and CANCEL_DT is null;
*/

-- Get list of batches completed on source Kofax table that show as uncompleted on ETL staging table.
-- KOFAX Central DB

/*
select '    ''' + BATCHID + ''','
from [kofaxardb]..BATCH 
where 
  CREATIONDTM < '05/23/2015' -- Only batches that may have been missed during outage, not batches yet to be processed.
  and CLASSNAME in('NYSOH-MAIL','NYSOH-FAX')
  and BATCHID in (
--  ...{insert list from ETL staging table query from CORP_ETL_MFB_BATCH}
);
*/
    
-- Update ETL staging table to  mark batches as completed that have completed.
-- Divided into sets of 1000 BATCH_GUIDs as required by Oracle.
-- NYHXMXDP DB

update CORP_ETL_MFB_BATCH cb
set 
  COMPLETE_DT = (select min(v2.create_dt) from d_nyhix_mfd_current_v2 v2 where cb.batch_name = v2.batch_name group by v2.batch_name),
  BATCH_COMPLETE_DT = (select min(v2.create_dt) from d_nyhix_mfd_current_v2 v2 where cb.batch_name = v2.batch_name group by v2.batch_name),
  STG_LAST_UPDATE_DATE = sysdate,
  CURRENT_BATCH_MODULE_ID = 'N/A'
where 
  BATCH_COMPLETE_DT is null 
  and INSTANCE_STATUS = 'Active'
  and BATCH_GUID in (
    '{aad80ed7-b64c-45cd-bdca-bec36f87bae1}',
    '{4643f0e8-a01f-4650-b4c9-04ed81fa7772}',
    '{ee601b1d-5ce8-49e6-84fa-83bc14bfe776}',
    '{ed1d73a3-d5be-4409-9391-c3fc9445da39}',
    '{e204bb97-e858-4ea8-b55c-744efbe37020}',
    '{c2ada4d5-61f2-4a1b-8a1f-2f5eb4273f30}',
    '{3707c66e-3dc7-4a6d-b686-ba140fc3bfa0}',
    '{be4e57dc-ef27-47c8-a5e1-836e92f9575f}',
    '{647048a5-6053-4078-ab9c-4ca87b321523}',
    '{c484e421-1e72-4b97-82ac-a814c1379faa}',
    '{e57bfc23-5024-4f60-9974-1e0d6639697c}',
    '{25e95d78-d2fa-4c41-a9f8-23772745fa57}',
    '{0a09838a-c8c2-4326-881b-0e2469bd1c52}',
    '{b1ad40bb-05b7-45b5-9b5b-7e22e8fcf297}',
    '{eb912bf2-4311-4db6-a53b-6bad784683c4}',
    '{628908f1-04e7-4bb9-b723-c53cf5c1d3f9}',
    '{88bbe68b-22ac-4cb1-816b-f0de2968cf33}',
    '{0c432f79-d31c-4313-8f79-0273e10ff84a}',
    '{dda9925a-e8a9-4c29-be00-2ec81897011a}',
    '{e80a3dfa-691c-48b3-a524-ea9fba65ce31}',
    '{fcc886b1-2725-48f3-904e-5e9de4147a7c}',
    '{173320b1-1e7e-404d-862e-5d4222a58674}',
    '{7f412a40-b9ca-475e-a317-3f0b5683ba7a}',
    '{48cd7c59-470f-4267-8770-2f15915b3a50}',
    '{f9ce56b3-d6e4-4b22-99d1-6db0ced32ed9}',
    '{69d3b08d-74c6-4ae7-b363-5a3a8e256d7b}',
    '{6db248e0-f4bc-4ca5-8869-57adb982f2ad}',
    '{65901869-1713-43ff-8b84-77f69c67d473}',
    '{868ef984-79d3-4f28-9bc4-6fc78f6f3dff}',
    '{ef1d5791-a11e-4273-99ac-d1d25df482a7}',
    '{aa0b4686-1114-4f1f-a2ca-f04a6c09ed54}',
    '{0393c4bc-4d96-4f3d-b01e-d72f9d5c48e5}',
    '{efc42e12-31dc-4794-9b6b-758cc7d2994e}',
    '{c420a241-c3f5-4e05-bf5d-3035b57dbbab}',
    '{f06ed31f-479d-4149-af95-a68dbfa3c8a9}',
    '{0a95d144-8882-48ca-aa6a-6699a677e250}',
    '{6c731ddf-2df3-431a-9dad-c8c64eec1f66}',
    '{25f8a8c1-84d3-41bf-bd26-01e0ed38fdad}',
    '{c13221c3-3616-41dc-b051-d05680bb2a6c}',
    '{a665fee0-ddb8-4725-97b9-34881612b690}',
    '{028cca29-5913-4680-b274-f2b8f3c59b15}',
    '{2e58a38d-c000-4b06-a5ec-dde9b6a0ef8b}',
    '{c8219da7-2af5-4410-b09d-5b63d1d534f4}',
    '{72735d13-092a-427a-850f-01fed6491b49}',
    '{ad3e0f2b-9eb6-4578-886e-2c4a4f7ed6e6}',
    '{a04ea2df-fb86-4fb9-9297-2f1e4524a0e7}',
    '{6c3e3575-2c8c-4fb0-bf6a-5c6a3d4096a0}',
    '{f7cc276c-28a5-4877-abd0-66d91342a59e}',
    '{5899330a-0fbc-42c2-8424-d01ee6c92fda}',
    '{2a57b479-7e14-4d5a-967d-93052b10380c}',
    '{d93e449c-07c3-4aa3-bffc-a50fd2f9222b}',
    '{f59d8209-12ab-40d1-8e52-42fca196d022}',
    '{0b53a389-32a0-4deb-891f-831da9609aee}',
    '{4e45210b-866b-4ab4-b774-c4c3428c6995}',
    '{9ea64943-a5ed-460b-9038-c622a6ca778b}',
    '{cc2f205f-f128-496d-8e51-87decb07099b}',
    '{4f7d851c-f769-4329-8943-ded8b5e94c91}',
    '{3354c462-ebe9-4445-a58f-138ac53c0b96}',
    '{f74550b4-3c1f-499d-94c8-5e137006481f}',
    '{8fcdbda9-cf9f-4593-a5e4-494f9e2fe4f3}',
    '{3ca6b731-2020-471d-b958-a4b8be9ef1b8}',
    '{2e87b26b-79fa-488e-a1d9-be1d7a9895d1}',
    '{fbe908d4-c531-42c3-9c95-336cec230598}',
    '{75bf184d-bc88-4cd9-8575-cfbf5c5e4a99}',
    '{a1269767-5d58-486b-80c0-1e12580669d9}',
    '{2b4b5466-0962-48c1-a820-7ecfb0422eb0}',
    '{9ba61510-3300-4451-b30b-93c13d80b5c5}',
    '{cae82368-9dbb-40b4-b14d-e0f639a4780a}',
    '{c683f69a-d998-41fc-afa1-2378b11cfec8}',
    '{8da8b82e-fa03-4854-b970-2b8019cbe62f}',
    '{48d439a4-180b-4241-b708-da014797a5fc}',
    '{57cc38ac-61b9-4512-88a8-8b85eefc0d39}',
    '{aebd85eb-6171-4d47-809d-5252d7ea1095}',
    '{7a2f6c0d-fb26-4089-8d3c-09a1ac3f39fe}',
    '{37dbcedd-2d50-4270-a918-c95630ca96f7}',
    '{a9bfece8-f372-45e8-b507-82f0671ce429}',
    '{ff1ced27-93cb-41d6-8c0a-a3c86c92bdfa}',
    '{0e375cd0-8314-48b0-b8e6-6afe7b2d0032}',
    '{4e51fd1e-baa9-4016-a3da-78fa8c66f589}',
    '{d18ae0a5-3529-4e59-84cd-659bbc9a565d}',
    '{fe1e3572-fef6-4ce6-9bef-89eb494b38f4}',
    '{21101642-919a-425f-9186-0c21222d4395}',
    '{4d113c45-8ae1-4114-b16c-dbbbe0ae3b58}',
    '{64da2e5c-c88c-49a4-8360-9a82b1926321}',
    '{d8afa23f-020d-4c4d-b9e5-dd5b3c748e42}',
    '{79c21feb-0b84-4f65-9c51-b0f50e52ed8c}',
    '{a12c0e69-2bee-476a-ba26-d26672e6bb73}',
    '{4eb0de56-a56e-4348-bf09-9cdd100c1811}',
    '{2891a85b-3f3d-4515-a018-8f9f00236d18}',
    '{98d40f0b-ba56-4de0-8430-a0cd77ad73bd}',
    '{07b88afc-6610-4e77-aa80-977b7d983957}',
    '{c5eba0e3-1c4b-4086-adf5-bfe10fb03e8b}',
    '{d5367d86-b760-4bcb-98cc-974f6a16f1fe}',
    '{0869e976-0092-43e8-b69f-13cb698d6cc5}',
    '{e1d90c3f-f75c-486c-a2ea-5ac308cc2431}',
    '{fe450529-ffb2-41d0-9dd7-aedf6aaa1db1}',
    '{9875d64a-6181-4af3-82e2-40def0d630bb}',
    '{8d52bd8c-0a48-4cd7-b2d5-3c0a5a1ec07a}',
    '{7403059d-9f79-48c4-8c7c-7d5fe1b0b359}',
    '{5e0015c0-b0f0-4f69-98f7-03003021ad05}',
    '{720ee47b-f509-46a1-9a32-155aa34a36d0}',
    '{254b661e-28c1-4bec-a3d4-fdb87289c2af}',
    '{16034b2b-5183-43c0-b63b-f1662512d1bc}',
    '{357757dd-cda1-462b-8a53-538787d9e58f}',
    '{fececacb-d39d-44e2-ad82-8195c4571638}',
    '{f18d4ab8-c731-4efc-93c3-62a1840e3f5b}',
    '{14f77aa4-f51d-4f1f-9cec-8fa17b2e3505}',
    '{6d59fa34-8383-44fc-ad96-d1c36366233d}',
    '{57c45d5f-f09f-425d-aefb-ca59fc1c2b5e}',
    '{f25a3f20-cdc0-4b78-98b0-e274c7494068}',
    '{074e31df-9b6d-46ba-b013-dde03f92d361}',
    '{8ced1276-af32-4e21-aca8-a6bd3d32d0b3}',
    '{b73ccc1b-f143-430d-b738-15f5bff67b22}',
    '{5eeadae8-b310-4d0d-8449-6cb6ef745e0a}',
    '{67bdc8fd-73ff-4b30-a276-a289572f5cbb}',
    '{7c1c5355-e34d-47ae-a77b-969177c80251}',
    '{fa7e57bd-cad1-45c7-a810-d93322126590}',
    '{4b5ec4e1-1053-4457-b7e4-9dd20b733b10}',
    '{9c72c2c2-237e-43cd-8878-ff52421a9086}',
    '{8d662b17-ad06-478c-918a-0d30aced0e65}',
    '{9d77962d-7c6f-4643-bf25-048c12717704}',
    '{95e718c7-52a0-4e9f-b678-47f45245cf24}',
    '{5e279a8d-9dd0-49bf-aab2-21904a13dfa1}',
    '{4a76019c-bd1c-4ff6-a115-d0b586cf7900}',
    '{b26016a1-1e11-4ff9-a997-e63ce8750ac0}',
    '{906182d4-5d4b-4eb4-9d20-b8a0236928d8}',
    '{42c85217-ebaa-4e68-868f-b46f858fb2b7}',
    '{e50e797a-df4d-4152-92f7-d694b8a69843}',
    '{d5a7e4f6-e888-427a-a79c-6ce6d030e329}',
    '{6283c72d-6f2b-43a7-b053-095cff773935}',
    '{bfcae6be-0c54-4fca-8cb7-0a704dce7017}',
    '{42796e62-9337-4d81-9295-3219306f9b35}',
    '{1c60c0d2-d4bc-4ea6-9d6b-d41164d27470}',
    '{6f54aced-d120-411c-ad3e-280988d99824}',
    '{12d38e56-d349-454c-9e18-fc255a192914}',
    '{fa4a75eb-0196-4c2b-b920-8f601fc83fb8}',
    '{8a6bfa07-7c7d-4520-8cb6-1b5a74e90bed}',
    '{0a38282c-6465-4383-aacb-c642e911c5fd}',
    '{02a7dd47-9063-495b-a5cf-c618abfad64e}',
    '{2a9fb943-fefb-441a-8ced-f3cb3d491bba}',
    '{765328b6-f2bc-4019-a6da-cce035d0b95e}',
    '{926ab251-1286-4909-bef9-b82842db7e57}',
    '{326db5d9-6f51-47d2-8006-d9cc83c6abf5}',
    '{810c1a1e-b00e-4bdc-830e-28104dea15d1}',
    '{2b7c341b-a2a7-4c0d-99bd-c65035376188}',
    '{4d450fbb-c1e2-4da7-b280-cd4ff5fa770a}',
    '{07d599a1-47f5-4df2-916f-c996e70b8683}',
    '{f8d5cda3-d7ed-439c-9e11-54975d3ca151}',
    '{4afb4cba-6bae-4b84-837b-f658ee7969cc}',
    '{e42a7775-4487-4ea3-be5a-e14f47e79855}',
    '{2e11bf54-8f0f-4df4-9fc5-ca3133dc1880}',
    '{85ad5747-33fd-4b65-ab08-b27f5a42f7b9}',
    '{f6696b10-3d5e-449a-989c-17a3565b067a}');

-- Verify 153 rows updated and then commit.