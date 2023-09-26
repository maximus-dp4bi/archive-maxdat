alter table MAXDAT.pp_bo_event_target_lkup 
add ee_adherence_v2  Varchar2(1);

update MAXDAT.pp_bo_event_target_lkup
set ee_adherence_v2 = 'N';

commit;

update MAXDAT.pp_bo_event_target_lkup
set end_date = to_date('20180331','yyyymmdd')
where EE_ADHERENCE = 'Y'
and start_date <= to_date('20180331','yyyymmdd')
and end_date is null;

commit;

insert into MAXDAT.pp_bo_event_target_lkup
select 
   EVENT_ID, NAME, 
   TARGET, SCORECARD_FLAG, 
   to_date('20180401','yyyymmdd') as START_DATE, 
   to_date(null) as END_DATE, 
   'CR1886' as CREATE_BY, 
   sysdate as CREATE_DATETIME, 
   SCORECARD_GROUP, 
   'N'  EE_ADHERENCE,
   OPS_GROUP, 
   WORKSUBACTIVITY_FLAG, 
   QC_FLAG,
   'Y' as EE_ADHERENCE_v2 
from MAXDAT.pp_bo_event_target_lkup
where EE_ADHERENCE = 'Y'
and end_date = to_date('20180331','yyyymmdd');

commit;


-- Changing 'N' to 'Y' 

update MAXDAT.pp_bo_event_target_lkup
set end_date = to_date('20180331','yyyymmdd')
where event_id in (1198, 1260, 1264, 1304, 1316, 1346, 1347, 1355, 1364, 1379)
and start_date < to_date('20180331','yyyymmdd')
 and EE_ADHERENCE = 'N'
and end_date is null;

insert into MAXDAT.pp_bo_event_target_lkup
select 
   EVENT_ID, NAME, 
   TARGET, SCORECARD_FLAG, 
   to_date('20180401','yyyymmdd') as START_DATE, 
   to_date(null) as END_DATE, 
   'CR1886' as CREATE_BY, 
   sysdate as CREATE_DATETIME, 
   SCORECARD_GROUP, 
   'N'  EE_ADHERENCE,
   OPS_GROUP, 
   WORKSUBACTIVITY_FLAG, 
   QC_FLAG,
   'Y' as EE_ADHERENCE_v2 
from MAXDAT.pp_bo_event_target_lkup
where event_id in (1198, 1260, 1264, 1304, 1316, 1346, 1347, 1355, 1364, 1379) 
and EE_ADHERENCE = 'N'
and end_date = to_date('20180331','yyyymmdd');

commit;

--select * from MAXDAT.pp_bo_event_target_lkup
--where event_id in (1198, 1260, 1264, 1304, 1316, 1346, 1347, 1355, 1364, 1379)
--order by event_id, start_date;


-- Changing 'N' to 'Y'  - round 2 

update MAXDAT.pp_bo_event_target_lkup
set end_date = to_date('20180331','yyyymmdd')
where event_id in ( 1239, 1245, 1246, 1250, 1256, 1348, 1349, 1380)
and start_date < to_date('20180331','yyyymmdd')
 and EE_ADHERENCE = 'N'
and end_date is null;

insert into MAXDAT.pp_bo_event_target_lkup
select 
   EVENT_ID, NAME, 
   TARGET, SCORECARD_FLAG, 
   to_date('20180401','yyyymmdd') as START_DATE, 
   to_date(null) as END_DATE, 
   'CR1886' as CREATE_BY, 
   sysdate as CREATE_DATETIME, 
   SCORECARD_GROUP, 
   'N'  EE_ADHERENCE,
   OPS_GROUP, 
   WORKSUBACTIVITY_FLAG, 
   QC_FLAG,
   'Y' as EE_ADHERENCE_v2 
from MAXDAT.pp_bo_event_target_lkup
where event_id in ( 1239, 1245, 1246, 1250, 1256, 1348, 1349, 1380)
and EE_ADHERENCE = 'N'
and end_date = to_date('20180331','yyyymmdd');

commit;

-- Deleting the Serving teams??

delete from MAXDAT.PP_BO_EVENT_TARGET_LKUP
where event_id in
( 22, 1000, 1003, 1006, 1007, 1008, 1009, 1010, 1011, 1018, 
1019, 1020, 1021, 1022, 1023, 1024, 1044, 1045, 1046, 1047,
1052, 1057, 1060, 1061, 1077, 1080, 1081, 1081, 1082, 1118,
1121, 1122, 1123, 1126, 1128, 1129, 1130, 1192, 1196, 1215,
1219, 1220, 1221, 1222, 1226, 1227, 1231, 1232, 1233, 1234,
1235, 1292, 1368, 1370, 1371, 1401, 1434, 1435, 1437, 1438,
1439, 1440, 1441, 1452, 1470, 1481 );

commit;

