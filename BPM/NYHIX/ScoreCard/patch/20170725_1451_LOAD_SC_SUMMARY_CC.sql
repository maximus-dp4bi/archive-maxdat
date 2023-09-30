CREATE OR REPLACE procedure DP_SCORECARD.LOAD_SC_SUMMARY_CC
AS
-- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
 	SVN_FILE_URL varchar2(200) := '$URL: svn://rcmxapp1d.maximus.com/maxdat/BPM/NYHIX/patch/20170623_PP_WFM_BACK_OFFICE_LOAD_PKG.sql $'; 
  	SVN_REVISION varchar2(20) := '$Revision: 20489 $'; 
 	SVN_REVISION_DATE varchar2(60) := '$Date: 2017-07-03 14:31:06 -0500 (Mon, 03 Jul 2017) $'; 
  	SVN_REVISION_AUTHOR varchar2(20) := '$Author: wl134672 $';


begin

  execute immediate 'truncate table DP_SCORECARD.SC_SUMMARY_CC';
    --Delete from SC_SUMMARY_CC;
    --commit;
   
   insert into SC_SUMMARY_CC (staff_staff_id,
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
      to_char(TRUNC(a11.AS_DATE), 'Month YYYY') as dates_year,
      to_char(AGENT_ID) AGENT_ID,
      a_s.staff_staff_id,
       NVL(EXCLUSION_FLAG,'N') AS EXCLUSION_FLAG,
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
		case when sum(SHORT_CALLS_ANSWERED) > 10 then 1 else 0 end as SHORT_CALL_AGENT_COUNT
		 --------------------------
         FROM dp_scorecard.scorecard_hierarchy_sv a_s
        join DP_SCORECARD.SC_AGENT_STAT_SV a11 on a_s.staff_natid =  a11.AGENT_ID
        where not exists (select 1 from dp_scorecard.sc_exclusion_yes_sv b where a11.agent_id = b.agent_id and a11.as_date = b.exclusion_date)
        and TRUNC(a11.AS_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
    group by to_char(TRUNC(a11.AS_DATE), 'YYYYMM'), to_char(TRUNC(a11.AS_DATE), 'Month YYYY'),a_s.staff_staff_id, AGENT_ID, NVL(EXCLUSION_FLAG,'N')
 ),
 QC_metrics AS
 (
 select staff_staff_id,
           staff_staff_name,
           staff_natid,
           dates_month_num,
           dates_year,
           avg_qc_score,
           qcs_performed
      from dp_scorecard.scorecard_quality_mthly_sv
 ),
 INCDEFS AS
 (
   SELECT a11.STAFF_ID,
--   trunc(a11.TASK_START) AS_DATE,
    a11.event_date AS_DATE,
--       to_char(TRUNC(a11.TASK_START), 'YYYYMM') as dates_month_num,
       to_char(a11.event_date, 'YYYYMM') as dates_month_num,
--       to_char(TRUNC(a11.TASK_START), 'Month YYYY') as dates_year,
       to_char(a11.event_date, 'Month YYYY') as dates_year,
	--   a11.Department,
	--   a11.Building,
        sum((Case when a11.EVENT_ID in (1374, 1375, 1376, 1377, 1378, 1379) then total_logged else 0 end)) INCIDENTS_COMPLETED,
        sum((Case when a11.EVENT_ID in (1373) then total_logged else 0 end)) DEFECTS_COMPLETED
--   FROM DP_SCORECARD.SCORECARD_HIERARCHY_SV a10
   FROM DP_SCORECARD.PP_WFM_DAILY_SUMMARY_WRK a11
--  join MAXDAT.PP_WFM_ACTUALS_SV a11 on a10.staff_staff_id=a11.staff_id
--  
   WHERE 1=1
   --and not exists (select 1 from dp_scorecard.sc_exclusion_yes_sv b where a11.staff_id = b.staff_id and trunc(a11.task_start) = trunc(b.exclusion_date))
--        and TRUNC(a11.task_start) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
        and event_date >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
  and (a11.EVENT_ID in (1374, 1375, 1376, 1377, 1378, 1379)
         or a11.EVENT_ID in (1373))
    --     and a11.TASK_END is not null and trunc(a11.TASK_START)=trunc(a11.TASK_END)
--   group by a11.staff_id, trunc(TASK_START)
   group by a11.staff_id, event_date --, BUILDING, DEPARTMENT
 ),
 INC_metrics AS
 (
 select
   distinct  a11.staff_id as staff_staff_id,
       a11.dates_month_num,
       a11.dates_year,
        sum(a11.INCIDENTS_COMPLETED) OVER (PARTITION BY a11.staff_id, a11.dates_month_num) as TOT_INCIDENTS_COMPLETED,
        count(a11.INCIDENTS_COMPLETED) OVER (PARTITION BY a11.staff_id, a11.dates_month_num) as DAYS_INCIDENTS_COMPLETED
   from  INCDEFS a11
   where  a11.INCIDENTS_COMPLETED <> 0
 ),
 DEF_metrics AS
 (
 select   
   distinct  a11.staff_id as staff_staff_id,
       a11.dates_month_num,
       a11.dates_year,
       sum(a11.DEFECTS_COMPLETED) OVER (PARTITION BY a11.staff_id, a11.dates_month_num) as TOT_DEFECTS_COMPLETED,
       count(a11.DEFECTS_COMPLETED) OVER (PARTITION BY a11.staff_id, a11.dates_month_num) as  DAYS_DEFECTS_COMPLETED
   from  INCDEFS a11
   where  a11.DEFECTS_COMPLETED <> 0
 ) ,
 LAG_metrics AS (
   SELECT
       distinct to_char(TRUNC(a11.LAG_DATE), 'YYYYMM') as dates_month_num,
       to_char(TRUNC(a11.LAG_DATE), 'Month YYYY') as dates_year,
        a10.staff_staff_id,
        sum(extract( day from NUMTODSINTERVAL (((to_date(TOT_SCHED_PRODUCTIVE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*24*60*60 +
         extract( hour from NUMTODSINTERVAL (((to_date(TOT_SCHED_PRODUCTIVE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60*60 +
         extract( minute from NUMTODSINTERVAL (((to_date(TOT_SCHED_PRODUCTIVE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60 +
         extract( second from NUMTODSINTERVAL (((to_date(TOT_SCHED_PRODUCTIVE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second')) )
        over (partition by a10.staff_staff_id, to_char(TRUNC(a11.LAG_DATE), 'YYYYMM')) as LAG_TIME_TOT_SCHED_PROD_TIME
       FROM DP_SCORECARD.SCORECARD_HIERARCHY_SV a10
  join DP_SCORECARD.SC_LAG_TIME_SV a11 on a10.staff_natid = a11.agent_id
  join (select trunc(as_date) as as_date, agent_id from DP_SCORECARD.SC_AGENT_STAT_SV
        where TRUNC(AS_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')) a12
        on  a12.agent_id=a10.staff_natid and a12.as_date= TRUNC(a11.LAG_DATE)
  WHERE not exists (select 1 from DP_SCORECARD.sc_exclusion_yes_sv b where a11.agent_id = b.agent_id and trunc(a11.LAG_DATE) = trunc(b.exclusion_date))
        and TRUNC(a11.LAG_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
 ),
 CUST_metrics AS
 (
    SELECT distinct
      to_char(TRUNC(a11.CALL_DATE), 'YYYYMM') as dates_month_num,
       to_char(TRUNC(a11.CALL_DATE), 'Month YYYY') as dates_year,
        a10.staff_staff_id,
       count(CALL_RECORD_ID) over (partition by a10.staff_staff_id,to_char(TRUNC(a11.CALL_DATE), 'Month YYYY')) as  TOT_CALL_RECORDS,
       sum(CUSTOMER_COUNT) over (partition by a10.staff_staff_id,to_char(TRUNC(a11.CALL_DATE), 'Month YYYY')) as TOT_CUSTOMER_COUNT,
       sum(CALL_WRAP_UP_COUNT) over (partition by a10.staff_staff_id,to_char(TRUNC(a11.CALL_DATE), 'Month YYYY')) as TOT_CALL_WRAP_UP_COUNT
    FROM DP_SCORECARD.SCORECARD_HIERARCHY_SV a10
  join DP_SCORECARD.SC_NON_STD_USE_SV a11 on to_char(a10.staff_natid) = a11.Employee_ID
  WHERE not exists (select 1 from DP_SCORECARD.sc_exclusion_yes_sv b where a11.Employee_ID = b.agent_id and trunc(a11.CALL_DATE) = trunc(b.exclusion_date))
        and TRUNC(a11.CALL_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
 ),
 WUE_metrics AS
 (
   SELECT distinct
       to_char(TRUNC(a11.WUE_DATE), 'YYYYMM') as dates_month_num,
       to_char(TRUNC(a11.WUE_DATE), 'Month YYYY') as dates_year,
        a10.staff_staff_id,
        sum(a11.WRAP_UP_ERROR) over (partition by a10.staff_staff_id,to_char(TRUNC(a11.WUE_DATE), 'Month YYYY')) as TOT_WRAP_UP_ERROR
   FROM DP_SCORECARD.SCORECARD_HIERARCHY_SV a10
  join DP_SCORECARD.SC_WRAP_UP_ERROR_SV a11 on a10.staff_natid = a11.AGENT_ID
  WHERE not exists (select 1 from DP_SCORECARD.sc_exclusion_yes_sv b where a11.agent_id = b.agent_id and trunc(a11.WUE_DATE) = trunc(b.exclusion_date))
        and TRUNC(a11.WUE_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
 ),
 CALL_metrics AS
 (                    
  SELECT
        a10.staff_staff_id,
       a11.AS_DATE,
        NVL(a11.EXCLUSION_FLAG,'N')     AS EXCLUSION_FLAG,
        CASE WHEN sum(a11.SHORT_CALLS_ANSWERED) > 10 THEN 1 ELSE null END short_calls,
        sum(a11.CALLS_ANSWERED) TOT_CALLS,
       to_char(TRUNC(a11.AS_DATE), 'YYYYMM') as dates_month_num,
       to_char(TRUNC(a11.AS_DATE), 'Month YYYY') as dates_year
   FROM DP_SCORECARD.SCORECARD_HIERARCHY_SV a10
  join DP_SCORECARD.SC_AGENT_STAT_SV a11 on a10.staff_natid = a11.AGENT_ID
  WHERE not exists (select 1 from DP_SCORECARD.sc_exclusion_yes_sv b where a11.agent_id = b.agent_id and trunc(a11.as_date) = trunc(b.exclusion_date))
        and TRUNC(a11.AS_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
   GROUP BY a10.staff_staff_id, a11.AS_DATE, NVL(a11.EXCLUSION_FLAG,'N')
 ),
 CALL_days AS
 (
   SELECT distinct
        staff_staff_id,
        dates_month_num,
        dates_year,
        NVL(EXCLUSION_FLAG,'N')         AS EXCLUSION_FLAG,
        count(short_calls)  over (partition by staff_staff_id,dates_month_num, NVL(EXCLUSION_FLAG,'N')) as Days_Short_Calls_GT_10,
         count(TOT_CALLS)  over (partition by staff_staff_id,dates_month_num, NVL(EXCLUSION_FLAG,'N')) as DAYS_CALLS_ANSWERED
   FROM CALL_metrics
  ),
 Adherence as
 (
   SELECT distinct
      to_char(TRUNC(a11.AS_DATE), 'YYYYMM') as dates_month_num,
      to_char(TRUNC(a11.AS_DATE), 'Month YYYY') as dates_year,
      to_char(a11.AGENT_ID) AGENT_ID,
      a_s.staff_staff_id,
       NVL(a11.EXCLUSION_FLAG,'N')   AS EXCLUSION_FLAG,
       sum(extract( day from NUMTODSINTERVAL (((to_date(LOGGED_IN_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*24*60*60 +
         extract( hour from NUMTODSINTERVAL (((to_date(LOGGED_IN_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60*60 +
         extract( minute from NUMTODSINTERVAL (((to_date(LOGGED_IN_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60 +
         extract( second from NUMTODSINTERVAL (((to_date(LOGGED_IN_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second')) ) TOT_LOGGED_IN_TIME,
       sum(extract( day from NUMTODSINTERVAL (((to_date(NOT_READY_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*24*60*60 +
         extract( hour from NUMTODSINTERVAL (((to_date(NOT_READY_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60*60 +
         extract( minute from NUMTODSINTERVAL (((to_date(NOT_READY_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60 +
         extract( second from NUMTODSINTERVAL (((to_date(NOT_READY_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second')) ) TOT_NOT_READY_TIME
         FROM dp_scorecard.scorecard_hierarchy_sv a_s
        join DP_SCORECARD.SC_AGENT_STAT_SV a11 on a_s.staff_natid =  a11.AGENT_ID
        join (SELECT TRUNC(a111.LAG_DATE) as LAG_DATE, a101.staff_staff_id, a111.agent_id
                  FROM DP_SCORECARD.SCORECARD_HIERARCHY_SV a101
                  join DP_SCORECARD.SC_LAG_TIME_SV a111
                    on a101.staff_natid = a111.agent_id
                 WHERE TRUNC(a111.LAG_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
              ) a12 on a11.agent_Id=a12.agent_Id and a11.AS_Date=a12.lag_date
        where not exists (select 1 from DP_SCORECARD.sc_exclusion_yes_sv b where a11.agent_id = b.agent_id and trunc(a11.as_date) = trunc(b.exclusion_date))
        and TRUNC(a11.AS_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')  /*and a11.EXCLUSION_FLAG='N'*/
    group by to_char(TRUNC(a11.AS_DATE), 'YYYYMM'), to_char(TRUNC(a11.AS_DATE), 'Month YYYY'),a_s.staff_staff_id, a11.AGENT_ID, NVL(a11.EXCLUSION_FLAG,'N')
 ),
Adherence_metric as
 (
   SELECT distinct
      a10.dates_month_num,
      a10.dates_year,
      a10.staff_staff_id,
      ((a10.TOT_LOGGED_IN_TIME - a10.TOT_NOT_READY_TIME)/a11.LAG_TIME_TOT_SCHED_PROD_TIME) as ADHERENCE
      FROM Adherence a10
      join LAG_metrics a11 on a10.staff_staff_id=a11.staff_staff_id and a10.dates_year=a11.dates_year
 ),
 Corr_Action as
 (
   select distinct staff_staff_id,
                  to_char(TRUNC(pt_entry_date), 'YYYYMM') as dates_month_num,
                  to_char(TRUNC(pt_entry_date), 'Month YYYY') as dates_year,
                  1 as corrective_action_flag
    from dp_scorecard.scorecard_perform_tracker_sv
   where DL_ID in (select dl_id
                     from dp_scorecard.scorecard_discussion_lkup_sv
                    where discussion_topic = 'Corrective Action')
 ),
 One_on_one as
 (
   select distinct staff_staff_id,
                  to_char(TRUNC(pt_entry_date), 'YYYYMM') as dates_month_num,
                  to_char(TRUNC(pt_entry_date), 'Month YYYY') as dates_year,
                  1 as one_on_one_flag
    from dp_scorecard.scorecard_perform_tracker_sv
   where DL_ID in (select dl_id
                     from dp_scorecard.scorecard_discussion_lkup_sv
                    where discussion_topic = 'One on One')
 ),
 Observation as
 (
   select distinct staff_staff_id,
                  to_char(TRUNC(pt_entry_date), 'YYYYMM') as dates_month_num,
                  to_char(TRUNC(pt_entry_date), 'Month YYYY') as dates_year,
                  1 as observation_flag
    from dp_scorecard.scorecard_perform_tracker_sv
   where DL_ID in (select dl_id
                     from dp_scorecard.scorecard_discussion_lkup_sv
                    where discussion_topic = 'Observation')
 ),
-- MER as
--  (
--    select distinct staff_staff_id,
--                   to_char(TRUNC(pt_entry_date), 'YYYYMM') as dates_month_num,
--                   to_char(TRUNC(pt_entry_date), 'Month YYYY') as dates_year,
--                   1 as mer_flag
--     from dp_scorecard.scorecard_perform_tracker_sv
--    where DL_ID in (select dl_id
--                      from dp_scorecard.scorecard_discussion_lkup_sv
--                     where discussion_topic = 'MER')
--  ),
 SCORECARD_QUALITY
 AS (  
 SELECT staff_staff_id,
       to_char(TRUNC(EVAL_DATE), 'YYYYMM') as dates_month_num,
       to_char(TRUNC(EVAL_DATE), 'Month YYYY') as dates_year,
       sum(SCORE_TOTAL) as avg_qc_score,  -- fix AVG of AVG
     --  avg(SCORE_TOTAL) as avg_qc_score,  -- ???? AVG of AVG
       sum(SCORE_TOTAL) as sum_qc_score,
       count(*) as count_qc_score,
       count(*) as qcs_performed,
       case
         when count(*)  >= 10 then 0
         else 10 - count(*) 
       end as qcs_remaining
  from dp_scorecard.SCORECARD_QUALITY_SV
  group by staff_staff_id ,
  to_char(TRUNC(EVAL_DATE), 'YYYYMM'), 
  to_char(TRUNC(EVAL_DATE), 'Month YYYY')
),
 ATTENDANCE 
AS (
	select distinct a.staff_STAFF_ID,
                DATES_MONTH,
                DATES_MONTH_NUM,
                DATES_YEAR,
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
   distinct all_staff.staff_staff_id,
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
   QC_metrics.qcs_performed,
   QC_metrics.avg_qc_score,
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
   Corr_Action.corrective_action_flag,
   One_on_one.one_on_one_flag,
   Observation.observation_flag,
--   mer.mer_flag,
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
	TIME_metrics.SHORT_CALL_AGENT_COUNT,   
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
 FROM (select distinct staff_staff_id,
         staff_staff_name,
         dates_month,
         dates_month_num,
         dates_year 
         from DP_SCORECARD.SCORECARD_STAFF_MONTHLY_SV
         ) all_staff
--LEFT OUTER JOIN MER on all_staff.staff_staff_id = MER.staff_staff_id   and all_staff.dates_month_num=MER.dates_month_num
LEFT OUTER JOIN STAFF_LOCATION ON all_staff.staff_staff_id = STAFF_LOCATION.STAFF_STAFF_ID 
LEFT OUTER JOIN Observation on all_staff.staff_staff_id = Observation.staff_staff_id and all_staff.dates_month_num=Observation.dates_month_num  
LEFT OUTER jOIN One_on_one on all_staff.staff_staff_id = One_on_one.staff_staff_id and all_staff.dates_month_num=One_on_one.dates_month_num
LEFT OUTER JOIN Corr_Action on all_staff.staff_staff_id = Corr_Action.staff_staff_id and all_staff.dates_month_num=Corr_Action.dates_month_num
LEFT OUTER JOIN Adherence_metric on all_staff.staff_staff_id = Adherence_metric.staff_staff_id and all_staff.dates_month_num=Adherence_metric.dates_month_num
LEFT OUTER JOIN CALL_days on all_staff.staff_staff_id = CALL_days.staff_staff_id and all_staff.dates_month_num=CALL_days.dates_month_num
LEFT OUTER JOIN WUE_metrics on all_staff.staff_staff_id = WUE_metrics.staff_staff_id and all_staff.dates_month_num=WUE_metrics.dates_month_num
LEFT OUTER JOIN CUST_metrics on all_staff.staff_staff_id = CUST_metrics.staff_staff_id and all_staff.dates_month_num=CUST_metrics.dates_month_num
LEFT OUTER JOIN LAG_metrics on all_staff.staff_staff_id = LAG_metrics.staff_staff_id and all_staff.dates_month_num=LAG_metrics.dates_month_num
LEFT OUTER JOIN DEF_metrics on all_staff.staff_staff_id = DEF_metrics.staff_staff_id and all_staff.dates_month_num=DEF_metrics.dates_month_num
LEFT OUTER JOIN INC_metrics on all_staff.staff_staff_id = INC_metrics.staff_staff_id and all_staff.dates_month_num=INC_metrics.dates_month_num
LEFT OUTER JOIN QC_metrics on all_staff.staff_staff_id = QC_metrics.staff_staff_id and all_staff.dates_month_num=QC_metrics.dates_month_num
LEFT OUTER JOIN TIME_metrics on all_staff.staff_staff_id = TIME_metrics.staff_staff_id and all_staff.dates_month_num=TIME_metrics.dates_month_num
LEFT OUTER JOIN SCORECARD_QUALITY ON ALL_Staff.staff_staff_id = SCORECARD_QUALITY.STAFF_STAFF_ID AND all_staff.dates_month_num=SCORECARD_QUALITY.dates_month_num
LEFT OUTER JOIN ATTENDANCE on all_staff.staff_staff_id = ATTENDANCE.staff_staff_id and all_staff.dates_month_num=ATTENDANCE.dates_month_num
;

COMMIT;
 

end LOAD_SC_SUMMARY_CC;
/

GRANT DEBUG ON DP_SCORECARD.LOAD_SC_SUMMARY_CC TO MAXDAT_READ_ONLY;

GRANT DEBUG ON DP_SCORECARD.LOAD_SC_SUMMARY_CC TO DP_SCORECARD_READ_ONLY;
