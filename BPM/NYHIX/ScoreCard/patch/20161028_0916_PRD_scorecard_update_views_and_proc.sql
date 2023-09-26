alter table DP_SCORECARD.SC_SUMMARY_CC add Tot_Return_to_Queue_Timeout NUMBER;

CREATE OR REPLACE VIEW DP_SCORECARD.SC_AGENT_STAT_SV
AS
select
AS_Date
,Agent_ID
,Supervisor_ID
,Calls_Answered
,Short_Calls_Answered
,Average_Handle_time
,(Tot_Return_to_Queue + Tot_Return_to_Queue_Timeout) as Tot_Return_to_Queue
,Tot_Return_to_Queue_Timeout
,(Tot_Return_to_Queue + Tot_Return_to_Queue_Timeout) as Tot_Ret_to_Queue_Total
,Tot_Sched_Productive_Time
,Actual_Productive_Time
,Talk_Time
,Wrap_Up_Time
,Logged_in_Time
,Not_Ready_Time
,Break_Time
,Lunch_Time
,EXCLUSION_FLAG
from SC_AGENT_STAT
WITH READ ONLY
;

GRANT SELECT ON DP_SCORECARD.SC_AGENT_STAT_SV TO MAXDAT_READ_ONLY;
GRANT SELECT ON DP_SCORECARD.SC_AGENT_STAT_SV TO MAXDAT;

CREATE OR REPLACE VIEW DP_SCORECARD.SC_SUMMARY_CC_SV
AS
select DISTINCT STAFF_STAFF_ID,
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
       TOT_DEFECTS_COMPLETED,
       DAYS_DEFECTS_COMPLETED,
       LAG_TIME_TOT_SCHED_PROD_TIME,
       TOT_CALL_RECORDS,
       TOT_CUSTOMER_COUNT,
       TOT_CALL_WRAP_UP_COUNT,
       TOT_WRAP_UP_ERROR,
       DAYS_SHORT_CALLS_GT_10,
       DAYS_CALLS_ANSWERED,
       ADHERENCE
  from dp_scorecard.sc_summary_cc
;

GRANT SELECT ON DP_SCORECARD.SC_SUMMARY_CC_SV TO MAXDAT_READ_ONLY;
GRANT SELECT ON DP_SCORECARD.SC_SUMMARY_CC_SV TO MAXDAT;

CREATE OR REPLACE VIEW DP_SCORECARD.SCORECARD_SUMMARY_CC_SV
AS
WITH ATTEND_Metrics AS
  (
   select staff_staff_id,
          staff_staff_name,
          dates_month,
          dates_month_num,
          dates_year,
          balance,
          total_balance,
          sc_attendance_id
     from dp_scorecard.scorecard_attendance_mthly_sv
  )
 select distinct a11.staff_staff_id,
        a11.staff_staff_name,
        a11.dates_month,
        a11.dates_month_num,
        a11.dates_year,
        a10.exclusion_flag,
        a10.tot_calls_answered,
        a10.tot_short_calls_answered,
        a10.tot_tot_return_to_queue,
        (a10.tot_tot_return_to_queue + a10.Tot_Return_to_Queue_Timeout) as Tot_Ret_to_Queue_Total ,
        a10.tot_average_handle_time,
        a10.tot_sched_productive_time,
        a10.tot_actual_productive_time,
        a10.tot_talk_time,
        a10.tot_wrap_up_time,
        a10.tot_logged_in_time,
        a10.tot_not_ready_time,
        a10.tot_break_time,
        a10.tot_lunch_time,
        a10.qcs_performed,
        a10.avg_qc_score,
        a10.tot_incidents_completed,
        a10.days_incidents_completed,
        a10.tot_defects_completed,
        a10.days_defects_completed,
        a10.lag_time_tot_sched_prod_time,
        a10.tot_call_records,
        a10.tot_customer_count,
        a10.tot_call_wrap_up_count,
        a10.tot_wrap_up_error,
        a10.days_short_calls_gt_10,
        a10.days_calls_answered,
        a11.balance,
        a11.total_balance,
        a10.adherence
        from ATTEND_Metrics a11
   LEFT OUTER JOIN dp_scorecard.sc_summary_cc a10 ON a11.staff_staff_id=a10.staff_staff_id
   and  a11.dates_month_num=a10.dates_month_num  /*order by a11.staff_staff_id, a11.dates_month_num*/
;

GRANT SELECT ON DP_SCORECARD.SCORECARD_SUMMARY_CC_SV TO MAXDAT_READ_ONLY;
GRANT SELECT ON DP_SCORECARD.SCORECARD_SUMMARY_CC_SV TO MAXDAT;

CREATE OR REPLACE procedure DP_SCORECARD.LOAD_SC_SUMMARY_CC
AS

begin

    Delete from SC_SUMMARY_CC;
    commit;

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
   DAYS_CALLS_ANSWERED
   )

WITH TIME_metrics as
 (
   SELECT
       to_char(TRUNC(a11.AS_DATE), 'YYYYMM') as dates_month_num,
      to_char(TRUNC(a11.AS_DATE), 'Month YYYY') as dates_year,
      to_char(AGENT_ID) AGENT_ID,
      a_s.staff_staff_id,
       EXCLUSION_FLAG,
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
         extract( second from NUMTODSINTERVAL (((to_date(LUNCH_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second')) ) TOT_LUNCH_TIME
         FROM dp_scorecard.scorecard_hierarchy_sv a_s
        join DP_SCORECARD.SC_AGENT_STAT_SV a11 on a_s.staff_natid =  a11.AGENT_ID
        where TRUNC(a11.AS_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
    group by to_char(TRUNC(a11.AS_DATE), 'YYYYMM'), to_char(TRUNC(a11.AS_DATE), 'Month YYYY'),a_s.staff_staff_id, AGENT_ID, EXCLUSION_FLAG
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
/*INCDEFS AS
 (
   SELECT trunc(a11.TASK_START) AS_DATE,
       a11.STAFF_ID,
       to_char(TRUNC(a11.TASK_START), 'YYYYMM') as dates_month_num,
       to_char(TRUNC(a11.TASK_START), 'Month YYYY') as dates_year,
        count((Case when a11.EVENT_ID in (1374, 1375, 1376, 1377, 1378, 1379) then 1 else null end)) INCIDENTS_COMPLETED,
        count((Case when a11.EVENT_ID in (1373) then 1 else null end)) DEFECTS_COMPLETED
   FROM DP_SCORECARD.SCORECARD_HIERARCHY_SV a10
  join MAXDAT.PP_WFM_ACTUALS_SV a11 on a10.staff_staff_id=a11.staff_id
   WHERE TRUNC(a11.task_start) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
  and (a11.EVENT_ID in (1374, 1375, 1376, 1377, 1378, 1379)
         or a11.EVENT_ID in (1373))
         and a11.TASK_END is not null
   group by trunc(TASK_START),
        a11.staff_id
 ),
 INCDEF_metrics AS
 (
 select
   distinct  a11.staff_id as staff_staff_id,
       a11.dates_month_num,
       a11.dates_year,
        sum(a11.INCIDENTS_COMPLETED) OVER (PARTITION BY a11.staff_id, a11.dates_month_num) as TOT_INCIDENTS_COMPLETED,
        count(a11.INCIDENTS_COMPLETED) OVER (PARTITION BY a11.staff_id, a11.dates_month_num) as DAYS_INCIDENTS_COMPLETED,
        sum(a11.DEFECTS_COMPLETED) OVER (PARTITION BY a11.staff_id, a11.dates_month_num) as TOT_DEFECTS_COMPLETED,
       count(a11.DEFECTS_COMPLETED) OVER (PARTITION BY a11.staff_id, a11.dates_month_num) as  DAYS_DEFECTS_COMPLETED
   from  INCDEFS a11
 ),*/
 INCDEFS AS
 (
   SELECT a11.STAFF_ID,
   trunc(a11.TASK_START) AS_DATE,
       to_char(TRUNC(a11.TASK_START), 'YYYYMM') as dates_month_num,
       to_char(TRUNC(a11.TASK_START), 'Month YYYY') as dates_year,
        count((Case when a11.EVENT_ID in (1374, 1375, 1376, 1377, 1378, 1379) then 1 else null end)) INCIDENTS_COMPLETED,
        count((Case when a11.EVENT_ID in (1373) then 1 else null end)) DEFECTS_COMPLETED
   FROM DP_SCORECARD.SCORECARD_HIERARCHY_SV a10
  join MAXDAT.PP_WFM_ACTUALS_SV a11 on a10.staff_staff_id=a11.staff_id
   WHERE TRUNC(a11.task_start) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
  and (a11.EVENT_ID in (1374, 1375, 1376, 1377, 1378, 1379)
         or a11.EVENT_ID in (1373))
         and a11.TASK_END is not null and trunc(a11.TASK_START)=trunc(a11.TASK_END)
         --and a10.staff_natid = 76386
   group by a11.staff_id, trunc(TASK_START)
--   order by a11.staff_id, trunc(TASK_START)
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
       to_char(TRUNC(a11.LAG_DATE), 'YYYYMM') as dates_month_num,
       to_char(TRUNC(a11.LAG_DATE), 'Month YYYY') as dates_year,
        a10.staff_staff_id,
        sum(extract( day from NUMTODSINTERVAL (((to_date(TOT_SCHED_PRODUCTIVE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*24*60*60 +
         extract( hour from NUMTODSINTERVAL (((to_date(TOT_SCHED_PRODUCTIVE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60*60 +
         extract( minute from NUMTODSINTERVAL (((to_date(TOT_SCHED_PRODUCTIVE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60 +
         extract( second from NUMTODSINTERVAL (((to_date(TOT_SCHED_PRODUCTIVE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second')) )
        over (partition by a10.staff_staff_id, to_char(TRUNC(a11.LAG_DATE), 'YYYYMM')) as LAG_TIME_TOT_SCHED_PROD_TIME
       FROM DP_SCORECARD.SCORECARD_HIERARCHY_SV a10
  join DP_SCORECARD.SC_LAG_TIME_SV a11 on a10.staff_natid = a11.agent_id
  WHERE TRUNC(a11.LAG_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
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
  WHERE TRUNC(a11.CALL_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
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
  WHERE TRUNC(a11.WUE_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
 ),
 CALL_metrics AS
 (
  SELECT
        a10.staff_staff_id,
       a11.AS_DATE,
        a11.EXCLUSION_FLAG,
        CASE WHEN sum(a11.SHORT_CALLS_ANSWERED) > 10 THEN 1 ELSE null END short_calls,
        sum(a11.CALLS_ANSWERED) TOT_CALLS,
       to_char(TRUNC(a11.AS_DATE), 'YYYYMM') as dates_month_num,
       to_char(TRUNC(a11.AS_DATE), 'Month YYYY') as dates_year
   FROM DP_SCORECARD.SCORECARD_HIERARCHY_SV a10
  join DP_SCORECARD.SC_AGENT_STAT_SV a11 on a10.staff_natid = a11.AGENT_ID
  WHERE TRUNC(a11.AS_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
   GROUP BY a10.staff_staff_id, a11.AS_DATE, a11.EXCLUSION_FLAG
 ),
 CALL_days AS
 (
   SELECT distinct
        staff_staff_id,
        dates_month_num,
        dates_year,
        EXCLUSION_FLAG,
        count(short_calls)  over (partition by staff_staff_id,dates_month_num, EXCLUSION_FLAG) as Days_Short_Calls_GT_10,
         count(TOT_CALLS)  over (partition by staff_staff_id,dates_month_num, EXCLUSION_FLAG) as DAYS_CALLS_ANSWERED
   FROM CALL_metrics
 )
 SELECT
   distinct all_staff.staff_staff_id,
   all_staff.staff_staff_name,
   all_staff.dates_month,
   all_staff.dates_month_num,
   all_staff.dates_year,
   tm.EXCLUSION_FLAG,
   tm.TOT_CALLS_ANSWERED,
   tm.TOT_SHORT_CALLS_ANSWERED,
   tm.TOT_TOT_RETURN_TO_QUEUE,
   tm.TOT_RETURN_TO_QUEUE_TIMEOUT,
   tm.TOT_AVERAGE_HANDLE_TIME,
   tm.TOT_SCHED_PRODUCTIVE_TIME,
   tm.TOT_ACTUAL_PRODUCTIVE_TIME,
   tm.TOT_TALK_TIME,
   tm.TOT_WRAP_UP_TIME,
   tm.TOT_LOGGED_IN_TIME,
   tm.TOT_NOT_READY_TIME,
   tm.TOT_BREAK_TIME,
   tm.TOT_LUNCH_TIME,
   qc.qcs_performed,
   qc.avg_qc_score,
   im.TOT_INCIDENTS_COMPLETED,
   im.DAYS_INCIDENTS_COMPLETED,
   dm.TOT_DEFECTS_COMPLETED,
   dm.DAYS_DEFECTS_COMPLETED,
   lt.LAG_TIME_TOT_SCHED_PROD_TIME,
   cm.TOT_CALL_RECORDS,
   cm.TOT_CUSTOMER_COUNT,
   cm.TOT_CALL_WRAP_UP_COUNT,
   wm.TOT_WRAP_UP_ERROR,
   cd.Days_Short_Calls_GT_10,
   cd.DAYS_CALLS_ANSWERED
 FROM (select distinct staff_staff_id,
         staff_staff_name,
         dates_month,
         dates_month_num,
         dates_year from dp_scorecard.scorecard_attendance_mthly_sv
         ) all_staff
 left outer join TIME_metrics tm on all_staff.staff_staff_id = tm.staff_staff_id and all_staff.dates_month_num=tm.dates_month_num
 left outer join QC_metrics qc on all_staff.staff_staff_id = qc.staff_staff_id and all_staff.dates_month_num=qc.dates_month_num
 left outer join INC_metrics im on all_staff.staff_staff_id = im.staff_staff_id and all_staff.dates_month_num=im.dates_month_num
 left outer join DEF_metrics dm on all_staff.staff_staff_id = dm.staff_staff_id and all_staff.dates_month_num=dm.dates_month_num
 left outer join LAG_metrics lt on all_staff.staff_staff_id = lt.staff_staff_id and all_staff.dates_month_num=lt.dates_month_num
 left outer join CUST_metrics cm on all_staff.staff_staff_id = cm.staff_staff_id and all_staff.dates_month_num=cm.dates_month_num
left outer join WUE_metrics wm on all_staff.staff_staff_id = wm.staff_staff_id and all_staff.dates_month_num=wm.dates_month_num
left outer join CALL_days cd on all_staff.staff_staff_id = cd.staff_staff_id and all_staff.dates_month_num=cd.dates_month_num;
--order by all_staff.staff_staff_id,all_staff.dates_month_num;
commit;
end LOAD_SC_SUMMARY_CC;
/

GRANT EXECUTE ON DP_SCORECARD.LOAD_SC_SUMMARY_CC TO MAXDAT_READ_ONLY;
GRANT EXECUTE ON DP_SCORECARD.LOAD_SC_SUMMARY_CC TO MAXDAT;

CREATE OR REPLACE PROCEDURE DP_SCORECARD.LOAD_SCORECARD_HIERARCHY 
AS 
BEGIN
delete scorecard_hierarchy where 1=1;
commit;

insert into scorecard_hierarchy ("ADMIN_ID", "SR_DIRECTOR_NAME", "SR_DIRECTOR_STAFF_ID", "SR_DIRECTOR_NATID", "DIRECTOR_NAME", "DIRECTOR_STAFF_ID", "DIRECTOR_NATID", "SR_MANAGER_NAME", "SR_MANAGER_STAFF_ID", "SR_MANAGER_NATID", "MANAGER_NAME", "MANAGER_STAFF_ID", "MANAGER_NATID", "SUPERVISOR_NAME", "SUPERVISOR_STAFF_ID", "SUPERVISOR_NATID", "STAFF_STAFF_ID", "STAFF_STAFF_NAME", "STAFF_NATID", "HIRE_DATE", "POSITION", "OFFICE", "TERMINATION_DATE") 
  with sr_directors as
(
select staff_id as sr_director_staff_id, national_id as sr_director_natid, (LAST_NAME||', '|| FIRST_NAME) as sr_director_name from maxdat.pp_wfm_staff_sv where staff_id in (
select staff_id
  from dp_scorecard.pp_wfm_job_classification_sv
 where job_classification_code_id in
       (select job_classification_code_id
          from dp_scorecard.pp_wfm_job_class_code_sv
         where code in ('Sr. Director'))
   and trunc(sysdate) between start_date and
       nvl(end_date, to_date('07/07/2077', 'mm/dd/yyyy')))
--       and termination_date is null
)
, directors as
(
select staff_id as director_staff_id, national_id as director_natid, (LAST_NAME||', '|| FIRST_NAME) as director_name from maxdat.pp_wfm_staff_sv where staff_id in (
select staff_id
  from dp_scorecard.pp_wfm_job_classification_sv
 where job_classification_code_id in
       (select job_classification_code_id
          from dp_scorecard.pp_wfm_job_class_code_sv
         where code in ('Director'))
   and trunc(sysdate) between start_date and
       nvl(end_date, to_date('07/07/2077', 'mm/dd/yyyy')))
--       and termination_date is null
)
, sr_managers as
(
select staff_id as sr_manager_staff_id, national_id as sr_manager_natid, (LAST_NAME||', '|| FIRST_NAME) as sr_manager_name from maxdat.pp_wfm_staff_sv where staff_id in (
select staff_id
  from dp_scorecard.pp_wfm_job_classification_sv
 where job_classification_code_id in
       (select job_classification_code_id
          from dp_scorecard.pp_wfm_job_class_code_sv
         where code in ('Sr. Manager'))
   and trunc(sysdate) between start_date and
       nvl(end_date, to_date('07/07/2077', 'mm/dd/yyyy')))
--       and termination_date is null
)
, managers as
(
select staff_id as manager_staff_id, national_id as manager_natid, (LAST_NAME||', '|| FIRST_NAME) as manager_name from maxdat.pp_wfm_staff_sv where staff_id in (
select staff_id
  from dp_scorecard.pp_wfm_job_classification_sv
 where job_classification_code_id in
       (select job_classification_code_id
          from dp_scorecard.pp_wfm_job_class_code_sv
         where job_classification_code_id in (1057,1018,1044))--'Manager','CC Management','Enrollment & Eligibility Operations Manager'
   and trunc(sysdate) between start_date and
       nvl(end_date, to_date('07/07/2077', 'mm/dd/yyyy')))
--       and termination_date is null
)
, supervisors as
(
select staff_id as supervisor_staff_id, national_id as supervisor_natid, (LAST_NAME||', '|| FIRST_NAME) as supervisor_name  from maxdat.pp_wfm_staff_sv where staff_id in (
select staff_id
  from dp_scorecard.pp_wfm_job_classification_sv
 where job_classification_code_id in
       (select job_classification_code_id
          from dp_scorecard.pp_wfm_job_class_code_sv
         where job_classification_code_id in (1058,1031)) --'Supervisor','E&E Supervisor'
   and trunc(sysdate) between start_date and
       nvl(end_date, to_date('07/07/2077', 'mm/dd/yyyy')))
--       and termination_date is null
)
, srdir_to_dir as
(
--sr director to director
select srdirs.sr_director_name, srdirs.sr_director_staff_id, srdirs.sr_director_natid, dirs.director_name, dirs.director_staff_id, dirs.director_natid
from maxdat.pp_wfm_supervisor_to_staff_sv sts
join sr_directors srdirs on sts.supervisor_id=srdirs.sr_director_staff_id
join directors dirs on sts.staff_id=dirs.director_staff_id
where ((sts.end_date is null
    or sts.end_date >= sysdate)
    and sts.effective_date <= sysdate)
)
, dir_to_srmgr as
(
--director to sr manager
select dirs.director_name, dirs.director_staff_id, dirs.director_natid, srmgrs.sr_manager_name, srmgrs.sr_manager_staff_id, srmgrs.sr_manager_natid
from maxdat.pp_wfm_supervisor_to_staff_sv sts
join directors dirs on sts.supervisor_id=dirs.director_staff_id
join sr_managers srmgrs on sts.staff_id=srmgrs.sr_manager_staff_id
where ((sts.end_date is null
    or sts.end_date >= sysdate)
    and sts.effective_date <= sysdate)
)
, srmgr_to_mgr as
(
--sr manager to manager
select
srmgrs.sr_manager_name, srmgrs.sr_manager_staff_id, srmgrs.sr_manager_natid, mgrs.manager_name, mgrs.manager_staff_id, mgrs.manager_natid
from maxdat.pp_wfm_supervisor_to_staff_sv sts
join sr_managers srmgrs on sts.supervisor_id=srmgrs.sr_manager_staff_id
join managers mgrs on sts.staff_id=mgrs.manager_staff_id
where ((sts.end_date is null
    or sts.end_date >= sysdate)
    and sts.effective_date <= sysdate)
)
, mgr_to_sup as
(
--manager to supervisor
select mgrs.manager_name, mgrs.manager_staff_id, mgrs.manager_natid, sups.supervisor_name, sups.supervisor_staff_id, sups.supervisor_natid
from maxdat.pp_wfm_supervisor_to_staff_sv sts
join managers mgrs on sts.supervisor_id=mgrs.manager_staff_id
join supervisors sups on sts.staff_id=sups.supervisor_staff_id
where ((sts.end_date is null
    or sts.end_date >= sysdate)
    and sts.effective_date <= sysdate)
)
, sup_to_staff as
(
SELECT
S.staff_id as staff_staff_id,
S.NATIONAL_ID as staff_natid,
S.LAST_NAME||', '||S.FIRST_NAME as staff_staff_name,
S.HIRE_DATE,
S.TERMINATION_DATE,
JC.CODE POSITION,
O.NAME OFFICE,
S1.STAFF_ID as supervisor_staff_id,
S1.NATIONAL_ID as supervisor_natid,
S1.LAST_NAME||', '||S1.FIRST_NAME as supervisor_name/*,
S1.HIRE_DATE,
JC1.CODE SUP_POSITION*/
FROM MAXDAT.PP_WFM_STAFF_SV S
LEFT JOIN DP_SCORECARD.PP_WFM_JOB_CLASSIFICATION_SV J ON S.STAFF_ID = J.STAFF_ID
LEFT JOIN DP_SCORECARD.PP_WFM_JOB_CLASS_CODE_SV JC ON J.JOB_CLASSIFICATION_CODE_ID = JC.JOB_CLASSIFICATION_CODE_ID
LEFT JOIN DP_SCORECARD.PP_WFM_STAFF_TO_OFFICE_SV SO ON (S.STAFF_ID = SO.STAFF_ID AND SO.END_DATE IS NULL)
LEFT JOIN DP_SCORECARD.PP_WFM_OFFICE_SV O ON SO.OFFICE_ID = O.OFFICE_ID
LEFT JOIN MAXDAT.PP_WFM_SUPERVISOR_TO_STAFF_SV ST ON S.STAFF_ID = ST.STAFF_ID
LEFT JOIN MAXDAT.PP_WFM_STAFF_SV S1 ON ST.SUPERVISOR_ID = S1.STAFF_ID
--LEFT JOIN DP_SCORECARD.PP_WFM_JOB_CLASSIFICATION_SV J1 ON S1.STAFF_ID = J1.STAFF_ID
--LEFT JOIN DP_SCORECARD.PP_WFM_JOB_CLASS_CODE_SV JC1 ON J1.JOB_CLASSIFICATION_CODE_ID = JC1.JOB_CLASSIFICATION_CODE_ID
WHERE J.END_DATE IS NULL
--AND J1.END_DATE IS NULL
AND ((ST.END_DATE IS NULL
or st.end_date >= sysdate)
  and st.effective_date <= sysdate)
AND JC.JOB_CLASSIFICATION_CODE_ID IN ('1068','1059','1054','1053','1024','1011','1010','1009','1008','1043','1019','1013','1012','1056','1047','1028','1025','1061','1032','1033','1060','1039','1063','1038','1037','1035','1052','1030','1022','1020','1046','1055','1026','1023','1027','1045','1051','1050','1049','1048','1017','1016','1015','1014')
--AND (S.TERMINATION_DATE IS NULL or S.TERMINATION_DATE > TRUNC(SYSDATE))
)
select 999 as admin_id, --created an admin level in the hierarchy so that user id 999 in MicroStrategy can see all managers
       sdtd.sr_director_name,
       sdtd.sr_director_staff_id,
       sdtd.sr_director_natid,
       dts.director_name,
       dts.director_staff_id,
       dts.director_natid,
       dts.sr_manager_name,
       dts.sr_manager_staff_id,
       dts.sr_manager_natid,
       stm.manager_name,
       stm.manager_staff_id,
       stm.manager_natid,
       mts.supervisor_name,
       mts.supervisor_staff_id,
       mts.supervisor_natid,
       sts.staff_staff_id,
       sts.staff_staff_name,
       sts.staff_natid,
       sts.hire_date,
       sts.position,
       sts.office,
       sts.termination_date
  from srdir_to_dir sdtd
  left outer join dir_to_srmgr dts on sdtd.director_staff_id = dts.director_staff_id
  left outer join  srmgr_to_mgr stm
    on dts.sr_manager_staff_id = stm.sr_manager_staff_id
  left outer join  mgr_to_sup mts
    on stm.manager_staff_id = mts.manager_staff_id
  left outer join  sup_to_staff sts
    on mts.supervisor_staff_id = sts.supervisor_staff_id
  order by
  sdtd.sr_director_name,
       dts.director_name,
       dts.sr_manager_name,
       stm.manager_name,
       mts.supervisor_name,
       sts.staff_staff_name
;
commit;
END LOAD_SCORECARD_HIERARCHY;
/

GRANT EXECUTE ON DP_SCORECARD.LOAD_SCORECARD_HIERARCHY TO MAXDAT;
GRANT EXECUTE ON DP_SCORECARD.LOAD_SCORECARD_HIERARCHY TO MAXDAT_READ_ONLY;
GRANT EXECUTE ON DP_SCORECARD.LOAD_SCORECARD_HIERARCHY TO MAXDAT_REPORTS;





