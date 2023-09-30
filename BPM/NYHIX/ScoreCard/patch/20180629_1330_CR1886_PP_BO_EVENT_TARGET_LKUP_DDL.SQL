alter table MAXDAT.pp_bo_event_target_lkup 
add ee_adherence_v2  Varchar2(1);

update MAXDAT.pp_bo_event_target_lkup
set ee_adherence_v2 = 'N';

commit;

update MAXDAT.pp_bo_event_target_lkup
set end_date = to_date('20180331','yyyymmdd')
where EE_ADHERENCE = 'Y'
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



