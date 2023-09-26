CREATE OR REPLACE FORCE VIEW DP_SCORECARD.SCORECARD_QUALITY_MTHLY_RUSVXX
(SUPERVISOR_STAFF_ID, DATES_MONTH_NUM, DATES_YEAR, AVG_QC_SCORE, QCS_PERFORMED, 
 QCS_REMAINING, SUM_QC_SCORE, COUNT_QC_SCORE, AUDITS, AUDITS_SUP_EVALED, 
 QC_SCORE, SUP_SCORE, DEVIATION_SCORE, QC_EVALS, QC_EVALS_SCORE, 
 DISPUTES, NON_DISPUTE_SCORE)
AS 
with just_months as
(
      SELECT
      to_char(add_months (TRUNC (ADD_MONTHS (SYSDATE, -11), 'MM'), 1*Level -1), 'MM/DD/YYYY') as dates,
      to_char(add_months (TRUNC (ADD_MONTHS (SYSDATE, -11), 'MM'), 1*Level -1), 'Month') as dates_month,
      to_char(add_months (TRUNC (ADD_MONTHS (SYSDATE, -11), 'MM'), 1*Level -1), 'YYYYMM') as dates_month_num,
      to_char(add_months (TRUNC (ADD_MONTHS (SYSDATE, -11), 'MM'), 1*Level -1), 'Month YYYY') as dates_year,
      0 as avg_qc_score,
      0  as qcs_performed,
      0 as qcs_remaining,
      0 as sum_qc_score,
      0 as count_qc_score
    FROM Dual
    CONNECT BY Level <= MONTHS_BETWEEN(trunc(SYSDATE), TRUNC (ADD_MONTHS (SYSDATE, -11), 'MM')) + 1
),
quality_by_month as
(
SELECT distinct h.supervisor_staff_id, --staff_staff_id, 
       dates_month_num,
       dates_year,
       avg(avg_qc_score) over (partition by h.supervisor_staff_id , dates_month_num) as avg_qc_score,
       sum(qcs_performed) over (partition by h.supervisor_staff_id , dates_month_num) as qcs_performed,
       sum(qcs_remaining) over (partition by h.supervisor_staff_id , dates_month_num) as qcs_remaining,
       sum(sum_qc_score) over (partition by h.supervisor_staff_id , dates_month_num) as sum_qc_score,
       sum(count_qc_score) over (partition by h.supervisor_staff_id , dates_month_num) as count_qc_score
  from
  (
  SELECT distinct SV.staff_staff_id,
       SV.staff_staff_name,
       SV.staff_natid,
       to_char(TRUNC(EVAL_DATE), 'YYYYMM') as dates_month_num,
       to_char(TRUNC(EVAL_DATE), 'Month YYYY') as dates_year,
       avg(SCORE_TOTAL) over (partition by SV.staff_staff_id ,to_char(TRUNC(EVAL_DATE), 'YYYYMM')) as avg_qc_score,
       sum(SCORE_TOTAL) over (partition by SV.staff_staff_id ,to_char(TRUNC(EVAL_DATE), 'YYYYMM')) as sum_qc_score,
       count(*) over (partition by SV.staff_staff_id ,to_char(TRUNC(EVAL_DATE), 'YYYYMM')) as count_qc_score,
       count(*) over (partition by SV.staff_staff_id ,to_char(TRUNC(EVAL_DATE), 'YYYYMM')) as qcs_performed,
       case
         when count(*) over (partition by SV.staff_staff_id ,to_char(TRUNC(EVAL_DATE), 'YYYYMM')) >= 10 then 0
           else 10 - count(*) over (partition by SV.staff_staff_id ,to_char(TRUNC(EVAL_DATE), 'YYYYMM'))
       end as qcs_remaining
  from dp_scorecard.SCORECARD_QUALITY_SV SV
  join dp_scorecard.scorecard_hierarchy_sv h on SV.staff_staff_id=h.staff_staff_id
  WHERE TRUNC(EVAL_DATE) BETWEEN H.HIRE_DATE AND NVL(TERMINATION_DATE,SYSDATE)
  ) q
  join dp_scorecard.scorecard_hierarchy_sv h on q.staff_staff_id=h.staff_staff_id
),
combined as
(
  select r.supervisor_staff_id, --STAFF_STAFF_ID,
         r.dates_month_num,
         r.dates_year,
         r.avg_qc_score,
         r.qcs_performed,
         r.qcs_remaining,
         r.sum_qc_score,
         r.count_qc_score
         from quality_by_month r
  union
  select r.supervisor_staff_id, --STAFF_STAFF_ID,
         jm.dates_month_num,
         jm.dates_year,
         jm.avg_qc_score,
         jm.qcs_performed,
         jm.qcs_remaining,
         jm.sum_qc_score,
         jm.count_qc_score
       from quality_by_month r, just_months jm
),
ranked as
(
select   supervisor_staff_id, --STAFF_STAFF_ID,
         dates_month_num,
         dates_year,
         avg_qc_score,
         qcs_performed,
         qcs_remaining,
         sum_qc_score,
         count_qc_score,
         rank() over(partition by supervisor_staff_id, dates_month_num order by qcs_performed desc) as rnk
         from combined order by supervisor_staff_id, dates_month_num
),
all_columns as
(
SELECT
H.supervisor_staff_id,
F.SCORECARD_SCORE_TYPE,
CASE WHEN A.CALL_DATE IS NULL THEN TO_CHAR(A.EVALUATION_DATE_TIME,'YYYYMM') ELSE TO_CHAR(A.CALL_DATE,'YYYYMM') END AS EVAL_MONTH,
COUNT(DISTINCT A.EVALUATION_REFERENCE) AUDITS,
COUNT(DISTINCT A1.EVALUATION_REFERENCE) AUDITS_SUP_EVALED,
ROUND(AVG(A1.SCORE_TOTAL),2) QC_SCORE,
ROUND(AVG(S.SCORE_TOTAL),2) SUP_SCORE,
(ROUND(AVG(S.SCORE_TOTAL),2) - ROUND(AVG(A1.SCORE_TOTAL),2)) DEVIATION_SCORE,
E.QC_EVALS,
E.QC_EVALS_SCORE,
X.QC_DISPUTES DISPUTES,
ROUND(((COUNT(DISTINCT A.EVALUATION_REFERENCE)- X.QC_DISPUTES)/(COUNT(DISTINCT A.EVALUATION_REFERENCE))),2) NON_DISPUTE_SCORE
FROM ( SELECT * FROM DP_SCORECARD.ENGAGE_ACTUALS_SV A11
        WHERE not exists (select 1 from sc_exclusion_yes_sv b where a11.AGENT_id = b.AGENT_id and trunc(a11.EVALUATION_DATE_TIME) = trunc(b.exclusion_date)) 
       ) A
JOIN DP_SCORECARD.ENGAGE_FORM_TYPE F ON A.EVALUATION_FORM = F.EVALUATION_FORM
JOIN DP_SCORECARD.SCORECARD_HIERARCHY H ON A.EVALUATOR_ID = H.STAFF_NATID
LEFT JOIN DP_SCORECARD.ENGAGE_ACTUALS_SUP S ON A.EVALUATION_REFERENCE = S.QC_EVALUATION_ID
LEFT JOIN DP_SCORECARD.ENGAGE_ACTUALS_SV A1 ON A1.EVALUATION_REFERENCE = S.QC_EVALUATION_ID
LEFT JOIN (
  SELECT TO_CHAR(EVALUATION_DATE_TIME,'YYYYMM') QC_MONTH,
  AGENT_ID,
  COUNT(EVALUATION_REFERENCE) QC_EVALS,
  ROUND(AVG(SCORE_TOTAL),2) QC_EVALS_SCORE
  FROM DP_SCORECARD.ENGAGE_ACTUALS_QC_EVAL
  GROUP BY TO_CHAR(EVALUATION_DATE_TIME,'YYYYMM'), AGENT_ID) E
      ON (A.EVALUATOR_ID = E.AGENT_ID AND CASE WHEN A.CALL_DATE IS NULL THEN TO_CHAR(A.EVALUATION_DATE_TIME,'YYYYMM') ELSE TO_CHAR(A.CALL_DATE,'YYYYMM') END = E.QC_MONTH) --CHANGEXX
LEFT JOIN (
  SELECT TO_CHAR(PT_ENTRY_DATE,'YYYYMM') ENTRY_DATE,
  H.STAFF_NATID,
  COUNT(PT_ID) QC_DISPUTES
  FROM DP_SCORECARD.SC_PERFORMANCE_TRACKER T
  LEFT JOIN DP_SCORECARD.SCORECARD_HIERARCHY H ON T.STAFF_ID = H.STAFF_STAFF_ID
  LEFT JOIN DP_SCORECARD.SC_DISCUSSION_LKUP L ON L.DL_ID = T.DL_ID
  WHERE L.DISCUSSION_TOPIC = 'QC Dispute'
  GROUP BY TO_CHAR(PT_ENTRY_DATE,'YYYYMM'), H.STAFF_NATID) X
      ON (X.STAFF_NATID = A.EVALUATOR_ID AND CASE WHEN A.CALL_DATE IS NULL THEN TO_CHAR(A.EVALUATION_DATE_TIME,'YYYYMM') ELSE TO_CHAR(A.CALL_DATE,'YYYYMM') END = x.ENTRY_DATE)  --CHANGE XX
WHERE F.SCORECARD_SCORE_TYPE = 'QC'
GROUP BY
H.supervisor_staff_id,
F.SCORECARD_SCORE_TYPE,
CASE WHEN A.CALL_DATE IS NULL THEN TO_CHAR(A.EVALUATION_DATE_TIME,'YYYYMM') ELSE TO_CHAR(A.CALL_DATE,'YYYYMM') END,
E.QC_EVALS,
E.QC_EVALS_SCORE,
X.QC_DISPUTES
),
all_columns2 as
(
SELECT
supervisor_staff_id,
SCORECARD_SCORE_TYPE,
EVAL_MONTH as dates_month_num ,
AUDITS,
AUDITS_SUP_EVALED,
QC_SCORE,
SUP_SCORE,
DEVIATION_SCORE,
QC_EVALS,
QC_EVALS_SCORE,
DISPUTES,
NON_DISPUTE_SCORE
FROM all_columns
),
rank_filter as
(
select   supervisor_staff_id,
         dates_month_num,
         dates_year,
         avg_qc_score,
         qcs_performed,
         qcs_remaining,
         sum_qc_score,
         count_qc_score
         from ranked where rnk=1
)
select   r.supervisor_staff_id,
         r.dates_month_num,
         r.dates_year,
         r.avg_qc_score,
         r.qcs_performed,
         r.qcs_remaining,
         r.sum_qc_score,
         r.count_qc_score,
         ac.AUDITS,
         ac.AUDITS_SUP_EVALED,
         ac.QC_SCORE,
         ac.SUP_SCORE,
         ac.DEVIATION_SCORE,
         ac.QC_EVALS,
         ac.QC_EVALS_SCORE,
         ac.DISPUTES,
         ac.NON_DISPUTE_SCORE
         from rank_filter r
         left outer join all_columns2 ac on r.supervisor_staff_id=ac.supervisor_staff_id and r.dates_month_num=ac.dates_month_num
--WHERE R.DATES_MONTH_NUM = 201611
--AND R.SUPERVISOR_STAFF_ID = 5357
;

show errors

grant select on DP_SCORECARD.SCORECARD_QUALITY_MTHLY_RUSVXX to MAXDAT;

grant select on DP_SCORECARD.SCORECARD_QUALITY_MTHLY_RUSVXX to MAXDAT_READ_ONLY;


CREATE OR REPLACE procedure DP_SCORECARD.LOAD_SC_SUMMARY_CC_V1XX
( add_mth_start number default 0,
  add_mth_stop  number default 11
 ) 
AS

    lv_date_month_num   varchar2(6)  := '199901';

begin

	For mth_loop in ADD_MTH_START .. ADD_MTH_STOP
	LOOP

    lv_date_month_num := to_char(add_months(sysdate,-mth_loop),'YYYYmm');
	
    Delete from SC_SUMMARY_CC_v1
	where dates_month_num = lv_date_month_num;

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
      --  and TRUNC(a11.AS_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
		AND TO_CHAR(a11.AS_DATE,'YYYYMM') = lv_date_month_num
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
		WHERE 1=1
		AND  DATES_MONTH_NUM = lv_date_month_num
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
      --  and TRUNC(a11.task_start) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
	AND TO_CHAR(a11.task_start,'YYYYMM') = lv_date_month_num
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
        where 1=1
	--	AND TRUNC(AS_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
		AND TO_CHAR(AS_DATE,'YYYYMM') = lv_date_month_num
		) a12
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
--        and TRUNC(a11.CALL_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
	AND TO_CHAR(a11.CALL_DATE,'YYYYMM') = lv_date_month_num

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
     --   and TRUNC(a11.WUE_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
	 	AND TO_CHAR(a11.wue_DATE,'YYYYMM') = lv_date_month_num
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
--        and TRUNC(a11.AS_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
	AND TO_CHAR(a11.AS_DATE,'YYYYMM') = lv_date_month_num
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
                 WHERE 1=1
				-- AND TRUNC(a111.LAG_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
					AND TO_CHAR(a111.LAG_DATE,'YYYYMM') = lv_date_month_num
              ) a12 on a11.agent_Id=a12.agent_Id and a11.AS_Date=a12.lag_date
        where not exists (select 1 from sc_exclusion_yes_sv b where a11.agent_id = b.agent_id and trunc(a11.as_date) = trunc(b.exclusion_date))
        --and TRUNC(a11.AS_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')  /*and a11.EXCLUSION_FLAG='N'*/
		AND TO_CHAR(a11.AS_DATE,'YYYYMM') = lv_date_month_num
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
		 WHERE DATES_MONTH_NUM = lv_date_month_num
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

END LOOP;

end LOAD_SC_SUMMARY_CC_v1xX;
/

SHOW ERRORS

GRANT EXECUTE ON DP_SCORECARD.LOAD_SC_SUMMARY_CC_V1XX TO MAXDAT;

GRANT EXECUTE ON DP_SCORECARD.LOAD_SC_SUMMARY_CC_V1XX TO MAXDAT_READ_ONLY;

GRANT DEBUG ON DP_SCORECARD.LOAD_SC_SUMMARY_CC_V1XX TO MAXDAT_READ_ONLY;

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------

CREATE OR REPLACE procedure DP_SCORECARD.LOAD_SC_SUMMARY_CC_ROLLUP_V1XX
( add_mth_start number default 0,
  add_mth_stop  number default 11
 ) 
AS

    lv_date_month_num   varchar2(6)  := '199901';


begin

	For mth_loop in ADD_MTH_START .. ADD_MTH_STOP
	LOOP

    lv_date_month_num := to_char(add_months(sysdate,-mth_loop),'YYYYmm');
	

    Delete from dp_scorecard.SC_SUMMARY_CC_ROLLUP_V1
    where dates_month_num = lv_date_month_num;

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

/*
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
 */

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
        Where 1=1
        AND not exists (select 1 from dp_scorecard.sc_exclusion_yes_sv b where a11.agent_id = b.agent_id and a11.as_date = b.exclusion_date)  -- ADDED 10/9/17 BUGin PROD
        And trunc(a11.as_date) between trunc(a_s.hire_date) and trunc(nvl(a_s.termination_date,sysdate))
		--AND TRUNC(a11.AS_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
		AND TO_CHAR((a11.AS_DATE),'YYYYMM') = lv_date_month_num
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
      from dp_scorecard.scorecard_quality_mthly_RUSVXX  --<< 10/9/2017 CHANGED TO FILTER EXCLUSIONS
	WHERE DATES_MONTH_NUM = lv_date_month_num
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
  join ( SELECT * FROM MAXDAT.PP_WFM_ACTUALS_SV a11   --<< 10/9/2017 Added Test For Exclusions Bug
        WHERE 1=1
        AND not exists (select 1 from dp_scorecard.sc_exclusion_yes_sv b 
            where a11.staff_id = b.staff_id 
            and trunc(a11.task_start) = trunc(b.exclusion_date)
            )
       ) a11
   on a10.staff_staff_id=a11.staff_id    
   WHERE 1=1
         and trunc(a11.task_start) between trunc (a10.hire_date) and trunc(nvl(a10.termination_date,sysdate))   -- added 10/11/2017  BUG FIX 
   --AND TRUNC(a11.task_start) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
   		AND TO_CHAR((a11.TASK_START),'YYYYMM') = lv_date_month_num
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
        where 1=1
		--AND TRUNC(AS_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
		AND TO_CHAR((AS_DATE),'YYYYMM') = lv_date_month_num
		) a12
        on  a12.agent_id=a10.staff_natid and a12.as_date= TRUNC(a11.LAG_DATE)
  WHERE 1=1
  and trunc(a12.as_date) between trunc (a10.hire_date) and trunc(nvl(a10.termination_date,sysdate))   -- added 10/11/2017  BUG FIX 
  --AND TRUNC(a11.LAG_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
		AND TO_CHAR((a11.LAG_DATE),'YYYYMM') = lv_date_month_num
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
  WHERE 1=1
  and trunc(a11.call_date) between trunc (a10.hire_date) and trunc(nvl(a10.termination_date,sysdate))   -- added 10/11/2017  BUG FIX 
--  AND TRUNC(a11.CALL_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
		AND TO_CHAR((a11.CALL_DATE),'YYYYMM') = lv_date_month_num
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
  WHERE 1=1
  and trunc(a11.wue_date) between trunc (a10.hire_date) and trunc(nvl(a10.termination_date,sysdate))   -- added 10/11/2017  BUG FIX 
  -- and TRUNC(a11.WUE_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
 		AND TO_CHAR((a11.wue_DATE),'YYYYMM') = lv_date_month_num
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
  WHERE 1=1
  and trunc(a21.as_date) between trunc (a20.hire_date) and trunc(nvl(a20.termination_date,sysdate))   -- added 10/11/2017  BUG FIX 
  -- and TRUNC(a21.AS_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
		AND TO_CHAR((a21.as_DATE),'YYYYMM') = lv_date_month_num
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
          WHERE 1=1
          and trunc(a21.as_date) between trunc(a20.hire_date) and trunc(nvl(a20.termination_date,sysdate))    -- 10/11/2017 bug fix
		  -- and TRUNC(a21.AS_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
		AND TO_CHAR((a21.as_DATE),'YYYYMM') = lv_date_month_num
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
                 WHERE 1=1
                   and trunc(a111.lag_date) between trunc (a101.hire_date) and trunc(nvl(a101.termination_date,sysdate))   -- added 10/11/2017  BUG FIX 
				 -- and TRUNC(a111.LAG_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
				AND TO_CHAR((a111.lag_DATE),'YYYYMM') = lv_date_month_num
              ) a12 on a11.agent_Id=a12.agent_Id and a11.AS_Date=a12.lag_date
        where 1=1
		AND TO_CHAR((a11.as_DATE),'YYYYMM') = lv_date_month_num
 		-- and TRUNC(a11.AS_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')  
		AND TO_CHAR((a11.as_DATE),'YYYYMM') = lv_date_month_num
		/*and a11.EXCLUSION_FLAG='N'*/
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
          where 1=1
		  -- and TRUNC(AS_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
  		AND TO_CHAR((as_DATE),'YYYYMM') = lv_date_month_num
  		AND trunc(as_date) between trunc(h.hire_date) and trunc(nvl(termination_date,sysdate))   --- added 10/11/2017 BUG FIX
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
       where 1=1 
  		AND trunc(as_date) between trunc(h.hire_date) and trunc(nvl(termination_date,sysdate))   --- added 10/11/2017 BUG FIX
	   -- and TRUNC(AS_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
		AND TO_CHAR((as_DATE),'YYYYMM') = lv_date_month_num
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
		where dates_month_num = lv_date_month_num
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

END LOOP;

COMMIT;

END LOAD_SC_SUMMARY_CC_ROLLUP_V1XX;
/

SHOW ERRORS

GRANT EXECUTE ON DP_SCORECARD.LOAD_SC_SUMMARY_CC_ROLLUP_V1XX TO MAXDAT;

GRANT EXECUTE ON DP_SCORECARD.LOAD_SC_SUMMARY_CC_ROLLUP_V1XX TO MAXDAT_READ_ONLY;

GRANT DEBUG ON DP_SCORECARD.LOAD_SC_SUMMARY_CC_ROLLUP_V1XX TO MAXDAT_READ_ONLY;
