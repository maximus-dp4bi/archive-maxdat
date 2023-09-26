alter table dp_scorecard.sc_summary_cc
ADD
(
corrective_action_flag   NUMBER,
one_on_one_flag          NUMBER,
observation_flag         NUMBER
);

commit;


create or replace view dp_scorecard.scorecard_summary_cc_sv as
WITH ATTEND_Metrics AS
  (
   select a.staff_staff_id,
          a.staff_staff_name,
          h.staff_natid,
          a.dates_month,
          a.dates_month_num,
          a.dates_year,
          a.balance,
          a.total_balance,
          a.sc_attendance_id
     from dp_scorecard.scorecard_attendance_mthly_sv a
     join dp_scorecard.scorecard_hierarchy_sv h on a.staff_staff_id=h.staff_staff_id
  )
 select distinct a11.staff_staff_id,
        a11.staff_staff_name,
        a11.staff_natid,
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
        a10.adherence,
        COALESCE(corrective_action_flag,0) as corrective_action_flag ,
        COALESCE(one_on_one_flag,0) as one_on_one_flag,
        COALESCE(observation_flag,0) as observation_flag 
        from ATTEND_Metrics a11
   LEFT OUTER JOIN dp_scorecard.sc_summary_cc a10 ON a11.staff_staff_id=a10.staff_staff_id
   and  a11.dates_month_num=a10.dates_month_num ;

grant select on dp_scorecard.scorecard_summary_cc_sv to maxdat;
grant select on dp_scorecard.scorecard_summary_cc_sv to maxdat_read_only;

   
create or replace procedure dp_scorecard.LOAD_SC_SUMMARY_CC
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
         dates_year from dp_scorecard.scorecard_attendance_mthly_sv
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
end LOAD_SC_SUMMARY_CC;
/

grant execute on LOAD_SC_SUMMARY_CC to maxdat;
grant execute on LOAD_SC_SUMMARY_CC to maxdat_read_only;

/*
begin
  dp_scorecard.LOAD_SC_SUMMARY_CC;
end;
*/
