 CREATE OR REPLACE VIEW dp_scorecard.SCORECARD_SUMMARY_BO_EVENTS_SV AS
select staff_id,
       dates_month_num,
       dates_year,
       event_name_sort as sort_order,
       (event_name || ' >= 100%') as event_name,
       event_subname_sort,
       event_subname,
       to_char((metric * 100), '999.99') || '%' as metric
  from dp_scorecard.SC_SUMMARY_BO
 where (Event_subname = 'Task Production' or event_subname IS NULL);

GRANT select on DP_SCORECARD.SCORECARD_SUMMARY_BO_EVENTS_SV to MAXDAT;  
GRANT select on DP_SCORECARD.SCORECARD_SUMMARY_BO_EVENTS_SV to MAXDAT_READ_ONLY;  


CREATE OR REPLACE VIEW dp_scorecard.SCORECARD_PRODUCTION_BO_SV AS
select staff_id,
       dates,
       event_name_sort as sort_order,
       event_name,
       event_subname_sort,
       event_subname,
       case when event_subname = 'Total Logged' then to_char(metric)
         when event_subname = 'Total Activity Time' then 
           to_char(trunc(round(metric * 3600,0)/3600), 'FM999999990')  || ':' || to_char(trunc(mod(round(metric * 3600,0),3600)/60), 'FM00') || ':' || to_char(mod(round(metric * 3600,0),60), 'FM00')
         else to_char((metric * 100), '999.99') || '%' end as metric 
  from dp_scorecard.sc_production_bo;

GRANT select on DP_SCORECARD.SCORECARD_PRODUCTION_BO_SV to MAXDAT;  
GRANT select on DP_SCORECARD.SCORECARD_PRODUCTION_BO_SV to MAXDAT_READ_ONLY;  

CREATE OR REPLACE VIEW dp_scorecard.SCORECARD_INCIDENTS_SV AS
With incidents as 
(
  SELECT a11.STAFF_ID as staff_staff_id,
         trunc(a11.TASK_START) AS_DATE,
         count((Case when a11.EVENT_ID in (1374, 1375, 1376, 1377, 1378, 1379) then 1 else null end)) INCIDENTS_COMPLETED,
         count((Case when a11.EVENT_ID in (1373) then 1 else null end)) DEFECTS_COMPLETED
    FROM MAXDAT.PP_WFM_ACTUALS_SV a11
   WHERE TRUNC(a11.task_start) >= TRUNC(ADD_MONTHS(SYSDATE, 0), 'MM')
     and (a11.EVENT_ID in (1374, 1375, 1376, 1377, 1378, 1379) or
          a11.EVENT_ID in (1373))
     and a11.TASK_END is not null
   group by a11.staff_id, trunc(a11.TASK_START)
)
select a10.staff_staff_id, a10.staff_staff_name, as_date, INCIDENTS_COMPLETED, DEFECTS_COMPLETED
FROM DP_SCORECARD.SCORECARD_HIERARCHY_SV a10
join incidents i on a10.staff_staff_id=i.staff_staff_id;  

GRANT select on DP_SCORECARD.SCORECARD_INCIDENTS_SV to MAXDAT_READ_ONLY;
GRANT select on DP_SCORECARD.SCORECARD_INCIDENTS_SV to MAXDAT;

--This is for Team Lead Quality:
CREATE OR REPLACE VIEW dp_scorecard.SCORECARD_QUALITY_TL_SV AS
SELECT distinct S.staff_staff_id,
       S.staff_staff_name,
       S.staff_natid,
       S1.staff_natid as Evaluatee_EID,
       S1.staff_staff_name as Evaluatee,
       F.SCORECARD_SCORE_TYPE,
       E.SCORE_TOTAL,
       E.EVALUATION_DATE_TIME as EVAL_DATE,
       E.EVALUATION_REFERENCE
  FROM dp_scorecard.scorecard_hierarchy_sv S
  JOIN DP_SCORECARD.ENGAGE_ACTUALS E
    ON S.staff_natid = E.EVALUATOR_ID
  JOIN DP_SCORECARD.ENGAGE_FORM_TYPE F
    ON E.EVALUATION_FORM = F.EVALUATION_FORM
  JOIN dp_scorecard.scorecard_hierarchy_sv S1
    ON S1.staff_natid = E.AGENT_ID
 WHERE F.SCORECARD_SCORE_TYPE = 'QC'
   AND TRUNC(EVALUATION_DATE_TIME) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM');

GRANT select on DP_SCORECARD.SCORECARD_QUALITY_TL_SV to MAXDAT;
GRANT select on DP_SCORECARD.SCORECARD_QUALITY_TL_SV to MAXDAT_READ_ONLY;

CREATE OR REPLACE VIEW dp_scorecard.SCORECARD_QUALITY_TL_MTHLY_SV AS
With just_months as
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
         from ranked where rnk=1;  
     
         
         
GRANT select on DP_SCORECARD.SCORECARD_QUALITY_TL_MTHLY_SV to MAXDAT;    
GRANT select on DP_SCORECARD.SCORECARD_QUALITY_TL_MTHLY_SV to MAXDAT_READ_ONLY;    

CREATE OR REPLACE VIEW dp_scorecard.SCORECARD_QUALITY_SV AS
SELECT S.staff_staff_id,
       S.staff_staff_name,
       S.staff_natid,
       F.SCORECARD_SCORE_TYPE,
       E.SCORE_TOTAL,
       E.EVALUATION_DATE_TIME as EVAL_DATE,
       E.EVALUATION_REFERENCE
  FROM dp_scorecard.scorecard_hierarchy_sv S
  JOIN DP_SCORECARD.ENGAGE_ACTUALS E
    ON S.staff_natid = E.AGENT_ID
  JOIN DP_SCORECARD.ENGAGE_FORM_TYPE F
    ON E.EVALUATION_FORM = F.EVALUATION_FORM
 WHERE F.SCORECARD_SCORE_TYPE = 'QC'
   AND TRUNC(EVALUATION_DATE_TIME) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM');
   
GRANT select on DP_SCORECARD.SCORECARD_QUALITY_SV to MAXDAT_READ_ONLY;
GRANT select on DP_SCORECARD.SCORECARD_QUALITY_SV to MAXDAT;
   
CREATE OR REPLACE VIEW dp_scorecard.SCORECARD_SUMMARY_CC_SV AS
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
select a10.staff_staff_id,
       a10.staff_staff_name,
       a10.dates_month,
       a10.dates_month_num,
       a10.dates_year,
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
       a11.total_balance
  from dp_scorecard.sc_summary_cc a10
  LEFT OUTER JOIN ATTEND_Metrics a11 ON a10.staff_staff_id=a11.staff_staff_id and  a10.dates_month_num=a11.dates_month_num  order by a10.staff_staff_id,
       a10.dates_month_num;
       
GRANT select on DP_SCORECARD.SCORECARD_SUMMARY_CC_SV to MAXDAT_READ_ONLY;  
GRANT select on DP_SCORECARD.SCORECARD_SUMMARY_CC_SV to MAXDAT;  

CREATE OR REPLACE VIEW dp_scorecard.SCORECARD_SUMMARY_TL_SV AS
 WITH QC_metrics AS
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

GRANT select on DP_SCORECARD.SCORECARD_SUMMARY_TL_SV to MAXDAT_READ_ONLY;
GRANT select on DP_SCORECARD.SCORECARD_SUMMARY_TL_SV to MAXDAT;

CREATE OR REPLACE VIEW dp_scorecard.SCORECARD_QUALITY_MTHLY_SV AS
with just_months as
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
         from ranked where rnk=1;    

GRANT select on DP_SCORECARD.SCORECARD_QUALITY_MTHLY_SV to MAXDAT_READ_ONLY; 
GRANT select on DP_SCORECARD.SCORECARD_QUALITY_MTHLY_SV to MAXDAT; 

create or replace view dp_scorecard.scorecard_exclusion_sv as
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
          from SC_EXCLUSION e);

GRANT select on DP_SCORECARD.scorecard_exclusion_sv to MAXDAT_READ_ONLY;
GRANT select on DP_SCORECARD.scorecard_exclusion_sv to MAXDAT; 

  CREATE OR REPLACE FORCE VIEW "DP_SCORECARD"."SCORECARD_QUALITY_TL_SV" ("STAFF_STAFF_ID", "STAFF_STAFF_NAME", "STAFF_NATID", "EVALUATEE_EID", "EVALUATEE", "SCORECARD_SCORE_TYPE", "SCORE_TOTAL", "EVAL_DATE", "EVALUATION_REFERENCE") AS 
  with QUALITY AS
(
SELECT
A.EVALUATOR_ID, A.EVALUATION_DATE_TIME, F.SCORECARD_SCORE_TYPE, F.SCORECARD_GROUP, A.EVALUATION_REFERENCE, A.SCORE_TOTAL, 
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
  JOIN QUALITY E ON S.staff_natid = E.EVALUATOR_ID;

GRANT select on DP_SCORECARD.SCORECARD_QUALITY_TL_SV to MAXDAT_READ_ONLY;
GRANT select on DP_SCORECARD.SCORECARD_QUALITY_TL_SV to MAXDAT; 
