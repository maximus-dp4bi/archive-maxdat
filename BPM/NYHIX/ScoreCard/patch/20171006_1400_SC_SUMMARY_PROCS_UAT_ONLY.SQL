CREATE OR REPLACE procedure DP_SCORECARD.LOAD_SC_SUMMARY_CC_v1x
AS

begin

    Delete from SC_SUMMARY_CC_v1;
    commit;

insert into SC_SUMMARY_CC_v1 (staff_staff_id,
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
   observation_flag
   )

WITH TIME_metrics as
 (
   SELECT
      distinct
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
        where not exists (select 1 from sc_exclusion_yes_sv b where a11.agent_id = b.agent_id and a11.as_date = b.exclusion_date)
        and TRUNC(a11.AS_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
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
   WHERE not exists (select 1 from sc_exclusion_yes_sv b where a11.staff_id = b.staff_id and trunc(a11.task_start) = trunc(b.exclusion_date))
        and TRUNC(a11.task_start) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
  and (a11.EVENT_ID in (1374, 1375, 1376, 1377, 1378, 1379)
         or a11.EVENT_ID in (1373))
         and a11.TASK_END is not null and trunc(a11.TASK_START)=trunc(a11.TASK_END)
   group by a11.staff_id, trunc(TASK_START)
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
  WHERE not exists (select 1 from sc_exclusion_yes_sv b where a11.agent_id = b.agent_id and trunc(a11.LAG_DATE) = trunc(b.exclusion_date))
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
  WHERE not exists (select 1 from sc_exclusion_yes_sv b where a11.Employee_ID = b.agent_id and trunc(a11.CALL_DATE) = trunc(b.exclusion_date))
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
  WHERE not exists (select 1 from sc_exclusion_yes_sv b where a11.agent_id = b.agent_id and trunc(a11.WUE_DATE) = trunc(b.exclusion_date))
        and TRUNC(a11.WUE_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
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
  WHERE not exists (select 1 from sc_exclusion_yes_sv b where a11.agent_id = b.agent_id and trunc(a11.as_date) = trunc(b.exclusion_date))
        and TRUNC(a11.AS_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
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
  ),
 Adherence as
 (
   SELECT distinct
      to_char(TRUNC(a11.AS_DATE), 'YYYYMM') as dates_month_num,
      to_char(TRUNC(a11.AS_DATE), 'Month YYYY') as dates_year,
      to_char(a11.AGENT_ID) AGENT_ID,
      a_s.staff_staff_id,
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
    group by to_char(TRUNC(a11.AS_DATE), 'YYYYMM'), to_char(TRUNC(a11.AS_DATE), 'Month YYYY'),a_s.staff_staff_id, a11.AGENT_ID, a11.EXCLUSION_FLAG
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
   cd.DAYS_CALLS_ANSWERED,
   a.ADHERENCE,
   ca.corrective_action_flag,
   ooo.one_on_one_flag,
   o.observation_flag
 FROM (select distinct staff_staff_id,
         staff_staff_name,
         dates_month,
         dates_month_num,
         dates_year from dp_scorecard.scorecard_staff_monthly_sv
         ) all_staff
 left outer join TIME_metrics tm on all_staff.staff_staff_id = tm.staff_staff_id and all_staff.dates_month_num=tm.dates_month_num
 left outer join QC_metrics qc on all_staff.staff_staff_id = qc.staff_staff_id and all_staff.dates_month_num=qc.dates_month_num
 left outer join INC_metrics im on all_staff.staff_staff_id = im.staff_staff_id and all_staff.dates_month_num=im.dates_month_num
 left outer join DEF_metrics dm on all_staff.staff_staff_id = dm.staff_staff_id and all_staff.dates_month_num=dm.dates_month_num
 left outer join LAG_metrics lt on all_staff.staff_staff_id = lt.staff_staff_id and all_staff.dates_month_num=lt.dates_month_num
 left outer join CUST_metrics cm on all_staff.staff_staff_id = cm.staff_staff_id and all_staff.dates_month_num=cm.dates_month_num
left outer join WUE_metrics wm on all_staff.staff_staff_id = wm.staff_staff_id and all_staff.dates_month_num=wm.dates_month_num
left outer join CALL_days cd on all_staff.staff_staff_id = cd.staff_staff_id and all_staff.dates_month_num=cd.dates_month_num
left outer join Adherence_metric a on all_staff.staff_staff_id = a.staff_staff_id and all_staff.dates_month_num=a.dates_month_num
left outer join Corr_Action ca on all_staff.staff_staff_id = ca.staff_staff_id and all_staff.dates_month_num=ca.dates_month_num
left outer join One_on_one ooo on all_staff.staff_staff_id = ooo.staff_staff_id and all_staff.dates_month_num=ooo.dates_month_num
left outer join Observation o on all_staff.staff_staff_id = o.staff_staff_id and all_staff.dates_month_num=o.dates_month_num;


commit;

end LOAD_SC_SUMMARY_CC_v1x;
/

grant execute on dp_scorecard.LOAD_SC_SUMMARY_CC_v1x to maxdat;

grant execute on dp_scorecard.LOAD_SC_SUMMARY_CC_v1x to maxdat_read_only;

grant execute on dp_scorecard.LOAD_SC_SUMMARY_CC_v1x to dp_scorecard_read_only;

---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------

CREATE OR REPLACE procedure DP_SCORECARD.LOAD_SC_SUMMARY_CC_ROLLUP_V1X
AS

begin

    Delete from dp_scorecard.SC_SUMMARY_CC_ROLLUP_V1;
    commit;

insert into dp_scorecard.SC_SUMMARY_CC_ROLLUP_V1 (supervisor_staff_id,
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
   staff_count,
   qcs_remaining,
   sum_qc_score,
   count_qc_score,
   TOT_HANDLE_TIME,
   TOT_HANDLE_TIME_COUNT,
   STAFF_TRTQ_COUNT,
   Short_Call_Agent_Count
   )

WITH attendance as
(
/*select distinct a.SUPERVISOR_STAFF_ID,
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
 order by supervisor_staff_id, dates_month_num*/

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
where a.DATES_MONTH_NUM >= to_char(h.hire_date,'YYYYMM')
AND (a.DATES_MONTH_NUM <= to_char(h.termination_date,'YYYYMM')
OR H.TERMINATION_DATE IS NULL)
ORDER BY SUPERVISOR_STAFF_ID, DATES_MONTH_NUM


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
         extract( second from NUMTODSINTERVAL (((to_date(LUNCH_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second')) ) TOT_LUNCH_TIME,
       sum(extract( day from NUMTODSINTERVAL (((to_date(AVERAGE_HANDLE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*24*60*60 +
         extract( hour from NUMTODSINTERVAL (((to_date(AVERAGE_HANDLE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60*60 +
         extract( minute from NUMTODSINTERVAL (((to_date(AVERAGE_HANDLE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60 +
         extract( second from NUMTODSINTERVAL (((to_date(AVERAGE_HANDLE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second')) ) TOT_HANDLE_TIME,
         count(1) as TOT_HANDLE_TIME_COUNT
         FROM dp_scorecard.scorecard_hierarchy_sv a_s
        join DP_SCORECARD.SC_AGENT_STAT_SV a11 on a_s.staff_natid =  a11.AGENT_ID
        Where TRUNC(a11.AS_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
    group by to_char(TRUNC(a11.AS_DATE), 'YYYYMM'), to_char(TRUNC(a11.AS_DATE), 'Month YYYY'),a_s.supervisor_staff_id, EXCLUSION_FLAG
 ),
 QC_metrics AS
 (
 select distinct supervisor_staff_id,
           dates_month_num,
           dates_year,
           avg_qc_score,
           qcs_performed,
           qcs_remaining,
           sum_qc_score,
           count_qc_score
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
   WHERE TRUNC(a11.task_start) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
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
  WHERE TRUNC(a11.LAG_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
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
  WHERE TRUNC(a11.CALL_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
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
  WHERE TRUNC(a11.WUE_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
 ),
CALL_metrics AS
 (
 SELECT
        a10.supervisor_staff_id,
       dates_month_num,
       dates_year,
        sum(short_calls) as short_calls
       -- sum(TOT_CALLS) TOT_CALLS
   FROM DP_SCORECARD.SCORECARD_HIERARCHY_SV a10
  join
  (
  SELECT
       a20.staff_staff_id,
       a21.AS_DATE,
        CASE WHEN sum(a21.SHORT_CALLS_ANSWERED) > 10 THEN 1 ELSE null END short_calls,
     --   sum(a21.CALLS_ANSWERED) TOT_CALLS,
       to_char(TRUNC(a21.AS_DATE), 'YYYYMM') as dates_month_num,
       to_char(TRUNC(a21.AS_DATE), 'Month YYYY') as dates_year
   FROM DP_SCORECARD.SCORECARD_HIERARCHY_SV a20
  join DP_SCORECARD.SC_AGENT_STAT_SV a21 on a20.staff_natid = a21.AGENT_ID
  WHERE TRUNC(a21.AS_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
   GROUP BY a20.staff_staff_id, a21.AS_DATE
  ) a11 on a10.staff_staff_id = a11.staff_staff_id
   GROUP BY a10.supervisor_staff_id, dates_month_num, dates_year

 ),
 CALL_days AS
 (
   SELECT distinct
        supervisor_staff_id,
        dates_month_num,
        dates_year,
         short_calls as Days_Short_Calls_GT_10
       --  TOT_CALLS as DAYS_CALLS_ANSWERED
   FROM CALL_metrics
  ),
--Unique Days Called
Unique_Calls_Metrics AS
 (
 SELECT
   distinct a11.supervisor_staff_id,
   dates_month_num,
   dates_year,
   count(Unique_Days) as DAYS_CALLS_ANSWERED
    from
    (
     SELECT
               distinct a20.supervisor_staff_id,--a20.staff_staff_id,
               to_char(TRUNC(a21.AS_DATE), 'YYYYMM') as dates_month_num,
               to_char(TRUNC(a21.AS_DATE), 'Month YYYY') as dates_year,
               TRUNC(a21.AS_DATE) as Unique_Days
           FROM DP_SCORECARD.SCORECARD_HIERARCHY_SV a20
          join DP_SCORECARD.SC_AGENT_STAT_SV a21 on a20.staff_natid = a21.AGENT_ID
          WHERE TRUNC(a21.AS_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
          --order by a20.supervisor_staff_id, TRUNC(a21.AS_DATE)
    ) a11
   GROUP BY a11.supervisor_staff_id, dates_month_num, dates_year
   --ORDER BY a11.supervisor_staff_id, dates_month_num

 ),

----
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
        where TRUNC(a11.AS_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')  /*and a11.EXCLUSION_FLAG='N'*/
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

 ),
TRTQ_Agent_Count as
(
--Description: Identifies the amount of agents that had more than 50 Total Return to Queue's per month
  select a10.supervisor_staff_id,
      dates_month_num,
      dates_year,
      sum(TRTQ) as TRTQ,
      sum(STAFF_TRTQ_COUNT) as STAFF_TRTQ_COUNT
      FROM DP_SCORECARD.SCORECARD_HIERARCHY_SV a10
      join
      (
          SELECT
          H.staff_staff_id,
          to_char(TRUNC(AS_DATE), 'YYYYMM') as dates_month_num,
          to_char(TRUNC(AS_DATE), 'Month YYYY') as dates_year,
          SUM(TOT_RET_TO_QUEUE_TOTAL) TRTQ,
          CASE WHEN SUM(TOT_RET_TO_QUEUE_TOTAL) > 50 THEN '1' ELSE '0' END AS STAFF_TRTQ_COUNT
          FROM DP_SCORECARD.SC_AGENT_STAT_SV S
          JOIN DP_SCORECARD.SCORECARD_HIERARCHY H ON H.STAFF_NATID = S.AGENT_ID
          where TRUNC(AS_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
          GROUP BY to_char(TRUNC(AS_DATE), 'YYYYMM'), to_char(TRUNC(AS_DATE), 'Month YYYY'), H.staff_staff_id
      ) a11 on a10.staff_staff_id = a11.staff_staff_id
     GROUP BY a10.supervisor_staff_id, dates_month_num, dates_year
),
Short_Call_Agent_Count as
(
--Description: Identifies the distinct amount of agents that had a day with over 10 short calls.
select distinct
supervisor_staff_id,
dates_month_num,
dates_year,
COUNT(DISTINCT AGENT_ID) over (partition by supervisor_staff_id, dates_month_num) as Short_Call_Agent_Count
FROM
  (
      select
       H.supervisor_staff_id,
       agent_id,
       to_char(TRUNC(AS_DATE), 'YYYYMM') as dates_month_num,
       to_char(TRUNC(AS_DATE), 'Month YYYY') as dates_year,
       TRUNC(AS_DATE),
       SHORT_CALLS_ANSWERED
        from DP_SCORECARD.SC_AGENT_STAT S
        JOIN DP_SCORECARD.SCORECARD_HIERARCHY H ON H.STAFF_NATID = S.AGENT_ID
       where TRUNC(AS_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
       and SHORT_CALLS_ANSWERED > 10
       --order by H.supervisor_staff_id,to_char(TRUNC(AS_DATE), 'YYYYMM')
  )
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
   ucm.DAYS_CALLS_ANSWERED,
   a.ADHERENCE,
   a.balance,
   a.total_balance,
   a.staff_count,
   qc.qcs_remaining,
   qc.sum_qc_score,
   qc.count_qc_score,
   tm.TOT_HANDLE_TIME,
   tm.TOT_HANDLE_TIME_COUNT,
   tac.STAFF_TRTQ_COUNT,
   scac.Short_Call_Agent_Count
 FROM (select distinct supervisor_staff_id,
         dates_month,
         dates_month_num,
         dates_year from dp_scorecard.scorecard_STAFF_MONTHLY_sv
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
left outer join Adherence_metric a on all_staff.supervisor_staff_id = a.supervisor_staff_id and all_staff.dates_month_num=a.dates_month_num
left outer join Unique_Calls_Metrics ucm on all_staff.supervisor_staff_id = ucm.supervisor_staff_id and all_staff.dates_month_num=ucm.dates_month_num
left outer join TRTQ_Agent_Count tac on all_staff.supervisor_staff_id = tac.supervisor_staff_id and all_staff.dates_month_num=tac.dates_month_num
left outer join Short_Call_Agent_Count scac  on all_staff.supervisor_staff_id = scac.supervisor_staff_id and all_staff.dates_month_num=scac.dates_month_num;
/*where all_staff.supervisor_staff_id in (select distinct supervisor_staff_id from dp_scorecard.scorecard_hierarchy_sv where manager_staff_id=1378);*/

commit;
END LOAD_SC_SUMMARY_CC_ROLLUP_V1X;
/

grant execute on dp_scorecard.LOAD_SC_SUMMARY_CC_ROLLUP_V1X to maxdat;

grant execute on dp_scorecard.LOAD_SC_SUMMARY_CC_ROLLUP_V1X to maxdat_read_only;

grant execute on dp_scorecard.LOAD_SC_SUMMARY_CC_ROLLUP_V1X to dp_scorecard_read_only;

----------------------------------------------------------------------
----------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE DP_SCORECARD.LOAD_SC_SUMMARY_CC_ROLLUP
AS
-- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
 	SVN_FILE_URL varchar2(200) := '$URL: svn://rcmxapp1d.maximus.com/maxdat/BPM/NYHIX/patch/20170623_PP_WFM_BACK_OFFICE_LOAD_PKG.sql $';
  	SVN_REVISION varchar2(20) := '$Revision: 20489 $';
 	SVN_REVISION_DATE varchar2(60) := '$Date: 2017-07-03 14:31:06 -0500 (Mon, 03 Jul 2017) $';
  	SVN_REVISION_AUTHOR varchar2(20) := '$Author: wl134672 $';


begin

  execute immediate 'TRUNCATE TABLE DP_SCORECARD.SC_SUMMARY_CC_ROLLUP';
    --Delete from DP_SCORECARD.SC_SUMMARY_CC_ROLLUP;
    --commit;

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
SELECT
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
	SUM(NVL(DAYS_DEFECTS_COMPLETED,0)) 						AS 	DAYS_DEFECTS_COMPLETED,
	SUM(NVL(LAG_TIME_TOT_SCHED_PROD_TIME,0))				AS 	LAG_TIME_TOT_SCHED_PROD_TIME,
	SUM(NVL(TOT_CALL_RECORDS,0)) 							AS 	TOT_CALL_RECORDS,
	SUM(NVL(TOT_CUSTOMER_COUNT,0)) 							AS 	TOT_CUSTOMER_COUNT,
	SUM(NVL(TOT_CALL_WRAP_UP_COUNT,0)) 						AS 	TOT_CALL_WRAP_UP_COUNT,
	SUM(NVL(TOT_WRAP_UP_ERROR,0)) 							AS 	TOT_WRAP_UP_ERROR,
	SUM(NVL(DAYS_SHORT_CALLS_GT_10,0)) 						AS 	DAYS_SHORT_CALLS_GT_10,
	SUM(NVL(DAYS_CALLS_ANSWERED,0)) 						AS 	DAYS_CALLS_ANSWERED,
    SUM(TOT_LOGGED_IN_TIME - TOT_NOT_READY_TIME)/SUM(LAG_TIME_TOT_SCHED_PROD_TIME)          AS ADHERENCE,
    SUM(NVL(TOT_RETURN_TO_QUEUE_TIMEOUT,0)) 				AS 	TOT_RETURN_TO_QUEUE_TIMEOUT,
	SUM(NVL(AVG_ATTENDANCE_BALANCE,0)) 						AS 	AVG_ATTENDANCE_BALANCE,
	SUM(NVL(AVG_ATTENDANCE_TOTAL_BALANCE,0))				AS 	AVG_ATTENDANCE_TOTAL_BALANCE,
	SUM(NVL(STAFF_COUNT,0)) 								AS 	STAFF_COUNT,
	SUM(NVL(SUM_QC_SCORE,0)) 								AS 	SUM_QC_SCORE,
	SUM(NVL(COUNT_QC_SCORE,0)) 								AS 	COUNT_QC_SCORE,
	SUM(10-COUNT_QC_SCORE)									AS 	QCS_REMAINING,
	SUM(NVL(TOT_HANDLE_TIME,0)) 							AS 	TOT_HANDLE_TIME,
	SUM(NVL(TOT_HANDLE_TIME_COUNT,0)) 						AS 	TOT_HANDLE_TIME_COUNT,
	SUM(NVL(TRTQ,0))               							AS  STAFF_TRTQ_COUNT ,
	SUM(NVL(SHORT_CALL_AGENT_COUNT,0))						AS 	SHORT_CALL_AGENT_COUNT
FROM DP_SCORECARD.SC_SUMMARY_CC
GROUP BY
	SUPERVISOR_STAFF_ID,
	DATES_MONTH,
	DATES_MONTH_NUM,
	DATES_YEAR,
	EXCLUSION_FLAG,
	BUILDING,
	DEPARTMENT;

COMMIT;

end LOAD_SC_SUMMARY_CC_ROLLUP;
/


grant execute on dp_scorecard.LOAD_SC_SUMMARY_CC_ROLLUP to maxdat;

grant execute on dp_scorecard.LOAD_SC_SUMMARY_CC_ROLLUP to maxdat_read_only;

grant execute on dp_scorecard.LOAD_SC_SUMMARY_CC_ROLLUP to dp_scorecard_read_only;

----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------

create or replace procedure              LOAD_SC_SUMMARY_CC_v2
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
   Mer_Flag,
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
       SUM(TOT_RET_TO_QUEUE_TOTAL) TRTQ
		 --------------------------
         FROM dp_scorecard.scorecard_hierarchy_sv a_s
        join DP_SCORECARD.SC_AGENT_STAT_SV a11 on a_s.staff_natid =  a11.AGENT_ID
        where not exists (select 1 from dp_scorecard.sc_exclusion_yes_sv b where a11.agent_id = b.agent_id and a11.as_date = b.exclusion_date)
        and TRUNC(a11.AS_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
    group by to_char(TRUNC(a11.AS_DATE), 'YYYYMM'), to_char(TRUNC(a11.AS_DATE), 'Month YYYY'),a_s.staff_staff_id, AGENT_ID, NVL(EXCLUSION_FLAG,'N')
 ),
  SHORT_CALL_AGENT_COUNT AS
 (
	--Description: Identifies the distinct amount of agents that had a day with over 10 short calls.
	SELECT DISTINCT
		STAFF_STAFF_ID,
		DATES_MONTH_NUM,
		DATES_YEAR,
		COUNT(DISTINCT AGENT_ID) OVER (PARTITION BY STAFF_STAFF_ID, DATES_MONTH_NUM) AS SHORT_CALL_AGENT_COUNT
	FROM
	(
      SELECT
       H.STAFF_STAFF_ID,
       AGENT_ID,
       TO_CHAR(TRUNC(AS_DATE), 'YYYYMM') AS DATES_MONTH_NUM,
       TO_CHAR(TRUNC(AS_DATE), 'MONTH YYYY') AS DATES_YEAR,
       TRUNC(AS_DATE),
       SHORT_CALLS_ANSWERED
        FROM DP_SCORECARD.SC_AGENT_STAT S
        JOIN DP_SCORECARD.SCORECARD_HIERARCHY H ON H.STAFF_NATID = S.AGENT_ID
       WHERE TRUNC(AS_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
       AND SHORT_CALLS_ANSWERED > 10
  )
),QC_metrics AS
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
  PERMFORM_TKR as
 (
   select distinct staff_staff_id,
                  to_char(TRUNC(pt_entry_date), 'YYYYMM') as dates_month_num,
                  to_char(TRUNC(pt_entry_date), 'Month YYYY') as dates_year,
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
   group by staff_staff_id,
            to_char(TRUNC(pt_entry_date),'YYYYMM'),
            to_char(TRUNC(pt_entry_date), 'Month YYYY')
  ),
-- Corr_Action as
-- (
--   select distinct staff_staff_id,
--                  to_char(TRUNC(pt_entry_date), 'YYYYMM') as dates_month_num,
--                  to_char(TRUNC(pt_entry_date), 'Month YYYY') as dates_year,
--                  1 as corrective_action_flag
--    from dp_scorecard.scorecard_perform_tracker_sv
--   where DL_ID in (select dl_id
--                     from dp_scorecard.scorecard_discussion_lkup_sv
--                    where discussion_topic = 'Corrective Action')
-- ),
-- One_on_one as
-- (
--   select distinct staff_staff_id,
--                  to_char(TRUNC(pt_entry_date), 'YYYYMM') as dates_month_num,
--                  to_char(TRUNC(pt_entry_date), 'Month YYYY') as dates_year,
--                  1 as one_on_one_flag
--    from dp_scorecard.scorecard_perform_tracker_sv
--   where DL_ID in (select dl_id
--                     from dp_scorecard.scorecard_discussion_lkup_sv
--                    where discussion_topic = 'One on One')
-- ),
-- Observation as
-- (
--   select distinct staff_staff_id,
--                  to_char(TRUNC(pt_entry_date), 'YYYYMM') as dates_month_num,
--                  to_char(TRUNC(pt_entry_date), 'Month YYYY') as dates_year,
--                  1 as observation_flag
--    from dp_scorecard.scorecard_perform_tracker_sv
--   where DL_ID in (select dl_id
--                     from dp_scorecard.scorecard_discussion_lkup_sv
--                    where discussion_topic = 'Observation')
-- ),
 MER as
  (
    select distinct staff_staff_id,
                   to_char(TRUNC(pt_entry_date), 'YYYYMM') as dates_month_num,
                   to_char(TRUNC(pt_entry_date), 'Month YYYY') as dates_year,
                   1 as mer_flag
     from dp_scorecard.scorecard_perform_tracker_sv
    where DL_ID in (select dl_id
                      from dp_scorecard.scorecard_discussion_lkup_sv
                     where discussion_topic = 'MER')
  ),
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
   PERMFORM_TKR.corrective_action_flag,
   PERMFORM_TKR.one_on_one_flag,
   PERMFORM_TKR.observation_flag,
   Recorded_Call_Review_flag,
   Live_Phone_Observation_flag,
   mer.mer_flag,
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
         WHERE DATES_MONTH_NUM >= TO_CHAR(SYSDATE,'YYYYMM')
         ) all_staff
LEFT OUTER JOIN MER on all_staff.staff_staff_id = MER.staff_staff_id   and all_staff.dates_month_num=MER.dates_month_num
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
LEFT OUTER JOIN QC_metrics on all_staff.staff_staff_id = QC_metrics.staff_staff_id and all_staff.dates_month_num=QC_metrics.dates_month_num
LEFT OUTER JOIN TIME_metrics on all_staff.staff_staff_id = TIME_metrics.staff_staff_id and all_staff.dates_month_num=TIME_metrics.dates_month_num
LEFT OUTER JOIN SCORECARD_QUALITY ON ALL_Staff.staff_staff_id = SCORECARD_QUALITY.STAFF_STAFF_ID AND all_staff.dates_month_num=SCORECARD_QUALITY.dates_month_num
LEFT OUTER JOIN ATTENDANCE on all_staff.staff_staff_id = ATTENDANCE.staff_staff_id and all_staff.dates_month_num=ATTENDANCE.dates_month_num
LEFT OUTER JOIN SHORT_CALL_AGENT_COUNT on all_staff.staff_staff_id = SHORT_CALL_AGENT_COUNT.staff_staff_id and all_staff.dates_month_num=SHORT_CALL_AGENT_COUNT.dates_month_num
;

COMMIT;

end LOAD_SC_SUMMARY_CC_v2;
/


grant execute on dp_scorecard.LOAD_SC_SUMMARY_CC_v2 to maxdat;

grant execute on dp_scorecard.LOAD_SC_SUMMARY_CC_v2 to maxdat_read_only;

grant execute on dp_scorecard.LOAD_SC_SUMMARY_CC_v2 to dp_scorecard_read_only;

