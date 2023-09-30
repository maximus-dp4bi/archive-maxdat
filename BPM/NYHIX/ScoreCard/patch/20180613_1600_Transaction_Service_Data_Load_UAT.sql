
-- this needs to be from the dp_scorecard schema

insert into dp_scorecard.SC_ATTENDANCE
(
    SC_ATTENDANCE_ID, 
    STAFF_ID, 
    ENTRY_DATE, 
    SC_ALL_ID, 
    ABSENCE_TYPE, 
    POINT_VALUE, 
    CREATE_BY, 
    CREATE_DATETIME, 
    INCENTIVE_FLAG, 
    LAST_UPDATED_BY, 
    LAST_UPDATED_DATETIME
)
with inserts as
(
SELECT distinct
   SC_ATTENDANCE_ID, 
   STAFF_ID, ENTRY_DATE, 
   SC_ALL_ID, ABSENCE_TYPE, POINT_VALUE, 
   CREATE_BY, CREATE_DATETIME, BALANCE, 
   INCENTIVE_BALANCE, TOTAL_BALANCE, INCENTIVE_FLAG, 
   LAST_UPDATED_BY, LAST_UPDATED_DATETIME
FROM restore.SC_ATTENDANCE
where (
   STAFF_ID 
   , ENTRY_DATE 
   , ABSENCE_TYPE 
   , POINT_VALUE 
   , nvl(INCENTIVE_FLAG,'NULL') 
    )
in (
    SELECT 
   STAFF_ID 
   , ENTRY_DATE 
   , ABSENCE_TYPE 
   , POINT_VALUE 
   , nvl(INCENTIVE_FLAG,'NULL') 
    FROM restore.SC_ATTENDANCE
    MINUS
    SELECT 
   STAFF_ID 
   , ENTRY_DATE 
   , ABSENCE_TYPE 
   , POINT_VALUE 
   , nvl(INCENTIVE_FLAG,'NULL') 
    FROM dp_scorecard.SC_ATTENDANCE
    )
)
select distinct
    SEQ_SCAS_ID.nextval, -- inserts.SC_ATTENDANCE_ID, 
    inserts.STAFF_ID, 
    inserts.ENTRY_DATE, 
    lkup.SC_ALL_ID, 
    inserts.ABSENCE_TYPE, 
    inserts.POINT_VALUE, 
    inserts.CREATE_BY, 
    inserts.CREATE_DATETIME, 
    inserts.INCENTIVE_FLAG, 
    inserts.LAST_UPDATED_BY, 
    inserts.LAST_UPDATED_DATETIME
from inserts
join dp_scorecard.SC_ATTENDANCE_ABSENCE_LKUP lkup
on lkup.ABSENCE_TYPE = inserts.ABSENCE_TYPE;

commit;

------------------------------------------------------------------
------------------------------------------------------------------
------------------------------------------------------------------

insert into dp_scorecard.SC_CORRECTIVE_ACTION
(
    CA_ID, STAFF_ID, CA_ENTRY_DATE, 
   CAL_ID, UNSATISFACTORY_BEHAVIOR, COMMENTS, 
   CREATE_BY, CREATE_DATETIME, LAST_UPDATED_BY, 
   LAST_UPDATED_DATETIME
)   
with inserts as 
( SELECT 
    CA_ID, STAFF_ID, CA_ENTRY_DATE, 
   CAL_ID, UNSATISFACTORY_BEHAVIOR, COMMENTS, 
   CREATE_BY, CREATE_DATETIME, LAST_UPDATED_BY, 
   LAST_UPDATED_DATETIME
FROM restore.SC_CORRECTIVE_ACTION
where ( STAFF_ID, trunc(CA_ENTRY_DATE), 
        UNSATISFACTORY_BEHAVIOR, 
        COMMENTS 
       ) 
in (
SELECT 
    STAFF_ID, trunc(CA_ENTRY_DATE), 
   UNSATISFACTORY_BEHAVIOR, 
   COMMENTS 
FROM restore.SC_CORRECTIVE_ACTION
minus
SELECT 
    STAFF_ID, trunc(CA_ENTRY_DATE), 
   UNSATISFACTORY_BEHAVIOR, 
   COMMENTS 
FROM dp_scorecard.SC_CORRECTIVE_ACTION
)
),
UAT_LKUP as
(
select 7 as uat_id,	'Verbal Counseling' as txt from dual union
select 8,	'Documented Verbal Counseling' from dual union
select 9,	'Written Warning' from dual union
select 10,	'Final Written Warning' from dual union
select 11,	'Corrective Action Plan' from dual union
select 12,	'Request for Termination' from dual 
),
PRD_LKUP as
(
select 1 as PRD_ID,	'Verbal Counseling' as txt  from dual union
select 2,	'Documented Verbal Counseling' from dual union
select 3,	'Written Warning' from dual union
select 4,	'Final Written Warning' from dual union
select 5,	'Corrective Action Plan' from dual union
select 6,	'Request for Termination'  from dual 
),
lkup_convert as
( select uat_id, prd_id
from uat_lkup
join prd_lkup
on uat_lkup.txt = prd_lkup.txt
)
select     
    dp_scorecard.SEQ_SCCA_ID.Nextval as CA_ID, 
    inserts.STAFF_ID, 
    inserts.CA_ENTRY_DATE,
    LKUP_convert.uat_ID, 
   inserts.UNSATISFACTORY_BEHAVIOR, 
   inserts.COMMENTS, 
   inserts.CREATE_BY, 
   inserts.CREATE_DATETIME, 
   inserts.LAST_UPDATED_BY, 
   inserts.LAST_UPDATED_DATETIME
from inserts
left outer join  lkup_convert
on lkup_convert.prd_id = inserts.cal_id;

commit;

------------------------------------------------------------------
------------------------------------------------------------------
--------------------------------------------------------

insert into dp_scorecard.sc_goal
(
	GOAL_ID,
	STAFF_ID, 
	GOAL_ENTRY_DATE, 
	GTL_ID, 
	GOAL_DESCRIPTION, 
	GOAL_DATE, 
	PROGRESS_NOTE, 
	CREATE_BY, 
	CREATE_DATETIME, 
	LAST_UPDATED_BY, 
	LAST_UPDATED_DATETIME
)
with UAT_LKUP as
(
select 21 as UAT_ID,	'Career' as txt from dual union
select 3,	'Short Term' from dual union
select 4,	'Long Term' from dual 
),
PRD_LKUP as
(
select 1 as PRD_ID,	'Short Term' as txt from dual union
select 2,	'Long Term' from dual union
select 21,	'Career' from dual 
),
lkup_convert as
( select uat_id, prd_id
from uat_lkup
join prd_lkup
on uat_lkup.txt = prd_lkup.txt
),
inserts as
( select 
	goal_id, 
    STAFF_ID, 
    GOAL_ENTRY_DATE, 
	GTL_ID, 
   GOAL_DESCRIPTION, 
   GOAL_DATE, 
   PROGRESS_NOTE, 
   CREATE_BY, 
   CREATE_DATETIME, 
   LAST_UPDATED_BY, 
   LAST_UPDATED_DATETIME
from restore.sc_goal
where (    STAFF_ID, 
		GOAL_ENTRY_DATE, 
		GOAL_DESCRIPTION, 
		GOAL_DATE, 
		PROGRESS_NOTE, 
		CREATE_DATETIME 
		)
in
( 
SELECT 
    STAFF_ID, 
    GOAL_ENTRY_DATE, 
   GOAL_DESCRIPTION, 
   GOAL_DATE, 
   PROGRESS_NOTE, 
   CREATE_DATETIME 
FROM restore.SC_GOAL
minus
SELECT 
    STAFF_ID, 
    GOAL_ENTRY_DATE, 
   GOAL_DESCRIPTION, 
   GOAL_DATE, 
   PROGRESS_NOTE, 
   CREATE_DATETIME 
from dp_scorecard.sc_goal
)
)
select 	
	dp_scorecard.SEQ_SCGOAL_ID.nextval,
    inserts.STAFF_ID, 
    inserts.GOAL_ENTRY_DATE, 
	lkup_convert.UAT_ID as GTL_ID, 
   inserts.GOAL_DESCRIPTION, 
   inserts.GOAL_DATE, 
   inserts.PROGRESS_NOTE, 
   inserts.CREATE_BY, 
   inserts.CREATE_DATETIME,
   inserts.LAST_UPDATED_BY, 
   inserts.LAST_UPDATED_DATETIME
 from inserts
 join lkup_convert
 on lkup_convert.prd_id = inserts.GTL_ID;

 commit;
 
------------------------------------------------------------------
------------------------------------------------------------------
--------------------------------------------------------

insert into dp_scorecard.SC_PERFORMANCE_TRACKER
(
	PT_ID, --SEQ_SCPT_ID.Nextval,
	STAFF_ID, 
	PT_ENTRY_DATE, 
	DL_ID, 
	COMMENTS, 
	CREATE_BY, 
	CREATE_DATETIME, 
	LAST_UPDATED_BY, 
	LAST_UPDATED_DATETIME
)
with inserts as
(
select 
	PT_ID,
	STAFF_ID, 
	PT_ENTRY_DATE, 
	DL_ID, 
	COMMENTS, 
	CREATE_BY, 
	CREATE_DATETIME, 
	LAST_UPDATED_BY, 
	LAST_UPDATED_DATETIME
FROM restore.SC_PERFORMANCE_TRACKER
where (
	STAFF_ID, 
	PT_ENTRY_DATE, 
	COMMENTS, 
	CREATE_DATETIME 
)
in (
	SELECT 
	STAFF_ID, 
	PT_ENTRY_DATE, 
	COMMENTS, 
	CREATE_DATETIME 
	FROM restore.SC_PERFORMANCE_TRACKER
	MINUS
	SELECT 
	STAFF_ID, 
	PT_ENTRY_DATE, 
	COMMENTS, 
	CREATE_DATETIME 
	FROM dp_scorecard.SC_PERFORMANCE_TRACKER
	)
)
select 
	dp_scorecard.SEQ_SCPT_ID.Nextval as PT_ID, 
	STAFF_ID, 
	PT_ENTRY_DATE, 
	DL_ID, 
	COMMENTS, 
	CREATE_BY, 
	CREATE_DATETIME, 
	LAST_UPDATED_BY, 
	LAST_UPDATED_DATETIME
from inserts;

commit;	
