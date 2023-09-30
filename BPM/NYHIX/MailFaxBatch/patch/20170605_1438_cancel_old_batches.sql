alter session set current_schema = MAXDAT;
---- NYHIX-31565

update corp_etl_mfb_batch_stg set CANCEL_DT = to_date('29-NOV-2015 19:04:37', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted', CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete' ,
STG_DONE_DATE = to_date('29-NOV-2015 19:04:37', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{5eeadae8-b310-4d0d-8449-6cb6ef745e0a}';
update corp_etl_mfb_batch set CANCEL_DT = to_date('29-NOV-2015 19:04:37', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted',CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete' ,
STG_DONE_DATE = to_date('29-NOV-2015 19:04:37', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{5eeadae8-b310-4d0d-8449-6cb6ef745e0a}';

update corp_etl_mfb_batch_stg set CANCEL_DT = to_date('01-APR-2016 10:48:58', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted', CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete',
STG_DONE_DATE = to_date('01-APR-2016 10:48:58', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{67bdc8fd-73ff-4b30-a276-a289572f5cbb}';
update corp_etl_mfb_batch set CANCEL_DT = to_date('01-APR-2016 10:48:58', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted',CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete' ,
STG_DONE_DATE = to_date('01-APR-2016 10:48:58', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{67bdc8fd-73ff-4b30-a276-a289572f5cbb}';

update corp_etl_mfb_batch_stg set CANCEL_DT = to_date('01-APR-2016 11:55:44', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted', CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete',
STG_DONE_DATE = to_date('01-APR-2016 11:55:44', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{3707c66e-3dc7-4a6d-b686-ba140fc3bfa0}';
update corp_etl_mfb_batch set CANCEL_DT = to_date('01-APR-2016 11:55:44 ', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted',CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete' ,
STG_DONE_DATE = to_date('01-APR-2016 11:55:44', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{3707c66e-3dc7-4a6d-b686-ba140fc3bfa0}';

update corp_etl_mfb_batch_stg set CANCEL_DT = to_date('01-APR-2016 11:51:13', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted', CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete',
STG_DONE_DATE = to_date('01-APR-2016  11:51:13', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{8d662b17-ad06-478c-918a-0d30aced0e65}';
update corp_etl_mfb_batch set CANCEL_DT = to_date('01-APR-2016 11:51:13', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted',CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete' ,
STG_DONE_DATE = to_date('01-APR-2017  11:51:13', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{8d662b17-ad06-478c-918a-0d30aced0e65}';

update corp_etl_mfb_batch_stg set CANCEL_DT = to_date('01-APR-2016 11:22:46', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted', CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete',
STG_DONE_DATE = to_date('01-APR-2016 11:22:46', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{ee601b1d-5ce8-49e6-84fa-83bc14bfe776}';
update corp_etl_mfb_batch set CANCEL_DT = to_date('01-APR-2016 11:22:46', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted',CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete' ,
STG_DONE_DATE = to_date('01-APR-2016 11:22:46', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{ee601b1d-5ce8-49e6-84fa-83bc14bfe776}';

update corp_etl_mfb_batch_stg set CANCEL_DT = to_date('01-APR-2016 11:17:08', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted', CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete',
STG_DONE_DATE = to_date('01-APR-2016 11:17:08', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{fa7e57bd-cad1-45c7-a810-d93322126590}';
update corp_etl_mfb_batch set CANCEL_DT = to_date('01-APR-2016 11:17:08', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted',CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete' ,
STG_DONE_DATE = to_date('01-APR-2016 11:17:08', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{fa7e57bd-cad1-45c7-a810-d93322126590}';

update corp_etl_mfb_batch_stg set CANCEL_DT = to_date('01-APR-2016 11:00:19', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted', CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete',
STG_DONE_DATE = to_date('01-APR-2016  11:00:19', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{028cca29-5913-4680-b274-f2b8f3c59b15}';
update corp_etl_mfb_batch set CANCEL_DT = to_date('01-APR-2016 11:00:19', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted',CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete' ,
STG_DONE_DATE = to_date('01-APR-2016 11:00:19', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{028cca29-5913-4680-b274-f2b8f3c59b15}';

update corp_etl_mfb_batch_stg set CANCEL_DT = to_date('01-APR-2016 10:57:22', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted', CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete',
STG_DONE_DATE = to_date('01-APR-2016 10:57:22 ', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{7c1c5355-e34d-47ae-a77b-969177c80251}';
update corp_etl_mfb_batch set CANCEL_DT = to_date('01-APR-2016 10:57:22', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted',CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete' ,
STG_DONE_DATE = to_date('01-APR-2016 10:57:22', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{7c1c5355-e34d-47ae-a77b-969177c80251}';

update corp_etl_mfb_batch_stg set CANCEL_DT = to_date('01-APR-2016 10:52:45', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted', CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete',
STG_DONE_DATE = to_date('01-APR-2016 10:52:45', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{4b5ec4e1-1053-4457-b7e4-9dd20b733b10}';
update corp_etl_mfb_batch set CANCEL_DT = to_date('01-APR-2016 10:52:45', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted',CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete' ,
STG_DONE_DATE = to_date('01-APR-2016 10:52:45', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{4b5ec4e1-1053-4457-b7e4-9dd20b733b10}';

update corp_etl_mfb_batch_stg set CANCEL_DT = to_date('01-APR-2016 10:56:35', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted', CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete',
STG_DONE_DATE = to_date('01-APR-2016 10:56:35 ', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{2e58a38d-c000-4b06-a5ec-dde9b6a0ef8b}';
update corp_etl_mfb_batch set CANCEL_DT = to_date('01-APR-2016 10:56:35', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted',CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete' ,
STG_DONE_DATE = to_date('01-APR-2016 10:56:35', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{2e58a38d-c000-4b06-a5ec-dde9b6a0ef8b}';

update corp_etl_mfb_batch_stg set CANCEL_DT = to_date('01-APR-2016 11:23:39', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted', CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete',
STG_DONE_DATE = to_date('01-APR-2016 11:23:39', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{e204bb97-e858-4ea8-b55c-744efbe37020}';
update corp_etl_mfb_batch set CANCEL_DT = to_date('01-APR-2016 11:23:39', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted',CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete' ,
STG_DONE_DATE = to_date('01-APR-2016 11:23:39', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{e204bb97-e858-4ea8-b55c-744efbe37020}';
commit;

update corp_etl_mfb_batch_stg set CANCEL_DT = to_date('01-APR-2016 10:52:45', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted', CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete',
STG_DONE_DATE = to_date('01-APR-2016 10:52:45', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{4b5ec4e1-1053-4457-b7e4-9dd20b733b10}';
update corp_etl_mfb_batch set CANCEL_DT = to_date('01-APR-2016 10:52:45', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted',CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete' ,
STG_DONE_DATE = to_date('01-APR-2016 10:52:45', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{4b5ec4e1-1053-4457-b7e4-9dd20b733b10}';

update corp_etl_mfb_batch_stg set CANCEL_DT = to_date('01-APR-2016 10:56:35', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted', CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete',
STG_DONE_DATE = to_date('01-APR-2016 10:56:35', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{2e58a38d-c000-4b06-a5ec-dde9b6a0ef8b}';
update corp_etl_mfb_batch set CANCEL_DT = to_date('01-APR-2016 10:56:35', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted',CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete' ,
STG_DONE_DATE = to_date('01-APR-2016 10:56:35', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{2e58a38d-c000-4b06-a5ec-dde9b6a0ef8b}';

update corp_etl_mfb_batch_stg set CANCEL_DT = to_date('01-APR-2016 11:23:39', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted', CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete',
STG_DONE_DATE = to_date('01-APR-2016 11:23:39', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{e204bb97-e858-4ea8-b55c-744efbe37020}';
update corp_etl_mfb_batch set CANCEL_DT = to_date('01-APR-2016 11:23:39', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted',CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete' ,
STG_DONE_DATE = to_date('01-APR-2016 11:23:39', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{e204bb97-e858-4ea8-b55c-744efbe37020}';

update corp_etl_mfb_batch_stg set CANCEL_DT = to_date('01-APR-2016 11:52:51', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted', CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete',
STG_DONE_DATE = to_date('01-APR-2016 11:52:51', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{21101642-919a-425f-9186-0c21222d4395}';
update corp_etl_mfb_batch set CANCEL_DT = to_date('01-APR-2016 11:52:51', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted',CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete' ,
STG_DONE_DATE = to_date('01-APR-2016 11:52:51', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{21101642-919a-425f-9186-0c21222d4395}';

update corp_etl_mfb_batch_stg set CANCEL_DT = to_date('01-APR-2016 11:49:51', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted', CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete',
STG_DONE_DATE = to_date('01-APR-2016 11:49:51', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{9d77962d-7c6f-4643-bf25-048c12717704}';
update corp_etl_mfb_batch set CANCEL_DT = to_date('01-APR-2016 11:49:51', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted',CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete' ,
STG_DONE_DATE = to_date('01-APR-2016 11:49:51', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{9d77962d-7c6f-4643-bf25-048c12717704}';

update corp_etl_mfb_batch_stg set CANCEL_DT = to_date('01-APR-2016 14:21:38', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted', CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete',
STG_DONE_DATE = to_date('01-APR-2016 14:21:38', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{c484e421-1e72-4b97-82ac-a814c1379faa}';
update corp_etl_mfb_batch set CANCEL_DT = to_date('01-APR-2016 14:21:38', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted',CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete' ,
STG_DONE_DATE = to_date('01-APR-2016 14:21:38', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{c484e421-1e72-4b97-82ac-a814c1379faa}';

update corp_etl_mfb_batch_stg set CANCEL_DT = to_date('01-APR-2016 14:04:56', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted', CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete',
STG_DONE_DATE = to_date('01-APR-2016 14:04:56', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{d8afa23f-020d-4c4d-b9e5-dd5b3c748e42}';
update corp_etl_mfb_batch set CANCEL_DT = to_date('01-APR-2016 14:04:56', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted',CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete' ,
STG_DONE_DATE = to_date('01-APR-2016 14:04:56', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{d8afa23f-020d-4c4d-b9e5-dd5b3c748e42}';

update corp_etl_mfb_batch_stg set CANCEL_DT = to_date('01-APR-2016 10:51:31', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted', CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete',
STG_DONE_DATE = to_date('01-APR-2016 10:51:31', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{9c72c2c2-237e-43cd-8878-ff52421a9086}';
update corp_etl_mfb_batch set CANCEL_DT = to_date('01-APR-2016 10:51:31', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted',CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete' ,
STG_DONE_DATE = to_date('01-APR-2016 10:51:31', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{9c72c2c2-237e-43cd-8878-ff52421a9086}';


update corp_etl_mfb_batch_stg set CANCEL_DT = to_date('01-APR-2016 11:23:09', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted', CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete',
STG_DONE_DATE = to_date('01-APR-2016 11:23:09', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{ed1d73a3-d5be-4409-9391-c3fc9445da39}';
update corp_etl_mfb_batch set CANCEL_DT = to_date('01-APR-2016 11:23:09', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted',CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete' ,
STG_DONE_DATE = to_date('01-APR-2016 11:23:09', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{ed1d73a3-d5be-4409-9391-c3fc9445da39}';
commit;

update corp_etl_mfb_batch_stg set CANCEL_DT = to_date('01-APR-2016 11:47:07', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted', CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete',
STG_DONE_DATE = to_date('01-APR-2016 11:47:07', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{c2ada4d5-61f2-4a1b-8a1f-2f5eb4273f30}';
update corp_etl_mfb_batch set CANCEL_DT = to_date('01-APR-2016 11:47:07', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted',CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete' ,
STG_DONE_DATE = to_date('01-APR-2016 11:47:07', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{c2ada4d5-61f2-4a1b-8a1f-2f5eb4273f30}';

update corp_etl_mfb_batch_stg set CANCEL_DT = to_date('01-APR-2016 11:59:18', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted', CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete',
STG_DONE_DATE = to_date('01-APR-2016 11:59:18', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{ad3e0f2b-9eb6-4578-886e-2c4a4f7ed6e6}';
update corp_etl_mfb_batch set CANCEL_DT = to_date('01-APR-2016 11:59:18', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted',CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete' ,
STG_DONE_DATE = to_date('01-APR-2016 11:59:18', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{ad3e0f2b-9eb6-4578-886e-2c4a4f7ed6e6}';

update corp_etl_mfb_batch_stg set CANCEL_DT = to_date('01-APR-2016 11:49:51', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted', CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete',
STG_DONE_DATE = to_date('01-APR-2016 11:49:51', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{9d77962d-7c6f-4643-bf25-048c12717704}';
update corp_etl_mfb_batch set CANCEL_DT = to_date('01-APR-2016 11:49:51', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted',CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete' ,
STG_DONE_DATE = to_date('01-APR-2016  11:49:51', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{9d77962d-7c6f-4643-bf25-048c12717704}';

update corp_etl_mfb_batch_stg set CANCEL_DT = to_date('01-APR-2016 14:21:38', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted', CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete',
STG_DONE_DATE = to_date('01-APR-2016 14:21:38', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{c484e421-1e72-4b97-82ac-a814c1379faa}';
update corp_etl_mfb_batch set CANCEL_DT = to_date('01-APR-2016 14:21:38', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted',CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete' ,
STG_DONE_DATE = to_date('01-APR-2016  14:21:38', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{c484e421-1e72-4b97-82ac-a814c1379faa}';


update corp_etl_mfb_batch_stg set CANCEL_DT = to_date('01-APR-2016 14:21:38', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted', CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete',
STG_DONE_DATE = to_date('01-APR-2016 14:21:38', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{d8afa23f-020d-4c4d-b9e5-dd5b3c748e42}';
update corp_etl_mfb_batch set CANCEL_DT = to_date('01-APR-2016 14:21:38', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted',CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete' ,
STG_DONE_DATE = to_date('01-APR-2016  14:21:38', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{d8afa23f-020d-4c4d-b9e5-dd5b3c748e42}';

update corp_etl_mfb_batch_stg set CANCEL_DT = to_date('01-APR-2016 10:51:31', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted', CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete',
STG_DONE_DATE = to_date('01-APR-2016 10:51:31', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{9c72c2c2-237e-43cd-8878-ff52421a9086}';
update corp_etl_mfb_batch set CANCEL_DT = to_date('01-APR-2016 10:51:31', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted',CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete' ,
STG_DONE_DATE = to_date('01-APR-2016  10:51:31', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{9c72c2c2-237e-43cd-8878-ff52421a9086}';

update corp_etl_mfb_batch_stg set CANCEL_DT = to_date('01-APR-2016 10:53:09', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted', CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete',
STG_DONE_DATE = to_date('01-APR-2016 10:53:09', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{c8219da7-2af5-4410-b09d-5b63d1d534f4}';
update corp_etl_mfb_batch set CANCEL_DT = to_date('01-APR-2016 10:53:09', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted',CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete' ,
STG_DONE_DATE = to_date('01-APR-2016 10:53:09', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{c8219da7-2af5-4410-b09d-5b63d1d534f4}';

update corp_etl_mfb_batch_stg set CANCEL_DT = to_date('01-APR-2016 11:23:09', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted', CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete',
STG_DONE_DATE = to_date('01-APR-2016 11:23:09', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{ed1d73a3-d5be-4409-9391-c3fc9445da39}';
update corp_etl_mfb_batch set CANCEL_DT = to_date('01-APR-2016 11:23:09', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted',CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete' ,
STG_DONE_DATE = to_date('01-APR-2016 11:23:09', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{ed1d73a3-d5be-4409-9391-c3fc9445da39}';

update corp_etl_mfb_batch_stg set CANCEL_DT = to_date('01-APR-2016 11:47:07', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted', CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete',
STG_DONE_DATE = to_date('01-APR-2016 11:47:07', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{c2ada4d5-61f2-4a1b-8a1f-2f5eb4273f30}';
update corp_etl_mfb_batch set CANCEL_DT = to_date('01-APR-2016 11:47:07', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted',CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete' ,
STG_DONE_DATE = to_date('01-APR-2016 11:47:07', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{c2ada4d5-61f2-4a1b-8a1f-2f5eb4273f30}';

update corp_etl_mfb_batch_stg set CANCEL_DT = to_date('01-APR-2016 11:59:18', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted', CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete',
STG_DONE_DATE = to_date('01-APR-2016 11:59:18', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{ad3e0f2b-9eb6-4578-886e-2c4a4f7ed6e6}';
update corp_etl_mfb_batch set CANCEL_DT = to_date('01-APR-2016 11:59:18', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted',CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete' ,
STG_DONE_DATE = to_date('01-APR-2016 11:59:18', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{ad3e0f2b-9eb6-4578-886e-2c4a4f7ed6e6}';

update corp_etl_mfb_batch_stg set CANCEL_DT = to_date('01-APR-2016 10:59:26', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted', CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete',
STG_DONE_DATE = to_date('01-APR-2016 10:59:26', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{4643f0e8-a01f-4650-b4c9-04ed81fa7772}';
update corp_etl_mfb_batch set CANCEL_DT = to_date('01-APR-2016 10:59:26', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted',CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete' ,
STG_DONE_DATE = to_date('01-APR-2016 10:59:26', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{4643f0e8-a01f-4650-b4c9-04ed81fa7772}';

update corp_etl_mfb_batch_stg set CANCEL_DT = to_date('01-APR-2016 11:18:50', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted', CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete',
STG_DONE_DATE = to_date('01-APR-2016 11:18:50', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{4e51fd1e-baa9-4016-a3da-78fa8c66f589}';
update corp_etl_mfb_batch set CANCEL_DT = to_date('01-APR-2016 11:18:50', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted',CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete' ,
STG_DONE_DATE = to_date('01-APR-2016 11:18:50', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{4e51fd1e-baa9-4016-a3da-78fa8c66f589}';

update corp_etl_mfb_batch_stg set CANCEL_DT = to_date('01-APR-2016 13:54:39', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted', CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete',
STG_DONE_DATE = to_date('01-APR-2016 13:54:39', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{647048a5-6053-4078-ab9c-4ca87b321523}';
update corp_etl_mfb_batch set CANCEL_DT = to_date('01-APR-2016 13:54:39', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted',CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete' ,
STG_DONE_DATE = to_date('01-APR-2016 13:54:39', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{647048a5-6053-4078-ab9c-4ca87b321523}';

update corp_etl_mfb_batch_stg set CANCEL_DT = to_date('01-APR-2016 13:34:20', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted', CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete',
STG_DONE_DATE = to_date('01-APR-2016 13:34:20', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{a04ea2df-fb86-4fb9-9297-2f1e4524a0e7}';
update corp_etl_mfb_batch set CANCEL_DT = to_date('01-APR-2016 13:34:20', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted',CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete' ,
STG_DONE_DATE = to_date('01-APR-2016 13:34:20', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{a04ea2df-fb86-4fb9-9297-2f1e4524a0e7}';

update corp_etl_mfb_batch_stg set CANCEL_DT = to_date('01-APR-2016 12:46:28', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted', CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete',
STG_DONE_DATE = to_date('01-APR-2016 12:46:28', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{79c21feb-0b84-4f65-9c51-b0f50e52ed8c}';
update corp_etl_mfb_batch set CANCEL_DT = to_date('01-APR-2016 12:46:28', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted',CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete' ,
STG_DONE_DATE = to_date('01-APR-2016 12:46:28', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{79c21feb-0b84-4f65-9c51-b0f50e52ed8c}';

update corp_etl_mfb_batch_stg set CANCEL_DT = to_date('01-APR-2016 14:48:30', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted', CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete',
STG_DONE_DATE = to_date('01-APR-2016 14:48:30', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{e57bfc23-5024-4f60-9974-1e0d6639697c}';
update corp_etl_mfb_batch set CANCEL_DT = to_date('01-APR-2016 14:48:30', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted',CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete' ,
STG_DONE_DATE = to_date('01-APR-2016 14:48:30', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{e57bfc23-5024-4f60-9974-1e0d6639697c}';

update corp_etl_mfb_batch_stg set CANCEL_DT = to_date('01-APR-2016 13:22:11', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted', CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete',
STG_DONE_DATE = to_date('01-APR-2016 13:22:11', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{64da2e5c-c88c-49a4-8360-9a82b1926321}';
update corp_etl_mfb_batch set CANCEL_DT = to_date('01-APR-2016 13:22:11', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted',CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete' ,
STG_DONE_DATE = to_date('01-APR-2016 13:22:11', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{64da2e5c-c88c-49a4-8360-9a82b1926321}';

update corp_etl_mfb_batch_stg set CANCEL_DT = to_date('01-APR-2016 15:27:08', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted', CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete',
STG_DONE_DATE = to_date('01-APR-2016 15:27:08', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{95e718c7-52a0-4e9f-b678-47f45245cf24}';
update corp_etl_mfb_batch set CANCEL_DT = to_date('01-APR-2016 15:27:08', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted',CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete' ,
STG_DONE_DATE = to_date('01-APR-2016 15:27:08', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{95e718c7-52a0-4e9f-b678-47f45245cf24}';

update corp_etl_mfb_batch_stg set CANCEL_DT = to_date('01-APR-2016 13:31:27', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted', CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete',
STG_DONE_DATE = to_date('01-APR-2016 13:31:27', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{4eb0de56-a56e-4348-bf09-9cdd100c1811}';
update corp_etl_mfb_batch set CANCEL_DT = to_date('01-APR-2016 13:31:27', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted',CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete' ,
STG_DONE_DATE = to_date('01-APR-2016 13:31:27', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{4eb0de56-a56e-4348-bf09-9cdd100c1811}';

update corp_etl_mfb_batch_stg set CANCEL_DT = to_date('01-APR-2016 12:40:08', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted', CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete',
STG_DONE_DATE = to_date('01-APR-2016 12:40:08', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{a12c0e69-2bee-476a-ba26-d26672e6bb73}';
update corp_etl_mfb_batch set CANCEL_DT = to_date('01-APR-2016 12:40:08', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted',CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete' ,
STG_DONE_DATE = to_date('01-APR-2016 12:40:08', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{a12c0e69-2bee-476a-ba26-d26672e6bb73}';

update corp_etl_mfb_batch_stg set CANCEL_DT = to_date('01-APR-2016 12:43:33', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted', CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete',
STG_DONE_DATE = to_date('01-APR-2016 12:43:33', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{4d113c45-8ae1-4114-b16c-dbbbe0ae3b58}';
update corp_etl_mfb_batch set CANCEL_DT = to_date('01-APR-2016 12:43:33', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted',CANCEL_METHOD = 'Exception',INSTANCE_STATUS = 'Complete' ,
STG_DONE_DATE = to_date('01-APR-2016 12:43:33', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{4d113c45-8ae1-4114-b16c-dbbbe0ae3b58}';

update corp_etl_mfb_batch_stg set CANCEL_DT = to_date('01-APR-2016 15:33:11', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted', CANCEL_METHOD = 'Exception',INSTANCE_STATUS = 'Complete',
STG_DONE_DATE = to_date('01-APR-2016 15:33:11', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{2891a85b-3f3d-4515-a018-8f9f00236d18}';
update corp_etl_mfb_batch set CANCEL_DT = to_date('01-APR-2016 15:33:11', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted',CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete' ,
STG_DONE_DATE = to_date('01-APR-2016 15:33:11', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{2891a85b-3f3d-4515-a018-8f9f00236d18}';

update corp_etl_mfb_batch_stg set CANCEL_DT = to_date('01-APR-2016 11:28:18', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted', CANCEL_METHOD = 'Exception',INSTANCE_STATUS = 'Complete',
STG_DONE_DATE = to_date('01-APR-2016 11:28:18 ', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{72735d13-092a-427a-850f-01fed6491b49}';
update corp_etl_mfb_batch set CANCEL_DT = to_date('01-APR-2016 11:28:18', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted',CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete' ,
STG_DONE_DATE = to_date('01-APR-2016 11:28:18', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{72735d13-092a-427a-850f-01fed6491b49}';

update corp_etl_mfb_batch_stg set CANCEL_DT = to_date('01-APR-2016 12:53:37', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted', CANCEL_METHOD = 'Exception',INSTANCE_STATUS = 'Complete',
STG_DONE_DATE = to_date('01-APR-2016 12:53:37', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{be4e57dc-ef27-47c8-a5e1-836e92f9575f}';
update corp_etl_mfb_batch set CANCEL_DT = to_date('01-APR-2016 12:53:37', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted',CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete' ,
STG_DONE_DATE = to_date('01-APR-2016 12:53:37', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{be4e57dc-ef27-47c8-a5e1-836e92f9575f}';

update corp_etl_mfb_batch_stg set CANCEL_DT = to_date('01-APR-2016 11:20:51', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted', CANCEL_METHOD = 'Exception',INSTANCE_STATUS = 'Complete',
STG_DONE_DATE = to_date('01-APR-2016 11:20:51', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{d18ae0a5-3529-4e59-84cd-659bbc9a565d}';
update corp_etl_mfb_batch set CANCEL_DT = to_date('01-APR-2016 11:20:51', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted',CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete' ,
STG_DONE_DATE = to_date('01-APR-2016 11:20:51', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{d18ae0a5-3529-4e59-84cd-659bbc9a565d}';

update corp_etl_mfb_batch_stg set CANCEL_DT = to_date('13-DEC-2016 13:18:47', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted', CANCEL_METHOD = 'Exception',INSTANCE_STATUS = 'Complete',
STG_DONE_DATE = to_date('13-DEC-2016 13:18:47', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{5e279a8d-9dd0-49bf-aab2-21904a13dfa1}';
update corp_etl_mfb_batch set CANCEL_DT = to_date('13-DEC-2016 13:18:47', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted',CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete' ,
STG_DONE_DATE = to_date('13-DEC-2016 13:18:47', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{5e279a8d-9dd0-49bf-aab2-21904a13dfa1}';

update corp_etl_mfb_batch_stg set CANCEL_DT = to_date('01-APR-2016 11:29:54', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted', CANCEL_METHOD = 'Exception',INSTANCE_STATUS = 'Complete',
STG_DONE_DATE = to_date('13-DEC-2016 11:29:54', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{fe1e3572-fef6-4ce6-9bef-89eb494b38f4}';
update corp_etl_mfb_batch set CANCEL_DT = to_date('13-DEC-2016 11:29:54', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted',CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete' ,
STG_DONE_DATE = to_date('13-DEC-2016 11:29:54', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{fe1e3572-fef6-4ce6-9bef-89eb494b38f4}';

update corp_etl_mfb_batch_stg set CANCEL_DT = to_date('01-APR-2016 10:58:57', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted', CANCEL_METHOD = 'Exception',INSTANCE_STATUS = 'Complete',
STG_DONE_DATE = to_date('13-DEC-2016 10:58:57', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{aad80ed7-b64c-45cd-bdca-bec36f87bae1}';
update corp_etl_mfb_batch set CANCEL_DT = to_date('13-DEC-2016  10:58:57', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted',CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete' ,
STG_DONE_DATE = to_date('13-DEC-2016 10:58:57', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{aad80ed7-b64c-45cd-bdca-bec36f87bae1}';

update corp_etl_mfb_batch_stg set CANCEL_DT = to_date('03-MAR-2017 8:09:11', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted', CANCEL_METHOD = 'Exception',INSTANCE_STATUS = 'Complete',
STG_DONE_DATE = to_date('03-MAR-2017 8:09:11', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{6c3e3575-2c8c-4fb0-bf6a-5c6a3d4096a0}';
update corp_etl_mfb_batch set CANCEL_DT = to_date('03-MAR-2017 8:09:11', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted',CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete' ,
STG_DONE_DATE = to_date('03-MAR-2017 8:09:11', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{6c3e3575-2c8c-4fb0-bf6a-5c6a3d4096a0}';

update corp_etl_mfb_batch_stg set CANCEL_DT = to_date('21-MAR-2017 14:19:58', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted', CANCEL_METHOD = 'Exception',INSTANCE_STATUS = 'Complete',
STG_DONE_DATE = to_date('21-MAR-2017 14:19:58', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{0a09838a-c8c2-4326-881b-0e2469bd1c52}';
update corp_etl_mfb_batch set CANCEL_DT = to_date('21-MAR-2017 14:19:58', 'dd-MON-yyyy HH24:MI:SS'), CANCEL_REASON= 'Deleted',CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete' ,
STG_DONE_DATE = to_date('21-MAR-2017 14:19:58', 'dd-MON-yyyy HH24:MI:SS') 
where batch_guid ='{0a09838a-c8c2-4326-881b-0e2469bd1c52}';
commit;




