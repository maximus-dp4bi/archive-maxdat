CREATE OR REPLACE PACKAGE DP_SCORECARD.PP_WFM_BACK_OFFICE_LOAD_PKG AS
-- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
 	SVN_FILE_URL varchar2(200) := '$URL: svn://svn-staging.maximus.com/dev1d/maxdat/BPM/NYHIX/ScoreCard/patch/20180713_1505_CR1886_PP_WFM_BACK_OFFICE_LOAD_PKG.sql $';
  	SVN_REVISION varchar2(20) := '$Revision: 24142 $';
 	SVN_REVISION_DATE varchar2(60) := '$Date: 2018-07-12 18:08:13 -0400 (Thu, 12 Jul 2018) $';
  	SVN_REVISION_AUTHOR varchar2(20) := '$Author: wl134672 $';

	PROCEDURE LOAD_SC_PROD_AND_SMRY;
	PROCEDURE STEP1_LOAD_DAILY_SUMMARY_WRK;
	PROCEDURE STEP2_LOAD_DAILY_SUMMARY;
	PROCEDURE STEP3_LOAD_SC_PRODUCTION_BO;
	PROCEDURE STEP4_LOAD_SC_PRDUCTION_BO_P4;
	PROCEDURE STEP4_LOAD_SC_PRDUCTION_BO_P41(idx in VARCHAR2);
	PROCEDURE STEP4_LOAD_SC_PRDUCTION_BO_P42(idx in VARCHAR2);
	PROCEDURE STEP5_LOAD_SC_SUMMARY_BO;
--	PROCEDURE STEP5_LOAD_SC_LOGGED_IN_TIME;

	PROCEDURE LOAD_SC_SUMMARY_BO_ROLLUP;
END PP_WFM_BACK_OFFICE_LOAD_PKG;
/

show errors

CREATE OR REPLACE PACKAGE BODY DP_SCORECARD.PP_WFM_BACK_OFFICE_LOAD_PKG AS

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
		STEP4_LOAD_SC_PRDUCTION_BO_P4;
		STEP5_LOAD_SC_SUMMARY_BO;
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
   EE_ADHERENCE, EE_ADHERENCE_V2,
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
	TARGRT_LKUP.EE_ADHERENCE, TARGRT_LKUP.EE_ADHERENCE_V2,
	sum(to_number(
	case
        when TARGRT_LKUP.SUBACTIVITY_FLAG = 'Y'
        and TARGRT_LKUP.QC_FLAG = 'Y'
        and ACTUALS.WORK_SUBACTIVITY = '10'
            then '1'
        ----
        when TARGRT_LKUP.SUBACTIVITY_FLAG = 'Y'
        and TARGRT_LKUP.QC_FLAG = 'Y'
        and  NVL(ACTUALS.WORK_SUBACTIVITY,'?') <> '10'
            then '0'
        ----
        when TARGRT_LKUP.SUBACTIVITY_FLAG = 'Y'
--        and LENGTH(TRIM(TRANSLATE(ACTUALS.WORK_SUBACTIVITY, ' +-.0123456789', ' '))) is null
--        and trim(ACTUALS.WORK_SUBACTIVITY) <> '+'
--        and trim(ACTUALS.WORK_SUBACTIVITY) <> '-'
--        and trim(ACTUALS.WORK_SUBACTIVITY) <> '.'
--        then trim(ACTUALS.WORK_SUBACTIVITY)
        then nvl(dp_scorecard.return_numeric(trim(ACTUALS.WORK_SUBACTIVITY)),0)
        else '0'
        end
        )
	) 	as SUBACTIVITY_LOGGED,
    TARGRT_LKUP.SUBACTIVITY_FLAG,
	count(ACTUALS.RT_ACTUALS_ID)     as record_count,
----------------------------
	SUM(to_number(
        CASE
        when TARGRT_LKUP.SUBACTIVITY_FLAG = 'Y'
        and TARGRT_LKUP.QC_FLAG = 'Y'
        and ACTUALS.WORK_SUBACTIVITY = '10'
            then '1'
        ----
        when TARGRT_LKUP.SUBACTIVITY_FLAG = 'Y'
        and TARGRT_LKUP.QC_FLAG = 'Y'
        and  NVL(ACTUALS.WORK_SUBACTIVITY,'?') <> '10'
            then '0'  --- ???? should be 1???
        ----
		WHEN TARGRT_LKUP.SUBACTIVITY_FLAG = 'Y'
--        and LENGTH(TRIM(TRANSLATE(ACTUALS.WORK_SUBACTIVITY, ' +-.0123456789', ' '))) is null
--        and trim(ACTUALS.WORK_SUBACTIVITY) <> '+'
--        and trim(ACTUALS.WORK_SUBACTIVITY) <> '-'
--        and trim(ACTUALS.WORK_SUBACTIVITY) <> '.'
--        then trim(ACTUALS.WORK_SUBACTIVITY)
        then nvl(dp_scorecard.return_numeric(trim(ACTUALS.WORK_SUBACTIVITY)),0)
		WHEN TARGRT_LKUP.SUBACTIVITY_FLAG = 'N'
		THEN '1'
        else '0'
        end
		) )   AS TOTAL_LOGGED,
----------------------------
--   sum((task_end-task_start)*24*60*60)  as HANDLE_TIME_IN_SECONDS,
	SUM(
        CASE
        when TARGRT_LKUP.SUBACTIVITY_FLAG = 'Y'
        and TARGRT_LKUP.QC_FLAG = 'Y'
        and ACTUALS.WORK_SUBACTIVITY = '10'
            then (task_end-task_start)*24*60*60
        ----
        when TARGRT_LKUP.SUBACTIVITY_FLAG = 'Y'
        and TARGRT_LKUP.QC_FLAG = 'Y'
        and NVL(ACTUALS.WORK_SUBACTIVITY,'SKIP') <> '10'
            then 0  --- ???? should be 1???
        else
            (task_end-task_start)*24*60*60
        end
        )                                as HANDLE_TIME_IN_SECONDS,
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
	   EE_ADHERENCE, EE_ADHERENCE_V2,
	   target,
	   ops_group,
	   qc_flag
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
	EE_ADHERENCE, EE_ADHERENCE_V2,
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
   EE_ADHERENCE, EE_ADHERENCE_V2,
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
	D.EE_ADHERENCE, D.EE_ADHERENCE_V2,
	D.SUBACTIVITY_LOGGED,
	D.subactivity_flag,
	D.record_count,
	d.TOTAL_LOGGED,
	D.HANDLE_TIME_IN_SECONDS,
	D.TARGET,
	d.OPS_GROUP
from DP_SCORECARD.PP_WFM_Daily_Summary_WRK D
where ( D.scorecard_flag = 'Y' or D.EE_ADHERENCE = 'Y' or D.EE_ADHERENCE_V2 = 'Y')
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
-- NOTE There are 2 methods for calculating Adherence
-- ( Se CR 1886 ) This insert is for the the first
-- method using EE_ADHERENCE.  There is NOT a filter
-- on Dates ( See procedure 4.1 and 4.2
-- for the 'NEW' method wich uses EE_ADHEREVE_V2
-- which will replace these record for dtaes after 04/01/2108
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
		WHERE ( EE_ADHERENCE = 'Y' )  -- Generate rows uning the OLD method
		--<< NOTE: SCORECARD_FLAG is NOT used >>
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
	WHERE T.EVENT_ID NOT IN ('4', '5')  -- << 4=BREAK AND 5=LUNCH
--	and delete_flag = 'N' << THE DELETE FLAG IS FILTERED BY THE VIEW
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
from COMBINED
where 	-- Adherence should only be calculated
		-- when there is production for the staff member
		-- on the specificc day
		(staff_id, dates )
		in ( Select staff_id, dates
			from sc_production_bo
			where event_name = 'Daily Production'
			)
		-- OR
		-- The staff member is in job_class is
		-- PP_WFM_JOB_CLASSIFICATION_CODE.JOB_CLASSIFICATION_CODE_ID = 1083
		or 	(
		staff_id
		in ( select sjc.staff_id --, sjc.start_date, sjc.end_date
			from
				( --web_chat
				select staff_id, job_classification_code_id,
					trunc(start_date) as start_date, trunc(nvl(end_date,sysdate)) as end_date
				from dp_scorecard.pp_wfm_job_classification
				where nvl(delete_flag,'N') = 'N'
				) sjc
				join
				(
				select job_classification_code_id
				from dp_scorecard.pp_wfm_job_classification_code
				where job_classification_code_id = 1083
				and delete_date is null
				) jc
				on sjc.job_classification_code_id = jc.job_classification_code_id
				where dates between trunc(start_date) and trunc(nvl(end_date,sysdate))
			));

commit;

END;

--------------------------------------------------------
--------------------------------------------------------

PROCEDURE STEP4_LOAD_SC_PRDUCTION_BO_P4 is


   begin
      for idx in -11..0 loop
        STEP4_lOAD_SC_PRDUCTION_BO_P41(to_char(add_months(sysdate,idx),'YYYYMM'));
        STEP4_lOAD_SC_PRDUCTION_BO_P42(to_char(add_months(sysdate,idx),'YYYYMM'));
      end loop;
    end;

--------------------------------------------------------
--------------------------------------------------------

PROCEDURE STEP4_lOAD_SC_PRDUCTION_BO_P41(idx in VARCHAR2) IS

-------------------------------------------------------------
-- NOTE this procedure inserts rows prior to 04/01/2018
-- as well as after 04/01/2018 so comparisonf can be made
-- and beter information provided
--
-------------------------------------------------------------
    CURSOR P4_CSR IS
	WITH ACTUALS AS
	( SELECT WRK.STAFF_ID, WRK.EVENT_DATE,
			SUM(HANDLE_TIME)/60 AS TOTAL_DAILY_HOURS,
			SUM(CASE WHEN LKP.EE_ADHERENCE_v2 = 'Y' -- NOTE THESE ROWS ARE GENERATED IF EITHER EE_ADHERENCE = 'Y'
				OR LKP.EE_ADHERENCE_V2 = 'Y'      -- OR EE_ADHERENCE_V2 = 'Y' THIS WILL ALLOW FOR COMPARISON BETWEEN THE METHODS
				THEN HANDLE_TIME ELSE 0
			END)/(60) AS ACTUAL_PRODUCTIVE_HOURS
		FROM ( SELECT * FROM DP_SCORECARD.SCORECARD_HIERARCHY ) H
		JOIN
			( SELECT staff_id, event_id, trunc(task_start) as event_date, sum(handle_time) as handle_time
				FROM maxdat.PP_WFM_ACTUALS_SV
				WHERE TO_CHAR(task_start,'YYYYMM') = IDX
				and trunc(task_start) = trunc(task_end)
				group by staff_id, event_id, task_start
			) WRK
			ON WRK.STAFF_ID = H.STAFF_STAFF_ID
			AND WRK.EVENT_DATE BETWEEN TRUNC(HIRE_DATE) AND TRUNC(NVL(H.TERMINATION_DATE,SYSDATE))
		left outer JOIN ( SELECT * FROM MAXDAT.PP_BO_EVENT_TARGET_LKUP ) LKP
			ON LKP.EVENT_ID = WRK.EVENT_ID
			AND WRK.EVENT_DATE BETWEEN LKP.START_DATE AND NVL(LKP.END_DATE,SYSDATE)
    GROUP BY  WRK.STAFF_ID, WRK.EVENT_DATE
	),
	SCHEDULED AS
	(
            SELECT BO.STAFF_ID, TRUNC(BO.TASK_START) AS EVENT_DATE,
			SUM(BO.DURATION)/60 AS SCHEDULED_NOT_READY_HOURS
            FROM DP_SCORECARD.PP_WFM_TASK_BO BO
            WHERE EVENT_ID IN
              ( SELECT EVENT_ID
                FROM MAXDAT.PP_BO_EVENT_TARGET_LKUP
                WHERE EE_ADHERENCE_V2 = 'N'
                AND TRUNC(BO.TASK_START) BETWEEN TRUNC(START_DATE) AND TRUNC(NVL(END_DATE,SYSDATE))
                )
			AND TRUNC(TASK_START) = TRUNC(TASK_END)
            AND TO_CHAR(TASK_START,'YYYYMM') = IDX
            AND (BO.DELETE_DETECTED_DATE IS NULL OR NVL(BO.DELETE_FLAG,'N') = 'N' )
 --           AND NOT ( LKP.EE_ADHERENCE = 'Y' OR EE_ADHERENCE_V2 = 'Y' )
            GROUP BY BO.STAFF_ID, TRUNC(BO.TASK_START)
    )
	SELECT ACTUALS.STAFF_ID,
		ACTUALS.EVENT_DATE,
		ACTUALS.TOTAL_DAILY_HOURS,
		ACTUALS.ACTUAL_PRODUCTIVE_HOURS,
		SCHEDULED.SCHEDULED_NOT_READY_HOURS
	FROM ACTUALS
	LEFT OUTER JOIN SCHEDULED
		ON SCHEDULED.STAFF_ID = ACTUALS.STAFF_ID
		AND SCHEDULED.EVENT_DATE = ACTUALS.EVENT_DATE;

    P4_REC                          P4_CSR%ROWTYPE;


BEGIN

    IF P4_CSR%ISOPEN
	THEN
		CLOSE P4_CSR;
	END IF;

	OPEN P4_CSR;

	LOOP

		FETCH P4_CSR INTO P4_REC;

		EXIT WHEN P4_CSR%NOTFOUND;

        INSERT INTO DP_SCORECARD.SC_PRODUCTION_BO
            (
            STAFF_ID,
            DATES,
            EVENT_NAME_SORT,
            EVENT_NAME,
            EVENT_SUBNAME_SORT,
            EVENT_SUBNAME,
            METRIC
            )
        VALUES
            (
            P4_REC.STAFF_ID,
            P4_REC.EVENT_DATE,
            4,                          -- <<EVENT_NAME_SORT,
            'Daily Adherence Detail',   --<<EVENT_NAME,
            1,                          --<<EVENT_SUBNAME_SORT,
            'Total Daily Hours',        --<<EVENT_SUBNAME,
            P4_REC.TOTAL_DAILY_HOURS
            );

        INSERT INTO DP_SCORECARD.SC_PRODUCTION_BO
            (
            STAFF_ID,
            DATES,
            EVENT_NAME_SORT,
            EVENT_NAME,
            EVENT_SUBNAME_SORT,
            EVENT_SUBNAME,
            METRIC
            )
        VALUES
            (
            P4_REC.STAFF_ID,
            P4_REC.EVENT_DATE,
            4,                          -- <<EVENT_NAME_SORT,
            'Daily Adherence Detail',   --<<EVENT_NAME,
            2,                          --<<EVENT_SUBNAME_SORT,
            'Scheduled Not Ready Hours',        --<<EVENT_SUBNAME,
            P4_REC.SCHEDULED_NOT_READY_HOURS
            );

        INSERT INTO DP_SCORECARD.SC_PRODUCTION_BO
            (
            STAFF_ID,
            DATES,
            EVENT_NAME_SORT,
            EVENT_NAME,
            EVENT_SUBNAME_SORT,
            EVENT_SUBNAME,
            METRIC
            )
        VALUES
            (
            P4_REC.STAFF_ID,
            P4_REC.EVENT_DATE,
            4,                          -- <<EVENT_NAME_SORT,
            'Daily Adherence Detail',   --<<EVENT_NAME,
            3,                          --<<EVENT_SUBNAME_SORT,
            'Actual Productive Hours',        --<<EVENT_SUBNAME,
            P4_REC.ACTUAL_PRODUCTIVE_HOURS
            );

        --- new method ---
        IF (nvl(P4_REC.TOTAL_DAILY_HOURS,0)-nvl(P4_REC.SCHEDULED_NOT_READY_HOURS,0)) <> 0
        THEN
        INSERT INTO DP_SCORECARD.SC_PRODUCTION_BO
            (
            STAFF_ID,
            DATES,
            EVENT_NAME_SORT,
            EVENT_NAME,
            EVENT_SUBNAME_SORT,
            EVENT_SUBNAME,
            METRIC
            )
        VALUES
            (
            P4_REC.STAFF_ID,
            P4_REC.EVENT_DATE,
            4,                          -- <<EVENT_NAME_SORT,
            'Daily Adherence Detail',   --<<EVENT_NAME,
            4,                          --<<EVENT_SUBNAME_SORT,
            'Adherence',        --<<EVENT_SUBNAME,
            P4_REC.ACTUAL_PRODUCTIVE_HOURS/(NVL(P4_REC.TOTAL_DAILY_HOURS,0)-NVL(P4_REC.SCHEDULED_NOT_READY_HOURS,0))
            );
        END IF;


        END LOOP;

        COMMIT;

END;


--------------------------------------------------------
--------------------------------------------------------

PROCEDURE STEP4_LOAD_SC_PRDUCTION_BO_P42(idx in VARCHAR2) IS

-------------------------------------------------------------
-- THE PURPOSE ON THIS PROCEDURE IS SIMPLY TO
-- INSERT  ( OR REPLACE ) THE  'Daily Adherence' RECORDS
-- AFTER 4/1/2018 TO MINIMISE THE IMPACE ON MICROSTARTEGEY
-------------------------------------------------------------

    CURSOR P42_CSR IS
    SELECT
    STAFF_ID, DATES,
    3 AS EVENT_NAME_SORT,
    'Daily Adherence' AS EVENT_NAME,
    1 AS EVENT_SUBNAME_SORT,
    NULL AS EVENT_SUBNAME,
    METRIC
    FROM ( select *
    from DP_SCORECARD.SC_PRODUCTION_BO
    where to_char(dates,'YYYYMM') = IDX
	and DATES >= TO_DATE('20180401','YYYYMMDD')
    ) det
    WHERE det.EVENT_NAME = 'Daily Adherence Detail'
    AND det.EVENT_SUBNAME =  'Adherence';

    P42_REC                          P42_CSR%ROWTYPE;

BEGIN

    DELETE FROM DP_SCORECARD.SC_PRODUCTION_BO
    WHERE DATES >= TO_DATE('20180401','YYYYMMDD')
	AND TO_CHAR(DATES,'YYYYMM') = IDX
    AND EVENT_NAME = 'Daily Adherence';


    IF P42_CSR%ISOPEN
	THEN
		CLOSE P42_CSR;
	END IF;

	OPEN P42_CSR;

	LOOP

		FETCH P42_CSR INTO P42_REC;

		EXIT WHEN P42_CSR%NOTFOUND;

        INSERT INTO DP_SCORECARD.SC_PRODUCTION_BO
        (
        STAFF_ID, DATES, EVENT_NAME_SORT,
        EVENT_NAME, EVENT_SUBNAME_SORT, EVENT_SUBNAME,
        METRIC
        )
        VALUES
        (P42_REC.STAFF_ID, P42_REC.DATES, P42_REC.EVENT_NAME_SORT,
        P42_REC.EVENT_NAME, P42_REC.EVENT_SUBNAME_SORT, P42_REC.EVENT_SUBNAME,
        P42_REC.METRIC
        );

    END LOOP;

    COMMIT;

    IF P42_CSR%ISOPEN
	THEN
		CLOSE P42_CSR;
	END IF;

END;


-------------------------------------------------------
--- ***************************************************
--- ***************************************************
--- ***************  MONTHLY **************************
--- ***************************************************
--- ***************************************************
-------------------------------------------------------

PROCEDURE STEP5_LOAD_SC_SUMMARY_BO IS
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
-- Old Method Prior to April 01 2108
----------------------------------------

insert into dp_scorecard.SC_SUMMARY_BO
  (staff_id, dates_month_num, dates_year, event_name_sort, event_name, event_subname_sort, event_subname, metric)
WITH ALL_MONTHS as
( -- This is to make sure we don'y have monthly adherence Unless there is daily Adherence
SELECT distinct staff_id,
		to_char(dates, 'YYYYMM') 						as dates_month_num,
		to_char(dates, 'Month YYYY') 					as dates_year
FROM DP_SCORECARD.sc_production_bo
where EVENT_NAME = 'Daily Adherence'
and dates < to_date('20180401','yyyymmdd')
),
PRODUCTIVITIY_DAILY as
(
	SELECT STAFF_ID,
		event_date    as task_start,
		SUM(HANDLE_TIME_IN_SECONDS)/60 as DAILY_PRODUCTIVITIY
	FROM PP_WFM_DAILY_SUMMARY
	where event_date >= TRUNC(ADD_MONTHS(SYSDATE, -12), 'MM')
	and trunc(nvl(STAFF_TERMINATION_DATE,sysdate)) >= event_date
	and ( EE_ADHERENCE = 'Y'
	--OR EE_ADHERENCE_V2 = 'Y'
		)
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

----------------------------------------
--MONTHLY Adherence (SUMMARY)
-- New Method STARTING April 01 2018
----------------------------------------

insert into dp_scorecard.SC_SUMMARY_BO
  (staff_id, dates_month_num, dates_year, event_name_sort, event_name, event_subname_sort, event_subname, metric)
SELECT staff_id,
		to_char(dates, 'YYYYMM') 						as dates_month_num,
		to_char(dates, 'Month YYYY') 					as dates_year,
		event_name_sort                                 as event_name_sort,
		'Monthly Adherence Detail'                      as event_name,
		event_subname_sort                              as event_subname_sort,
		event_subname                                   as event_subname,
		sum(metric)                                     as metric
FROM DP_SCORECARD.sc_production_bo
where EVENT_NAME = 'Daily Adherence Detail'
and event_subname in ( 'Total Daily Hours', 'Scheduled Not Ready Hours', 'Actual Productive Hours' )
AND DATES >= TO_DATE('20180401','yyyymmdd')
AND( STAFF_ID, DATES ) IN
    ( SELECT STAFF_ID, DATES
    FROM DP_SCORECARD.sc_production_bo
    WHERE EVENT_NAME = 'Daily Adherence' AND NVL(METRIC,0) <> 0
    )
GROUP BY
        STAFF_ID,
		TO_CHAR(DATES, 'YYYYMM'),
		TO_CHAR(DATES, 'Month YYYY'),
		EVENT_NAME_SORT,
		EVENT_NAME,
		EVENT_SUBNAME_SORT,
		EVENT_SUBNAME;

    COMMIT;

    INSERT INTO DP_SCORECARD.SC_SUMMARY_BO
    (STAFF_ID, DATES_MONTH_NUM, DATES_YEAR,
    EVENT_NAME_SORT, EVENT_NAME,
    EVENT_SUBNAME_SORT, EVENT_SUBNAME,
    METRIC)
    WITH ADHERENCE_REC
    AS
    (
        SELECT
            STAFF_ID, DATES_MONTH_NUM, DATES_YEAR,
            3 as EVENT_NAME_SORT,
            'Monthly Adherence' as event_name,
            1 AS EVENT_SUBNAME_SORT, NULL AS EVENT_SUBNAME,
            -- ADHERENCE = ACTUAL_PRODUCTIVE_HOURS / (TOTAL_DAILY_HOURS - SCHEDULED_NOT_READY_HOURS)
            SUM( CASE WHEN EVENT_SUBNAME = 'Actual Productive Hours'    THEN METRIC ELSE 0  END ) AS PRODCTIVE_HOURS,
            SUM( CASE WHEN EVENT_SUBNAME = 'Total Daily Hours'          THEN METRIC ELSE 0  END ) AS TOTAL_DAILY_HOURS,
            SUM( CASE WHEN EVENT_SUBNAME = 'Scheduled Not Ready Hours'  THEN METRIC ELSE 0  END ) AS SCHEDULED_NOT_READY
        FROM DP_SCORECARD.SC_SUMMARY_BO
        WHERE EVENT_NAME = 'Monthly Adherence Detail'
        AND EVENT_SUBNAME IN (
            'Actual Productive Hours',
            'Total Daily Hours',
            'Scheduled Not Ready Hours'
            )
        GROUP BY
            STAFF_ID, DATES_MONTH_NUM, DATES_YEAR,
            EVENT_NAME_SORT
        HAVING SUM( CASE WHEN EVENT_SUBNAME = 'Total Daily Hours'          THEN METRIC ELSE 0  END )
                - SUM( CASE WHEN EVENT_SUBNAME = 'Scheduled Not Ready Hours'  THEN METRIC ELSE 0  END ) <> 0
    )
    SELECT STAFF_ID, DATES_MONTH_NUM, DATES_YEAR,
        EVENT_NAME_SORT, EVENT_NAME,
        EVENT_SUBNAME_SORT, EVENT_SUBNAME,
       ( PRODCTIVE_HOURS / ( TOTAL_DAILY_HOURS - SCHEDULED_NOT_READY ) ) AS METRIC
    FROM ADHERENCE_REC;

    COMMIT;

	EXCEPTION
		WHEN OTHERS THEN RAISE;

	END;

----------------------------------------
-- *************************************
-- *************************************
-- MONTHLY ROLLUP TO SUPERVISOR LEVEL
-- *************************************
-- *************************************
----------------------------------------
PROCEDURE LOAD_SC_SUMMARY_BO_ROLLUP IS
	BEGIN
		NULL;


	EXECUTE IMMEDIATE 'truncate table dp_scorecard.SC_SUMMARY_BO_ROLLUP';

	--delete dp_scorecard.SC_SUMMARY_BO_ROLLUP;
	--commit;
    DBMS_OUTPUT.PUT_LINE('TRUNCATE COMPLETE');
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

    DBMS_OUTPUT.PUT_LINE('insert 1 COMPLETE');

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

    DBMS_OUTPUT.PUT_LINE('insert 2 COMPLETE');


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

    DBMS_OUTPUT.PUT_LINE('insert 3 COMPLETE');



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

    DBMS_OUTPUT.PUT_LINE('insert 4 COMPLETE');


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

    DBMS_OUTPUT.PUT_LINE('insert 5 COMPLETE');


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

    DBMS_OUTPUT.PUT_LINE('insert 6 COMPLETE');


----------------------------------
--Rollup MONTHLY
--Rollup Adherence Numerator
-- old method prior to April 2018
----------------------------------

insert into dp_scorecard.SC_SUMMARY_BO_ROLLUP
  (supervisor_staff_id, building, department,
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
  where dates_month_num < '201804'
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
  AND to_char(event_date,'YYYYMM') < '201804'
  AND ( EE_ADHERENCE_V2 = 'Y'
		OR EE_ADHERENCE = 'Y'
		)
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
   and to_char(task_start,'YYYYMM') < '201804'
GROUP BY T.STAFF_ID, TRUNC(T.TASK_START)
),
COMBINED_DAILY as
(
select p.staff_id, p.TASK_START, p.DAILY_PRODUCTIVITIY, s.DAILY_TOTAL_MIN_SCHED
from PRODUCTIVITIY_DAILY p
left outer join SCHEDULED_DAILY s on p.STAFF_ID=s.STAFF_ID and p.TASK_START=s.TASK_START
where to_char(P.task_start,'YYYYMM') < '201804'
),
PRODUCTIVITIY as
(
SELECT STAFF_ID,
       TO_CHAR(TASK_START,'YYYYMM') as dates_month_num,
       SUM(DAILY_PRODUCTIVITIY) as PRODUCTIVITIY
  FROM COMBINED_DAILY
WHERE DAILY_PRODUCTIVITIY IS NOT NULL AND DAILY_PRODUCTIVITIY > 0
AND DAILY_TOTAL_MIN_SCHED IS NOT NULL AND DAILY_TOTAL_MIN_SCHED > 0
and TO_CHAR(TASK_START,'YYYYMM') < '201804'
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
and TO_CHAR(TASK_START,'YYYYMM') < '201804'
GROUP BY STAFF_ID, TO_CHAR(TASK_START,'YYYYMM')
),
COMBINED as
(
    select h.supervisor_staff_id, h.department, h.building, p.dates_month_num,
        --(sum(p.PRODUCTIVITIY)/sum(s.TOTAL_MIN_SCHED)) as monthly_adherence_metric
        sum(p.PRODUCTIVITIY) as metric
        --sum(s.TOTAL_MIN_SCHED) as denominator
    from dp_scorecard.scorecard_hierarchy_sv h
    JOIN PRODUCTIVITIY p on h.staff_staff_id=p.STAFF_ID
    LEFT OUTER join SCHEDULED s on p.STAFF_ID=s.STAFF_ID and p.dates_month_num=s.dates_month_num
    group by h.supervisor_staff_id, h.department, h.building, p.dates_month_num
)
select
	supervisor_staff_id,
	building,
	department,
	dates_month_num,
	to_char(to_date(dates_month_num,'YYYYMM'),'Month YYYY') as dates_year,
	3 as event_name_sort,
	'Monthly Adherence Numerator' as event_name,
	1 as event_subname_sort,
	to_char(NULL) as event_subname,
	sum(metric) as metric
    from (
select am.supervisor_staff_id,
	am.department, am.building,
	am.dates_month_num, --am.dates_year,
0 as metric --monthly_adherence_metric
FROM ALL_MONTHS am
where am.dates_month_num < '201804'
union all
select cmb.supervisor_staff_id,
	cmb.department, cmb.building,
	cmb.dates_month_num,
	cmb.metric
from COMBINED cmb
where cmb.dates_month_num < '201804'
    )
group by
    supervisor_staff_id,
	building,
	department,
	dates_month_num;
--WHERE AM.supervisor_staff_id = 1176
--ORDER BY 1,2,3,4,5,6,7

--rollback;

commit;

    DBMS_OUTPUT.PUT_LINE('insert 7 COMPLETE');


-------------------------------
--Rollup MONTHLY
--Rollup Adherence Denominator
-- old method prior to April 1 2018
-------------------------------

insert into dp_scorecard.SC_SUMMARY_BO_ROLLUP
  (supervisor_staff_id, building, department,
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
  where dates_month_num < '201804'
  order by supervisor_staff_id, department, building,
       dates_month_num
),
PRODUCTIVITIY_DAILY as
(
SELECT STAFF_ID,
       EVENT_DATE as TASK_START,
       SUM(HANDLE_TIME_IN_SECONDS) as DAILY_PRODUCTIVITIY
  FROM dp_scorecard.PP_WFM_DAILY_SUMMARY A
  WHERE ( EE_ADHERENCE = 'Y'
	--	OR EE_ADHERENCE_V2 = 'Y'
		)
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
--results as
--(
select
	supervisor_staff_id,
	building,
	department,
	dates_month_num,
	to_char(to_date(dates_month_num,'YYYYMM'),'Month YYYY') as dates_year,
	3 as event_name_sort,
	'Monthly Adherence Denominator' as event_name,
	1 as event_subname_sort,
	to_char(NULL) as event_subname,
	sum(denominator) as metric
    from (
select am.supervisor_staff_id,
	am.department, am.building,
	am.dates_month_num, --am.dates_year,
0 as denominator --monthly_adherence_metric
FROM ALL_MONTHS am
where dates_month_num < 201804
union all
select cmb.supervisor_staff_id,
	cmb.department, cmb.building,
	cmb.dates_month_num,
	cmb.denominator
from COMBINED cmb
where dates_month_num < 201804
    )
group by
    supervisor_staff_id,
	building,
	department,
	dates_month_num;
--ORDER BY 1,2,3,4,5,6,7;

    DBMS_OUTPUT.PUT_LINE('insert 8.1 COMPLETE');

commit;

-------------------------------
--Rollup MONTHLY
--Rollup Adherence NUMERATOR
-- NEW method Starting April 1 2018
-------------------------------

	INSERT INTO DP_SCORECARD.SC_SUMMARY_BO_ROLLUP
		(SUPERVISOR_STAFF_ID, BUILDING, DEPARTMENT,
		DATES_MONTH_NUM, DATES_YEAR,
		EVENT_NAME_SORT, EVENT_NAME,
		EVENT_SUBNAME_SORT, EVENT_SUBNAME,
		METRIC
		)
		SELECT
			H.SUPERVISOR_STAFF_ID, H.BUILDING, H.DEPARTMENT,
			BO.DATES_MONTH_NUM,
			BO.DATES_YEAR,
			3 AS EVENT_NAME_SORT,
			'Monthly Adherence Numerator'   AS event_name,
			1 AS EVENT_SUBNAME_SORT,
			NULL 	AS EVENT_SUBNAME,
			( SUM(CASE WHEN EVENT_SUBNAME = 'Actual Productive Hours' THEN NVL(METRIC,0) ELSE 0 END)
			)	   AS METRIC
	FROM SC_SUMMARY_BO BO
	JOIN DP_SCORECARD.SCORECARD_HIERARCHY H
	ON H.STAFF_STAFF_ID = BO.STAFF_ID
	AND DATES_MONTH_NUM BETWEEN TO_CHAR(HIRE_DATE,'YYYYMM') AND TO_CHAR(NVL(TERMINATION_DATE,SYSDATE),'YYYYMM')
	WHERE DATES_MONTH_NUM >= '201804'
	AND EVENT_SUBNAME IN ('Actual Productive Hours' )
	GROUP BY H.SUPERVISOR_STAFF_ID, h.building, h.department, BO.DATES_MONTH_NUM, BO.DATES_YEAR;

	COMMIT;


-------------------------------
--Rollup MONTHLY
--Rollup Adherence Denominator
-- NEW method Starting April 1 2018
-------------------------------

	INSERT INTO DP_SCORECARD.SC_SUMMARY_BO_ROLLUP
		(SUPERVISOR_STAFF_ID, BUILDING, DEPARTMENT,
		DATES_MONTH_NUM, DATES_YEAR,
		EVENT_NAME_SORT, EVENT_NAME,
		EVENT_SUBNAME_SORT, EVENT_SUBNAME,
		METRIC
		)
		SELECT
			H.SUPERVISOR_STAFF_ID, H.BUILDING, H.DEPARTMENT,
			BO.DATES_MONTH_NUM,
			BO.DATES_YEAR,
			3 AS EVENT_NAME_SORT,
			'Monthly Adherence Denominator'   AS event_name,
			1 AS EVENT_SUBNAME_SORT,
			NULL 	AS EVENT_SUBNAME,
			( SUM(CASE WHEN EVENT_SUBNAME = 'Total Daily Hours' THEN NVL(METRIC,0) ELSE 0 END)
			- SUM(CASE WHEN EVENT_SUBNAME = 'Scheduled Not Ready Hours' THEN NVL(METRIC,0) ELSE 0 END)
			)	   AS METRIC
	FROM SC_SUMMARY_BO BO
	JOIN DP_SCORECARD.SCORECARD_HIERARCHY H
	ON H.STAFF_STAFF_ID = BO.STAFF_ID
	AND DATES_MONTH_NUM BETWEEN TO_CHAR(HIRE_DATE,'YYYYMM') AND TO_CHAR(NVL(TERMINATION_DATE,SYSDATE),'YYYYMM')
	WHERE DATES_MONTH_NUM >= '201804'
	AND EVENT_SUBNAME IN ('Total Daily Hours', 'Scheduled Not Ready Hours' )
	GROUP BY H.SUPERVISOR_STAFF_ID, h.building, h.department, BO.DATES_MONTH_NUM, BO.DATES_YEAR;

	COMMIT;

	DBMS_OUTPUT.PUT_LINE('insert 8.2 COMPLETE');

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

    DBMS_OUTPUT.PUT_LINE('insert 9 COMPLETE');

    DBMS_OUTPUT.PUT_LINE('ALL COMPLETE');

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
/

show errors