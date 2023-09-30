--------------------------------------------------------------------------
-- Updates per 51118
--------------------------------------------------------------------------
update maxdat.pp_bo_event_target_lkup set end_date = to_date('20190727','yyyymmdd') where event_id = 1065;
update maxdat.pp_bo_event_target_lkup set end_date = to_date('20190727','yyyymmdd') where event_id = 1119;
update maxdat.pp_bo_event_target_lkup set end_date = to_date('20190726','yyyymmdd') where event_id = 1530;

Insert into MAXDAT.PP_BO_EVENT_TARGET_LKUP 
(EVENT_ID,NAME,TARGET,SCORECARD_FLAG,START_DATE,END_DATE,
CREATE_BY,CREATE_DATETIME,
SCORECARD_GROUP,EE_ADHERENCE,OPS_GROUP,WORKSUBACTIVITY_FLAG,QC_FLAG,EE_ADHERENCE_V2) 
values (1530,'Hickory Learning System',0,'N',to_date('27-JUL-19','DD-MON-RR'),null,
'CR 2308',trunc(sysdate),
'NON-PRODUCTIVE','N','NOT IN SCORECARD','N','N','N');

--update maxdat.pp_bo_event_target_lkup 
--set end_date = to_date('20190628','yyyymmdd') where event_id = 1638;

update maxdat.pp_bo_event_target_lkup 
set target = 8.5 where event_id = 1638;

Insert into MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID,NAME,TARGET,SCORECARD_FLAG,
START_DATE,END_DATE,CREATE_BY,CREATE_DATETIME,
SCORECARD_GROUP,EE_ADHERENCE,OPS_GROUP,WORKSUBACTIVITY_FLAG,QC_FLAG,EE_ADHERENCE_V2) 
values (1586,'Nesting Assist',0,'N',
to_date('27-JUl-19','DD-MON-RR'),null,'CR 2308',trunc(sysdate),
'NON-PRODUCTIVE','N','NOT IN SCORECARD','N','N','N');

Insert into MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID,NAME,TARGET,SCORECARD_FLAG,
START_DATE,END_DATE,CREATE_BY,CREATE_DATETIME,
SCORECARD_GROUP,EE_ADHERENCE,OPS_GROUP,WORKSUBACTIVITY_FLAG,QC_FLAG,EE_ADHERENCE_V2) 
values (1587,'QPP',0,'N',
to_date('27-JUl-19','DD-MON-RR'),null,'CR 2308',trunc(sysdate),
'NON-PRODUCTIVE','N','NOT IN SCORECARD','N','N','N');

Insert into MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID,NAME,TARGET,SCORECARD_FLAG,
START_DATE,END_DATE,CREATE_BY,CREATE_DATETIME,
SCORECARD_GROUP,EE_ADHERENCE,OPS_GROUP,WORKSUBACTIVITY_FLAG,QC_FLAG,EE_ADHERENCE_V2) 
values (1639,'Meeting',0,'N',
to_date('27-JUl-19','DD-MON-RR'),null,'CR 2308',trunc(sysdate),
'NON-PRODUCTIVE','N','NOT IN SCORECARD','N','N','N');

COMMIT;
