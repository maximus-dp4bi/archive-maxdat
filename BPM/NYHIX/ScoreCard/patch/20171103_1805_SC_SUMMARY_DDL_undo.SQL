DROP TABLE DP_SCORECARD.SC_SUMMARY_CC CASCADE CONSTRAINTS;

CREATE TABLE DP_SCORECARD.SC_SUMMARY_CC
(
  STAFF_STAFF_ID                NUMBER(38),
  STAFF_STAFF_NAME              VARCHAR2(100 BYTE),
  DATES_MONTH                   VARCHAR2(36 BYTE),
  DATES_MONTH_NUM               VARCHAR2(6 BYTE),
  DATES_YEAR                    VARCHAR2(41 BYTE),
  EXCLUSION_FLAG                VARCHAR2(1 BYTE),
  TOT_CALLS_ANSWERED            NUMBER,
  TOT_SHORT_CALLS_ANSWERED      NUMBER,
  TOT_TOT_RETURN_TO_QUEUE       NUMBER,
  TOT_AVERAGE_HANDLE_TIME       NUMBER,
  TOT_SCHED_PRODUCTIVE_TIME     NUMBER,
  TOT_ACTUAL_PRODUCTIVE_TIME    NUMBER,
  TOT_TALK_TIME                 NUMBER,
  TOT_WRAP_UP_TIME              NUMBER,
  TOT_LOGGED_IN_TIME            NUMBER,
  TOT_NOT_READY_TIME            NUMBER,
  TOT_BREAK_TIME                NUMBER,
  TOT_LUNCH_TIME                NUMBER,
  QCS_PERFORMED                 NUMBER,
  AVG_QC_SCORE                  NUMBER,
  TOT_INCIDENTS_COMPLETED       NUMBER,
  DAYS_INCIDENTS_COMPLETED      NUMBER,
  TOT_DEFECTS_COMPLETED         NUMBER,
  DAYS_DEFECTS_COMPLETED        NUMBER,
  LAG_TIME_TOT_SCHED_PROD_TIME  NUMBER,
  TOT_CALL_RECORDS              NUMBER,
  TOT_CUSTOMER_COUNT            NUMBER,
  TOT_CALL_WRAP_UP_COUNT        NUMBER,
  TOT_WRAP_UP_ERROR             NUMBER,
  DAYS_SHORT_CALLS_GT_10        NUMBER,
  DAYS_CALLS_ANSWERED           NUMBER,
  ADHERENCE                     NUMBER,
  TOT_RETURN_TO_QUEUE_TIMEOUT   NUMBER,
  CORRECTIVE_ACTION_FLAG        NUMBER,
  ONE_ON_ONE_FLAG               NUMBER,
  OBSERVATION_FLAG              NUMBER
)
TABLESPACE MAXDAT_DATA
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
MONITORING;


CREATE INDEX DP_SCORECARD.SC_SUMMARY_CC_STAFF_ID_NDX ON DP_SCORECARD.SC_SUMMARY_CC
(STAFF_STAFF_ID)
LOGGING
TABLESPACE MAXDAT_INDX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );

GRANT SELECT ON DP_SCORECARD.SC_SUMMARY_CC TO DP_SCORECARD_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.SC_SUMMARY_CC TO MAXDAT_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.SC_SUMMARY_CC TO MAXDAT;

GRANT SELECT ON DP_SCORECARD.SC_SUMMARY_CC TO MAXDAT_REPORTS;



-----------------------------------------------------------------------
-----------------------------------------------------------------------

DROP TABLE DP_SCORECARD.SC_SUMMARY_CC_ROLLUP CASCADE CONSTRAINTS;

CREATE TABLE DP_SCORECARD.SC_SUMMARY_CC_ROLLUP
(
  SUPERVISOR_STAFF_ID           NUMBER(38),
  DATES_MONTH                   VARCHAR2(36 BYTE),
  DATES_MONTH_NUM               VARCHAR2(6 BYTE),
  DATES_YEAR                    VARCHAR2(41 BYTE),
  EXCLUSION_FLAG                VARCHAR2(1 BYTE),
  TOT_CALLS_ANSWERED            NUMBER,
  TOT_SHORT_CALLS_ANSWERED      NUMBER,
  TOT_TOT_RETURN_TO_QUEUE       NUMBER,
  TOT_AVERAGE_HANDLE_TIME       NUMBER,
  TOT_SCHED_PRODUCTIVE_TIME     NUMBER,
  TOT_ACTUAL_PRODUCTIVE_TIME    NUMBER,
  TOT_TALK_TIME                 NUMBER,
  TOT_WRAP_UP_TIME              NUMBER,
  TOT_LOGGED_IN_TIME            NUMBER,
  TOT_NOT_READY_TIME            NUMBER,
  TOT_BREAK_TIME                NUMBER,
  TOT_LUNCH_TIME                NUMBER,
  QCS_PERFORMED                 NUMBER,
  AVG_QC_SCORE                  NUMBER,
  TOT_INCIDENTS_COMPLETED       NUMBER,
  DAYS_INCIDENTS_COMPLETED      NUMBER,
  TOT_DEFECTS_COMPLETED         NUMBER,
  DAYS_DEFECTS_COMPLETED        NUMBER,
  LAG_TIME_TOT_SCHED_PROD_TIME  NUMBER,
  TOT_CALL_RECORDS              NUMBER,
  TOT_CUSTOMER_COUNT            NUMBER,
  TOT_CALL_WRAP_UP_COUNT        NUMBER,
  TOT_WRAP_UP_ERROR             NUMBER,
  DAYS_SHORT_CALLS_GT_10        NUMBER,
  DAYS_CALLS_ANSWERED           NUMBER,
  ADHERENCE                     NUMBER,
  TOT_RETURN_TO_QUEUE_TIMEOUT   NUMBER,
  AVG_ATTENDANCE_BALANCE        NUMBER,
  AVG_ATTENDANCE_TOTAL_BALANCE  NUMBER,
  QCS_REMAINING                 NUMBER,
  SUM_QC_SCORE                  NUMBER,
  COUNT_QC_SCORE                NUMBER,
  STAFF_COUNT                   NUMBER,
  TOT_HANDLE_TIME               NUMBER,
  TOT_HANDLE_TIME_COUNT         NUMBER,
  STAFF_TRTQ_COUNT              NUMBER,
  SHORT_CALL_AGENT_COUNT        NUMBER
)
TABLESPACE MAXDAT_DATA
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
MONITORING;


GRANT SELECT ON DP_SCORECARD.SC_SUMMARY_CC_ROLLUP TO DP_SCORECARD_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.SC_SUMMARY_CC_ROLLUP TO MAXDAT_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.SC_SUMMARY_CC_ROLLUP TO MAXDAT;

GRANT SELECT ON DP_SCORECARD.SC_SUMMARY_CC_ROLLUP TO MAXDAT_REPORTS;




CREATE INDEX DP_SCORECARD.SC_SUMMARY_CC_RU_MON_NUM_NDX ON DP_SCORECARD.SC_SUMMARY_CC_ROLLUP
(DATES_MONTH_NUM)
LOGGING
TABLESPACE MAXDAT_DATA
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );

CREATE INDEX DP_SCORECARD.SC_SUMMARY_CC_RU_SUP_ID_NDX ON DP_SCORECARD.SC_SUMMARY_CC_ROLLUP
(SUPERVISOR_STAFF_ID)
LOGGING
TABLESPACE MAXDAT_DATA
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );

GRANT SELECT ON DP_SCORECARD.SC_SUMMARY_CC_ROLLUP TO DP_SCORECARD_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.SC_SUMMARY_CC_ROLLUP TO MAXDAT_READ_ONLY;

-----------------------------------------------------------------------
-----------------------------------------------------------------------

--DROP VIEW DP_SCORECARD.SC_SUMMARY_CC_SV;

CREATE OR REPLACE FORCE VIEW DP_SCORECARD.SC_SUMMARY_CC_SV
(STAFF_STAFF_ID, STAFF_STAFF_NAME, DATES_MONTH, DATES_MONTH_NUM, DATES_YEAR, 
 EXCLUSION_FLAG, TOT_CALLS_ANSWERED, TOT_SHORT_CALLS_ANSWERED, TOT_TOT_RETURN_TO_QUEUE, TOT_RETURN_TO_QUEUE_TIMEOUT, 
 TOT_AVERAGE_HANDLE_TIME, TOT_SCHED_PRODUCTIVE_TIME, TOT_ACTUAL_PRODUCTIVE_TIME, TOT_TALK_TIME, TOT_WRAP_UP_TIME, 
 TOT_LOGGED_IN_TIME, TOT_NOT_READY_TIME, TOT_BREAK_TIME, TOT_LUNCH_TIME, QCS_PERFORMED, 
 AVG_QC_SCORE, TOT_INCIDENTS_COMPLETED, DAYS_INCIDENTS_COMPLETED, TOT_DEFECTS_COMPLETED, DAYS_DEFECTS_COMPLETED, 
 LAG_TIME_TOT_SCHED_PROD_TIME, TOT_CALL_RECORDS, TOT_CUSTOMER_COUNT, TOT_CALL_WRAP_UP_COUNT, TOT_WRAP_UP_ERROR, 
 DAYS_SHORT_CALLS_GT_10, DAYS_CALLS_ANSWERED, ADHERENCE)
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
  from dp_scorecard.sc_summary_cc;


GRANT SELECT ON DP_SCORECARD.SC_SUMMARY_CC_SV TO DP_SCORECARD_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.SC_SUMMARY_CC_SV TO MAXDAT_READ_ONLY;


-----------------------------------------------------------------------
-----------------------------------------------------------------------

--DROP VIEW DP_SCORECARD.SCORECARD_SUMMARY_CC_ROLLUP_SV;

CREATE OR REPLACE FORCE VIEW DP_SCORECARD.SCORECARD_SUMMARY_CC_ROLLUP_SV
(SUPERVISOR_STAFF_ID, D_DATE, DATES_MONTH, DATES_MONTH_NUM, DATES_YEAR, 
 EXCLUSION_FLAG, TOT_CALLS_ANSWERED, TOT_SHORT_CALLS_ANSWERED, TOT_TOT_RETURN_TO_QUEUE, TOT_AVERAGE_HANDLE_TIME, 
 TOT_SCHED_PRODUCTIVE_TIME, TOT_ACTUAL_PRODUCTIVE_TIME, TOT_TALK_TIME, TOT_WRAP_UP_TIME, TOT_LOGGED_IN_TIME, 
 TOT_NOT_READY_TIME, TOT_BREAK_TIME, TOT_LUNCH_TIME, QCS_PERFORMED, AVG_QC_SCORE, 
 QCS_REMAINING, TOT_INCIDENTS_COMPLETED, DAYS_INCIDENTS_COMPLETED, TOT_DEFECTS_COMPLETED, DAYS_DEFECTS_COMPLETED, 
 LAG_TIME_TOT_SCHED_PROD_TIME, TOT_CALL_RECORDS, TOT_CUSTOMER_COUNT, TOT_CALL_WRAP_UP_COUNT, TOT_WRAP_UP_ERROR, 
 DAYS_SHORT_CALLS_GT_10, DAYS_CALLS_ANSWERED, ADHERENCE, TOT_RETURN_TO_QUEUE_TIMEOUT, AVG_ATTENDANCE_BALANCE, 
 AVG_ATTENDANCE_TOTAL_BALANCE, STAFF_COUNT, SUM_QC_SCORE, COUNT_QC_SCORE, TOT_HANDLE_TIME, 
 TOT_HANDLE_TIME_COUNT, STAFF_TRTQ_COUNT, SHORT_CALL_AGENT_COUNT)
AS 
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
       qcs_remaining,
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
       staff_count,
       sum_qc_score,
       count_qc_score,
       TOT_HANDLE_TIME,
       TOT_HANDLE_TIME_COUNT,
       STAFF_TRTQ_COUNT,
       Short_Call_Agent_Count
  from dp_scorecard.sc_summary_cc_rollup;



GRANT SELECT ON DP_SCORECARD.SCORECARD_SUMMARY_CC_ROLLUP_SV TO MAXDAT;

GRANT SELECT ON DP_SCORECARD.SCORECARD_SUMMARY_CC_ROLLUP_SV TO MAXDAT_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.SCORECARD_SUMMARY_CC_ROLLUP_SV TO MAXDAT_REPORTS;

GRANT SELECT ON DP_SCORECARD.SCORECARD_SUMMARY_CC_ROLLUP_SV TO DP_SCORECARD_READ_ONLY;


-----------------------------------------------------------------------
-----------------------------------------------------------------------

DROP VIEW DP_SCORECARD.SCORECARD_SUMMARY_CC_SV;

CREATE OR REPLACE FORCE VIEW DP_SCORECARD.SCORECARD_SUMMARY_CC_SV
(STAFF_STAFF_ID, STAFF_STAFF_NAME, STAFF_NATID, DATES_MONTH, DATES_MONTH_NUM, 
 DATES_YEAR, EXCLUSION_FLAG, TOT_CALLS_ANSWERED, TOT_SHORT_CALLS_ANSWERED, TOT_TOT_RETURN_TO_QUEUE, 
 TOT_RET_TO_QUEUE_TOTAL, TOT_AVERAGE_HANDLE_TIME, TOT_SCHED_PRODUCTIVE_TIME, TOT_ACTUAL_PRODUCTIVE_TIME, TOT_TALK_TIME, 
 TOT_WRAP_UP_TIME, TOT_LOGGED_IN_TIME, TOT_NOT_READY_TIME, TOT_BREAK_TIME, TOT_LUNCH_TIME, 
 QCS_PERFORMED, AVG_QC_SCORE, TOT_INCIDENTS_COMPLETED, DAYS_INCIDENTS_COMPLETED, TOT_DEFECTS_COMPLETED, 
 DAYS_DEFECTS_COMPLETED, LAG_TIME_TOT_SCHED_PROD_TIME, TOT_CALL_RECORDS, TOT_CUSTOMER_COUNT, TOT_CALL_WRAP_UP_COUNT, 
 TOT_WRAP_UP_ERROR, DAYS_SHORT_CALLS_GT_10, DAYS_CALLS_ANSWERED, BALANCE, TOTAL_BALANCE, 
 ADHERENCE, CORRECTIVE_ACTION_FLAG, ONE_ON_ONE_FLAG, OBSERVATION_FLAG, RECORDED_CALL_REVIEW_FLAG, 
 LIVE_PHONE_OBSERVATION_FLAG)
AS 
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
                  max(case when discussion_topic = 'Real Time Phone Observation' then 1 else 0 end ) as Live_Phone_Observation_flag
    from dp_scorecard.scorecard_perform_tracker_sv PERF
    where discussion_topic in (
                    'Corrective Action',
                    'One on One',
                    'Observation',
                    'Recorded Call Review',
                    'Real Time Phone Observation'
                    )
   group by staff_staff_id,
            to_char(TRUNC(pt_entry_date),'YYYYMM'),
            to_char(TRUNC(pt_entry_date), 'Month YYYY')
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
        COALESCE(a10.corrective_action_flag,0) as corrective_action_flag ,
        COALESCE(a10.one_on_one_flag,0) as one_on_one_flag,
        COALESCE(a10.observation_flag,0) as observation_flag,
        NVL(PT.Recorded_Call_Review_flag,0)     as Recorded_Call_Review_flag,
        NVL(PT.Live_Phone_Observation_flag,0)       as Live_Phone_Observation_flag
        from ATTEND_Metrics a11
   LEFT OUTER JOIN dp_scorecard.sc_summary_cc a10 ON a11.staff_staff_id=a10.staff_staff_id
   and  a11.dates_month_num=a10.dates_month_num
   LEFT OUTER JOIN PERMFORM_TKR PT ON a11.staff_staff_id=pt.staff_staff_id
   and  a11.dates_month_num=pt.dates_month_num;


GRANT SELECT ON DP_SCORECARD.SCORECARD_SUMMARY_CC_SV TO MAXDAT;

GRANT SELECT ON DP_SCORECARD.SCORECARD_SUMMARY_CC_SV TO MAXDAT_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.SCORECARD_SUMMARY_CC_SV TO MAXDAT_REPORTS;

GRANT SELECT ON DP_SCORECARD.SCORECARD_SUMMARY_CC_SV TO DP_SCORECARD_READ_ONLY;


-----------------------------------------------------------------------
-----------------------------------------------------------------------

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


GRANT EXECUTE ON DP_SCORECARD.LOAD_SC_SUMMARY_CC TO MAXDAT;

GRANT EXECUTE ON DP_SCORECARD.LOAD_SC_SUMMARY_CC TO MAXDAT_READ_ONLY;

GRANT DEBUG ON DP_SCORECARD.LOAD_SC_SUMMARY_CC TO MAXDAT_READ_ONLY;

GRANT EXECUTE ON DP_SCORECARD.LOAD_SC_SUMMARY_CC TO DP_SCORECARD_READ_ONLY;

-----------------------------------------------------------------------
-----------------------------------------------------------------------

CREATE OR REPLACE procedure DP_SCORECARD.LOAD_SC_SUMMARY_CC_ROLLUP
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
left outer join Adherence_metric a on all_staff.supervisor_staff_id = a.supervisor_staff_id and all_staff.dates_month_num=a.dates_month_num
left outer join Unique_Calls_Metrics ucm on all_staff.supervisor_staff_id = ucm.supervisor_staff_id and all_staff.dates_month_num=ucm.dates_month_num
left outer join TRTQ_Agent_Count tac on all_staff.supervisor_staff_id = tac.supervisor_staff_id and all_staff.dates_month_num=tac.dates_month_num
left outer join Short_Call_Agent_Count scac  on all_staff.supervisor_staff_id = scac.supervisor_staff_id and all_staff.dates_month_num=scac.dates_month_num;
/*where all_staff.supervisor_staff_id in (select distinct supervisor_staff_id from dp_scorecard.scorecard_hierarchy_sv where manager_staff_id=1378);*/

commit;
END LOAD_SC_SUMMARY_CC_ROLLUP;
/

GRANT EXECUTE ON DP_SCORECARD.LOAD_SC_SUMMARY_CC_ROLLUP TO MAXDAT;

GRANT EXECUTE ON DP_SCORECARD.LOAD_SC_SUMMARY_CC_ROLLUP TO MAXDAT_READ_ONLY;

GRANT DEBUG ON DP_SCORECARD.LOAD_SC_SUMMARY_CC_ROLLUP TO MAXDAT_READ_ONLY;

GRANT EXECUTE ON DP_SCORECARD.LOAD_SC_SUMMARY_CC_ROLLUP TO DP_SCORECARD_READ_ONLY;

