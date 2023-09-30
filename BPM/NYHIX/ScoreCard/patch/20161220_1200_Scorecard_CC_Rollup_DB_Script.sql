create table DP_SCORECARD.SC_SUMMARY_CC_ROLLUP
(
  supervisor_staff_id          NUMBER(38),
  dates_month                  VARCHAR2(36),
  dates_month_num              VARCHAR2(6),
  dates_year                   VARCHAR2(41),
  exclusion_flag               VARCHAR2(1),
  tot_calls_answered           NUMBER,
  tot_short_calls_answered     NUMBER,
  tot_tot_return_to_queue      NUMBER,
  tot_average_handle_time      NUMBER,
  tot_sched_productive_time    NUMBER,
  tot_actual_productive_time   NUMBER,
  tot_talk_time                NUMBER,
  tot_wrap_up_time             NUMBER,
  tot_logged_in_time           NUMBER,
  tot_not_ready_time           NUMBER,
  tot_break_time               NUMBER,
  tot_lunch_time               NUMBER,
  qcs_performed                NUMBER,
  avg_qc_score                 NUMBER,
  tot_incidents_completed      NUMBER,
  days_incidents_completed     NUMBER,
  tot_defects_completed        NUMBER,
  days_defects_completed       NUMBER,
  lag_time_tot_sched_prod_time NUMBER,
  tot_call_records             NUMBER,
  tot_customer_count           NUMBER,
  tot_call_wrap_up_count       NUMBER,
  tot_wrap_up_error            NUMBER,
  days_short_calls_gt_10       NUMBER,
  days_calls_answered          NUMBER,
  adherence                    NUMBER,
  tot_return_to_queue_timeout  NUMBER,
  avg_attendance_balance       NUMBER,
  avg_attendance_total_balance NUMBER
);

create index DP_SCORECARD.SC_SUMMARY_CC_RU_SUP_ID_NDX on DP_SCORECARD.SC_SUMMARY_CC_ROLLUP (supervisor_staff_id);

GRANT select on SC_SUMMARY_CC_ROLLUP to MAXDAT; 
GRANT select on SC_SUMMARY_CC_ROLLUP to MAXDAT_READ_ONLY; 

COMMIT;

CREATE OR REPLACE VIEW DP_SCORECARD.SCORECARD_SUMMARY_CC_ROLLUP_SV AS
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
       avg_attendance_total_balance
  from dp_scorecard.sc_summary_cc_rollup
  WITH READ ONLY;
  
  
GRANT select on DP_SCORECARD.SCORECARD_SUMMARY_CC_ROLLUP_SV to MAXDAT_READ_ONLY;
GRANT select on DP_SCORECARD.SCORECARD_SUMMARY_CC_ROLLUP_SV to MAXDAT;

commit;


create table DP_SCORECARD.SCORECARD_OFFICE_BUILDING_LKUP
(
  office         VARCHAR2(100),
  building       VARCHAR2(100)
);

GRANT select on DP_SCORECARD.SCORECARD_OFFICE_BUILDING_LKUP to MAXDAT_READ_ONLY;
GRANT select on DP_SCORECARD.SCORECARD_OFFICE_BUILDING_LKUP to MAXDAT;


insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('11CW FL-6  Z-1','11 - ALBANY');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('11CW FL-6  Z-2','11 - ALBANY');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('11CW FL-6  Z-3','11 - ALBANY');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('E&' || 'E 11CW','11 - ALBANY');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('22CW FL-2  Z-1','22 - ALBANY');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('22CW FL-2  Z-2','22 - ALBANY');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('22CW FL-2  Z-3','22 - ALBANY');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('22CW FL-4  Z-1','22 - ALBANY');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('22CW FL-4  Z-2','22 - ALBANY');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('E&' || 'E 22CW','22 - ALBANY');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('30 Broad','NYC');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('NYC FL-16','NYC');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('NYC FL-17','NYC');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('NYC FL-5','NYC');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('833 FL-1','833 - ALBANY');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('833 FL-2','833 - ALBANY');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('833 FL-1 Z-1','833 - ALBANY');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('833 FL-1 Z-2','833 - ALBANY');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('833 FL-2 Z-3','833 - ALBANY');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('833 FL-2 Z-4','833 - ALBANY');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('833 FL-2 Z-5','833 - ALBANY');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('833 FL-2 Z-6','833 - ALBANY');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('ROC ARU','ROCHESTER');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('11 Suite A','11 - ALBANY');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('11 Suite D','11 - ALBANY');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('AT-121','N/A');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('AT-122','N/A');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('AT-123','N/A');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('AT-124','N/A');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('AT-127','N/A');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('AT-145','N/A');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('AT-146','N/A');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('AT-15','N/A');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('AT-155','N/A');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('AT-172','N/A');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('AT-182','N/A');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('TEMP','N/A');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('Roc N Z-1','ROCHESTER');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('Roc N Z-2','ROCHESTER');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('Roc N Z-3','ROCHESTER');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('Roc N Z-4','ROCHESTER');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('Roc N Z-5','ROCHESTER');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('Roc N Z-6','ROCHESTER');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('Roc N Z-7','ROCHESTER');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('Roc N Z-8','ROCHESTER');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('Roc S Z-10','ROCHESTER');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('Roc S Z-11','ROCHESTER');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('Roc S Z-12','ROCHESTER');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('Roc S Z-13','ROCHESTER');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('Roc S Z-14','ROCHESTER');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('Roc S Z-15','ROCHESTER');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('Roc S Z-16','ROCHESTER');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('Roc S Z-17','ROCHESTER');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('Roc S Z-9','ROCHESTER');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('Rochester','ROCHESTER');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('E&' || 'E What If Office','N/A');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('15 Corporate','N/A');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('Maximus','');
commit;


---NEEDS TO BE ADDED TO THE DAILY RUN
create or replace procedure dp_scorecard.LOAD_SC_SUMMARY_CC_ROLLUP
AS

begin

    Delete from SC_SUMMARY_CC_ROLLUP;
    commit;

insert into SC_SUMMARY_CC_ROLLUP (supervisor_staff_id,
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
   avg_attendance_total_balance
   )

WITH attendance as
( 
select distinct SUPERVISOR_STAFF_ID,
                DATES_MONTH,
                DATES_MONTH_NUM,
                DATES_YEAR,
                AVG(BALANCE) over(partition by SUPERVISOR_STAFF_ID, dates_month_num) as BALANCE,
                AVG(TOTAL_BALANCE) over(partition by SUPERVISOR_STAFF_ID, dates_month_num) as TOTAL_BALANCE,
                SC_ATTENDANCE_ID
  from dp_scorecard.scorecard_attendance_mthly_sv
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
        where TRUNC(a11.AS_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
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
       a11.AS_DATE,
        a11.EXCLUSION_FLAG,
        CASE WHEN sum(a11.SHORT_CALLS_ANSWERED) > 10 THEN 1 ELSE null END short_calls,
        sum(a11.CALLS_ANSWERED) TOT_CALLS,
       to_char(TRUNC(a11.AS_DATE), 'YYYYMM') as dates_month_num,
       to_char(TRUNC(a11.AS_DATE), 'Month YYYY') as dates_year
   FROM DP_SCORECARD.SCORECARD_HIERARCHY_SV a10
  join DP_SCORECARD.SC_AGENT_STAT_SV a11 on a10.staff_natid = a11.AGENT_ID
  WHERE TRUNC(a11.AS_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
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
      to_char(TRUNC(a11.AS_DATE), 'YYYYMM') as dates_month_num,
      to_char(TRUNC(a11.AS_DATE), 'Month YYYY') as dates_year,
      to_char(a11.AGENT_ID) AGENT_ID,
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
        where TRUNC(a11.AS_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')  and a11.EXCLUSION_FLAG='N'
    group by to_char(TRUNC(a11.AS_DATE), 'YYYYMM'), to_char(TRUNC(a11.AS_DATE), 'Month YYYY'),a_s.supervisor_staff_id, a11.AGENT_ID, a11.EXCLUSION_FLAG
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
   a.total_balance
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

GRANT execute on DP_SCORECARD.LOAD_SC_SUMMARY_CC_ROLLUP to MAXDAT_READ_ONLY;
GRANT execute on DP_SCORECARD.LOAD_SC_SUMMARY_CC_ROLLUP to MAXDAT;


create or replace view dp_scorecard.scorecard_hierarchy_sv as
select 999 as admin_id, --created an admin level in the hierarchy so that user id 999 in MicroStrategy can see all managers
       h.sr_director_name,
       h.sr_director_staff_id,
       h.sr_director_natid,
       (select termination_date from MAXDAT.PP_WFM_STAFF_SV S where h.sr_director_staff_id = s.Staff_id) sr_director_termination_date,
       h.director_name,
       h.director_staff_id,
       h.director_natid,
       (select termination_date from MAXDAT.PP_WFM_STAFF_SV S where h.director_staff_id = s.Staff_id) director_termination_date,
       h.sr_manager_name,
       h.sr_manager_staff_id,
       h.sr_manager_natid,
       (select termination_date from MAXDAT.PP_WFM_STAFF_SV S where h.sr_manager_staff_id = s.Staff_id) sr_manager_termination_date,
       h.manager_name,
       h.manager_staff_id,
       h.manager_natid,
       (select termination_date from MAXDAT.PP_WFM_STAFF_SV S where h.manager_staff_id = s.Staff_id) manager_termination_date,
       h.supervisor_name,
       h.supervisor_staff_id,
       h.supervisor_natid,
       (select termination_date from MAXDAT.PP_WFM_STAFF_SV S where h.supervisor_staff_id = s.Staff_id) supervisor_termination_date,
	   h.staff_staff_id,
       h.staff_staff_name,
       h.staff_natid,
       h.hire_date,
       h.position,
       h.office,
       h.termination_date,
       (select distinct d.name from dp_scorecard.pp_wfm_staff_to_department std
        join dp_scorecard.pp_wfm_department d on std.department_id=d.department_id
        where trunc(std.effective_date) <= trunc(sysdate) and coalesce(std.end_date,to_date('07/07/7777','mm/dd/yyyy')) > trunc(sysdate) and std.staff_id=h.staff_staff_id) as department,
       (select building from dp_scorecard.scorecard_office_building_lkup obl where obl.office=h.office) as building
  from dp_scorecard.scorecard_hierarchy h
    WITH READ ONLY;

 
  commit;


