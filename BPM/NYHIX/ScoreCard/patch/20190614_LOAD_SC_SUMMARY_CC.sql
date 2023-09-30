CREATE OR REPLACE procedure DP_SCORECARD.LOAD_SC_SUMMARY_CC
( add_mth_start number default 0,
  add_mth_stop  number default 11
 )
AS
-- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
 	SVN_FILE_URL varchar2(200) := '$URL: svn://rcmxapp1d.maximus.com/maxdat/BPM/NYHIX/patch/20170623_PP_WFM_BACK_OFFICE_LOAD_PKG.sql $';
  	SVN_REVISION varchar2(20) := '$Revision: 20489 $';
 	SVN_REVISION_DATE varchar2(60) := '$Date: 2017-07-03 14:31:06 -0500 (Mon, 03 Jul 2017) $';
  	SVN_REVISION_AUTHOR varchar2(20) := '$Author: wl134672 $';


BEGIN

    --    The ADD_MTH_START .. ADD_MTH_STOP parameters are used to drive
    --    a loop which uses ADD_MONTHS(sysdate, "minus" the loop value.
    --    The loop starts with the current month and works "back".
    --    To calulate from the current month and going back 14 months
    --    the parameters would be LOAD_SC_SUMMARY_CC(0,13)
    --    The "zero" would be the current month the "Thirteen" earliest month.

	FOR MTH_LOOP IN ADD_MTH_START .. ADD_MTH_STOP
	LOOP


	DELETE FROM DP_SCORECARD.SC_SUMMARY_CC
	WHERE DATES_MONTH_NUM = TO_CHAR(ADD_MONTHS(SYSDATE,-MTH_LOOP),'YYYYMM');

    COMMIT;

   INSERT INTO SC_SUMMARY_CC (STAFF_STAFF_ID, STAFF_NATID,
	STAFF_STAFF_NAME,
	DATES_MONTH,
	DATES_MONTH_NUM,
	DATES_YEAR,
	EXCLUSION_FLAG,
	TOT_CALLS_ANSWERED,
	TOT_SHORT_CALLS_ANSWERED,
	TOT_TOT_RETURN_TO_QUEUE,
	TOT_RETURN_TO_QUEUE_TIMEOUT,
	TOT_AVERAGE_HANDLE_TIME,
	TOT_SCHED_PRODUCTIVE_TIME,
	TOT_ACTUAL_PRODUCTIVE_TIME,
	TOT_TALK_TIME,
	TOT_WRAP_UP_TIME,
	TOT_LOGGED_IN_TIME,
	TOT_NOT_READY_TIME,
	TOT_BREAK_TIME,
	TOT_LUNCH_TIME,
	QCS_PERFORMED,
	AVG_QC_SCORE,
	TOT_INCIDENTS_COMPLETED,
	DAYS_INCIDENTS_COMPLETED,
	DAYS_DEF_INC_COMPLETED,
	TOT_DEFECTS_COMPLETED,
	DAYS_DEFECTS_COMPLETED,
	LAG_TIME_TOT_SCHED_PROD_TIME,
	TOT_CALL_RECORDS,
	TOT_CUSTOMER_COUNT,
	TOT_CALL_WRAP_UP_COUNT,
	TOT_WRAP_UP_ERROR,
	DAYS_SHORT_CALLS_GT_10,
	DAYS_CALLS_ANSWERED,
	ADHERENCE,
	CORRECTIVE_ACTION_FLAG,
	ONE_ON_ONE_FLAG,
	OBSERVATION_FLAG,
	RECORDED_CALL_REVIEW_FLAG,
	LIVE_PHONE_OBSERVATION_FLAG,
	--   Mer_Flag,
	----------------
	SUPERVISOR_STAFF_ID,
	SUPERVISOR_NATID,
	BUILDING,
	DEPARTMENT,
	------------------
	-- From SC_AGENT_STAT_SV
	TOT_HANDLE_TIME,
	TOT_HANDLE_TIME_COUNT,
	TRTQ,
	CALLS_OFFERED,
	SHORT_CALL_AGENT_COUNT,
	-- FROM SCORECARD_QUALITY_SV
	SUM_QC_SCORE,
	COUNT_QC_SCORE,
	QCS_REMAINING,
	-- From Attendance - scorecard_attendance_mthly_sv
	AVG_ATTENDANCE_BALANCE,
	AVG_ATTENDANCE_TOTAL_BALANCE,
	STAFF_COUNT,
	ADHERENCE_TOT_LOGGED_IN_TIME,
	ADHERENCE_TOT_NOT_READY_TIME,
   -- From WEBCHAT_ACTUALS 
	WEBCHAT_ASSIGNED,
	WEBCHAT_TRANSFERRED,
	WEBCHAT_CONFERENCED,
	WEBCHAT_TOTAL_NUMBER
   )
WITH
TIME_metrics as
 (
   SELECT
      distinct
      to_char(TRUNC(a11.AS_DATE), 'YYYYMM') as dates_month_num,
      to_char(AGENT_ID) AGENT_ID,
      a_s.staff_staff_id,
       NVL(EXCLUSION_FLAG,'N')   AS EXCLUSION_FLAG,
       sum(CALLS_ANSWERED) TOT_CALLS_ANSWERED,
       sum(SHORT_CALLS_ANSWERED) TOT_SHORT_CALLS_ANSWERED,
       sum(TOT_RETURN_TO_QUEUE) TOT_TOT_RETURN_TO_QUEUE,
       sum(TOT_RETURN_TO_QUEUE_TIMEOUT) TOT_RETURN_TO_QUEUE_TIMEOUT,
       avg(extract( day from NUMTODSINTERVAL (((to_date(AVERAGE_HANDLE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*24*60*60 +
         extract( hour from NUMTODSINTERVAL (((to_date(AVERAGE_HANDLE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60*60 +
         extract( minute from NUMTODSINTERVAL (((to_date(AVERAGE_HANDLE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60 +
         extract( second from NUMTODSINTERVAL (((to_date(AVERAGE_HANDLE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second')) ) TOT_AVERAGE_HANDLE_TIME,
       sum(extract( day from NUMTODSINTERVAL (((to_date(TOT_SCHED_PRODUCTIVE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*24*60*60 +
         extract( hour from NUMTODSINTERVAL (((to_date(TOT_SCHED_PRODUCTIVE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60*60 +
         extract( minute from NUMTODSINTERVAL (((to_date(TOT_SCHED_PRODUCTIVE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60 +
         extract( second from NUMTODSINTERVAL (((to_date(TOT_SCHED_PRODUCTIVE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second')) ) TOT_SCHED_PRODUCTIVE_TIME,
       sum(extract( day from NUMTODSINTERVAL (((to_date(ACTUAL_PRODUCTIVE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*24*60*60 +
         extract( hour from NUMTODSINTERVAL (((to_date(ACTUAL_PRODUCTIVE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60*60 +
         extract( minute from NUMTODSINTERVAL (((to_date(ACTUAL_PRODUCTIVE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60 +
         extract( second from NUMTODSINTERVAL (((to_date(ACTUAL_PRODUCTIVE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second')) ) TOT_ACTUAL_PRODUCTIVE_TIME,
       sum(extract( day from NUMTODSINTERVAL (((to_date(TALK_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*24*60*60 +
         extract( hour from NUMTODSINTERVAL (((to_date(TALK_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60*60 +
         extract( minute from NUMTODSINTERVAL (((to_date(TALK_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60 +
         extract( second from NUMTODSINTERVAL (((to_date(TALK_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second')) ) TOT_TALK_TIME,
       sum(extract( day from NUMTODSINTERVAL (((to_date(WRAP_UP_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*24*60*60 +
         extract( hour from NUMTODSINTERVAL (((to_date(WRAP_UP_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60*60 +
         extract( minute from NUMTODSINTERVAL (((to_date(WRAP_UP_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60 +
         extract( second from NUMTODSINTERVAL (((to_date(WRAP_UP_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second')) ) TOT_WRAP_UP_TIME,
		 -- 2017/10/19 TOT_LOGGED_IN_TIME and TOT_NOT_READY_TIME moved to ADHERENCE
       sum(extract( day from NUMTODSINTERVAL (((to_date(LOGGED_IN_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*24*60*60 +
         extract( hour from NUMTODSINTERVAL (((to_date(LOGGED_IN_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60*60 +
         extract( minute from NUMTODSINTERVAL (((to_date(LOGGED_IN_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60 +
         extract( second from NUMTODSINTERVAL (((to_date(LOGGED_IN_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second')) ) TOT_LOGGED_IN_TIME,
       sum(extract( day from NUMTODSINTERVAL (((to_date(NOT_READY_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*24*60*60 +
         extract( hour from NUMTODSINTERVAL (((to_date(NOT_READY_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60*60 +
         extract( minute from NUMTODSINTERVAL (((to_date(NOT_READY_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60 +
         extract( second from NUMTODSINTERVAL (((to_date(NOT_READY_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second')) ) TOT_NOT_READY_TIME,
       sum(extract( day from NUMTODSINTERVAL (((to_date(BREAK_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*24*60*60 +
         extract( hour from NUMTODSINTERVAL (((to_date(BREAK_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60*60 +
         extract( minute from NUMTODSINTERVAL (((to_date(BREAK_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60 +
         extract( second from NUMTODSINTERVAL (((to_date(BREAK_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second')) ) TOT_BREAK_TIME,
       sum(extract( day from NUMTODSINTERVAL (((to_date(LUNCH_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*24*60*60 +
         extract( hour from NUMTODSINTERVAL (((to_date(LUNCH_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60*60 +
         extract( minute from NUMTODSINTERVAL (((to_date(LUNCH_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60 +
         extract( second from NUMTODSINTERVAL (((to_date(LUNCH_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second')) ) TOT_LUNCH_TIME,
		 --------------------------
       sum(extract( day from NUMTODSINTERVAL (((to_date(AVERAGE_HANDLE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*24*60*60 +
         extract( hour from NUMTODSINTERVAL (((to_date(AVERAGE_HANDLE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60*60 +
         extract( minute from NUMTODSINTERVAL (((to_date(AVERAGE_HANDLE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60 +
         extract( second from NUMTODSINTERVAL (((to_date(AVERAGE_HANDLE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second')) ) TOT_HANDLE_TIME,
       count(1) as TOT_HANDLE_TIME_COUNT,
       SUM(TOT_RET_TO_QUEUE_TOTAL) TRTQ,
	   SUM(CALLS_OFFERED)  CALLS_OFFERED
		 --------------------------
         FROM dp_scorecard.scorecard_hierarchy_sv a_s
        join DP_SCORECARD.SC_AGENT_STAT_SV a11 on a_s.staff_natid =  a11.AGENT_ID
        where not exists (select 1
							from dp_scorecard.sc_exclusion_yes_sv b
							where a11.agent_id = b.agent_id
							and a11.as_date = b.exclusion_date
							)
        and TO_CHAR(a11.AS_DATE,'YYYYMM') = TO_CHAR(ADD_MONTHS(SYSDATE, -mth_loop),'YYYYMM')
    group by to_char(TRUNC(a11.AS_DATE), 'YYYYMM'), a_s.staff_staff_id, AGENT_ID, NVL(EXCLUSION_FLAG,'N')
 ),
  SHORT_CALL_AGENT_COUNT AS
 (
	--Description: Identifies the distinct amount of agents that had a day with over 10 short calls.
	SELECT DISTINCT
		STAFF_STAFF_ID,
		DATES_MONTH_NUM,
		COUNT(DISTINCT AGENT_ID) OVER (PARTITION BY STAFF_STAFF_ID, DATES_MONTH_NUM) AS SHORT_CALL_AGENT_COUNT
	FROM
	(
      SELECT
       H.STAFF_STAFF_ID,
       AGENT_ID,
       TO_CHAR(TRUNC(AS_DATE), 'YYYYMM') AS DATES_MONTH_NUM,
       TRUNC(AS_DATE),
       SHORT_CALLS_ANSWERED
        FROM DP_SCORECARD.SC_AGENT_STAT S
        JOIN DP_SCORECARD.SCORECARD_HIERARCHY H ON H.STAFF_NATID = S.AGENT_ID
	   WHERE TO_CHAR(S.AS_DATE,'YYYYMM') = TO_CHAR(ADD_MONTHS(SYSDATE, -mth_loop),'YYYYMM')
       AND SHORT_CALLS_ANSWERED > 10
  )
),
 INCDEFS AS
 (
   SELECT A11.STAFF_ID,
    A11.EVENT_DATE AS_DATE,
       TO_CHAR(A11.EVENT_DATE, 'YYYYMM') AS DATES_MONTH_NUM,
        SUM((CASE WHEN A11.EVENT_ID IN (1374, 1375, 1376, 1377, 1378, 1379) THEN TOTAL_LOGGED ELSE 0 END)) INCIDENTS_COMPLETED,
        SUM((CASE WHEN A11.EVENT_ID IN (1373) THEN TOTAL_LOGGED ELSE 0 END)) DEFECTS_COMPLETED
 	FROM DP_SCORECARD.PP_WFM_DAILY_SUMMARY_WRK A11
   WHERE 1=1
	AND TO_CHAR(A11.EVENT_DATE,'YYYYMM') = TO_CHAR(ADD_MONTHS(SYSDATE, -MTH_LOOP),'YYYYMM')
	AND (A11.EVENT_ID IN (1374, 1375, 1376, 1377, 1378, 1379)
         OR A11.EVENT_ID IN (1373))
   GROUP BY A11.STAFF_ID, EVENT_DATE --, BUILDING, DEPARTMENT
 ),
 INC_METRICS AS
 (
 SELECT
   DISTINCT  A11.STAFF_ID AS STAFF_STAFF_ID,
       A11.DATES_MONTH_NUM,
        SUM(A11.INCIDENTS_COMPLETED) OVER (PARTITION BY A11.STAFF_ID, A11.DATES_MONTH_NUM) AS TOT_INCIDENTS_COMPLETED,
        COUNT(A11.INCIDENTS_COMPLETED) OVER (PARTITION BY A11.STAFF_ID, A11.DATES_MONTH_NUM) AS DAYS_INCIDENTS_COMPLETED
   FROM  INCDEFS A11
   WHERE  A11.INCIDENTS_COMPLETED <> 0
 ),
 DEF_METRICS AS
 (
 SELECT
   DISTINCT  A11.STAFF_ID AS STAFF_STAFF_ID,
       A11.DATES_MONTH_NUM,
       SUM(A11.DEFECTS_COMPLETED) OVER (PARTITION BY A11.STAFF_ID, A11.DATES_MONTH_NUM) AS TOT_DEFECTS_COMPLETED,
       COUNT(A11.DEFECTS_COMPLETED) OVER (PARTITION BY A11.STAFF_ID, A11.DATES_MONTH_NUM) AS  DAYS_DEFECTS_COMPLETED
   FROM  INCDEFS A11
   WHERE  A11.DEFECTS_COMPLETED <> 0
 ) ,
 INC_DEF_METRICS AS (
   SELECT STAFF_ID AS STAFF_STAFF_ID,
       DATES_MONTH_NUM,
       COUNT(DISTINCT AS_DATE ) AS  DAYS_DEF_INC_COMPLETED
   FROM  INCDEFS A11
   WHERE  DEFECTS_COMPLETED > 0
   OR INCIDENTS_COMPLETED > 0
   GROUP BY STAFF_ID, DATES_MONTH_NUM
 ),
 LAG_METRICS AS (
   SELECT
       DISTINCT TO_CHAR(TRUNC(A11.LAG_DATE), 'YYYYMM') AS DATES_MONTH_NUM,
        A10.STAFF_STAFF_ID,
        SUM(EXTRACT( DAY FROM NUMTODSINTERVAL (((TO_DATE(TOT_SCHED_PRODUCTIVE_TIME,'HH24:MI:SS') - TO_DATE('00:00:00','HH24:MI:SS')) * 86400), 'SECOND'))*24*60*60 +
         EXTRACT( HOUR FROM NUMTODSINTERVAL (((TO_DATE(TOT_SCHED_PRODUCTIVE_TIME,'HH24:MI:SS') - TO_DATE('00:00:00','HH24:MI:SS')) * 86400), 'SECOND'))*60*60 +
         EXTRACT( MINUTE FROM NUMTODSINTERVAL (((TO_DATE(TOT_SCHED_PRODUCTIVE_TIME,'HH24:MI:SS') - TO_DATE('00:00:00','HH24:MI:SS')) * 86400), 'SECOND'))*60 +
         EXTRACT( SECOND FROM NUMTODSINTERVAL (((TO_DATE(TOT_SCHED_PRODUCTIVE_TIME,'HH24:MI:SS') - TO_DATE('00:00:00','HH24:MI:SS')) * 86400), 'SECOND')) )
        OVER (PARTITION BY A10.STAFF_STAFF_ID, TO_CHAR(TRUNC(A11.LAG_DATE), 'YYYYMM')) AS LAG_TIME_TOT_SCHED_PROD_TIME
       FROM DP_SCORECARD.SCORECARD_HIERARCHY_SV A10
  JOIN DP_SCORECARD.SC_LAG_TIME_SV A11 ON A10.STAFF_NATID = A11.AGENT_ID
  JOIN (SELECT TRUNC(AS_DATE) AS AS_DATE, AGENT_ID
		FROM DP_SCORECARD.SC_AGENT_STAT_SV
		WHERE TO_CHAR(AS_DATE,'YYYYMM') = TO_CHAR(ADD_MONTHS(SYSDATE, -MTH_LOOP),'YYYYMM')
		) A12
        ON  A12.AGENT_ID=A10.STAFF_NATID AND A12.AS_DATE= TRUNC(A11.LAG_DATE)
  WHERE NOT EXISTS (SELECT 1 FROM DP_SCORECARD.SC_EXCLUSION_YES_SV B
					WHERE A11.AGENT_ID = B.AGENT_ID
					AND TRUNC(A11.LAG_DATE) = TRUNC(B.EXCLUSION_DATE)
					)
		AND TO_CHAR(A11.LAG_DATE,'YYYYMM') = TO_CHAR(ADD_MONTHS(SYSDATE, -MTH_LOOP),'YYYYMM')
 ),
 CUST_METRICS AS
 (
    SELECT DISTINCT
      TO_CHAR(TRUNC(A11.CALL_DATE), 'YYYYMM') AS DATES_MONTH_NUM,
        A10.STAFF_STAFF_ID,
       COUNT(CALL_RECORD_ID) OVER (PARTITION BY A10.STAFF_STAFF_ID,TO_CHAR(TRUNC(A11.CALL_DATE), 'MONTH YYYY')) AS  TOT_CALL_RECORDS,
       SUM(CUSTOMER_COUNT) OVER (PARTITION BY A10.STAFF_STAFF_ID,TO_CHAR(TRUNC(A11.CALL_DATE), 'MONTH YYYY')) AS TOT_CUSTOMER_COUNT,
       SUM(CALL_WRAP_UP_COUNT) OVER (PARTITION BY A10.STAFF_STAFF_ID,TO_CHAR(TRUNC(A11.CALL_DATE), 'MONTH YYYY')) AS TOT_CALL_WRAP_UP_COUNT
    FROM DP_SCORECARD.SCORECARD_HIERARCHY_SV A10
  JOIN DP_SCORECARD.SC_NON_STD_USE_SV A11 ON TO_CHAR(A10.STAFF_NATID) = A11.EMPLOYEE_ID
  WHERE NOT EXISTS (SELECT 1 FROM DP_SCORECARD.SC_EXCLUSION_YES_SV B
					WHERE A11.EMPLOYEE_ID = B.AGENT_ID
					AND TRUNC(A11.CALL_DATE) = TRUNC(B.EXCLUSION_DATE)
					)
  AND TO_CHAR(A11.CALL_DATE,'YYYYMM') = TO_CHAR(ADD_MONTHS(SYSDATE, -MTH_LOOP),'YYYYMM')
 ),
 WUE_METRICS AS
 (
   SELECT DISTINCT
       TO_CHAR(TRUNC(A11.WUE_DATE), 'YYYYMM') AS DATES_MONTH_NUM,
        A10.STAFF_STAFF_ID,
        SUM(A11.WRAP_UP_ERROR) OVER (PARTITION BY A10.STAFF_STAFF_ID,TO_CHAR(TRUNC(A11.WUE_DATE), 'MONTH YYYY')) AS TOT_WRAP_UP_ERROR
   FROM DP_SCORECARD.SCORECARD_HIERARCHY_SV A10
  JOIN DP_SCORECARD.SC_WRAP_UP_ERROR_SV A11 ON A10.STAFF_NATID = A11.AGENT_ID
  WHERE NOT EXISTS (SELECT 1 FROM DP_SCORECARD.SC_EXCLUSION_YES_SV B
		WHERE A11.AGENT_ID = B.AGENT_ID
		AND TRUNC(A11.WUE_DATE) = TRUNC(B.EXCLUSION_DATE)
		)
		AND TO_CHAR(A11.WUE_DATE,'YYYYMM') = TO_CHAR(ADD_MONTHS(SYSDATE, -MTH_LOOP),'YYYYMM')
 ),
 CALL_metrics AS
 (
  SELECT
        A10.STAFF_STAFF_ID,
		A11.AS_DATE,
        CASE WHEN SUM(A11.SHORT_CALLS_ANSWERED) > 10 THEN 1 ELSE NULL END SHORT_CALLS,
        SUM(A11.CALLS_ANSWERED) TOT_CALLS,
       TO_CHAR(TRUNC(A11.AS_DATE), 'YYYYMM') AS DATES_MONTH_NUM
   FROM DP_SCORECARD.SCORECARD_HIERARCHY_SV a10
   JOIN DP_SCORECARD.SC_AGENT_STAT_SV A11 ON A10.STAFF_NATID = A11.AGENT_ID
   WHERE NOT EXISTS (SELECT 1
					FROM DP_SCORECARD.SC_EXCLUSION_YES_SV B
					WHERE A11.AGENT_ID = B.AGENT_ID
					AND TRUNC(A11.AS_DATE) = TRUNC(B.EXCLUSION_DATE)
					)
 		AND TO_CHAR(A11.AS_DATE,'YYYYMM') = TO_CHAR(ADD_MONTHS(SYSDATE, -MTH_LOOP),'YYYYMM')
   GROUP BY A10.STAFF_STAFF_ID, A11.AS_DATE
 ),
 CALL_days AS
 (
   SELECT distinct
        staff_staff_id,
        dates_month_num,
        count(short_calls)  over (partition by staff_staff_id,dates_month_num) as Days_Short_Calls_GT_10,
         count(TOT_CALLS)  over (partition by staff_staff_id,dates_month_num) as DAYS_CALLS_ANSWERED
   FROM CALL_metrics
  ),
 Adherence as
 (
	SELECT distinct
		to_char(TRUNC(a11.AS_DATE), 'YYYYMM') as dates_month_num,
		to_char(a11.AGENT_ID) AGENT_ID,
		a_s.staff_staff_id,
		sum(extract( day from NUMTODSINTERVAL (((to_date(LOGGED_IN_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*24*60*60 +
			extract( hour from NUMTODSINTERVAL (((to_date(LOGGED_IN_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60*60 +
			extract( minute from NUMTODSINTERVAL (((to_date(LOGGED_IN_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60 +
			extract( second from NUMTODSINTERVAL (((to_date(LOGGED_IN_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second')) ) ADHERENCE_TOT_LOGGED_IN_TIME,
		sum(extract( day from NUMTODSINTERVAL (((to_date(NOT_READY_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*24*60*60 +
			extract( hour from NUMTODSINTERVAL (((to_date(NOT_READY_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60*60 +
			extract( minute from NUMTODSINTERVAL (((to_date(NOT_READY_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60 +
			extract( second from NUMTODSINTERVAL (((to_date(NOT_READY_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second')) ) ADHERENCE_TOT_NOT_READY_TIME
    FROM dp_scorecard.scorecard_hierarchy_sv a_s
    join DP_SCORECARD.SC_AGENT_STAT_SV a11
		on a_s.staff_natid =  a11.AGENT_ID
    join (SELECT TRUNC(a111.LAG_DATE) as LAG_DATE, a101.staff_staff_id, a111.agent_id
          FROM DP_SCORECARD.SCORECARD_HIERARCHY_SV a101
          join DP_SCORECARD.SC_LAG_TIME_SV a111
            on a101.staff_natid = a111.agent_id
		  WHERE TO_CHAR(a111.LAG_DATE,'YYYYMM') = TO_CHAR(ADD_MONTHS(SYSDATE, -mth_loop),'YYYYMM')
          ) a12
		  on a11.agent_Id=a12.agent_Id and a11.AS_Date=a12.lag_date
    where not exists ( select 1
					from DP_SCORECARD.sc_exclusion_yes_sv b
					where a11.agent_id = b.agent_id
					and trunc(a11.as_date) = trunc(b.exclusion_date)
					)
	and TO_CHAR(a11.AS_DATE,'YYYYMM') = TO_CHAR(ADD_MONTHS(SYSDATE, -mth_loop),'YYYYMM')
    group by to_char(TRUNC(a11.AS_DATE), 'YYYYMM'), a11.AGENT_ID, a_s.staff_staff_id
 ),
Adherence_metric as
 (
   SELECT distinct
      a10.dates_month_num,
      a10.staff_staff_id,
      a10.ADHERENCE_TOT_LOGGED_IN_TIME,
      a10.ADHERENCE_TOT_NOT_READY_TIME,
      a11.LAG_TIME_TOT_SCHED_PROD_TIME,
      ((a10.ADHERENCE_TOT_LOGGED_IN_TIME
        - a10.ADHERENCE_TOT_NOT_READY_TIME)
        /a11.LAG_TIME_TOT_SCHED_PROD_TIME) as ADHERENCE
      FROM Adherence A10
      join LAG_metrics a11 on a10.staff_staff_id=a11.staff_staff_id
      and a10.dates_month_num=a11.dates_month_num
 ),
  PERMFORM_TKR as
 (
   select distinct staff_staff_id,
                  to_char(TRUNC(pt_entry_date), 'YYYYMM') as dates_month_num,
                  max(case when discussion_topic = 'Corrective Action' then 1 else 0 end )      as corrective_action_flag,
                  max(case when discussion_topic = 'One on One' then 1 else 0 end )             as one_on_one_flag,
                  max(case when discussion_topic = 'Observation' then 1 else 0 end )            as observation_flag,
                  max(case when discussion_topic = 'Recorded Call Review' then 1 else 0 end )   as Recorded_Call_Review_flag,
                  max(case when discussion_topic = 'Live Phone Observation' then 1 else 0 end ) as Live_Phone_Observation_flag
    from dp_scorecard.scorecard_perform_tracker_sv PERF
    where discussion_topic in (
                    'Corrective Action',
                    'One on One',
                    'Observation',
                    'Recorded Call Review',
                    'Live Phone Observation'
                    )
   group by staff_staff_id, to_char(TRUNC(pt_entry_date),'YYYYMM')
  ),
-- MER as
--  (
--    select distinct staff_staff_id,
--                   to_char(TRUNC(pt_entry_date), 'YYYYMM') as dates_month_num,
--    --               to_char(TRUNC(pt_entry_date), 'Month YYYY') as dates_year,
--                   1 as mer_flag
--     from dp_scorecard.scorecard_perform_tracker_sv
--    where DL_ID in (select dl_id
--                      from dp_scorecard.scorecard_discussion_lkup_sv
--                     where discussion_topic = 'MER')
--  ),
 SCORECARD_QUALITY
 AS (
 SELECT V.staff_staff_id,
       to_char(TRUNC(V.EVAL_DATE), 'YYYYMM') as dates_month_num,
       avg(V.SCORE_TOTAL) as avg_qc_score,
       sum(V.SCORE_TOTAL) as sum_qc_score,
       count(*) as count_qc_score,
       count(*) as qcs_performed,
       case
         when count(*)  >= 10 then 0
         else 10 - count(*)
       end as qcs_remaining
  from dp_scorecard.SCORECARD_QUALITY_SV V
  join dp_scorecard.scorecard_hierarchy H  --<< added 10/102017
  on v.staff_staff_id = H.staff_staff_id
  WHERE TRUNC(V.EVAL_DATE) BETWEEN H.HIRE_DATE AND NVL(TERMINATION_DATE,SYSDATE) --<< added 10/102017
  group by V.staff_staff_id ,
  to_char(TRUNC(V.EVAL_DATE), 'YYYYMM')
),
 ATTENDANCE
AS (
	select distinct a.staff_STAFF_ID,
                DATES_MONTH,
                DATES_MONTH_NUM,
                SUM(BALANCE) over(partition by a.staff_STAFF_ID, dates_month_num) as BALANCE,
                SUM(TOTAL_BALANCE) over(partition by a.staff_STAFF_ID, dates_month_num) as TOTAL_BALANCE,
                --SC_ATTENDANCE_ID,
                COUNT(HSV.staff_staff_id) over(partition by a.staff_STAFF_ID, dates_month_num) as STAFF_COUNT
	from dp_scorecard.scorecard_attendance_mthly_sv a
	join dp_scorecard.scorecard_hierarchy_sv HSV
		on a.STAFF_STAFF_ID = HSV.staff_staff_id
	where a.DATES_MONTH_NUM >= to_char(HSV.hire_date,'YYYYMM')
	AND (a.DATES_MONTH_NUM <= to_char(HSV.termination_date,'YYYYMM')
	OR HSV.TERMINATION_DATE IS NULL)
),
WEBCHAT_ACTUALS_GRP AS
(
SELECT WEBCHAT_STAFF_ID, 
    TO_CHAR(WEBCHAT_DATE,'yyyymm')  		AS DATES_MONTH_NUM, 
    SUM(NVL(ASSIGNED,0))                   	AS WEBCHAT_ASSIGNED,    
    SUM(NVL(TRANSFERRED,0))                	AS WEBCHAT_TRANSFERRED, 
    SUM(NVL(CONFERENCED,0))               	AS WEBCHAT_CONFERENCED, 
    SUM(NVL(TOTAL_NUMBER,0))               	AS WEBCHAT_TOTAL_NUMBER
FROM WEBCHAT_ACTUALS
GROUP BY WEBCHAT_STAFF_ID, TO_CHAR(WEBCHAT_DATE,'yyyymm')
),
STAFF_LOCATION AS
 (
  -- GET THE BUILDING AND DEPARTMENT IF THERE IS
  -- ONLY 1 SET OF BUILDING AND DEPARTMENT FOR THE STAFF_ID
  SELECT STAFF_STAFF_ID, SUPERVISOR_STAFF_ID, SUPERVISOR_NATID, BUILDING, DEPARTMENT
  FROM DP_SCORECARD.SCORECARD_HIERARCHY
  )
------------------------------------------------
------------------------------------------------
 SELECT
   distinct all_staff.staff_staff_id, all_staff.staff_natid,
   all_staff.staff_staff_name,
   all_staff.dates_month,
   all_staff.dates_month_num,
   all_staff.dates_year,
   NVL(TIME_metrics.EXCLUSION_FLAG,'N'),
   TIME_metrics.TOT_CALLS_ANSWERED,
   TIME_metrics.TOT_SHORT_CALLS_ANSWERED,
   TIME_metrics.TOT_TOT_RETURN_TO_QUEUE,
   TIME_metrics.TOT_RETURN_TO_QUEUE_TIMEOUT,
   TIME_metrics.TOT_AVERAGE_HANDLE_TIME,
   TIME_metrics.TOT_SCHED_PRODUCTIVE_TIME,
   TIME_metrics.TOT_ACTUAL_PRODUCTIVE_TIME,
   TIME_metrics.TOT_TALK_TIME,
   TIME_metrics.TOT_WRAP_UP_TIME,
   TIME_metrics.TOT_LOGGED_IN_TIME,
   TIME_metrics.TOT_NOT_READY_TIME,
   TIME_metrics.TOT_BREAK_TIME,
   TIME_metrics.TOT_LUNCH_TIME,
   scorecard_quality.qcs_performed,
   scorecard_quality.avg_qc_score,
   INC_metrics.TOT_INCIDENTS_COMPLETED,
   INC_metrics.DAYS_INCIDENTS_COMPLETED,
   INC_def_metrics.DAYS_DEF_INC_COMPLETED,
   DEF_metrics.TOT_DEFECTS_COMPLETED,
   DEF_metrics.DAYS_DEFECTS_COMPLETED,
   LAG_metrics.LAG_TIME_TOT_SCHED_PROD_TIME,
   CUST_metrics.TOT_CALL_RECORDS,
   CUST_metrics.TOT_CUSTOMER_COUNT,
   CUST_metrics.TOT_CALL_WRAP_UP_COUNT,
   WUE_metrics.TOT_WRAP_UP_ERROR,
   CALL_days.Days_Short_Calls_GT_10,
   CALL_days.DAYS_CALLS_ANSWERED,
   Adherence_metric.ADHERENCE,
   PERMFORM_TKR.corrective_action_flag,
   PERMFORM_TKR.one_on_one_flag,
   PERMFORM_TKR.observation_flag,
   Recorded_Call_Review_flag,
   Live_Phone_Observation_flag,
   --mer.mer_flag,
   -------------------------------------
	STAFF_LOCATION.SUPERVISOR_STAFF_ID,
	STAFF_LOCATION.SUPERVISOR_NATID,
	STAFF_LOCATION.BUILDING,
	STAFF_LOCATION.DEPARTMENT,
	------------------------------------
	-- From SC_AGENT_STAT_SV
	TIME_metrics.TOT_HANDLE_TIME,
	TIME_metrics.TOT_HANDLE_TIME_COUNT,
	TIME_metrics.TRTQ,
	TIME_metrics.CALLS_OFFERED,
	SHORT_CALL_AGENT_COUNT.SHORT_CALL_AGENT_COUNT,
	------------------------------------
	-- FROM SCORECARD_QUALITY_SV
	SCORECARD_QUALITY.SUM_QC_SCORE,
	SCORECARD_QUALITY.COUNT_QC_SCORE,
	SCORECARD_QUALITY.QCS_REMAINING,
	------------------------------------
	-- From Attendance - scorecard_attendance_mthly_sv
	ATTENDANCE.BALANCE,
	ATTENDANCE.TOTAL_BALANCE,
	ATTENDANCE.STAFF_COUNT,
    Adherence_metric.ADHERENCE_TOT_LOGGED_IN_TIME,
    Adherence_metric.ADHERENCE_TOT_NOT_READY_TIME,
	-- from WEBCHAT_ACTUALS
	WEBCHAT_ASSIGNED,    
	WEBCHAT_TRANSFERRED, 
	WEBCHAT_CONFERENCED, 
	WEBCHAT_TOTAL_NUMBER
 FROM 	(select distinct staff_staff_id, staff_natid,
			staff_staff_name,
			dates_month,
			dates_month_num,
			dates_year
         from ---DP_SCORECARD.SCORECARD_STAFF_MONTHLY_SV
			(
			SELECT SUPERVISOR_STAFF_ID, SUPERVISOR_NATID, STAFF_STAFF_ID, STAFF_NATID, DATES_MONTH_NUM, DATES_MONTH, DATES_YEAR, STAFF_STAFF_NAME
			FROM (
				WITH JUST_MONTHS AS
				(
				SELECT
					TO_CHAR(ADD_MONTHS (TRUNC (ADD_MONTHS (SYSDATE, -24), 'MM'), 1*LEVEL -1), 'MM/DD/YYYY') AS DATES,
					TO_CHAR(ADD_MONTHS (TRUNC (ADD_MONTHS (SYSDATE, -24), 'MM'), 1*LEVEL -1), 'Month') AS DATES_MONTH,
					TO_CHAR(ADD_MONTHS (TRUNC (ADD_MONTHS (SYSDATE, -24), 'MM'), 1*LEVEL -1), 'YYYYMM') AS DATES_MONTH_NUM,
					TO_CHAR(ADD_MONTHS (TRUNC (ADD_MONTHS (SYSDATE, -24), 'MM'), 1*LEVEL -1), 'Month YYYY') AS DATES_YEAR
				FROM DUAL
				CONNECT BY LEVEL <= MONTHS_BETWEEN(TRUNC(SYSDATE), TRUNC (ADD_MONTHS (SYSDATE, -24), 'MM')) + 1
				)
				SELECT --min(dates_month_num), max(dates_month_num)
					SUPERVISOR_STAFF_ID, SUPERVISOR_NATID, STAFF_STAFF_ID, STAFF_NATID, DATES_MONTH_NUM, 1  AS STAFF_COUNT,
					DATES_MONTH, DATES_YEAR, STAFF_STAFF_NAME
					FROM DP_SCORECARD.SCORECARD_HIERARCHY
					JOIN JUST_MONTHS ON JUST_MONTHS.DATES_MONTH_NUM
						BETWEEN TO_CHAR(TRUNC(HIRE_DATE,'MM'),'YYYYMM')
						AND TO_CHAR(TRUNC(NVL(TERMINATION_DATE,SYSDATE),'MM'),'YYYYMM)')
					ORDER BY 2 DESC, 1
				)
			)
         WHERE DATES_MONTH_NUM = TO_CHAR(add_months(SYSDATE,-mth_loop),'YYYYMM')
        ) all_staff
--LEFT OUTER JOIN MER on all_staff.staff_staff_id = MER.staff_staff_id   and all_staff.dates_month_num=MER.dates_month_num
LEFT OUTER JOIN STAFF_LOCATION ON all_staff.staff_staff_id = STAFF_LOCATION.STAFF_STAFF_ID
LEFT OUTER JOIN PERMFORM_TKR on all_staff.staff_staff_id = PERMFORM_TKR.staff_staff_id and all_staff.dates_month_num=PERMFORM_TKR.dates_month_num
--LEFT OUTER jOIN One_on_one on all_staff.staff_staff_id = One_on_one.staff_staff_id and all_staff.dates_month_num=One_on_one.dates_month_num
--LEFT OUTER JOIN Corr_Action on all_staff.staff_staff_id = Corr_Action.staff_staff_id and all_staff.dates_month_num=Corr_Action.dates_month_num
LEFT OUTER JOIN Adherence_metric on all_staff.staff_staff_id = Adherence_metric.staff_staff_id and all_staff.dates_month_num=Adherence_metric.dates_month_num
LEFT OUTER JOIN CALL_days on all_staff.staff_staff_id = CALL_days.staff_staff_id and all_staff.dates_month_num=CALL_days.dates_month_num
LEFT OUTER JOIN WUE_metrics on all_staff.staff_staff_id = WUE_metrics.staff_staff_id and all_staff.dates_month_num=WUE_metrics.dates_month_num
LEFT OUTER JOIN CUST_metrics on all_staff.staff_staff_id = CUST_metrics.staff_staff_id and all_staff.dates_month_num=CUST_metrics.dates_month_num
LEFT OUTER JOIN LAG_metrics on all_staff.staff_staff_id = LAG_metrics.staff_staff_id and all_staff.dates_month_num=LAG_metrics.dates_month_num
LEFT OUTER JOIN DEF_metrics on all_staff.staff_staff_id = DEF_metrics.staff_staff_id and all_staff.dates_month_num=DEF_metrics.dates_month_num
LEFT OUTER JOIN INC_metrics on all_staff.staff_staff_id = INC_metrics.staff_staff_id and all_staff.dates_month_num=INC_metrics.dates_month_num
LEFT OUTER JOIN inc_def_metrics on all_staff.staff_staff_id = INC_def_metrics.staff_staff_id and all_staff.dates_month_num=INC_def_metrics.dates_month_num
--LEFT OUTER JOIN QC_metrics on all_staff.staff_staff_id = QC_metrics.staff_staff_id and all_staff.dates_month_num=QC_metrics.dates_month_num
LEFT OUTER JOIN TIME_metrics on all_staff.staff_staff_id = TIME_metrics.staff_staff_id and all_staff.dates_month_num=TIME_metrics.dates_month_num
LEFT OUTER JOIN SCORECARD_QUALITY ON ALL_Staff.staff_staff_id = SCORECARD_QUALITY.STAFF_STAFF_ID AND all_staff.dates_month_num=SCORECARD_QUALITY.dates_month_num
LEFT OUTER JOIN ATTENDANCE on all_staff.staff_staff_id = ATTENDANCE.staff_staff_id and all_staff.dates_month_num=ATTENDANCE.dates_month_num
LEFT OUTER JOIN SHORT_CALL_AGENT_COUNT on all_staff.staff_staff_id = SHORT_CALL_AGENT_COUNT.staff_staff_id and all_staff.dates_month_num=SHORT_CALL_AGENT_COUNT.dates_month_num
LEFT OUTER JOIN WEBCHAT_ACTUALS_GRP ON all_staff.staff_staff_id = WEBCHAT_ACTUALS_GRP.WEBCHAT_STAFF_ID AND all_staff.dates_month_num = WEBCHAT_ACTUALS_GRP.DATES_MONTH_NUM
;

    COMMIT;

END LOOP;

  COMMIT;

end LOAD_SC_SUMMARY_CC;
/

SHOW ERRORS


GRANT DEBUG		ON DP_SCORECARD.LOAD_SC_SUMMARY_CC	TO MAXDAT;
GRANT EXECUTE	ON DP_SCORECARD.LOAD_SC_SUMMARY_CC	TO MAXDAT;				
GRANT EXECUTE	ON DP_SCORECARD.LOAD_SC_SUMMARY_CC	TO MAXDAT_MSTR_TRX_RPT;	
GRANT DEBUG		ON DP_SCORECARD.LOAD_SC_SUMMARY_CC	TO MAXDAT_READ_ONLY;	
GRANT EXECUTE	ON DP_SCORECARD.LOAD_SC_SUMMARY_CC	TO MAXDAT_READ_ONLY;	
GRANT EXECUTE	ON DP_SCORECARD.LOAD_SC_SUMMARY_CC	TO MAXDAT_REPORTS;		
GRANT DEBUG		ON DP_SCORECARD.LOAD_SC_SUMMARY_CC	TO MAXDAT_REPORTS;		
GRANT DEBUG		ON DP_SCORECARD.LOAD_SC_SUMMARY_CC	TO DP_SCORECARD_READ_ONLY;	
GRANT EXECUTE	ON DP_SCORECARD.LOAD_SC_SUMMARY_CC	TO DP_SCORECARD_READ_ONLY;	


