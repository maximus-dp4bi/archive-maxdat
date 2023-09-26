alter table SC_ATTENDANCE modify CREATE_BY VARCHAR2(100 BYTE);
alter table SC_ATTENDANCE add (LAST_UPDATED_BY VARCHAR2(100),LAST_UPDATED_DATETIME DATE);

alter table SC_CORRECTIVE_ACTION modify CREATE_BY VARCHAR2(100 BYTE);
alter table SC_CORRECTIVE_ACTION add (LAST_UPDATED_BY VARCHAR2(100),LAST_UPDATED_DATETIME DATE);

alter table SC_GOAL modify CREATE_BY VARCHAR2(100 BYTE);
alter table SC_GOAL add (LAST_UPDATED_BY VARCHAR2(100),LAST_UPDATED_DATETIME DATE);

alter table SC_PERFORMANCE_TRACKER modify CREATE_BY VARCHAR2(100 BYTE);
alter table SC_PERFORMANCE_TRACKER add (LAST_UPDATED_BY VARCHAR2(100),LAST_UPDATED_DATETIME DATE);

CREATE INDEX sc_hier_mang_staff_id_NDX ON scorecard_hierarchy (MANAGER_STAFF_ID ASC) 
TABLESPACE MAXDAT_INDX; 

declare  c int;
begin
   select count(*) into c from user_tables where table_name ='SC_PRODUCTION_BO';
   if c = 1 then
      execute immediate 'drop table SC_PRODUCTION_BO cascade constraints';
   end if;
end;
/

CREATE TABLE SC_PRODUCTION_BO 
(
  STAFF_ID NUMBER 
, DATES DATE 
, EVENT_NAME_SORT NUMBER 
, EVENT_NAME VARCHAR2(300 BYTE) 
, EVENT_SUBNAME_SORT NUMBER 
, EVENT_SUBNAME VARCHAR2(300 BYTE) 
, METRIC NUMBER 
) TABLESPACE MAXDAT_DATA;

declare  c int;
begin
   select count(*) into c from user_tables where table_name ='SC_SUMMARY_BO';
   if c = 1 then
      execute immediate 'drop table SC_SUMMARY_BO cascade constraints';
   end if;
end;
/

CREATE TABLE SC_SUMMARY_BO 
(
  STAFF_ID NUMBER 
, DATES_MONTH_NUM VARCHAR2(6 BYTE) 
, DATES_YEAR VARCHAR2(41 BYTE) 
, EVENT_NAME_SORT NUMBER 
, EVENT_NAME VARCHAR2(300 BYTE) 
, EVENT_SUBNAME_SORT NUMBER 
, EVENT_SUBNAME VARCHAR2(300 BYTE) 
, METRIC NUMBER 
) TABLESPACE MAXDAT_DATA;


declare  c int;
begin
   select count(*) into c from user_tables where table_name ='SC_SUMMARY_CC';
   if c = 1 then
      execute immediate 'drop table SC_SUMMARY_CC cascade constraints';
   end if;
end;
/

CREATE TABLE SC_SUMMARY_CC 
(
  STAFF_STAFF_ID NUMBER(38, 0) 
, STAFF_STAFF_NAME VARCHAR2(100 BYTE) 
, DATES_MONTH VARCHAR2(36 BYTE) 
, DATES_MONTH_NUM VARCHAR2(6 BYTE) 
, DATES_YEAR VARCHAR2(41 BYTE) 
, EXCLUSION_FLAG VARCHAR2(1 BYTE) 
, TOT_CALLS_ANSWERED NUMBER 
, TOT_SHORT_CALLS_ANSWERED NUMBER 
, TOT_TOT_RETURN_TO_QUEUE NUMBER 
, TOT_AVERAGE_HANDLE_TIME NUMBER 
, TOT_SCHED_PRODUCTIVE_TIME NUMBER 
, TOT_ACTUAL_PRODUCTIVE_TIME NUMBER 
, TOT_TALK_TIME NUMBER 
, TOT_WRAP_UP_TIME NUMBER 
, TOT_LOGGED_IN_TIME NUMBER 
, TOT_NOT_READY_TIME NUMBER 
, TOT_BREAK_TIME NUMBER 
, TOT_LUNCH_TIME NUMBER 
, QCS_PERFORMED NUMBER 
, AVG_QC_SCORE NUMBER 
, TOT_INCIDENTS_COMPLETED NUMBER 
, DAYS_INCIDENTS_COMPLETED NUMBER 
, TOT_DEFECTS_COMPLETED NUMBER 
, DAYS_DEFECTS_COMPLETED NUMBER 
, LAG_TIME_TOT_SCHED_PROD_TIME NUMBER 
, TOT_CALL_RECORDS NUMBER 
, TOT_CUSTOMER_COUNT NUMBER 
, TOT_CALL_WRAP_UP_COUNT NUMBER 
, TOT_WRAP_UP_ERROR NUMBER 
, DAYS_SHORT_CALLS_GT_10 NUMBER 
, DAYS_CALLS_ANSWERED NUMBER 
, ADHERENCE NUMBER) 
TABLESPACE MAXDAT_DATA;

CREATE INDEX DP_SCORECARD.SC_SUMMARY_CC_STAFF_ID_NDX ON DP_SCORECARD.SC_SUMMARY_CC (STAFF_STAFF_ID ASC) 
TABLESPACE MAXDAT_INDX; 


create or replace view dp_scorecard.sc_summary_cc_sv as
select DISTINCT STAFF_STAFF_ID,
       STAFF_STAFF_NAME,
       DATES_MONTH,
       DATES_MONTH_NUM,
       DATES_YEAR,
       EXCLUSION_FLAG,
       TOT_CALLS_ANSWERED,
       TOT_SHORT_CALLS_ANSWERED,
       TOT_TOT_RETURN_TO_QUEUE,
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

GRANT select on DP_SCORECARD.sc_summary_cc_sv to MAXDAT_READ_ONLY;  
GRANT select on DP_SCORECARD.sc_summary_cc_sv to MAXDAT;  

  
create or replace view dp_scorecard.scorecard_prod_dp_bo_mthly_sv as
with overall as
(
select staff_id, dates_month_num as month_id, dates_year as month_name, event_name, event_name_sort/*event_subname_sort*/, metric as overall from dp_scorecard.sc_summary_bo
where event_name='Overall'
)
select a10.staff_id,
       a10.month_id,
       a10.month_name,
       a10.event_name_sort as event_sort_id,
       a10.event_name || ' >= 100%' as event_name,
       a10.overall
  from overall a10;
  
GRANT select on DP_SCORECARD.scorecard_prod_dp_bo_mthly_sv to MAXDAT_READ_ONLY;  
GRANT select on DP_SCORECARD.scorecard_prod_dp_bo_mthly_sv to MAXDAT;  

  CREATE or replace VIEW SCORECARD_ATTENDANCE_SCORE_SV
AS With staff as
(
select
       manager_staff_id,
       manager_name,
       supervisor_staff_id,
       supervisor_name,
       staff_staff_id,
       staff_staff_name,
       hire_date,
       0 as sc_attendance_id,
       hire_date as create_datetime
  from dp_scorecard.scorecard_hierarchy
)
, staff_starting_balance as
(
select manager_staff_id,
       manager_name,
       supervisor_staff_id,
       supervisor_name,
       staff_staff_id,
       staff_staff_name,
       --hire_date as dates,
       coalesce(ais.start_date,hire_date) as dates,
       'Starting Balance' as absence_type,
       'Starting Balance' as absence_comment_type,
       --40 as point_value,
       coalesce(ais.attendance_points,40) as point_value,
       --40 as balance,
       coalesce(ais.attendance_points,40) as balance,
       --0 as incentive_balance,
       coalesce(ais.incentive_points,0) as incentive_balance,
       --40 as total_balance,
       (coalesce(ais.attendance_points,40) + coalesce(ais.incentive_points,0)) as total_balance,
       NULL as incentive_flag,
       NULL as comments,
       create_datetime,
       null as create_by,
       NULL as last_updated_by,
       null as LAST_UPDATED_DATETIME,
       sc_attendance_id
  from staff s
  left outer join dp_scorecard.sc_attendance_initial_score ais on s.staff_staff_id = ais.staff_id
),
sc_attend_entries as
(
select s.manager_staff_id,
       s.manager_name,
       s.supervisor_staff_id,
       s.supervisor_name,
       s.staff_staff_id,
       s.staff_staff_name,
       sca.entry_date as dates,
       sca.absence_type,
       sca.point_value,
       sca.balance,
       sca.incentive_balance,
       sca.total_balance,
       sca.incentive_flag,
       sca.sc_attendance_id,
       sca.create_datetime,
       sca.create_by,
       sca.last_updated_by,
       sca.LAST_UPDATED_DATETIME
  from staff s
inner join DP_SCORECARD.SC_ATTENDANCE sca
    on s.staff_staff_id = sca.staff_id
)
select manager_staff_id,
       manager_name,
       supervisor_staff_id,
       supervisor_name,
       staff_staff_id,
       staff_staff_name,
       dates,
       absence_type,
       point_value,
       balance,
       incentive_balance,
       total_balance,
       incentive_flag,
       sc_attendance_id,
       create_datetime,
       create_by,
       last_updated_by,
       LAST_UPDATED_DATETIME
  from staff_starting_balance
union all
select manager_staff_id,
       manager_name,
       supervisor_staff_id,
       supervisor_name,
       staff_staff_id,
       staff_staff_name,
       dates,
       absence_type,
       point_value,
       balance,
       incentive_balance,
       total_balance,
       incentive_flag,
       sc_attendance_id,
       create_datetime,
       create_by,
       last_updated_by,
       LAST_UPDATED_DATETIME
  from sc_attend_entries;
  
CREATE or replace VIEW SCORECARD_CORRECT_ACTION_SV
AS select
          sh.manager_staff_id,
          sh.manager_name,
          sh.supervisor_staff_id,
          sh.supervisor_name,
          sh.staff_staff_id,
          sh.staff_staff_name,
          ca.ca_id,
          ca.ca_entry_date,
          ca.cal_id,
          cal.correction_action_type,
          ca.unsatisfactory_behavior,
          ca.comments,
          ca.create_by,
          ca.create_datetime,
          ca.last_updated_by,
          ca.LAST_UPDATED_DATETIME
      from dp_scorecard.sc_corrective_action ca
      join dp_scorecard.sc_corrective_action_lkup cal on ca.cal_id=cal.cal_id
      join dp_scorecard.scorecard_hierarchy sh on ca.staff_id=sh.staff_staff_id
	  ;
	  
  CREATE OR REPLACE FORCE VIEW "SCORECARD_EXCLUSION_SV" ("EXCLUSION_ID", "SUPERVISOR_STAFF_ID", "SUPERVISOR_NAME", "STAFF_NATID", "STAFF_STAFF_ID", "STAFF_STAFF_NAME", "EXCLUSION_DATE", "EXCLUSION_FLAG", "EXCLUSION_COMMENT", "CREATE_DATE", "CREATE_BY") AS 
  select exclusion_ID,
       supervisor_id as supervisor_staff_id,
       (select distinct supervisor_name from dp_scorecard.scorecard_hierarchy x where x.supervisor_staff_id=supervisor_id) as supervisor_name,
       agent_id as staff_natid,
       staff_id as staff_staff_id,
       (select distinct staff_staff_name from dp_scorecard.scorecard_hierarchy x where x.staff_staff_id=staff_id) as staff_staff_name,
       exclusion_date,
       exclusion_flag,
       exclusion_comment,
       create_date,
       case
         when Create_by_name is null then
          to_char(create_by)
         else
          create_by_name
       end as create_by
  from (select e.exclusion_ID,
               e.supervisor_id,
               e.agent_id,
               e.staff_id,
               e.exclusion_date,
               e.exclusion_flag,
               e.exclusion_comment,
               e.create_date,
               Create_by,
               (select sr_director_name as create_by
                  from dp_scorecard.scorecard_hierarchy_sv
                 where to_char(sr_director_natid) = to_char(e.create_by)
                union
                select director_name as create_by
                  from dp_scorecard.scorecard_hierarchy_sv
                 where to_char(director_natid) = to_char(e.create_by)
                union
                select sr_manager_name as create_by
                  from dp_scorecard.scorecard_hierarchy_sv
                 where to_char(sr_manager_natid) = to_char(e.create_by)
                union
                select manager_name as create_by
                  from dp_scorecard.scorecard_hierarchy_sv
                 where to_char(manager_natid) = to_char(e.create_by)
                union
                select supervisor_name as create_by
                  from dp_scorecard.scorecard_hierarchy_sv
                 where to_char(supervisor_natid) = to_char(e.create_by)) as Create_by_name
          from SC_EXCLUSION e
          where e.exclusion_flag = 'Y'
          and not exists (select 1 from sc_exclusion b 
                                   where b.exclusion_date = e.exclusion_date
                                   and b.agent_id = e.agent_id
                                   and b.staff_id = e.staff_id
                                   and b.exclusion_id > e.exclusion_id
                                   and b.exclusion_flag = 'N'));

								   
CREATE OR REPLACE VIEW SCORECARD_GOAL_SV
AS select
       sh.manager_staff_id,
       sh.manager_name,
       sh.supervisor_staff_id,
       sh.supervisor_name,
       sh.staff_staff_id,
       sh.staff_staff_name,
       g.goal_id,
       g.staff_id,
       g.goal_entry_date,
       g.gtl_id,
       g.goal_description,
       g.goal_date,
       g.progress_note,
       g.create_by,
       g.create_datetime,
       g.last_updated_by,
       g.LAST_UPDATED_DATETIME
  from dp_scorecard.sc_goal g
  join dp_scorecard.sc_goal_type_lkup gtl on g.gtl_id=gtl.gtl_id
  join dp_scorecard.scorecard_hierarchy sh on g.staff_id=sh.staff_staff_id
;

CREATE OR REPLACE VIEW SCORECARD_INCIDENTS_SV
AS With incidents as
 (
   SELECT a11.STAFF_ID as staff_staff_id,
          trunc(a11.TASK_START) AS_DATE,
          count((Case when a11.EVENT_ID in (1374, 1375, 1376, 1377, 1378, 1379) then 1 else null end)) INCIDENTS_COMPLETED,
          count((Case when a11.EVENT_ID in (1373) then 1 else null end)) DEFECTS_COMPLETED
     FROM MAXDAT.PP_WFM_ACTUALS_SV a11
    WHERE TRUNC(a11.task_start) >= TRUNC(SYSDATE-60) and trunc(a11.TASK_END)=trunc(a11.TASK_START)
      and (a11.EVENT_ID in (1374, 1375, 1376, 1377, 1378, 1379) or
           a11.EVENT_ID in (1373))
      and trunc(a11.TASK_END)=trunc(a11.TASK_START)
    group by a11.staff_id, trunc(a11.TASK_START)
 )
 select a10.staff_staff_id, a10.staff_staff_name, as_date, INCIDENTS_COMPLETED, DEFECTS_COMPLETED
 FROM DP_SCORECARD.SCORECARD_HIERARCHY_SV a10
 join incidents i on a10.staff_staff_id=i.staff_staff_id
;

CREATE OR REPLACE VIEW SCORECARD_PERFORM_TRACKER_SV
AS select
           sh.manager_staff_id,
           sh.manager_name,
           sh.supervisor_staff_id,
           sh.supervisor_name,
           sh.staff_staff_id,
           sh.staff_staff_name,
           pt.pt_id,
           pt.pt_entry_date,
           pt.dl_id,
           dl.discussion_topic,
           pt.comments,
           pt.create_by,
           pt.create_datetime,
           pt.last_updated_by,
           pt.LAST_UPDATED_DATETIME
    from dp_scorecard.sc_performance_tracker pt
    join dp_scorecard.sc_discussion_lkup dl on pt.dl_id=dl.dl_id
    join dp_scorecard.scorecard_hierarchy sh on pt.staff_id=sh.staff_staff_id
;

CREATE OR REPLACE VIEW SCORECARD_PROD_BO_MTHLY_SV
AS with total_logged as
(
select staff_id, dates_month_num as month_id, dates_year as month_name, event_name, event_name_sort/*event_subname_sort*/, metric as total_logged from dp_scorecard.sc_summary_bo
where event_subname='Total Logged'
),
activity_time as
(
select staff_id, dates_month_num as month_id, dates_year as month_name, event_name, event_name_sort/*event_subname_sort*/, metric as activity_time from dp_scorecard.sc_summary_bo
where event_subname='Total Activity Time'
),
targets as
(
select scorecard_group, target from
    (select distinct
           case
             when upper(scorecard_group) like 'OTHER%' then
              'All Other Tasks'
             else
              scorecard_group
           end as scorecard_group,
           target
      from maxdat.PP_BO_EVENT_TARGET_LKUP
     where SCORECARD_FLAG = 'Y' and (end_date is null or trunc(sysdate) <= trunc(end_date)))
)
select a10.staff_id,
       a10.month_id,
       a10.month_name,
       a10.event_name_sort as event_sort_id,
       a10.event_name || ' >= 100%' as event_name,
       a10.total_logged,
       a11.activity_time,
       (to_char(trunc((a11.activity_time * 3600) / 3600), 'FM999999990') || ':' || to_char(trunc(mod((a11.activity_time * 3600), 3600) / 60), 'FM00') || ':' || to_char(mod((a11.activity_time * 3600), 60), 'FM00')) as activity_time_in_hhmmss,
       (select target from targets where scorecard_group = a10.event_name) as target
  from total_logged a10
  left outer join activity_time a11
    on a10.staff_id = a11.staff_id
   and a10.month_id = a11.month_id
   and a10.event_name = a11.event_name
;

CREATE OR REPLACE VIEW SCORECARD_PROD_BO_SV
AS with total_logged as
(
select staff_id, dates, event_name_sort, event_name, metric as total_logged from dp_scorecard.sc_production_bo
where event_subname='Total Logged'
),
activity_time as
(
select staff_id, dates, event_name_sort, event_name, metric as activity_time from dp_scorecard.sc_production_bo
where event_subname='Total Activity Time'
),
targets as
(
select scorecard_group, target from
    (select distinct
           case
             when upper(scorecard_group) like 'OTHER%' then
              'All Other Tasks'
             else
              scorecard_group
           end as scorecard_group,
           target
      from maxdat.PP_BO_EVENT_TARGET_LKUP
     where SCORECARD_FLAG = 'Y' and (end_date is null or trunc(sysdate) <= trunc(end_date)))
)
select a10.staff_id,
       a10.dates,
       a10.event_name_sort as event_sort_id,
       a10.event_name,
       a10.total_logged,
       a11.activity_time,
       (to_char(trunc((a11.activity_time * 3600) / 3600), 'FM999999990') || ':' || to_char(trunc(mod((a11.activity_time * 3600), 3600) / 60), 'FM00') || ':' || to_char(mod((a11.activity_time * 3600), 60), 'FM00')) as activity_time_in_hhmmss,
       (select target from targets where scorecard_group = a10.event_name) as target
  from total_logged a10
  left outer join activity_time a11
    on a10.staff_id = a11.staff_id
   and a10.dates = a11.dates
   and a10.event_name = a11.event_name
;

CREATE OR REPLACE VIEW SCORECARD_PROD_DP_BO_SV
AS select dates, staff_id,  event_name, event_name_sort as event_sort_id, metric as productivity from dp_scorecard.sc_production_bo
where event_name='Daily Production'
;

CREATE OR REPLACE VIEW SCORECARD_PRODUCTION_BO_SV
AS select staff_id,
       dates,
       event_name_sort as sort_order,
       event_name,
       event_subname_sort,
       event_subname,
       case when event_subname = 'Total Logged' then to_char(metric)
         when event_subname = 'Total Activity Time' then
           to_char(trunc(round(metric * 3600,0)/3600), 'FM999999990')  || ':' || to_char(trunc(mod(round(metric * 3600,0),3600)/60), 'FM00') || ':' || to_char(mod(round(metric * 3600,0),60), 'FM00')
         else to_char((metric * 100), '999.99') || '%' end as metric
  from dp_scorecard.sc_production_bo
;

CREATE OR REPLACE VIEW SCORECARD_QUALITY_MTHLY_SV
AS with just_months as
(
      SELECT
      to_char(add_months (TRUNC (ADD_MONTHS (SYSDATE, -11), 'MM'), 1*Level -1), 'MM/DD/YYYY') as dates,
      to_char(add_months (TRUNC (ADD_MONTHS (SYSDATE, -11), 'MM'), 1*Level -1), 'Month') as dates_month,
      to_char(add_months (TRUNC (ADD_MONTHS (SYSDATE, -11), 'MM'), 1*Level -1), 'YYYYMM') as dates_month_num,
      to_char(add_months (TRUNC (ADD_MONTHS (SYSDATE, -11), 'MM'), 1*Level -1), 'Month YYYY') as dates_year,
      0 as avg_qc_score,
      0  as qcs_performed
    FROM Dual
    CONNECT BY Level <= MONTHS_BETWEEN(trunc(SYSDATE), TRUNC (ADD_MONTHS (SYSDATE, -11), 'MM')) + 1
),
quality_by_month as
(
SELECT distinct staff_staff_id,
       staff_staff_name,
       staff_natid,
       to_char(TRUNC(EVAL_DATE), 'YYYYMM') as dates_month_num,
       to_char(TRUNC(EVAL_DATE), 'Month YYYY') as dates_year,
       avg(SCORE_TOTAL) over (partition by staff_staff_id ,to_char(TRUNC(EVAL_DATE), 'YYYYMM')) as avg_qc_score,
       count(*) over (partition by staff_staff_id ,to_char(TRUNC(EVAL_DATE), 'YYYYMM')) as qcs_performed
  from dp_scorecard.SCORECARD_QUALITY_SV
),
combined as
(
  select r.staff_staff_id,
         r.staff_staff_name,
         r.staff_natid,
         r.dates_month_num,
         r.dates_year,
         r.avg_qc_score,
         r.qcs_performed
         from quality_by_month r
  union
  select r.staff_staff_id,
         r.staff_staff_name,
         r.staff_natid,
         jm.dates_month_num,
         jm.dates_year,
         jm.avg_qc_score,
         jm.qcs_performed
       from quality_by_month r, just_months jm
),
ranked as
(
select staff_staff_id,
         staff_staff_name,
         staff_natid,
         dates_month_num,
         dates_year,
         avg_qc_score,
         qcs_performed,
         rank() over(partition by staff_staff_id, dates_month_num order by qcs_performed desc) as rnk
         from combined order by staff_staff_id, dates_month_num
)
select staff_staff_id,
         staff_staff_name,
         staff_natid,
         dates_month_num,
         dates_year,
         avg_qc_score,
         qcs_performed
         from ranked where rnk=1
;

CREATE OR REPLACE VIEW SCORECARD_QUALITY_SV
AS SELECT S.staff_staff_id,
       S.staff_staff_name,
       S.staff_natid,
       F.SCORECARD_SCORE_TYPE,
       E.SCORE_TOTAL,
       COALESCE(E.CALL_DATE,E.EVALUATION_DATE_TIME) as EVAL_DATE,
       E.EVALUATION_REFERENCE
  FROM dp_scorecard.scorecard_hierarchy_sv S
  JOIN DP_SCORECARD.ENGAGE_ACTUALS E
    ON S.staff_natid = E.AGENT_ID
  JOIN DP_SCORECARD.ENGAGE_FORM_TYPE F
    ON E.EVALUATION_FORM = F.EVALUATION_FORM
 WHERE F.SCORECARD_SCORE_TYPE = 'QC'
   AND TRUNC(EVALUATION_DATE_TIME) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
;

CREATE OR REPLACE VIEW SCORECARD_QUALITY_TL_MTHLY_SV
AS With just_months as
(
      SELECT
      to_char(add_months (TRUNC (ADD_MONTHS (SYSDATE, -11), 'MM'), 1*Level -1), 'MM/DD/YYYY') as dates,
      to_char(add_months (TRUNC (ADD_MONTHS (SYSDATE, -11), 'MM'), 1*Level -1), 'Month') as dates_month,
      to_char(add_months (TRUNC (ADD_MONTHS (SYSDATE, -11), 'MM'), 1*Level -1), 'YYYYMM') as dates_month_num,
      to_char(add_months (TRUNC (ADD_MONTHS (SYSDATE, -11), 'MM'), 1*Level -1), 'Month YYYY') as dates_year,
      0  as qcs_performed
    FROM Dual
    CONNECT BY Level <= MONTHS_BETWEEN(trunc(SYSDATE), TRUNC (ADD_MONTHS (SYSDATE, -11), 'MM')) + 1
),
quality_by_month as
(
SELECT staff_staff_id,
       staff_staff_name,
       staff_natid,
       to_char(TRUNC(EVAL_DATE), 'YYYYMM') as dates_month_num,
       to_char(TRUNC(EVAL_DATE), 'Month YYYY') as dates_year,
       count(*) over (partition by staff_staff_id ,to_char(TRUNC(EVAL_DATE), 'YYYYMM')) as qcs_performed
  from dp_scorecard.scorecard_quality_tl_sv
),
combined as
(
  select r.staff_staff_id,
         r.staff_staff_name,
         r.staff_natid,
         r.dates_month_num,
         r.dates_year,
         r.qcs_performed
         from quality_by_month r
  union
  select r.staff_staff_id,
         r.staff_staff_name,
         r.staff_natid,
         jm.dates_month_num,
         jm.dates_year,
         jm.qcs_performed
       from quality_by_month r, just_months jm
),
ranked as
(
select staff_staff_id,
         staff_staff_name,
         staff_natid,
         dates_month_num,
         dates_year,
         qcs_performed,
         rank() over(partition by staff_staff_id, dates_month_num order by qcs_performed desc) as rnk
         from combined order by staff_staff_id, dates_month_num
)
select staff_staff_id,
         staff_staff_name,
         staff_natid,
         dates_month_num,
         dates_year,
         qcs_performed
         from ranked where rnk=1
;

CREATE OR REPLACE VIEW SCORECARD_QUALITY_TL_SV
AS with QUALITY AS
(
SELECT DISTINCT
A.EVALUATOR_ID, COALESCE(A.CALL_DATE,A.EVALUATION_DATE_TIME) AS EVALUATION_DATE_TIME, F.SCORECARD_SCORE_TYPE, F.SCORECARD_GROUP, A.EVALUATION_REFERENCE, A.SCORE_TOTAL,
A.AGENT_ID AS Evaluatee_EID, (LAST_NAME||', '|| FIRST_NAME) as Evaluatee
FROM DP_SCORECARD.ENGAGE_ACTUALS A
JOIN DP_SCORECARD.ENGAGE_FORM_TYPE F ON A.EVALUATION_FORM = F.EVALUATION_FORM
JOIN MAXDAT.PP_WFM_STAFF S ON A.AGENT_ID=S.NATIONAL_ID
)
SELECT distinct S.staff_staff_id,
       S.staff_staff_name,
       S.staff_natid,
       E.Evaluatee_EID,
       E.Evaluatee,
       E.SCORECARD_SCORE_TYPE,
       E.SCORE_TOTAL,
       E.EVALUATION_DATE_TIME as EVAL_DATE,
       E.EVALUATION_REFERENCE
  FROM dp_scorecard.scorecard_hierarchy_sv S
  JOIN QUALITY E ON S.staff_natid = E.EVALUATOR_ID
;

CREATE OR REPLACE VIEW DP_SCORECARD.SCORECARD_SUMMARY_BO_EVENTS_SV
AS select staff_id,
       dates_month_num,
       dates_year,
       event_name_sort as sort_order,
       (event_name || ' >= 100%') as event_name,
       event_subname_sort,
       event_subname,
       to_char((metric * 100), '999.99') || '%' as metric
  from dp_scorecard.SC_SUMMARY_BO
 where (Event_subname = 'Task Production' or event_subname IS NULL)
;

create or replace view scorecard_summary_cc_sv as
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
   and  a11.dates_month_num=a10.dates_month_num  /*order by a11.staff_staff_id, a11.dates_month_num*/;

CREATE OR REPLACE VIEW SCORECARD_SUMMARY_TL_SV
AS WITH QC_metrics AS
 (
 select staff_staff_id,
           staff_staff_name,
           staff_natid,
           dates_month_num,
           dates_year,
           qcs_performed
      from dp_scorecard.scorecard_quality_tl_mthly_sv
 ),
ATTEND_Metrics AS
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
 SELECT
   all_staff.staff_staff_id,
   all_staff.staff_staff_name,
   all_staff.dates_month,
   all_staff.dates_month_num,
   all_staff.dates_year,
   am.balance,
   am.total_balance,
   qc.qcs_performed
 FROM (select distinct staff_staff_id,
         staff_staff_name,
         dates_month,
         dates_month_num,
         dates_year from dp_scorecard.scorecard_attendance_mthly_sv
         /*where staff_staff_id=1181*/) all_staff
 left outer join ATTEND_Metrics am on all_staff.staff_staff_id = am.staff_staff_id and all_staff.dates_month_num=am.dates_month_num
 left outer join QC_metrics qc on all_staff.staff_staff_id = qc.staff_staff_id and all_staff.dates_month_num=qc.dates_month_num
 order by all_staff.staff_staff_id,
         all_staff.dates_month_num
;