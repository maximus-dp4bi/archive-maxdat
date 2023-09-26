CREATE OR REPLACE procedure DP_SCORECARD.LOAD_SC_SUMMARY_CC
( add_mth_start number default 0,
  add_mth_stop  number default 11
 ) 
AS
-- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
 	SVN_FILE_URL varchar2(200) := '$URL$';
  	SVN_REVISION varchar2(20) := '$Revision$';
 	SVN_REVISION_DATE varchar2(60) := '$Date$';
  	SVN_REVISION_AUTHOR varchar2(20) := '$Author$';


BEGIN

	FOR MTH_LOOP IN ADD_MTH_START .. ADD_MTH_STOP
	LOOP

    
	DELETE FROM DP_SCORECARD.SC_SUMMARY_CC
	WHERE DATES_MONTH_NUM = TO_CHAR(ADD_MONTHS(SYSDATE,-MTH_LOOP),'YYYYMM');
	
    COMMIT;

   insert into SC_SUMMARY_CC (staff_staff_id, staff_natid,
   staff_staff_name,
   dates_month,
   dates_month_num,
   dates_year,
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
   qcs_performed,
   avg_qc_score,
   TOT_INCIDENTS_COMPLETED,
   DAYS_INCIDENTS_COMPLETED,
   TOT_DEFECTS_COMPLETED,
   DAYS_DEFECTS_COMPLETED,
   LAG_TIME_TOT_SCHED_PROD_TIME,
   TOT_CALL_RECORDS,
   TOT_CUSTOMER_COUNT,
   TOT_CALL_WRAP_UP_COUNT,
   TOT_WRAP_UP_ERROR,
   Days_Short_Calls_GT_10,
   DAYS_CALLS_ANSWERED,
   ADHERENCE,
   corrective_action_flag,
   one_on_one_flag,
   observation_flag,
   Recorded_Call_Review_flag,
   Live_Phone_Observation_flag,
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
  SHORT_CALL_AGENT_COUNT,
	-- FROM SCORECARD_QUALITY_SV
  SUM_QC_SCORE,
  COUNT_QC_SCORE,
  QCS_REMAINING,
	-- From Attendance - scorecard_attendance_mthly_sv
  AVG_ATTENDANCE_BALANCE,
  AVG_ATTENDANCE_TOTAL_BALANCE,
  STAFF_COUNT
   )
WITH TIME_metrics as
 (
   SELECT
      distinct
      to_char(TRUNC(a11.AS_DATE), 'YYYYMM') as dates_month_num,
--      to_char(TRUNC(a11.AS_DATE), 'Month YYYY') as dates_year,
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
--       sum(extract( day from NUMTODSINTERVAL (((to_date(LOGGED_IN_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*24*60*60 +
--         extract( hour from NUMTODSINTERVAL (((to_date(LOGGED_IN_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60*60 +
--         extract( minute from NUMTODSINTERVAL (((to_date(LOGGED_IN_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60 +
--         extract( second from NUMTODSINTERVAL (((to_date(LOGGED_IN_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second')) ) TOT_LOGGED_IN_TIME,
--       sum(extract( day from NUMTODSINTERVAL (((to_date(NOT_READY_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*24*60*60 +
--         extract( hour from NUMTODSINTERVAL (((to_date(NOT_READY_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60*60 +
--         extract( minute from NUMTODSINTERVAL (((to_date(NOT_READY_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60 +
--         extract( second from NUMTODSINTERVAL (((to_date(NOT_READY_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second')) ) TOT_NOT_READY_TIME,
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
       SUM(TOT_RET_TO_QUEUE_TOTAL) TRTQ
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
--		DATES_YEAR,
		COUNT(DISTINCT AGENT_ID) OVER (PARTITION BY STAFF_STAFF_ID, DATES_MONTH_NUM) AS SHORT_CALL_AGENT_COUNT
	FROM
	(
      SELECT
       H.STAFF_STAFF_ID,
       AGENT_ID,
       TO_CHAR(TRUNC(AS_DATE), 'YYYYMM') AS DATES_MONTH_NUM,
--       TO_CHAR(TRUNC(AS_DATE), 'MONTH YYYY') AS DATES_YEAR,
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
--       TO_CHAR(A11.EVENT_DATE, 'MONTH YYYY') AS DATES_YEAR,
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
--       A11.DATES_YEAR,
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
 --      A11.DATES_YEAR,
       SUM(A11.DEFECTS_COMPLETED) OVER (PARTITION BY A11.STAFF_ID, A11.DATES_MONTH_NUM) AS TOT_DEFECTS_COMPLETED,
       COUNT(A11.DEFECTS_COMPLETED) OVER (PARTITION BY A11.STAFF_ID, A11.DATES_MONTH_NUM) AS  DAYS_DEFECTS_COMPLETED
   FROM  INCDEFS A11
   WHERE  A11.DEFECTS_COMPLETED <> 0
 ) ,
 LAG_METRICS AS (
   SELECT
       DISTINCT TO_CHAR(TRUNC(A11.LAG_DATE), 'YYYYMM') AS DATES_MONTH_NUM,
--       TO_CHAR(TRUNC(A11.LAG_DATE), 'MONTH YYYY') AS DATES_YEAR,
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
 --      TO_CHAR(TRUNC(A11.CALL_DATE), 'MONTH YYYY') AS DATES_YEAR,
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
 --      to_char(TRUNC(a11.WUE_DATE), 'Month YYYY') as dates_year,
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
	--  NVL(A11.EXCLUSION_FLAG,'N')     AS EXCLUSION_FLAG,
        CASE WHEN SUM(A11.SHORT_CALLS_ANSWERED) > 10 THEN 1 ELSE NULL END SHORT_CALLS,
        SUM(A11.CALLS_ANSWERED) TOT_CALLS,
       TO_CHAR(TRUNC(A11.AS_DATE), 'YYYYMM') AS DATES_MONTH_NUM
	--  to_char(TRUNC(a11.AS_DATE), 'Month YYYY') as dates_year
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
        --dates_year,
        --NVL(EXCLUSION_FLAG,'N')         AS EXCLUSION_FLAG,
        count(short_calls)  over (partition by staff_staff_id,dates_month_num) as Days_Short_Calls_GT_10,
         count(TOT_CALLS)  over (partition by staff_staff_id,dates_month_num) as DAYS_CALLS_ANSWERED
   FROM CALL_metrics
  ),
 Adherence as
 (
	SELECT distinct
		to_char(TRUNC(a11.AS_DATE), 'YYYYMM') as dates_month_num,
--		to_char(TRUNC(a11.AS_DATE), 'Month YYYY') as dates_year,
		to_char(a11.AGENT_ID) AGENT_ID,
		a_s.staff_staff_id,
		sum(extract( day from NUMTODSINTERVAL (((to_date(LOGGED_IN_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*24*60*60 +
			extract( hour from NUMTODSINTERVAL (((to_date(LOGGED_IN_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60*60 +
			extract( minute from NUMTODSINTERVAL (((to_date(LOGGED_IN_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60 +
			extract( second from NUMTODSINTERVAL (((to_date(LOGGED_IN_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second')) ) TOT_LOGGED_IN_TIME,
		sum(extract( day from NUMTODSINTERVAL (((to_date(NOT_READY_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*24*60*60 +
			extract( hour from NUMTODSINTERVAL (((to_date(NOT_READY_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60*60 +
			extract( minute from NUMTODSINTERVAL (((to_date(NOT_READY_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60 +
			extract( second from NUMTODSINTERVAL (((to_date(NOT_READY_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second')) ) TOT_NOT_READY_TIME
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
--      a10.dates_year,
      a10.staff_staff_id,
      a10.TOT_LOGGED_IN_TIME, a10.TOT_NOT_READY_TIME, a11.LAG_TIME_TOT_SCHED_PROD_TIME, 
      ((a10.TOT_LOGGED_IN_TIME - a10.TOT_NOT_READY_TIME)/a11.LAG_TIME_TOT_SCHED_PROD_TIME) as ADHERENCE
      FROM Adherence A10
      join LAG_metrics a11 on a10.staff_staff_id=a11.staff_staff_id 
      and a10.dates_month_num=a11.dates_month_num
 ),
  PERMFORM_TKR as
 (
   select distinct staff_staff_id,
                  to_char(TRUNC(pt_entry_date), 'YYYYMM') as dates_month_num,
   --               to_char(TRUNC(pt_entry_date), 'Month YYYY') as dates_year,
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
 --      to_char(TRUNC(V.EVAL_DATE), 'Month YYYY') as dates_year,
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
--                DATES_YEAR,
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
   Adherence_metric.TOT_LOGGED_IN_TIME,
   Adherence_metric.TOT_NOT_READY_TIME,
   TIME_metrics.TOT_BREAK_TIME,
   TIME_metrics.TOT_LUNCH_TIME,
   scorecard_quality.qcs_performed,
   scorecard_quality.avg_qc_score,
   INC_metrics.TOT_INCIDENTS_COMPLETED,
   INC_metrics.DAYS_INCIDENTS_COMPLETED,
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
	ATTENDANCE.STAFF_COUNT
 FROM (select distinct staff_staff_id, staff_natid,
         staff_staff_name,
         dates_month,
         dates_month_num,
         dates_year
         from DP_SCORECARD.SCORECARD_STAFF_MONTHLY_SV
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
--LEFT OUTER JOIN QC_metrics on all_staff.staff_staff_id = QC_metrics.staff_staff_id and all_staff.dates_month_num=QC_metrics.dates_month_num
LEFT OUTER JOIN TIME_metrics on all_staff.staff_staff_id = TIME_metrics.staff_staff_id and all_staff.dates_month_num=TIME_metrics.dates_month_num
LEFT OUTER JOIN SCORECARD_QUALITY ON ALL_Staff.staff_staff_id = SCORECARD_QUALITY.STAFF_STAFF_ID AND all_staff.dates_month_num=SCORECARD_QUALITY.dates_month_num
LEFT OUTER JOIN ATTENDANCE on all_staff.staff_staff_id = ATTENDANCE.staff_staff_id and all_staff.dates_month_num=ATTENDANCE.dates_month_num
LEFT OUTER JOIN SHORT_CALL_AGENT_COUNT on all_staff.staff_staff_id = SHORT_CALL_AGENT_COUNT.staff_staff_id and all_staff.dates_month_num=SHORT_CALL_AGENT_COUNT.dates_month_num
;

    COMMIT;

END LOOP;
  
  COMMIT;

end LOAD_SC_SUMMARY_CC;
/

SHOW ERRORS

GRANT EXECUTE ON DP_SCORECARD.LOAD_SC_SUMMARY_CC TO MAXDAT;

GRANT EXECUTE ON DP_SCORECARD.LOAD_SC_SUMMARY_CC TO MAXDAT_READ_ONLY;

GRANT DEBUG ON DP_SCORECARD.LOAD_SC_SUMMARY_CC TO MAXDAT_READ_ONLY;

GRANT EXECUTE ON DP_SCORECARD.LOAD_SC_SUMMARY_CC TO DP_SCORECARD_READ_ONLY;


CREATE OR REPLACE PROCEDURE DP_SCORECARD.LOAD_SC_SUMMARY_CC_ROLLUP
( add_mth_start number default 0,
  add_mth_stop  number default 11
 )
AS
-- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
 	SVN_FILE_URL varchar2(200) := '$URL$';
  	SVN_REVISION varchar2(20) := '$Revision$';
 	SVN_REVISION_DATE varchar2(60) := '$Date$';
  	SVN_REVISION_AUTHOR varchar2(20) := '$Author$';


    lv_date_month_num   varchar2(6)  := '199901';

begin

	For mth_loop in ADD_MTH_START .. ADD_MTH_STOP
	LOOP

--  execute immediate 'TRUNCATE TABLE DP_SCORECARD.SC_SUMMARY_CC_ROLLUP';

    lv_date_month_num := to_char(add_months(sysdate,-mth_loop),'YYYYMM');

	Delete from DP_SCORECARD.SC_SUMMARY_CC_ROLLUP
	where dates_month_num = lv_date_month_num;

    commit;

INSERT INTO DP_SCORECARD.SC_SUMMARY_CC_ROLLUP
	( SUPERVISOR_STAFF_ID, DATES_MONTH, DATES_MONTH_NUM,
	DATES_YEAR, EXCLUSION_FLAG,
   	BUILDING,
	DEPARTMENT,
	TOT_CALLS_ANSWERED,
   TOT_SHORT_CALLS_ANSWERED, TOT_TOT_RETURN_TO_QUEUE, TOT_AVERAGE_HANDLE_TIME,
   TOT_SCHED_PRODUCTIVE_TIME, TOT_ACTUAL_PRODUCTIVE_TIME, TOT_TALK_TIME,
   TOT_WRAP_UP_TIME, TOT_LOGGED_IN_TIME, TOT_NOT_READY_TIME,
   TOT_BREAK_TIME, TOT_LUNCH_TIME, QCS_PERFORMED,
   AVG_QC_SCORE, TOT_INCIDENTS_COMPLETED, DAYS_INCIDENTS_COMPLETED,
   TOT_DEFECTS_COMPLETED, DAYS_DEFECTS_COMPLETED, LAG_TIME_TOT_SCHED_PROD_TIME,
   TOT_CALL_RECORDS, TOT_CUSTOMER_COUNT, TOT_CALL_WRAP_UP_COUNT,
   TOT_WRAP_UP_ERROR, DAYS_SHORT_CALLS_GT_10, DAYS_CALLS_ANSWERED,
   ADHERENCE, TOT_RETURN_TO_QUEUE_TIMEOUT, AVG_ATTENDANCE_BALANCE,
   AVG_ATTENDANCE_TOTAL_BALANCE, STAFF_COUNT, SUM_QC_SCORE,
   COUNT_QC_SCORE, QCS_REMAINING, TOT_HANDLE_TIME,
   TOT_HANDLE_TIME_COUNT, STAFF_TRTQ_COUNT, SHORT_CALL_AGENT_COUNT
   )
-----
WITH CC_SUMMARY AS
(SELECT
	SUPERVISOR_STAFF_ID,
	DATES_MONTH,
	DATES_MONTH_NUM,
	DATES_YEAR,
	EXCLUSION_FLAG,
	BUILDING,
	DEPARTMENT,
	SUM(NVL(TOT_CALLS_ANSWERED,0)) 							AS 	TOT_CALLS_ANSWERED,
	SUM(NVL(TOT_SHORT_CALLS_ANSWERED,0)) 					AS 	TOT_SHORT_CALLS_ANSWERED,
	SUM(NVL(TOT_TOT_RETURN_TO_QUEUE,0)) 					AS 	TOT_TOT_RETURN_TO_QUEUE,
	SUM(NVL(TOT_AVERAGE_HANDLE_TIME,0)) 					AS 	TOT_AVERAGE_HANDLE_TIME,
	SUM(NVL(TOT_SCHED_PRODUCTIVE_TIME,0)) 					AS 	TOT_SCHED_PRODUCTIVE_TIME,
	SUM(NVL(TOT_ACTUAL_PRODUCTIVE_TIME,0)) 					AS 	TOT_ACTUAL_PRODUCTIVE_TIME,
	SUM(NVL(TOT_TALK_TIME,0)) 								AS 	TOT_TALK_TIME,
	SUM(NVL(TOT_WRAP_UP_TIME,0)) 							AS 	TOT_WRAP_UP_TIME,
	SUM(NVL(TOT_LOGGED_IN_TIME,0)) 							AS 	TOT_LOGGED_IN_TIME,
	SUM(NVL(TOT_NOT_READY_TIME,0)) 							AS 	TOT_NOT_READY_TIME,
	SUM(NVL(TOT_BREAK_TIME,0)) 								AS 	TOT_BREAK_TIME,
	SUM(NVL(TOT_LUNCH_TIME,0)) 								AS 	TOT_LUNCH_TIME,
	SUM(NVL(QCS_PERFORMED,0)) 								AS 	QCS_PERFORMED,
	CASE WHEN SUM(NVL(QCS_PERFORMED,0)) <> 0
		THEN
			ROUND(SUM(NVL(AVG_QC_SCORE,0))/SUM(NVL(QCS_PERFORMED,0)),0)
		ELSE 0 END 											AS 	AVG_QC_SCORE,
	SUM(NVL(TOT_INCIDENTS_COMPLETED,0)) 					AS 	TOT_INCIDENTS_COMPLETED,
	SUM(NVL(DAYS_INCIDENTS_COMPLETED,0)) 					AS 	DAYS_INCIDENTS_COMPLETED,
	SUM(NVL(TOT_DEFECTS_COMPLETED,0)) 						AS 	TOT_DEFECTS_COMPLETED,
	SUM(NVL(DAYS_DEFECTS_COMPLETED,0)) 						AS 	DAYS_DEFECTS_COMPLETED,  --
	SUM(NVL(LAG_TIME_TOT_SCHED_PROD_TIME,0))				AS 	LAG_TIME_TOT_SCHED_PROD_TIME,
	SUM(NVL(TOT_CALL_RECORDS,0)) 							AS 	TOT_CALL_RECORDS,
	SUM(NVL(TOT_CUSTOMER_COUNT,0)) 							AS 	TOT_CUSTOMER_COUNT,
	SUM(NVL(TOT_CALL_WRAP_UP_COUNT,0)) 						AS 	TOT_CALL_WRAP_UP_COUNT,
	SUM(NVL(TOT_WRAP_UP_ERROR,0)) 							AS 	TOT_WRAP_UP_ERROR,
	SUM(NVL(DAYS_SHORT_CALLS_GT_10,0)) 						AS 	DAYS_SHORT_CALLS_GT_10,
	SUM(NVL(DAYS_CALLS_ANSWERED,0)) 						AS 	DAYS_CALLS_ANSWERED,   --- ?????
    SUM(TOT_LOGGED_IN_TIME - TOT_NOT_READY_TIME)/SUM(LAG_TIME_TOT_SCHED_PROD_TIME)          AS ADHERENCE,
    SUM(NVL(TOT_RETURN_TO_QUEUE_TIMEOUT,0)) 				AS 	TOT_RETURN_TO_QUEUE_TIMEOUT,
	SUM(NVL(AVG_ATTENDANCE_BALANCE,0)) 						AS 	AVG_ATTENDANCE_BALANCE,
	SUM(NVL(AVG_ATTENDANCE_TOTAL_BALANCE,0))				AS 	AVG_ATTENDANCE_TOTAL_BALANCE,
	SUM(NVL(STAFF_COUNT,0)) 								AS 	STAFF_COUNT,
	SUM(NVL(SUM_QC_SCORE,0)) 								AS 	SUM_QC_SCORE,
	SUM(NVL(COUNT_QC_SCORE,0)) 								AS 	COUNT_QC_SCORE,
	SUM(nvl(qcs_remaining,0)) 								AS 	QCS_REMAINING,
	SUM(NVL(TOT_HANDLE_TIME,0)) 							AS 	TOT_HANDLE_TIME,
	SUM(NVL(TOT_HANDLE_TIME_COUNT,0)) 						AS 	TOT_HANDLE_TIME_COUNT,
	SUM( CASE WHEN TOT_TOT_RETURN_TO_QUEUE > 50 THEN 1 ELSE 0 END ) AS STAFF_TRTQ_COUNT,
	SUM(NVL(SHORT_CALL_AGENT_COUNT,0))						AS 	SHORT_CALL_AGENT_COUNT
FROM DP_SCORECARD.SC_SUMMARY_CC
where DATES_MONTH_NUM = lv_date_month_num
GROUP BY
	SUPERVISOR_STAFF_ID,
	DATES_MONTH,
	DATES_MONTH_NUM,
	DATES_YEAR,
	EXCLUSION_FLAG,
	BUILDING,
	DEPARTMENT
),
INCDEFS AS
 (
   SELECT a11.supervisor_staff_id, building, department,
   trunc(a11.event_date) task_DATE,
       to_char(TRUNC(a11.event_date), 'YYYYMM') as dates_month_num,
       to_char(TRUNC(a11.event_date), 'Month YYYY') as dates_year,
        count((Case when a11.EVENT_ID in (1374, 1375, 1376, 1377, 1378, 1379) then 1 else null end)) INCIDENTS_COMPLETED,
        count((Case when a11.EVENT_ID in (1373) then 1 else null end)) DEFECTS_COMPLETED
   FROM DP_SCORECARD.PP_WFM_DAILY_SUMMARY_WRK a11
   WHERE 1=1
   AND TO_CHAR(EVENT_DATE,'yyyymm') = lv_date_month_num
  and (a11.EVENT_ID in (1374, 1375, 1376, 1377, 1378, 1379)
         or a11.EVENT_ID in (1373))
   group by a11.supervisor_staff_id, a11.staff_id, trunc(event_date), building, department
 ),
 INC_metrics AS
 (
 select
   distinct  a11.supervisor_staff_id, building, department,
          a11.dates_month_num,
--       a11.dates_year,
       count(distinct a11.task_date) DAYS_incidents_COMPLETED
   from  INCDEFS a11
   where  a11.INCIDENTS_COMPLETED <> 0
   group by a11.supervisor_staff_id, a11.dates_month_num, building, department
 ),
 DEF_metrics AS
 (
 select
   distinct  a11.supervisor_staff_id, building, department,
       a11.dates_month_num,
--      a11.dates_year,
       count(distinct a11.task_date) as DAYS_DEFECTS_COMPLETED
   from  INCDEFS a11
   where  a11.DEFECTS_COMPLETED <> 0
   group by a11.supervisor_staff_id, a11.dates_month_num, building, department
 ),
CALL_DAYS AS
(
SELECT SUPERVISOR_STAFF_ID, BUILDING, DEPARTMENT,
    TO_CHAR(AS_DATE,'YYYYMM') AS DATES_MONTH_NUM,
    COUNT(DISTINCT AS_DATE) AS DAYS_CALLS_ANSWERED,
    SUM(DAYS_SHORT_CALLS_GT_10) AS DAYS_SHORT_CALLS_GT_10
 FROM   (
        SELECT
            H.SUPERVISOR_STAFF_ID,
            H.STAFF_STAFF_ID, H.BUILDING, H.DEPARTMENT,
            TRUNC(STAT.AS_DATE)  AS_DATE,
            CASE WHEN SUM(STAT.SHORT_CALLS_ANSWERED) > 10 THEN 1 ELSE NULL END AS DAYS_SHORT_CALLS_GT_10
        FROM DP_SCORECARD.SCORECARD_HIERARCHY_SV H
        JOIN DP_SCORECARD.SC_AGENT_STAT_SV STAT
            ON H.STAFF_NATID = STAT.AGENT_ID
        WHERE 1=1
        AND TO_CHAR(STAT.AS_DATE,'YYYYMM') = TO_CHAR(ADD_MONTHS(SYSDATE, -mth_loop),'YYYYMM')
        AND TRUNC(STAT.AS_DATE) BETWEEN TRUNC(H.HIRE_DATE) AND TRUNC(NVL(H.TERMINATION_DATE,SYSDATE))
        GROUP BY H.SUPERVISOR_STAFF_ID, H.STAFF_STAFF_ID, H.BUIlding, h.department, TRUNC(STAT.AS_DATE)
        )
GROUP BY SUPERVISOR_STAFF_ID, building, department, TO_CHAR(AS_DATE,'YYYYMM')
)
---------------
SELECT
	CC_SUMMARY.SUPERVISOR_STAFF_ID,
	CC_SUMMARY.DATES_MONTH,
	CC_SUMMARY.DATES_MONTH_NUM,
	CC_SUMMARY.DATES_YEAR,
	CC_SUMMARY.EXCLUSION_FLAG,
	CC_SUMMARY.BUILDING,
	CC_SUMMARY.DEPARTMENT,
	CC_SUMMARY.TOT_CALLS_ANSWERED,
	CC_SUMMARY.TOT_SHORT_CALLS_ANSWERED,
	CC_SUMMARY.TOT_TOT_RETURN_TO_QUEUE,
	CC_SUMMARY.TOT_AVERAGE_HANDLE_TIME,
	CC_SUMMARY.TOT_SCHED_PRODUCTIVE_TIME,
	CC_SUMMARY.TOT_ACTUAL_PRODUCTIVE_TIME,
	CC_SUMMARY.TOT_TALK_TIME,
	CC_SUMMARY.TOT_WRAP_UP_TIME,
	CC_SUMMARY.TOT_LOGGED_IN_TIME,
	CC_SUMMARY.TOT_NOT_READY_TIME,
	CC_SUMMARY.TOT_BREAK_TIME,
	CC_SUMMARY.TOT_LUNCH_TIME,
	CC_SUMMARY.QCS_PERFORMED,
	CC_SUMMARY.AVG_QC_SCORE,
	CC_SUMMARY.TOT_INCIDENTS_COMPLETED,
	INC_METRICS.DAYS_INCIDENTS_COMPLETED,
	CC_SUMMARY.TOT_DEFECTS_COMPLETED,
	DEF_METRICS.DAYS_DEFECTS_COMPLETED,
	CC_SUMMARY.LAG_TIME_TOT_SCHED_PROD_TIME,
	CC_SUMMARY.TOT_CALL_RECORDS,
	CC_SUMMARY.TOT_CUSTOMER_COUNT,
	CC_SUMMARY.TOT_CALL_WRAP_UP_COUNT,
	CC_SUMMARY.TOT_WRAP_UP_ERROR,
--	CC_SUMMARY.DAYS_SHORT_CALLS_GT_10,
    CALL_DAYS.DAYS_SHORT_CALLS_GT_10,
--  CC_SUMMARY.DAYS_CALLS_ANSWERED,
    CALL_DAYS.DAYS_CALLS_ANSWERED,
    CC_SUMMARY.ADHERENCE,
    CC_SUMMARY.TOT_RETURN_TO_QUEUE_TIMEOUT,
	CC_SUMMARY.AVG_ATTENDANCE_BALANCE,
	CC_SUMMARY.AVG_ATTENDANCE_TOTAL_BALANCE,
	CC_SUMMARY.STAFF_COUNT,
	CC_SUMMARY.SUM_QC_SCORE,
	CC_SUMMARY.COUNT_QC_SCORE,
	CC_SUMMARY.QCS_REMAINING,
	CC_SUMMARY.TOT_HANDLE_TIME,
	CC_SUMMARY.TOT_HANDLE_TIME_COUNT,
	CC_SUMMARY.STAFF_TRTQ_COUNT ,
	CC_SUMMARY.SHORT_CALL_AGENT_COUNT
FROM CC_SUMMARY
LEFT OUTER JOIN INC_METRICS ON INC_METRICS.SUPERVISOR_STAFF_ID = CC_SUMMARY.SUPERVISOR_STAFF_ID
    AND INC_METRICS.DATES_MONTH_NUM = CC_SUMMARY.DATES_MONTH_NUM
    AND INC_METRICS.BUILDING = CC_SUMMARY.BUILDING
    AND INC_METRICS.DEPARTMENT = CC_SUMMARY.DEPARTMENT
LEFT OUTER JOIN DEF_METRICS ON DEF_METRICS.SUPERVISOR_STAFF_ID = CC_SUMMARY.SUPERVISOR_STAFF_ID
    AND DEF_METRICS.DATES_MONTH_NUM = CC_SUMMARY.DATES_MONTH_NUM
    AND DEF_METRICS.BUILDING = CC_SUMMARY.BUILDING
    AND DEF_METRICS.DEPARTMENT = CC_SUMMARY.DEPARTMENT
LEFT OUTER JOIN CALL_DAYS ON CALL_DAYS.SUPERVISOR_STAFF_ID = CC_SUMMARY.SUPERVISOR_STAFF_ID
    AND CALL_DAYS.DATES_MONTH_NUM = CC_SUMMARY.DATES_MONTH_NUM
    AND CALL_DAYS.BUILDING = CC_SUMMARY.BUILDING
    AND CALL_DAYS.DEPARTMENT = CC_SUMMARY.DEPARTMENT;

    COMMIT;
    
--- Add a "Total" row for each supervisor that has staff in Multiple Buildings and Departments    

END LOOP;  -- end for loop

    COMMIT;

END LOAD_SC_SUMMARY_CC_ROLLUP;
/

SHOW ERRORS

GRANT EXECUTE ON DP_SCORECARD.LOAD_SC_SUMMARY_CC_ROLLUP TO MAXDAT;

GRANT EXECUTE ON DP_SCORECARD.LOAD_SC_SUMMARY_CC_ROLLUP TO MAXDAT_READ_ONLY;

GRANT DEBUG ON DP_SCORECARD.LOAD_SC_SUMMARY_CC_ROLLUP TO MAXDAT_READ_ONLY;

GRANT EXECUTE ON DP_SCORECARD.LOAD_SC_SUMMARY_CC_ROLLUP TO DP_SCORECARD_READ_ONLY;

GRANT DEBUG ON DP_SCORECARD.LOAD_SC_SUMMARY_CC_ROLLUP TO DP_SCORECARD_READ_ONLY;

