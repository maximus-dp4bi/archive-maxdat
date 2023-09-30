ALTER TABLE dp_scorecard.SC_SUMMARY_CC_ROLLUP
ADD staff_count NUMBER;

COMMIT;

create or replace view dp_scorecard.scorecard_summary_cc_rollup_sv as
select supervisor_staff_id,
       to_date(dates_month_num,'YYYYMM') as d_date,
       dates_month,
       dates_month_num,
       dates_year,
       exclusion_flag,
       tot_calls_answered,
       tot_short_calls_answered,
       tot_tot_return_to_queue,
       tot_average_handle_time,
       tot_sched_productive_time,
       tot_actual_productive_time,
       tot_talk_time,
       tot_wrap_up_time,
       tot_logged_in_time,
       tot_not_ready_time,
       tot_break_time,
       tot_lunch_time,
       qcs_performed,
       avg_qc_score,
       tot_incidents_completed,
       days_incidents_completed,
       tot_defects_completed,
       days_defects_completed,
       lag_time_tot_sched_prod_time,
       tot_call_records,
       tot_customer_count,
       tot_call_wrap_up_count,
       tot_wrap_up_error,
       days_short_calls_gt_10,
       days_calls_answered,
       adherence,
       tot_return_to_queue_timeout,
       avg_attendance_balance,
       avg_attendance_total_balance,
       staff_count
  from dp_scorecard.sc_summary_cc_rollup;


create or replace procedure dp_scorecard.LOAD_SC_SUMMARY_CC_ROLLUP
AS

begin

    Delete from dp_scorecard.SC_SUMMARY_CC_ROLLUP;
    commit;

insert into dp_scorecard.SC_SUMMARY_CC_ROLLUP (supervisor_staff_id,
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
   avg_attendance_balance,
   avg_attendance_total_balance,
   staff_count
   )

WITH attendance as
(
/*select distinct SUPERVISOR_STAFF_ID,
                DATES_MONTH,
                DATES_MONTH_NUM,
                DATES_YEAR,
                AVG(BALANCE) over(partition by SUPERVISOR_STAFF_ID, dates_month_num) as BALANCE,
                AVG(TOTAL_BALANCE) over(partition by SUPERVISOR_STAFF_ID, dates_month_num) as TOTAL_BALANCE,
                SC_ATTENDANCE_ID
  from dp_scorecard.scorecard_attendance_mthly_sv*/
select distinct a.SUPERVISOR_STAFF_ID,
                DATES_MONTH,
                DATES_MONTH_NUM,
                DATES_YEAR,
                SUM(BALANCE) over(partition by a.SUPERVISOR_STAFF_ID, dates_month_num) as BALANCE,
                SUM(TOTAL_BALANCE) over(partition by a.SUPERVISOR_STAFF_ID, dates_month_num) as TOTAL_BALANCE,
                --SC_ATTENDANCE_ID,
                COUNT(h.staff_staff_id) over(partition by a.SUPERVISOR_STAFF_ID, dates_month_num) as STAFF_COUNT
from dp_scorecard.scorecard_attendance_mthly_sv a
 join dp_scorecard.scorecard_hierarchy_sv h on a.STAFF_STAFF_ID=h.staff_staff_id
 where to_date(a.DATES_MONTH_NUM,'YYYYMM') >= ADD_MONTHS((LAST_DAY(h.hire_date)+1),-1) 
 order by supervisor_staff_id, dates_month_num 
  
),
TIME_metrics as
 (
   SELECT
      distinct
      to_char(TRUNC(a11.AS_DATE), 'YYYYMM') as dates_month_num,
      to_char(TRUNC(a11.AS_DATE), 'Month YYYY') as dates_year,
       a_s.supervisor_staff_id,
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
        where not exists (select 1 from sc_exclusion_yes_sv b where a11.agent_id = b.agent_id and a11.as_date = b.exclusion_date)
        and TRUNC(a11.AS_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
    group by to_char(TRUNC(a11.AS_DATE), 'YYYYMM'), to_char(TRUNC(a11.AS_DATE), 'Month YYYY'),a_s.supervisor_staff_id, EXCLUSION_FLAG
 ),
 QC_metrics AS
 (
 select supervisor_staff_id,
           dates_month_num,
           dates_year,
           avg_qc_score,
           qcs_performed
      from dp_scorecard.scorecard_quality_mthly_ru_sv
 ),
INCDEFS AS
 (
   SELECT a10.supervisor_staff_id,
   trunc(a11.TASK_START) AS_DATE,
       to_char(TRUNC(a11.TASK_START), 'YYYYMM') as dates_month_num,
       to_char(TRUNC(a11.TASK_START), 'Month YYYY') as dates_year,
        count((Case when a11.EVENT_ID in (1374, 1375, 1376, 1377, 1378, 1379) then 1 else null end)) INCIDENTS_COMPLETED,
        count((Case when a11.EVENT_ID in (1373) then 1 else null end)) DEFECTS_COMPLETED
   FROM DP_SCORECARD.SCORECARD_HIERARCHY_SV a10
  join MAXDAT.PP_WFM_ACTUALS_SV a11 on a10.staff_staff_id=a11.staff_id
   WHERE not exists (select 1 from sc_exclusion_yes_sv b where a11.staff_id = b.staff_id and trunc(a11.task_start) = trunc(b.exclusion_date))
        and	TRUNC(a11.task_start) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
  and (a11.EVENT_ID in (1374, 1375, 1376, 1377, 1378, 1379)
         or a11.EVENT_ID in (1373))
         and a11.TASK_END is not null and trunc(a11.TASK_START)=trunc(a11.TASK_END)
   group by a10.supervisor_staff_id, trunc(TASK_START)
 ),
 INC_metrics AS
 (
 select
   distinct a11.supervisor_staff_id,
       a11.dates_month_num,
       a11.dates_year,
        sum(a11.INCIDENTS_COMPLETED) OVER (PARTITION BY a11.supervisor_staff_id, a11.dates_month_num) as TOT_INCIDENTS_COMPLETED,
        count(a11.INCIDENTS_COMPLETED) OVER (PARTITION BY a11.supervisor_staff_id, a11.dates_month_num) as DAYS_INCIDENTS_COMPLETED
   from  INCDEFS a11
   where  a11.INCIDENTS_COMPLETED <> 0
 ),
 DEF_metrics AS
 (
 select
   distinct a11.supervisor_staff_id,
       a11.dates_month_num,
       a11.dates_year,
       sum(a11.DEFECTS_COMPLETED) OVER (PARTITION BY a11.supervisor_staff_id, a11.dates_month_num) as TOT_DEFECTS_COMPLETED,
       count(a11.DEFECTS_COMPLETED) OVER (PARTITION BY a11.supervisor_staff_id, a11.dates_month_num) as  DAYS_DEFECTS_COMPLETED
   from  INCDEFS a11
   where  a11.DEFECTS_COMPLETED <> 0
 ) ,
 LAG_metrics AS (
   SELECT
       distinct to_char(TRUNC(a11.LAG_DATE), 'YYYYMM') as dates_month_num,
       to_char(TRUNC(a11.LAG_DATE), 'Month YYYY') as dates_year,
        a10.supervisor_staff_id,
        sum(extract( day from NUMTODSINTERVAL (((to_date(TOT_SCHED_PRODUCTIVE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*24*60*60 +
         extract( hour from NUMTODSINTERVAL (((to_date(TOT_SCHED_PRODUCTIVE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60*60 +
         extract( minute from NUMTODSINTERVAL (((to_date(TOT_SCHED_PRODUCTIVE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60 +
         extract( second from NUMTODSINTERVAL (((to_date(TOT_SCHED_PRODUCTIVE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second')) )
        over (partition by a10.supervisor_staff_id, to_char(TRUNC(a11.LAG_DATE), 'YYYYMM')) as LAG_TIME_TOT_SCHED_PROD_TIME
       FROM DP_SCORECARD.SCORECARD_HIERARCHY_SV a10
  join DP_SCORECARD.SC_LAG_TIME_SV a11 on a10.staff_natid = a11.agent_id
  join (select trunc(as_date) as as_date, agent_id from DP_SCORECARD.SC_AGENT_STAT_SV
        where TRUNC(AS_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')) a12
        on  a12.agent_id=a10.staff_natid and a12.as_date= TRUNC(a11.LAG_DATE)
  WHERE not exists (select 1 from sc_exclusion_yes_sv b where a11.agent_id = b.agent_id and trunc(a11.LAG_DATE) = trunc(b.exclusion_date))
        and TRUNC(a11.LAG_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
 ),
 CUST_metrics AS
 (
    SELECT distinct
      to_char(TRUNC(a11.CALL_DATE), 'YYYYMM') as dates_month_num,
       to_char(TRUNC(a11.CALL_DATE), 'Month YYYY') as dates_year,
       a10.supervisor_staff_id,
       count(CALL_RECORD_ID) over (partition by a10.supervisor_staff_id,to_char(TRUNC(a11.CALL_DATE), 'Month YYYY')) as  TOT_CALL_RECORDS,
       sum(CUSTOMER_COUNT) over (partition by a10.supervisor_staff_id,to_char(TRUNC(a11.CALL_DATE), 'Month YYYY')) as TOT_CUSTOMER_COUNT,
       sum(CALL_WRAP_UP_COUNT) over (partition by a10.supervisor_staff_id,to_char(TRUNC(a11.CALL_DATE), 'Month YYYY')) as TOT_CALL_WRAP_UP_COUNT
    FROM DP_SCORECARD.SCORECARD_HIERARCHY_SV a10
  join DP_SCORECARD.SC_NON_STD_USE_SV a11 on to_char(a10.staff_natid) = a11.Employee_ID
  WHERE not exists (select 1 from sc_exclusion_yes_sv b where a11.Employee_ID = b.agent_id and trunc(a11.CALL_DATE) = trunc(b.exclusion_date))
        and TRUNC(a11.CALL_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
 ),
 WUE_metrics AS
 (
   SELECT distinct
       to_char(TRUNC(a11.WUE_DATE), 'YYYYMM') as dates_month_num,
       to_char(TRUNC(a11.WUE_DATE), 'Month YYYY') as dates_year,
        a10.supervisor_staff_id,
        sum(a11.WRAP_UP_ERROR) over (partition by a10.supervisor_staff_id,to_char(TRUNC(a11.WUE_DATE), 'Month YYYY')) as TOT_WRAP_UP_ERROR
   FROM DP_SCORECARD.SCORECARD_HIERARCHY_SV a10
  join DP_SCORECARD.SC_WRAP_UP_ERROR_SV a11 on a10.staff_natid = a11.AGENT_ID
  WHERE not exists (select 1 from sc_exclusion_yes_sv b where a11.agent_id = b.agent_id and trunc(a11.WUE_DATE) = trunc(b.exclusion_date))
        and TRUNC(a11.WUE_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
 ),
CALL_metrics AS
 (
  SELECT
        a10.supervisor_staff_id,
       a11.AS_DATE,
        a11.EXCLUSION_FLAG,
        CASE WHEN sum(a11.SHORT_CALLS_ANSWERED) > 10 THEN 1 ELSE null END short_calls,
        sum(a11.CALLS_ANSWERED) TOT_CALLS,
       to_char(TRUNC(a11.AS_DATE), 'YYYYMM') as dates_month_num,
       to_char(TRUNC(a11.AS_DATE), 'Month YYYY') as dates_year
   FROM DP_SCORECARD.SCORECARD_HIERARCHY_SV a10
  join DP_SCORECARD.SC_AGENT_STAT_SV a11 on a10.staff_natid = a11.AGENT_ID
  WHERE not exists (select 1 from sc_exclusion_yes_sv b where a11.agent_id = b.agent_id and trunc(a11.as_date) = trunc(b.exclusion_date))
        and TRUNC(a11.AS_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
   GROUP BY a10.supervisor_staff_id, a11.AS_DATE, a11.EXCLUSION_FLAG
 ),
 CALL_days AS
 (
   SELECT distinct
        supervisor_staff_id,
        dates_month_num,
        dates_year,
        EXCLUSION_FLAG,
        count(short_calls)  over (partition by supervisor_staff_id,dates_month_num, EXCLUSION_FLAG) as Days_Short_Calls_GT_10,
         count(TOT_CALLS)  over (partition by supervisor_staff_id,dates_month_num, EXCLUSION_FLAG) as DAYS_CALLS_ANSWERED
   FROM CALL_metrics
  ),
  Adherence as
 (
   SELECT distinct
      dates_month_num,
      dates_year,
       supervisor_staff_id,
       EXCLUSION_FLAG,
       SUM(TOT_LOGGED_IN_TIME) as TOT_LOGGED_IN_TIME,
       SUM(TOT_NOT_READY_TIME) as TOT_NOT_READY_TIME
       from
       (
   SELECT distinct
      to_char(TRUNC(a11.AS_DATE), 'YYYYMM') as dates_month_num,
      to_char(TRUNC(a11.AS_DATE), 'Month YYYY') as dates_year,
      to_char(a11.AGENT_ID) AGENT_ID,
      a_s.staff_staff_id,
      a_s.supervisor_staff_id,
       a11.EXCLUSION_FLAG,
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
        where not exists (select 1 from sc_exclusion_yes_sv b where a11.agent_id = b.agent_id and trunc(a11.as_date) = trunc(b.exclusion_date))
        and TRUNC(a11.AS_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')  /*and a11.EXCLUSION_FLAG='N'*/
    group by to_char(TRUNC(a11.AS_DATE), 'YYYYMM'), to_char(TRUNC(a11.AS_DATE), 'Month YYYY'),a_s.staff_staff_id, a11.AGENT_ID, a_s.supervisor_staff_id, a11.EXCLUSION_FLAG
    )
    group by dates_month_num,
      dates_year,
       supervisor_staff_id,
       EXCLUSION_FLAG
 ),
Adherence_metric as
 (

   SELECT distinct
      a10.dates_month_num,
      a10.dates_year,
      a10.supervisor_staff_id,
      ((a10.TOT_LOGGED_IN_TIME - a10.TOT_NOT_READY_TIME)/a11.LAG_TIME_TOT_SCHED_PROD_TIME) as ADHERENCE
      FROM Adherence a10
      join LAG_metrics a11 on a10.supervisor_staff_id=a11.supervisor_staff_id and a10.dates_year=a11.dates_year

 )

 SELECT
   distinct all_staff.supervisor_staff_id,
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
   cd.DAYS_CALLS_ANSWERED,
   a.ADHERENCE,
   a.balance,
   a.total_balance,
   a.staff_count
 FROM (select distinct supervisor_staff_id,
         dates_month,
         dates_month_num,
         dates_year from dp_scorecard.scorecard_attendance_mthly_sv
         ) all_staff
 left outer join attendance a on all_staff.supervisor_staff_id = a.supervisor_staff_id and all_staff.dates_month_num=a.dates_month_num
 left outer join TIME_metrics tm on all_staff.supervisor_staff_id = tm.supervisor_staff_id and all_staff.dates_month_num=tm.dates_month_num
 left outer join QC_metrics qc on all_staff.supervisor_staff_id = qc.supervisor_staff_id and all_staff.dates_month_num=qc.dates_month_num
 left outer join INC_metrics im on all_staff.supervisor_staff_id = im.supervisor_staff_id and all_staff.dates_month_num=im.dates_month_num
 left outer join DEF_metrics dm on all_staff.supervisor_staff_id = dm.supervisor_staff_id and all_staff.dates_month_num=dm.dates_month_num
 left outer join LAG_metrics lt on all_staff.supervisor_staff_id = lt.supervisor_staff_id and all_staff.dates_month_num=lt.dates_month_num
 left outer join CUST_metrics cm on all_staff.supervisor_staff_id = cm.supervisor_staff_id and all_staff.dates_month_num=cm.dates_month_num
left outer join WUE_metrics wm on all_staff.supervisor_staff_id = wm.supervisor_staff_id and all_staff.dates_month_num=wm.dates_month_num
left outer join CALL_days cd on all_staff.supervisor_staff_id = cd.supervisor_staff_id and all_staff.dates_month_num=cd.dates_month_num
left outer join Adherence_metric a on all_staff.supervisor_staff_id = a.supervisor_staff_id and all_staff.dates_month_num=a.dates_month_num;


commit;
end LOAD_SC_SUMMARY_CC_ROLLUP;
/

grant execute on LOAD_SC_SUMMARY_CC_ROLLUP to MAXDAT;
grant execute on LOAD_SC_SUMMARY_CC_ROLLUP to MAXDAT_READ_ONLY;


BEGIN
  dp_scorecard.LOAD_SC_SUMMARY_CC_ROLLUP;
END;
/
