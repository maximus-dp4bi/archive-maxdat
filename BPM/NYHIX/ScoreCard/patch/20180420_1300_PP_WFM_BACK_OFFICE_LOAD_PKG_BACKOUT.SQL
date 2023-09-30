create or replace PACKAGE              PP_WFM_BACK_OFFICE_LOAD_PKG AS
-- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
 	SVN_FILE_URL varchar2(200) := '$URL: svn://rcmxapp1d.maximus.com/maxdat/BPM/NYHIX/patch/20170623_PP_WFM_BACK_OFFICE_LOAD_PKG.sql $';
  	SVN_REVISION varchar2(20) := '$Revision: 20489 $';
 	SVN_REVISION_DATE varchar2(60) := '$Date: 2017-07-03 15:31:06 -0400 (Mon, 03 Jul 2017) $';
  	SVN_REVISION_AUTHOR varchar2(20) := '$Author: wl134672 $';

	PROCEDURE LOAD_SC_PROD_AND_SMRY;
	PROCEDURE STEP1_LOAD_DAILY_SUMMARY_WRK;
	PROCEDURE STEP2_LOAD_DAILY_SUMMARY;
	PROCEDURE STEP3_LOAD_SC_PRODUCTION_BO;
	PROCEDURE STEP4_LOAD_SC_SUMMARY_BO;
--	PROCEDURE STEP5_LOAD_SC_LOGGED_IN_TIME;

	PROCEDURE LOAD_SC_SUMMARY_BO_ROLLUP;
END PP_WFM_BACK_OFFICE_LOAD_PKG;

create or replace PACKAGE BODY              PP_WFM_BACK_OFFICE_LOAD_PKG AS

----------------------------------------
-- *************************************
-- *************************************
-- *************************************
----------------------------------------
PROCEDURE LOAD_SC_PROD_AND_SMRY IS

	BEGIN
		NULL;

		STEP1_LOAD_DAILY_SUMMARY_WRK;
		STEP2_LOAD_DAILY_SUMMARY;
		STEP3_LOAD_SC_PRODUCTION_BO;
		STEP4_LOAD_SC_SUMMARY_BO;
	--	STEP5_LOAD_SC_LOGGED_IN_TIME;


	EXCEPTION
		WHEN OTHERS THEN RAISE;

	END;

----------------------------------------
-- *************************************
-- *************************************
-- *************************************
----------------------------------------
PROCEDURE STEP1_LOAD_DAILY_SUMMARY_WRK IS
	BEGIN
		NULL;

		execute immediate 'truncate table DP_SCORECARD.PP_WFM_Daily_Summary_WRK';

		--delete from DP_SCORECARD.PP_WFM_Daily_Summary_WRK;

		--commit;

Insert into DP_SCORECARD.PP_WFM_Daily_Summary_WRK
( STAFF_ID, EVENT_ID, EVENT_DATE,
	SUPERVISOR_STAFF_ID, STAFF_HIRE_DATE, STAFF_TERMINATION_DATE,
	OFFICE,
	DEPARTMENT,
	BUILDING,
   SCORECARD_GROUP,
   SCORECARD_FLAG,
   EE_ADHERENCE,
   SUBACTIVITY_LOGGED,
   SUBACTIVITY_FLAG,
   RECORD_COUNT,
   TOTAL_LOGGED,
   HANDLE_TIME_IN_SECONDS,
   TARGET, OPS_GROUP )
select
	ACTUALS.STAFF_ID,
	ACTUALS.EVENT_ID,
	trunc(ACTUALS.task_start) as EVENT_DATE,
	HSV.SUPERVISOR_STAFF_ID,
	HSV.HIRE_DATE,
	HSV.TERMINATION_DATE,
	HSV.OFFICE,
	HSV.DEPARTMENT,
	HSV.BUILDING,
	TARGRT_LKUP.scorecard_group,
	TARGRT_LKUP.SCORECARD_FLAG,
	TARGRT_LKUP.EE_ADHERENCE,
	sum(to_number(
	case
        when TARGRT_LKUP.SUBACTIVITY_FLAG = 'Y'
        and LENGTH(TRIM(TRANSLATE(ACTUALS.WORK_SUBACTIVITY, ' +-.0123456789', ' '))) is null
        and trim(ACTUALS.WORK_SUBACTIVITY) <> '+'
        and trim(ACTUALS.WORK_SUBACTIVITY) <> '-'
        and trim(ACTUALS.WORK_SUBACTIVITY) <> '.'
        then ACTUALS.WORK_SUBACTIVITY
        else '0'
        end
        )
	) 	as SUBACTIVITY_LOGGED,
    TARGRT_LKUP.SUBACTIVITY_FLAG,
	count(ACTUALS.RT_ACTUALS_ID)     as record_count,
----------------------------
	SUM(
		CASE WHEN TARGRT_LKUP.SUBACTIVITY_FLAG = 'Y'
        and LENGTH(TRIM(TRANSLATE(ACTUALS.WORK_SUBACTIVITY, ' +-.0123456789', ' '))) is null
       -- and trim(ACTUALS.WORK_SUBACTIVITY) <> ''
        and trim(ACTUALS.WORK_SUBACTIVITY) <> '+'
        and trim(ACTUALS.WORK_SUBACTIVITY) <> '-'
        and trim(ACTUALS.WORK_SUBACTIVITY) <> '.'
        then TO_NUMBER(ACTUALS.WORK_SUBACTIVITY)
		WHEN TARGRT_LKUP.SUBACTIVITY_FLAG = 'N'
		THEN 1
        else 0
        end
		)    AS TOTAL_LOGGED,
----------------------------
   sum((task_end-task_start)*24*60*60)  as HANDLE_TIME_IN_SECONDS,
	TARGRT_LKUP.target,
	TARGRT_LKUP.ops_group
from
( select * from MAXDAT.PP_WFM_ACTUALS
	where trunc(task_end) = trunc(task_start)  --<< Only use events that start and end on the same day
	AND NVL(EXCLUSION_FLAG,'N') <> 'Y'
	and trunc(task_start) >= TRUNC(ADD_MONTHS(SYSDATE, -12), 'MM')
) ACTUALS
LEFT OUTER JOIN DP_SCORECARD.SCORECARD_HIERARCHY_SV HSV
	ON HSV.STAFF_STAFF_ID = ACTUALS.STAFF_ID
JOIN  (select event_id,
       case
         when upper(scorecard_group) like 'OTHER%' then
          'All Other Tasks'
         else
          scorecard_group
       end as scorecard_group,
	   SCORECARD_FLAG,
       trunc(start_date)   as start_date,
       NVL(trunc(end_date), trunc(sysdate+1)) as end_date,
       WORKSUBACTIVITY_FLAG  AS SUBACTIVITY_FLAG,
	   EE_ADHERENCE,
	   target,
	   ops_group
  from maxdat.PP_BO_EVENT_TARGET_LKUP/*_SV*/
	)  TARGRT_LKUP
    on   (ACTUALS.EVENT_ID = TARGRT_LKUP.EVENT_ID)
    and (trunc(ACTUALS.TASK_START) >= trunc(TARGRT_LKUP.start_date)
    and trunc(ACTUALS.TASK_START) <= trunc(TARGRT_LKUP.end_date) )
group by
	ACTUALS.STAFF_ID,
	ACTUALS.EVENT_ID,
	HSV.SUPERVISOR_STAFF_ID,
	HSV.HIRE_DATE,
	HSV.TERMINATION_DATE,
	HSV.OFFICE,
    HSV.DEPARTMENT,
    HSV.BUILDING,
	TARGRT_LKUP.scorecard_group,
	TARGRT_LKUP.SCORECARD_FLAG,
	EE_ADHERENCE,
	SUBACTIVITY_FLAG,
	trunc(ACTUALS.task_start),
	TARGRT_LKUP.target,
	TARGRT_LKUP.ops_group
order by trunc(ACTUALS.task_start),
	ACTUALS.STAFF_ID,
	ACTUALS.EVENT_ID;

commit;

	EXCEPTION
		WHEN OTHERS THEN RAISE;

	END;

----------------------------------------
-- *************************************
-- *************************************
-- *************************************
----------------------------------------
PROCEDURE STEP2_LOAD_DAILY_SUMMARY IS
----------------------------------------
-- Be sure to first populate >>> DP_SCORECARD.PP_WFM_Daily_Summary_WRK
----------------------------------------

	BEGIN

	rollback;  -- PP_WFM_DAILY_SUMMARY

	EXECUTE IMMEDIATE 'truncate table DP_SCORECARD.PP_WFM_DAILY_SUMMARY';

	--commit;


Insert into DP_SCORECARD.PP_WFM_DAILY_SUMMARY
( STAFF_ID, EVENT_ID, EVENT_DATE,
	SUPERVISOR_STAFF_ID, STAFF_HIRE_DATE, STAFF_TERMINATION_DATE,
	OFFICE,
	----------------------------
	DEPARTMENT, BUILDING,
	----------------------------
   SCORECARD_GROUP,
   scorecard_flag,
   EE_ADHERENCE,
   SUBACTIVITY_LOGGED, 		--<< WORK_SUBACTIVITY,
   SUBACTIVITY_FLAG,        --<<WORKSUBACTIVITY_FLAG,
   RECORD_COUNT,
   total_logged,
   HANDLE_TIME_IN_SECONDS,
   target,
	ops_group)
select
	D.STAFF_ID, D.EVENT_ID, D.EVENT_DATE,
	D.SUPERVISOR_STAFF_ID, D.STAFF_HIRE_DATE, D.STAFF_TERMINATION_DATE,
	D.OFFICE,
	D.DEPARTMENT, D.BUILDING,
	D.scorecard_group,
	D.SCORECARD_FLAG,
	D.EE_ADHERENCE,
	D.SUBACTIVITY_LOGGED,
	D.subactivity_flag,
	D.record_count,
	d.TOTAL_LOGGED,
	D.HANDLE_TIME_IN_SECONDS,
	D.TARGET,
	d.OPS_GROUP
from DP_SCORECARD.PP_WFM_Daily_Summary_WRK D
where ( D.scorecard_flag = 'Y' or D.EE_ADHERENCE = 'Y' )
and D.building is not null
and D.department is not null
order by D.EVENT_DATE,
	D.STAFF_ID,
	D.EVENT_ID;

commit;

	EXCEPTION
		WHEN OTHERS THEN RAISE;

	END;

----------------------------------------
-- *************************************
-- *************************************
-- *************************************
----------------------------------------
PROCEDURE STEP3_LOAD_SC_PRODUCTION_BO IS
	BEGIN
		NULL;


EXECUTE IMMEDIATE 'TRUNCATE TABLE dp_scorecard.SC_PRODUCTION_BO';

EXECUTE IMMEDIATE 'TRUNCATE TABLE dp_scorecard.SC_SUMMARY_BO';

-----------------------------------------
-- ********** DAILY *********************
-----------------------------------------

-----------------------------------------
--  DAILY 1.1  Total Logged
-----------------------------------------

insert into dp_scorecard.sc_production_bo
  (staff_id, dates,
  event_name_sort, event_name,
  event_subname_sort, event_subname,
  metric)
select DS.staff_id, DS.dates,
DS.event_name_sort, DS.event_name,
DS.event_subname_sort, DS.event_subname,
sum(DS.metric)
from (
select
	staff_id						as staff_id,
	event_date						as dates,
	case when scorecard_group = 'All Other Tasks'
		then 2
		else 1
	end 							as event_name_sort,
	scorecard_group                 as event_name,
	1   							as event_subname_sort,
	'Total Logged'  				as event_subname,
	case when subactivity_flag = 'Y' then nvl(subactivity_logged,0)
	    when nvl(subactivity_flag,'N') = 'N' then nvl(total_logged,0)
	    else 0
	    end 			            as metric
From DP_SCORECARD.PP_WFM_DAILY_SUMMARY
where 1=1
and scorecard_flag = 'Y'
and trunc(nvl(STAFF_TERMINATION_DATE,sysdate)) >= event_date
and department is not null
and building is not null
and supervisor_staff_id is NOT null
) DS
group by DS.staff_id, DS.dates,
	DS.event_name_sort, DS.event_name,
	DS.event_subname_sort, DS.event_subname;

commit;

-----------------------------------------
-- *****  1.2 Total Activity Time in Hrs  ***
-----------------------------------------
--select staff_id, end_date,
--case when scorecard_group = 'All Other Tasks' then 2 else 1 end,

insert into dp_scorecard.sc_production_bo
  (staff_id, dates,
  event_name_sort, event_name,
  event_subname_sort, event_subname,
  metric)
SELECT staff_id, dates, event_name_sort, event_name, event_subname_sort, event_subname, SUM(metric)
FROM (
select
	staff_id						as staff_id,
	event_date						as dates,
	case when scorecard_group = 'All Other Tasks'
		then 2
		else 1
	end 							as event_name_sort,
	scorecard_group                 as event_name,
	2   							as event_subname_sort,
	'Total Activity Time'			as event_subname,
	nvl(HANDLE_TIME_IN_SECONDS/3600,0) 				as metric --<< Time in hours
From DP_SCORECARD.PP_WFM_DAILY_SUMMARY D
where nvl(HANDLE_TIME_IN_SECONDS,0) <> 0
and scorecard_flag = 'Y'
and trunc(nvl(STAFF_TERMINATION_DATE,sysdate)) >= event_date
and department is not null
and building is not null
)
GROUP BY staff_id, dates, event_name_sort, event_name, event_subname_sort, event_subname;

commit;

-----------------------------------------
-- *****  1.3 Task Production  ***
-----------------------------------------

--Task Production : ([Total Logged] / ([Total Activity Time in Hrs] / [Max (QC Target)]))

insert into dp_scorecard.sc_production_bo
  (staff_id, dates, event_name_sort, event_name, event_subname_sort, event_subname, metric)
SELECT staff_id, dates, event_name_sort, event_name, event_subname_sort, event_subname, SUM(metric)
FROM (
select
	staff_id						as staff_id,
	event_date						as dates,
	case when scorecard_group = 'All Other Tasks'
		then 2
		else 1
	end 							as event_name_sort,
	scorecard_group                 as event_name,
	3   							as event_subname_sort,
	'Task Production'  				as event_subname,
	nvl(TOTAL_LOGGED/(HANDLE_TIME_IN_hours)/TARGET, 0) 			as metric
From
    ( select
        staff_id,
        event_date,
        scorecard_group,
		sum(TOTAL_LOGGED)	AS TOTAL_LOGGED,
        sum(HANDLE_TIME_IN_SECONDS)/3600 	AS HANDLE_TIME_IN_hours,
        MAX(TARGET) 		AS TARGET
	from DP_SCORECARD.PP_WFM_DAILY_SUMMARY
	where supervisor_staff_id is NOT NULL
    and scorecard_flag = 'Y'
	and trunc(nvl(STAFF_TERMINATION_DATE,sysdate)) >= event_date
	and department is not null
	and building is not null
	GROUP BY
        staff_id,
        event_date,
        scorecard_group
	) D
	-- PROTECT AGAINST ZERO DIVIDE ERRORS
    where nvl(HANDLE_TIME_IN_hours,0) <> 0
    AND NVL(TARGET,0) <> 0
)
GROUP BY staff_id, dates, event_name_sort, event_name, event_subname_sort, event_subname
order by 1,2,3,4,5,6;


commit;

-------------------
--Daily PRODUCTION
-------------------

insert into dp_scorecard.sc_production_bo
  (staff_id, dates, event_name_sort, event_name, event_subname_sort, event_subname, metric)
select staff_id, dates, 3, 'Daily Production',  1, NULL, daily_production_metric
from
(
select staff_id, dates, sum(subtotal) as numerator, sum(total_act_time_metric) as denominator,
sum(subtotal) / sum(total_act_time_metric) as daily_production_metric
from
(
select tp.staff_id,
       tp.dates,
       tp.event_name,
       tp.task_prod_metric,
       tat.total_act_time_metric,
       (tp.task_prod_metric * tat.total_act_time_metric) as subtotal
  from (select staff_id, dates, event_name, metric as task_prod_metric
          from dp_scorecard.sc_production_bo
         where event_subname = 'Task Production') tp
  join (select staff_id, dates, event_name, metric as total_act_time_metric
          from dp_scorecard.sc_production_bo
         where event_subname = 'Total Activity Time') tat
    on tp.staff_id = tat.staff_id
   and tp.dates = tat.dates
   and tp.event_name = tat.event_name
)
group by staff_id, dates
);

commit;

------------------------------
--Daily Adherence (PRODUCTION)
------------------------------

insert into dp_scorecard.sc_production_bo
  (staff_id, dates, event_name_sort, event_name, event_subname_sort, event_subname, metric)
With PRODUCTIVITIY as
	( SELECT D. STAFF_ID, D.EVENT_DATE, D.PRODUCTIVITIY
	FROM
        ( SELECT STAFF_ID,
            event_date,
          --  EVENT_ID,
            SUM(HANDLE_TIME_IN_SECONDS) as PRODUCTIVITIY
        FROM DP_SCORECARD.PP_WFM_DAILY_SUMMARY
		WHERE EE_ADHERENCE = 'Y'					--<< SCORECARD_FLAG is NOT used
		and EVENT_DATE >= TRUNC(ADD_MONTHS(SYSDATE, -12), 'MM')
		and trunc(nvl(STAFF_TERMINATION_DATE,sysdate)) >= event_date
		and department is not null
		and building is not null
        GROUP BY STAFF_ID,
          --  EVENT_ID
            event_date
        ) D
	),
SCHEDULED as
	(
	SELECT T.STAFF_ID,
		TRUNC(T.TASK_START) as TASK_START,
		SUM(T.DURATION) as TOTAL_MIN_SCHED
	FROM DP_SCORECARD.PP_WFM_TASK_BO_SV T
	WHERE T.EVENT_ID NOT IN ('4', '5')
--	and delete_flag = 'N'
	AND TRUNC(T.TASK_START) <= SYSDATE
	and trunc(T.TASK_START) >= TRUNC(ADD_MONTHS(SYSDATE, -12), 'MM')
	AND TRUNC(T.TASK_START) = TRUNC(T.TASK_END)
	GROUP BY T.STAFF_ID, TRUNC(T.TASK_START)
	order by task_start
	),
COMBINED as
	(
	select p.staff_id, p.EVENT_DATE as dates,
	((p.PRODUCTIVITIY/60)/s.TOTAL_MIN_SCHED) as daily_adherence_metric,
	p.PRODUCTIVITIY,
	s.TOTAL_MIN_SCHED
	from PRODUCTIVITIY p
	JOIN SCHEDULED s
		on p.STAFF_ID=s.STAFF_ID
		and p.EVENT_DATE=s.TASK_START
	WHERE NVL(p.PRODUCTIVITIY,0) > 0
	AND   NVL(s.TOTAL_MIN_SCHED,0) > 0
	)
select staff_id, dates,
    3, 'Daily Adherence',
    1, NULL,
    daily_adherence_metric
from COMBINED;

commit;

EXCEPTION
	WHEN OTHERS THEN NULL;
END;

-------------------------------------------------------
--- ***************************************************
--- ***************************************************
--- ***************  MONTHLY **************************
--- ***************************************************
--- ***************************************************
-------------------------------------------------------

PROCEDURE STEP4_LOAD_SC_SUMMARY_BO IS
BEGIN

	EXECUTE IMMEDIATE 'TRUNCATE TABLE dp_scorecard.SC_SUMMARY_BO';

----------------------------------------
-- Monthly Total Logged
----------------------------------------

insert into dp_scorecard.SC_SUMMARY_BO
  (staff_id,
  dates_month_num, dates_year,
  event_name_sort, event_name,
  event_subname_sort, event_subname,
  metric)
select 		staff_id,
			dates_month_num,
			dates_year,
			case when scorecard_group = 'All Other Tasks'
			then 2
			else 1 end                      as event_name_sort,
			scorecard_group                 as event_name,
			1								as event_subname_sort,
			'Total Logged'					as event_subname,
			nvl(TOTAL_LOGGED,0)             as metric
From
(
	select
		STAFF_ID,
		to_char(event_date, 'YYYYMM') as dates_month_num,
		to_char(event_date, 'Month YYYY') as dates_year,
		scorecard_group,
		subactivity_flag,
		sum(Subactivity_Logged) as Subactivity_Logged,
		sum(TOTAL_LOGGED)   as TOTAL_LOGGED
	from  DP_SCORECARD.PP_WFM_DAILY_SUMMARY
	where event_date >= TRUNC(ADD_MONTHS(SYSDATE, -12), 'MM')
	and scorecard_flag = 'Y'
	and trunc(nvl(STAFF_TERMINATION_DATE,sysdate)) >= event_date
	and department is not null
	and building is not null
group by
  STAFF_ID,
  to_char(event_date, 'YYYYMM'),
  to_char(event_date, 'Month YYYY'),
  scorecard_group,
  subactivity_flag
);

commit;

----------------------------------------
--MONTLHY --Total Activity Time in Hrs
----------------------------------------

insert into dp_scorecard.SC_SUMMARY_BO
  (staff_id, dates_month_num, dates_year,
  event_name_sort, event_name,
  event_subname_sort, event_subname, metric)
select staff_id,
	dates_month_num,
	dates_year,
	case when scorecard_group = 'All Other Tasks'
		then 2
		else 1
	end														as event_name_sort,
	scorecard_group											as event_name,
	1														as event_subname_sort,
	'Total Activity Time'									as event_subname,
	HANDLE_TIME_IN_HOURS									as metric
From
(
	select
		D.STAFF_ID,
		to_char(TRUNC(D.event_date), 'YYYYMM') 			as dates_month_num,
		to_char(TRUNC(D.event_date), 'Month YYYY') 		as dates_year,
		D.scorecard_group,
		sum(ROUND(D.HANDLE_TIME_IN_SECONDS / 3600,4))  		as HANDLE_TIME_IN_HOURS
	from  DP_SCORECARD.PP_WFM_DAILY_SUMMARY  D
	where trunc(D.event_date) >= TRUNC(ADD_MONTHS(SYSDATE, -12), 'MM')
	and D.scorecard_flag = 'Y'
	and trunc(nvl(STAFF_TERMINATION_DATE,sysdate)) >= event_date
	and department is not null
	and building is not null
	group by
		D.STAFF_ID,
		to_char(TRUNC(D.event_date), 'YYYYMM'),
		to_char(TRUNC(D.event_date), 'Month YYYY'),
		D.scorecard_group
);

commit;


----------------------------------------
-- MONTHLY  Task Production
-- ([Total Logged] / ([Total Activity Time in Hrs] / [Max (QC Target)]))
----------------------------------------

insert into dp_scorecard.SC_SUMMARY_BO
  (staff_id, dates_month_num, dates_year, event_name_sort, event_name,
  event_subname_sort, event_subname, metric)
select staff_id, dates_month_num, dates_year,
	case when scorecard_group = 'All Other Tasks' then 2 else 1 end AS event_name_sort,
	scorecard_group,
	3 AS event_subname_sort,
	'Task Production' AS event_subname, metric
from
(
select D.STAFF_ID,
	D.dates_month_num,
	D.dates_year,
	D.scorecard_group,
	D.TOTAL_LOGGED,
	D.HANDLE_TIME_IN_hours,
	D.target,
	((D.TOTAL_LOGGED / D.HANDLE_TIME_IN_hours) / D.target) as metric
from
    ( select
        staff_id,
		to_char(event_date, 'YYYYMM') 						as dates_month_num,
		to_char(event_date, 'Month YYYY') 					as dates_year,
        scorecard_group,
        SCORECARD_FLAG,
			round(sum(HANDLE_TIME_IN_SECONDS/3600 ),4)		as HANDLE_TIME_IN_hours,
			max(target)                                   	as target,
        sum(total_logged)                                 	as total_logged
	from DP_SCORECARD.PP_WFM_DAILY_SUMMARY
		where to_char(event_date,'YYYYMM') >= to_char(ADD_MONTHS(SYSDATE, -12), 'YYYYMM')
		and scorecard_flag = 'Y'
		and trunc(nvl(STAFF_TERMINATION_DATE,sysdate)) >= event_date
		and department is not null
		and building is not null
    group by
        STAFF_ID,
        to_char(event_date, 'YYYYMM'),
        to_char(event_date, 'Month YYYY'),
        scorecard_group,
        scorecard_flag
	having nvl(round(sum(HANDLE_TIME_IN_SECONDS/3600 ),4),0) > 0
	and nvl(sum(target),0) > 0
	) D
--) ORDER BY 2,3,4,5;
);

commit;

----------------------------------------
-- MONTHLY 'Overall'
----------------------------------------

insert into dp_scorecard.SC_SUMMARY_BO
  (staff_id, dates_month_num, dates_year,
  event_name_sort, event_name,
  event_subname_sort,
  event_subname,
  metric
  )
select staff_id,  dates_month_num, dates_year,
			3 					AS event_name_sort,
			'Overall' 			AS event_name,
			1 					AS event_subname_sort,
			NULL 				AS event_subname,
			daily_production_metric
from
(
select staff_id,  dates_month_num, dates_year,
	sum(subtotal) as numerator,
	sum(total_act_time_metric) as denominator,
	sum(subtotal) / sum(total_act_time_metric) as daily_production_metric
from
(
select tp.staff_id,
       tp.dates_month_num,
       tp.dates_year,
       tp.event_name,
       tp.task_prod_metric,
       tat.total_act_time_metric,
       (tp.task_prod_metric * tat.total_act_time_metric) as subtotal
  from (select staff_id, dates_month_num, dates_year, event_name, metric as task_prod_metric
          from dp_scorecard.SC_SUMMARY_BO
         where event_subname = 'Task Production') tp
  join (select staff_id, dates_month_num, dates_year, event_name, metric as total_act_time_metric
          from dp_scorecard.SC_SUMMARY_BO
         where event_subname = 'Total Activity Time') tat
    on tp.staff_id = tat.staff_id
   and tp.dates_month_num = tat.dates_month_num
   and tp.event_name = tat.event_name
)
group by staff_id, dates_month_num, dates_year
having nvl(sum(total_act_time_metric),0) <> 0
);

commit;

----------------------------------------
--MONTHLY Adherence (SUMMARY)
----------------------------------------

insert into dp_scorecard.SC_SUMMARY_BO
  (staff_id, dates_month_num, dates_year, event_name_sort, event_name, event_subname_sort, event_subname, metric)
WITH ALL_MONTHS as
(
	select distinct staff_id,
		dates_month_num,
		dates_year
	from dp_scorecard.SC_SUMMARY_BO
),
PRODUCTIVITIY_DAILY as
(
	SELECT STAFF_ID,
		event_date    as task_start,
		SUM(HANDLE_TIME_IN_SECONDS)/60 as DAILY_PRODUCTIVITIY
	FROM PP_WFM_DAILY_SUMMARY
	where event_date >= TRUNC(ADD_MONTHS(SYSDATE, -12), 'MM')
	and trunc(nvl(STAFF_TERMINATION_DATE,sysdate)) >= event_date
	and ee_adherence = 'Y'
	and department is not null
	and building is not null
GROUP BY STAFF_ID, event_date
),
SCHEDULED_DAILY as
(
	SELECT T.STAFF_ID,
       TRUNC(T.TASK_START) as TASK_START,
       SUM(T.DURATION) as DAILY_TOTAL_MIN_SCHED
	FROM DP_SCORECARD.PP_WFM_TASK_BO_SV T
	WHERE T.EVENT_ID NOT IN ('4', '5')
--	and delete_flag = 'N'
	AND TRUNC(T.TASK_START) <= SYSDATE
	and TRUNC(T.TASK_START) >= TRUNC(ADD_MONTHS(SYSDATE, -12), 'MM')
	AND TRUNC(T.TASK_START) = TRUNC(T.TASK_END)
 GROUP BY T.STAFF_ID, TRUNC(T.TASK_START)
),
COMBINED_DAILY as
(
	select p.staff_id, p.TASK_START, p.DAILY_PRODUCTIVITIY, s.DAILY_TOTAL_MIN_SCHED
	from PRODUCTIVITIY_DAILY p
	join SCHEDULED_DAILY s
		on p.STAFF_ID=s.STAFF_ID
		and p.task_start=s.TASK_START
	where p.DAILY_PRODUCTIVITIY > 0
),
PRODUCTIVITIY as
(
	SELECT STAFF_ID,
		TO_CHAR(TASK_START,'YYYYMM') as dates_month_num,
		SUM(DAILY_PRODUCTIVITIY) as PRODUCTIVITIY
	FROM COMBINED_DAILY
	WHERE NVL(DAILY_PRODUCTIVITIY,0) > 0
	AND NVL(DAILY_TOTAL_MIN_SCHED,0) > 0
	GROUP BY STAFF_ID, TO_CHAR(TASK_START,'YYYYMM')
),
SCHEDULED as
(
	SELECT STAFF_ID,
		TO_CHAR(TASK_START,'YYYYMM') as dates_month_num,
		SUM(DAILY_TOTAL_MIN_SCHED) as TOTAL_MIN_SCHED
	FROM COMBINED_DAILY
	WHERE 1=1
	and NVL(DAILY_PRODUCTIVITIY,0) > 0
	AND NVL(DAILY_TOTAL_MIN_SCHED,0) > 0
	GROUP BY STAFF_ID, TO_CHAR(TASK_START,'YYYYMM')
),
COMBINED as
(
	select p.staff_id, p.dates_month_num,
		sum(p.PRODUCTIVITIY)/sum(s.TOTAL_MIN_SCHED) as monthly_adherence_metric,
		sum(p.PRODUCTIVITIY)   						as PRODUCTIVITIY,
		sum(s.TOTAL_MIN_SCHED)						as TOTAL_MIN_SCHED
	from PRODUCTIVITIY p
	join SCHEDULED s
		on p.STAFF_ID=s.STAFF_ID
		and p.dates_month_num=s.dates_month_num
	group by p.staff_id, p.dates_month_num
)
select am.staff_id, am.dates_month_num, am.dates_year,
		3 					AS event_name_sort,
		'Monthly Adherence'	AS event_name,
		1					AS event_subname_sort,
		NULL				AS event_subname,
		monthly_adherence_metric
FROM ALL_MONTHS am
left outer join COMBINED c
	on am.staff_id=c.staff_id
	and am.dates_month_num=c.dates_month_num;
--order by 1,2,3,4,5,6,7

commit;


	EXCEPTION
		WHEN OTHERS THEN RAISE;

	END;

----------------------------------------
-- *************************************
-- *************************************
-- *************************************
-- *************************************
----------------------------------------
PROCEDURE LOAD_SC_SUMMARY_BO_ROLLUP IS
	BEGIN
		NULL;


	EXECUTE IMMEDIATE 'truncate table dp_scorecard.SC_SUMMARY_BO_ROLLUP';

	--delete dp_scorecard.SC_SUMMARY_BO_ROLLUP;
	--commit;

-----------------------------------------
-- Rollup MONTHLY -- Total Logged
-----------------------------------------

insert into dp_scorecard.SC_SUMMARY_BO_ROLLUP
  (supervisor_staff_id, department, building,
  dates_month_num, dates_year,
  event_name_sort, event_name,
  event_subname_sort, event_subname,
  metric)
SELECT supervisor_staff_id, department, building,
  dates_month_num, dates_year,
  event_name_sort, event_name,
  event_subname_sort, event_subname,
  SUM(metric)
  from (
		select
		supervisor_staff_id, department, building,
		to_char(EVENT_date, 'YYYYMM')         AS dates_month_num,
		to_char(EVENT_date, 'Month YYYY')     AS dates_year,
		case when scorecard_group = 'All Other Tasks'
		then 2 else 1 end					as event_name_sort,
		scorecard_group                     as event_name,
		1									as event_subname_sort,
		'Total Logged'						as event_subname,
		nvl(TOTAL_LOGGED,0)					as metric
        from DP_SCORECARD.PP_WFM_DAILY_SUMMARY
		WHERE SUPERVISOR_STAFF_ID IS NOT NULL
		AND DEPARTMENT IS NOT NULL
		AND BUILDING IS NOT NULL
		)
group by
	supervisor_staff_id, department, building,
	dates_month_num, dates_year,
	event_name_sort, event_name,
	event_subname_sort, event_subname;

commit;

--Rollup MONTLHY
--Total Activity Time in Hrs
insert into dp_scorecard.SC_SUMMARY_BO_ROLLUP
  (supervisor_staff_id, department, building,
  dates_month_num, dates_year,
  event_name_sort, event_name,
  event_subname_sort, event_subname,
  metric)
SELECT supervisor_staff_id, department, building,
  dates_month_num, dates_year,
  event_name_sort, event_name,
  event_subname_sort, event_subname,
  SUM(metric)
  from (
		select
		supervisor_staff_id, department, building,
		to_char(EVENT_date, 'YYYYMM')         	AS dates_month_num,
		to_char(EVENT_date, 'Month YYYY')     	AS dates_year,
		case when scorecard_group = 'All Other Tasks'
		then 2 else 1 end						as event_name_sort,
		scorecard_group                     	as event_name,
		1										as event_subname_sort,
		'Total Activity Time'					as event_subname,
		nvl(HANDLE_TIME_IN_SECONDS/3600,0)		as metric   ---- in HOURS
        from DP_SCORECARD.PP_WFM_DAILY_SUMMARY
		WHERE SUPERVISOR_STAFF_ID IS NOT NULL
		AND DEPARTMENT IS NOT NULL
		AND BUILDING IS NOT NULL
	)
group by
	supervisor_staff_id, department, building,
  dates_month_num, dates_year,
  event_name_sort, event_name,
  event_subname_sort, event_subname;

commit;


---Rollup MONTHLY
--Staff Count
insert into dp_scorecard.SC_SUMMARY_BO_ROLLUP
  (supervisor_staff_id, department, building,
  dates_month_num, dates_year,
  event_name_sort,
  event_name,
  event_subname_sort,
  event_subname,
  metric)
select supervisor_staff_id,
	department, building,
	dates_month_num, dates_year,
	case
		when scorecard_group = 'All Other Tasks'
		then 2
		else 1
	end				AS event_name_sort,
	scorecard_group				AS event_name,
	1							AS event_subname_sort,
	'Staff Count'				AS event_subname,
	nvl(STAFF_COUNT,0)			aS METRIC
From
	(
	select distinct
		supervisor_staff_id,
		department,
		building,
		dates_month_num,
		dates_year,
		scorecard_group,
	COUNT(distinct STAFF_ID)
		over(partition by supervisor_staff_id,
						department,
						building,
						dates_month_num,
						dates_year,
						scorecard_group
			) as STAFF_COUNT
	from
		(
		select
			supervisor_staff_id,
			department,
			building,
			STAFF_ID,
			to_char(EVENT_DATE, 'YYYYMM') 		as dates_month_num,
			to_char(EVENT_DATE, 'Month YYYY') 	as dates_year,
			scorecard_group,
			SUM(TOTAL_LOGGED)  					as TOTAL_LOGGED
		from  DP_SCORECARD.PP_WFM_DAILY_SUMMARY
		where EVENT_DATE >= TRUNC(ADD_MONTHS(SYSDATE, -12), 'MM')
		AND SUPERVISOR_STAFF_ID IS NOT NULL
		AND DEPARTMENT IS NOT NULL
		AND BUILDING IS NOT NULL
		group by
			supervisor_staff_id,
			department,
			building,
			STAFF_ID,
			to_char(EVENT_DATE, 'YYYYMM'),
			to_char(EVENT_DATE, 'Month YYYY'),
			scorecard_group
		)
);


commit;



--Rollup MONTHLY
--Task Prodution : ([Total Logged] / ([Total Activity Time in Hrs] / [Max (QC Target)]))

insert into dp_scorecard.SC_SUMMARY_BO_ROLLUP
  (supervisor_staff_id,
  department, building,
  dates_month_num, dates_year,
  event_name_sort, event_name,
  event_subname_sort, event_subname,
  metric)
select supervisor_staff_id,
	department, building,
	dates_month_num, dates_year,
	case when scorecard_group = 'All Other Tasks' then 2 else 1 end,
	scorecard_group,
	3,
	'Task Production',
	metric
from
	(
	select supervisor_staff_id,
		department, building,
		dates_month_num, dates_year,
		scorecard_group,
		TOTAL_LOGGED,
		HANDLE_TIME_IN_HOURS,
		target,
		((TOTAL_LOGGED / HANDLE_TIME_IN_HOURS) / target) as metric
	from
		(
		select
			supervisor_staff_id,
			department,	building,
			dates_month_num, dates_year,
			scorecard_group,
			round(sum(HANDLE_TIME_IN_SECONDS/3600),4)        as HANDLE_TIME_IN_HOURS,
			sum(TOTAL_LOGGED)       as TOTAL_LOGGED,
			MAX(Target)			    as Target
		from
			(
			select
				supervisor_STAFF_ID,
				department,	building,
				to_char(event_date, 'YYYYMM') 		as dates_month_num,
				to_char(event_date, 'Month YYYY') 	as dates_year,
				scorecard_group,
				HANDLE_TIME_IN_SECONDS,
				TOTAL_LOGGED,
				TARGET
			from  DP_SCORECARD.PP_WFM_DAILY_SUMMARY  a11
			where event_date >= TRUNC(ADD_MONTHS(SYSDATE, -12), 'MM')
			and supervisor_staff_id is not null
			AND DEPARTMENT IS NOT NULL
			AND BUILDING IS NOT NULL
			)
	group by
		supervisor_staff_id,
		department,
		building,
		dates_month_num,
		dates_year,
		scorecard_group
		)
	where nvl(HANDLE_time_IN_HOURS,0) <> 0
	and nvl(target,0) <> 0
	);

commit;

--Rollup MONTHLY
--Rollup Overall Numerator
insert into dp_scorecard.SC_SUMMARY_BO_ROLLUP
  (supervisor_staff_id, department, building,
  dates_month_num, dates_year,
  event_name_sort, event_name,
  event_subname_sort, event_subname,
  metric)
select supervisor_staff_id, department, building,
	dates_month_num, dates_year,
	3 								as event_name_sort,
	'Overall Numerator'				as event_name,
	1								as event_subname_sort,
	NULL							as  event_subname,
	numerator
from
	(
	select supervisor_staff_id, department, building,
	dates_month_num, dates_year,
	sum(subtotal) 					as numerator
	from
		(
		select tp.supervisor_staff_id,
			tp.department,
			tp.building,
			tp.dates_month_num,
			tp.dates_year,
			tp.event_name,
			tp.task_prod_metric,
			tat.total_act_time_metric,
			(tp.task_prod_metric * tat.total_act_time_metric) as subtotal
		from (
			select supervisor_staff_id, department, building,
				dates_month_num, dates_year,
				event_name,
				metric as task_prod_metric
			from dp_scorecard.SC_SUMMARY_BO_ROLLUP
			where event_subname = 'Task Production'
			) tp
	join
		(select supervisor_staff_id, department, building,
			dates_month_num, dates_year,
			event_name,
			metric as total_act_time_metric
        from dp_scorecard.SC_SUMMARY_BO_ROLLUP
        where event_subname = 'Total Activity Time'
		) tat
		on tp.supervisor_staff_id = tat.supervisor_staff_id
		and tp.department = tat.department
		and tp.building = tat.building
		and tp.dates_month_num = tat.dates_month_num
		and tp.event_name = tat.event_name
		)
group by supervisor_staff_id, department, building, dates_month_num, dates_year
);

commit;


-------------------------------
--Rollup MONTHLY
--Rollup Overall Denominator
-------------------------------

insert into dp_scorecard.SC_SUMMARY_BO_ROLLUP
  (supervisor_staff_id, department, building,
  dates_month_num, dates_year,
  event_name_sort, event_name,
  event_subname_sort, event_subname,
  metric)
select supervisor_staff_id, department, building,
		dates_month_num, dates_year,
		3								as event_name_sort,
		'Overall Denominator'			AS event_name,
		1								AS event_subname_sort,
		NULL							AS event_subname,
		denominator
from
	(
	select supervisor_staff_id, department, building,
			dates_month_num, dates_year,
			sum(total_act_time_metric) as denominator
	from
		(
		select tp.supervisor_staff_id,
			tp.department,
			tp.building,
			tp.dates_month_num,
			tp.dates_year,
			tp.event_name,
			tp.task_prod_metric,
			tat.total_act_time_metric,
			(tp.task_prod_metric * tat.total_act_time_metric) as subtotal
		from
			(select supervisor_staff_id, department, building,
					dates_month_num, dates_year,
					event_name,
					metric as task_prod_metric
			from dp_scorecard.SC_SUMMARY_BO_ROLLUP
			where event_subname = 'Task Production'
			) tp
		join
			(select supervisor_staff_id, department, building,
					dates_month_num, dates_year,
					event_name,
					metric as total_act_time_metric
			from dp_scorecard.SC_SUMMARY_BO_ROLLUP
			where event_subname = 'Total Activity Time'
			) tat
		on tp.supervisor_staff_id = tat.supervisor_staff_id
		and tp.department = tat.department
		and tp.building = tat.building
		and tp.dates_month_num = tat.dates_month_num
		and tp.event_name = tat.event_name
		)
		group by supervisor_staff_id, department, building,
				dates_month_num, dates_year
	);

commit;

----------------------------------
--Rollup MONTHLY
--Rollup Adherence Numerator
----------------------------------

insert into dp_scorecard.SC_SUMMARY_BO_ROLLUP
  (supervisor_staff_id, department, building,
  dates_month_num, dates_year,
  event_name_sort, event_name,
  event_subname_sort, event_subname,
  metric)
WITH ALL_MONTHS as
(
select distinct supervisor_staff_id, department, building,
       dates_month_num,
       dates_year
  from dp_scorecard.SC_SUMMARY_BO_ROLLUP
  order by supervisor_staff_id, department, building,
       dates_month_num
),
PRODUCTIVITIY_DAILY as
(
SELECT STAFF_ID,
       EVENT_DATE as TASK_START,
       round(SUM(HANDLE_TIME_IN_SECONDS)/60,4) as DAILY_PRODUCTIVITIY
  FROM DP_SCORECARD.PP_WFM_DAILY_SUMMARY_WRK A
  WHERE EVENT_DATE >= TRUNC(ADD_MONTHS(SYSDATE, -12), 'MM')
  AND EE_ADHERENCE = 'Y'
GROUP BY STAFF_ID, EVENT_DATE
),
SCHEDULED_DAILY as
(
SELECT T.STAFF_ID,
       TRUNC(T.TASK_START) as TASK_START,
       SUM(T.DURATION) as DAILY_TOTAL_MIN_SCHED
  FROM DP_SCORECARD.PP_WFM_TASK_BO_SV T
WHERE T.EVENT_ID NOT IN ('4', '5')
   AND TRUNC(T.TASK_START) <= SYSDATE
   AND TRUNC(TASK_START) >= TRUNC(ADD_MONTHS(SYSDATE, -12), 'MM')
   AND TRUNC(TASK_START) = TRUNC(TASK_END)
GROUP BY T.STAFF_ID, TRUNC(T.TASK_START)
),
COMBINED_DAILY as
(
select p.staff_id, p.TASK_START, p.DAILY_PRODUCTIVITIY, s.DAILY_TOTAL_MIN_SCHED
from PRODUCTIVITIY_DAILY p
left outer join SCHEDULED_DAILY s on p.STAFF_ID=s.STAFF_ID and p.TASK_START=s.TASK_START
),
PRODUCTIVITIY as
(
SELECT STAFF_ID,
       TO_CHAR(TASK_START,'YYYYMM') as dates_month_num,
       SUM(DAILY_PRODUCTIVITIY) as PRODUCTIVITIY
  FROM COMBINED_DAILY
WHERE DAILY_PRODUCTIVITIY IS NOT NULL AND DAILY_PRODUCTIVITIY > 0
AND DAILY_TOTAL_MIN_SCHED IS NOT NULL AND DAILY_TOTAL_MIN_SCHED > 0
GROUP BY STAFF_ID, TO_CHAR(TASK_START,'YYYYMM')
),
SCHEDULED as
(
SELECT STAFF_ID,
       TO_CHAR(TASK_START,'YYYYMM') as dates_month_num,
       SUM(DAILY_TOTAL_MIN_SCHED) as TOTAL_MIN_SCHED
  FROM COMBINED_DAILY
WHERE DAILY_PRODUCTIVITIY IS NOT NULL AND DAILY_PRODUCTIVITIY > 0
AND DAILY_TOTAL_MIN_SCHED IS NOT NULL AND DAILY_TOTAL_MIN_SCHED > 0
GROUP BY STAFF_ID, TO_CHAR(TASK_START,'YYYYMM')
),
COMBINED as
(
    select h.supervisor_staff_id, h.department, h.building, p.dates_month_num,
        --(sum(p.PRODUCTIVITIY)/sum(s.TOTAL_MIN_SCHED)) as monthly_adherence_metric
        sum(p.PRODUCTIVITIY) as numerator
        --sum(s.TOTAL_MIN_SCHED) as denominator
    from dp_scorecard.scorecard_hierarchy_sv h
    JOIN PRODUCTIVITIY p on h.staff_staff_id=p.STAFF_ID
    LEFT OUTER join SCHEDULED s on p.STAFF_ID=s.STAFF_ID and p.dates_month_num=s.dates_month_num
    group by h.supervisor_staff_id, h.department, h.building, p.dates_month_num
)
select am.supervisor_staff_id, am.department, am.building,
am.dates_month_num, am.dates_year,
3, 'Monthly Adherence Numerator',
1, NULL,
numerator --monthly_adherence_metric
FROM ALL_MONTHS am
left outer join COMBINED c on am.supervisor_staff_id=c.supervisor_staff_id
and am.department=c.department
and am.building=c.building
and am.dates_month_num=c.dates_month_num;
--WHERE AM.supervisor_staff_id = 1176
--ORDER BY 1,2,3,4,5,6,7

--rollback;

commit;

-------------------------------
--Rollup MONTHLY
--Rollup Adherence Denominator
-------------------------------

insert into dp_scorecard.SC_SUMMARY_BO_ROLLUP
  (supervisor_staff_id, department, building,
  dates_month_num, dates_year,
  event_name_sort, event_name,
  event_subname_sort, event_subname,
  metric
  )
WITH ALL_MONTHS as
(
select distinct supervisor_staff_id, department, building,
       dates_month_num,
       dates_year
  from dp_scorecard.SC_SUMMARY_BO_ROLLUP
  order by supervisor_staff_id, department, building,
       dates_month_num
),
PRODUCTIVITIY_DAILY as
(
SELECT STAFF_ID,
       EVENT_DATE as TASK_START,
       SUM(HANDLE_TIME_IN_SECONDS) as DAILY_PRODUCTIVITIY
  FROM dp_scorecard.PP_WFM_DAILY_SUMMARY A
  WHERE EE_ADHERENCE = 'Y'
  and EVENT_DATE >= TRUNC(ADD_MONTHS(SYSDATE, -12), 'MM')
GROUP BY STAFF_ID, EVENT_DATE
),
SCHEDULED_DAILY as
(
	SELECT T.STAFF_ID,
       TRUNC(T.TASK_START) as TASK_START,
       SUM(T.DURATION) as DAILY_TOTAL_MIN_SCHED
	FROM DP_SCORECARD.PP_WFM_TASK_BO_SV T
	WHERE T.EVENT_ID NOT IN ('4', '5')
	AND TRUNC(T.TASK_START) <= SYSDATE
	and TRUNC(TASK_START) >= TRUNC(ADD_MONTHS(SYSDATE, -12), 'MM')
	AND TRUNC(T.TASK_START) = TRUNC(T.TASK_END)
GROUP BY T.STAFF_ID, TRUNC(T.TASK_START)
),
COMBINED_DAILY as
(
select p.staff_id, p.TASK_START, p.DAILY_PRODUCTIVITIY, s.DAILY_TOTAL_MIN_SCHED
from PRODUCTIVITIY_DAILY p
left outer join SCHEDULED_DAILY s on p.STAFF_ID=s.STAFF_ID and p.TASK_START=s.TASK_START
),
PRODUCTIVITIY as
(
SELECT STAFF_ID,
       TO_CHAR(TASK_START,'YYYYMM') as dates_month_num,
       SUM(DAILY_PRODUCTIVITIY) as PRODUCTIVITIY
  FROM COMBINED_DAILY
WHERE DAILY_PRODUCTIVITIY IS NOT NULL AND DAILY_PRODUCTIVITIY > 0
AND DAILY_TOTAL_MIN_SCHED IS NOT NULL AND DAILY_TOTAL_MIN_SCHED > 0
GROUP BY STAFF_ID, TO_CHAR(TASK_START,'YYYYMM')
),
SCHEDULED as
(
SELECT STAFF_ID,
       TO_CHAR(TASK_START,'YYYYMM') as dates_month_num,
       SUM(DAILY_TOTAL_MIN_SCHED) as TOTAL_MIN_SCHED
  FROM COMBINED_DAILY
WHERE DAILY_PRODUCTIVITIY IS NOT NULL AND DAILY_PRODUCTIVITIY > 0
AND DAILY_TOTAL_MIN_SCHED IS NOT NULL AND DAILY_TOTAL_MIN_SCHED > 0
GROUP BY STAFF_ID, TO_CHAR(TASK_START,'YYYYMM')
),
COMBINED as
(
select h.supervisor_staff_id, h.department, h.building, p.dates_month_num,
sum(s.TOTAL_MIN_SCHED) as denominator
from
dp_scorecard.scorecard_hierarchy_sv h
JOIN PRODUCTIVITIY p on h.staff_staff_id=p.STAFF_ID
LEFT OUTER join SCHEDULED s on p.STAFF_ID=s.STAFF_ID and p.dates_month_num=s.dates_month_num
group by h.supervisor_staff_id, h.department, h.building, p.dates_month_num
)
select am.supervisor_staff_id,
am.department, am.building,
am.dates_month_num, am.dates_year,
3, 'Monthly Adherence Denominator',
1, NULL,
denominator --monthly_adherence_metric
FROM ALL_MONTHS am
left outer join COMBINED c on am.supervisor_staff_id=c.supervisor_staff_id
and am.department=c.department
and am.building=c.building
and am.dates_month_num=c.dates_month_num;
--ORDER BY 1,2,3,4,5,6,7;

----------------------------------------------
-- Distinct Days Worked
----------------------------------------------

insert into dp_scorecard.SC_SUMMARY_BO_ROLLUP
  (supervisor_staff_id, building, department,
  dates_month_num, dates_year,
  event_name_sort, event_name,
  event_subname_sort, event_subname,
  metric
  )
select supervisor_staff_id,
	building,
	department,
	to_char(event_date,'yyyymm') as dates_month_num,
	to_char(event_date, 'Month YYYY') as dates_year,
	4 as event_name_sort,
	'Unique Days Worked' as Event_name,
	1	as event_subname_sort,
	NULL as event_subname,
	count(event_date) as metric
from (
	select distinct supervisor_staff_id, building, department, trunc(event_date) as event_date
	FROM dp_scorecard.PP_WFM_DAILY_SUMMARY
	where scorecard_flag = 'Y'
	)
group by
	supervisor_staff_id,
	building,
	department,
	to_char(event_date,'yyyymm'),
	to_char(event_date, 'Month YYYY');


commit;

	EXCEPTION
		WHEN OTHERS THEN RAISE;

	END;

--PROCEDURE 		STEP5_LOAD_SC_LOGGED_IN_TIME
--IS
--
--	BEGIN
--
--		DELETE FROM DP_SCORECARD.PP_WFM_SC_LOGGED_IN_TIME
--		WHERE LOGGED_DATE >= TRUNC(ADD_MONTHS(SYSDATE, -12), 'MM');
--
--		COMMIT;
--
--		INSERT INTO DP_SCORECARD.PP_WFM_SC_LOGGED_IN_TIME(
--            NATIONAL_ID,
--			STAFF_ID,
--			LOGGED_DATE,
--			TOTAL_LOGGED_IN_TIME,
--			LUNCH_TIME,
--			BREAK_TIME,
--			TRAINING_TIME,
--			DAILY_PRODUCTION,
--			DAILY_ADHERENCE
--		)
--        WITH LOGGED_TIME AS
--        (
--		SELECT H.STAFF_NATID NATIONAL_ID,
--			WRK.STAFF_ID,
--			TRUNC(WRK.EVENT_DATE) AS LOGGED_DATE,
--			ROUND(SUM(HANDLE_TIME_IN_SECONDS),2) AS TOTAL_LOGGED_IN_TIME,
--			ROUND(SUM(CASE WHEN EVENT_TYPE_GROUP_ID = 106 THEN HANDLE_TIME_IN_SECONDS ELSE 0 END),2) AS LUNCH_TIME,
--			ROUND(SUM(CASE WHEN EVENT_TYPE_GROUP_ID = 102 THEN HANDLE_TIME_IN_SECONDS ELSE 0 END),2) AS BREAK_TIME,
--			ROUND(SUM(CASE WHEN EVENT_TYPE_GROUP_ID = 50 THEN HANDLE_TIME_IN_SECONDS ELSE 0 END),2) AS TRAINING_TIME
--		FROM DP_SCORECARD.PP_WFM_DAILY_SUMMARY_WRK WRK
--		JOIN ( 	SELECT EVENT_ID, EVENT_TYPE_GROUP_ID
--				FROM MAXDAT.PP_WFM_EVENT
--				WHERE DELETE_DATE IS NULL
--				--EVENT_TYPE_GROUP_ID = 50 -- TRAINING
--				--EVENT_TYPE_GROUP_ID = 106 -- LUNCH
--				--EVENT_TYPE_GROUP_ID = 102 -- BREAK
--			) EVENTS
--				ON EVENTS.EVENT_ID = WRK.EVENT_ID
--		JOIN ( SELECT STAFF_STAFF_ID, STAFF_NATID
--				FROM DP_SCORECARD.SCORECARD_HIERARCHY
--				-- WHERE MANAGER_NATID = 57997  --- TEST CASE
--			) H
--				ON H.STAFF_STAFF_ID = WRK.STAFF_ID
--				GROUP BY H.STAFF_NATID, WRK.STAFF_ID, TRUNC(WRK.EVENT_DATE)
--        ),
--        PRODUCTIVE_TIME AS
--        (
--        SELECT TRUNC(DATES) AS DATES, STAFF_ID, STAFF_NATID,
--            SUM(DAILY_PRODUCTION) AS DAILY_PRODUCTION,
--            SUM(DAILY_ADHERENCE) AS DAILY_ADHERENCE
--        FROM (
--            SELECT TRUNC(DATES) AS DATES,
--                STAFF_ID,
--            (
--                SELECT DISTINCT STAFF_NATID
--                FROM DP_SCORECARD.SCORECARD_HIERARCHY_SV
--                WHERE STAFF_STAFF_ID = STAFF_ID
--            )   AS STAFF_NATID,
--                CASE WHEN EVENT_NAME = 'Daily Production'
--                THEN NVL(METRIC,0) ELSE 0 END AS DAILY_PRODUCTION,
--                0 AS DAILY_ADHERENCE
--            FROM DP_SCORECARD.SC_PRODUCTION_BO
--            WHERE EVENT_NAME = 'Daily Production'
--            -- and trunc(dates) >= trunc(sysdate - 31)
--            UNION
--            SELECT TRUNC(DA.DATES) AS DATES,
--                DA.STAFF_ID,
--            (   SELECT DISTINCT STAFF_NATID
--                FROM DP_SCORECARD.SCORECARD_HIERARCHY_SV
--                WHERE STAFF_STAFF_ID = DA.STAFF_ID
--            )                       AS STAFF_NATID,
--            0					AS DAILY_PRODUCTION,
--            CASE WHEN EVENT_NAME = 'Daily Adherence'
--                THEN NVL(METRIC,0) ELSE 0
--                END                             AS DAILY_ADHERENCE
--            FROM DP_SCORECARD.SC_PRODUCTION_BO DA
--            JOIN (SELECT DATES, STAFF_ID
--                FROM DP_SCORECARD.SC_PRODUCTION_BO
--                WHERE EVENT_NAME = 'Daily Production'
--                --         and trunc(dates) >= trunc(sysdate - 31)
--                ) DP
--            ON TRUNC(DA.DATES) = TRUNC(DP.DATES)
--            AND DA.STAFF_ID = DP.STAFF_ID
--            WHERE DA.EVENT_NAME = 'Daily Adherence'
--            )
--        GROUP BY TRUNC(DATES), STAFF_ID, STAFF_NATID
--        )
--    SELECT NVL(LOGGED_TIME.NATIONAL_ID,PRODUCTIVE_TIME.STAFF_NATID) AS NATIONAL_ID,
--        NVL(LOGGED_TIME.STAFF_ID, PRODUCTIVE_TIME.STAFF_ID) AS STAFF_ID,
--        NVL(LOGGED_TIME.LOGGED_DATE, PRODUCTIVE_TIME.DATES) AS LOGGED_DATE,
--        TOTAL_LOGGED_IN_TIME,
--        LUNCH_TIME,
--        BREAK_TIME,
--        TRAINING_TIME,
--        DAILY_PRODUCTION,
--        DAILY_ADHERENCE
--    FROM LOGGED_TIME
--    FULL OUTER JOIN PRODUCTIVE_TIME
--    ON LOGGED_TIME.LOGGED_DATE = PRODUCTIVE_TIME.DATES
--    AND LOGGED_TIME.STAFF_ID = PRODUCTIVE_TIME.STAFF_ID;
--
--
--		COMMIT;
--
--	EXCEPTION
--		WHEN OTHERS THEN RAISE;
--
--	END;


END PP_WFM_BACK_OFFICE_LOAD_PKG;