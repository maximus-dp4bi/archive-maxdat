-- Created in MAXDAT DEV only, Only returns active rows
CREATE OR REPLACE FORCE VIEW PP_BO_EVENT_TARGET_LKUP_SV 
(EVENT_ID
, NAME
, TARGET
, SCORECARD_FLAG
, START_DATE
, END_DATE
, CREATE_BY
, CREATE_DATETIME
, SCORECARD_GROUP
, EE_ADHERENCE
, OPS_GROUP
) AS 
SELECT EVENT_ID
,NAME
,TARGET
,SCORECARD_FLAG
,START_DATE
,END_DATE
,CREATE_BY
,CREATE_DATETIME
,SCORECARD_GROUP
,EE_ADHERENCE
,OPS_GROUP
 FROM maxdat.pp_bo_event_target_lkup
 WHERE  start_date <= SYSDATE
 	and (end_date IS null
 		or end_date >= SYSDATE);


Grant select on pp_bo_event_target_lkup_sv to MAXDAT_READ_ONLY;
Grant select on pp_bo_event_target_lkup_sv to MAXDAT;
grant select on pp_bo_event_target_lkup_sv to DP_SCORECARD with grant option;

