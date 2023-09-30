



 create or replace view sc_summary_cc_sv as
 select * from dp_scorecard.sc_summary_cc;

 grant select on dp_scorecard.sc_summary_cc_sv to MAXDAT;
 grant select on dp_scorecard.sc_summary_cc_sv to MAXDAT_READ_ONLY;


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

create or replace procedure              UPDATE_SC_ATTENDANCE_MTHLY
(in_staff_id IN NUMBER default null)
AS

begin

if in_staff_id is null then
    Delete from scorecard_attendance_mthly;
    commit;
    
    insert INTO scorecard_attendance_mthly (MANAGER_STAFF_ID, MANAGER_NAME, SUPERVISOR_STAFF_ID, SUPERVISOR_NAME, STAFF_STAFF_ID, STAFF_STAFF_NAME, DATES_MONTH, DATES_MONTH_NUM, DATES_YEAR, BALANCE, TOTAL_BALANCE, SC_ATTENDANCE_ID)
    with all_recs as
    (
    select manager_staff_id,
           manager_name,
           supervisor_staff_id,
           supervisor_name,
           staff_staff_id,
           staff_staff_name,
           dates,
           to_char(dates, 'Month') as dates_month,
           to_char(dates, 'YYYYMM') as dates_month_num,
           to_char(dates, 'Month YYYY') as dates_year,
           balance,
           total_balance,
           sc_attendance_id,
           create_datetime,
           rownum as rn
      from dp_scorecard.scorecard_attendance_score_sv
      order by staff_staff_id, dates_month_num, dates desc, create_datetime desc --staff_staff_id, dates_month_num, create_datetime
    ),
    ranked as
    (
    select manager_staff_id,
           manager_name,
           supervisor_staff_id,
           supervisor_name,
           staff_staff_id,
           staff_staff_name,
           dates,
           dates_month,
           dates_month_num,
           dates_year,
           balance,
           total_balance,
           sc_attendance_id,
           create_datetime,
           rn
      from (select manager_staff_id,
                   manager_name,
                   supervisor_staff_id,
                   supervisor_name,
                   staff_staff_id,
                   staff_staff_name,
                   dates,
                   dates_month,
                   dates_month_num,
                   dates_year,
                   balance,
                   total_balance,
                   sc_attendance_id,
                   create_datetime,
                   rn,
                   rank() over(partition by staff_staff_id, dates_month_num order by dates/*rn*/ desc, create_datetime desc) as rnk
              from all_recs) y
    where y.rnk = 1
    ),
    just_months as
    (
         SELECT
          to_char(add_months (trunc (to_date('01/01/2012','MM/DD/YYYY'), 'MM'), 1*Level -1), 'MM/DD/YYYY') as dates,
          to_char(add_months (trunc (to_date('01/01/2012','MM/DD/YYYY'), 'MM'), 1*Level -1), 'Month') as dates_month,
          to_char(add_months (trunc (to_date('01/01/2012','MM/DD/YYYY'), 'MM'), 1*Level -1), 'YYYYMM') as dates_month_num,
          to_char(add_months (trunc (to_date('01/01/2012','MM/DD/YYYY'), 'MM'), 1*Level -1), 'Month YYYY') as dates_year,
          0 as balance,
          0 as total_balance,
          -1 as sc_attendance_id,
          0 as rn
        FROM Dual
        CONNECT BY Level <= MONTHS_BETWEEN(trunc(SYSDATE), to_date('01/01/2012','MM/DD/YYYY')) + 1
    ),
    combined as
    (
      select r.manager_staff_id,
             r.manager_name,
             r.supervisor_staff_id,
             r.supervisor_name,
             r.staff_staff_id,
             r.staff_staff_name,
             jm.dates_month,
             jm.dates_month_num,
             jm.dates_year,
             jm.balance,
             jm.total_balance,
             jm.sc_attendance_id,
             jm.rn from ranked r, just_months jm
             where jm.dates_month_num <> r.dates_month_num
      union
      select manager_staff_id,
             manager_name,
             supervisor_staff_id,
             supervisor_name,
             staff_staff_id,
             staff_staff_name,
             dates_month,
             dates_month_num,
             dates_year,
             balance,
             total_balance,
             sc_attendance_id,
             rn
           from ranked
           order by staff_staff_id, dates_month_num
    ),
    lead_balance as
    (
    select manager_staff_id,
           manager_name,
           supervisor_staff_id,
           supervisor_name,
           staff_staff_id,
           staff_staff_name,
           to_number(dates_month_num) as dates_month_num,
           balance,
           total_balance,
           to_number(coalesce(lead (dates_month_num,1) over (partition by staff_staff_id ORDER BY staff_staff_id, dates_month_num ),'207707')) AS end_dates_month_num
    from ranked
    ),
    rolled_balances as
    (
    select c.manager_staff_id,
           c.manager_name,
           c.supervisor_staff_id,
           c.supervisor_name,
           c.staff_staff_id,
           c.staff_staff_name,
           c.dates_month,
           c.dates_month_num,
           c.dates_year,
           coalesce((select balance
                      from lead_balance
                     where staff_staff_id = c.staff_staff_id
                       and (to_number(c.dates_month_num) >= dates_month_num and
                           to_number(c.dates_month_num) < end_dates_month_num)),
                    0) as balance,
           coalesce((select total_balance
                      from lead_balance
                     where staff_staff_id = c.staff_staff_id
                       and (to_number(c.dates_month_num) >= dates_month_num and
                           to_number(c.dates_month_num) < end_dates_month_num)),
                    0) as total_balance,
           --c.total_balance as original_balance,
           c.sc_attendance_id,
           c.rn
      from combined c
     where c.dates_month_num in
           (select to_number(dates_month_num)
              from just_months
             where to_date(dates, 'mm/dd/yyyy') >= trunc(sysdate - 365))
    )
    select
           manager_staff_id,
           manager_name,
           supervisor_staff_id,
           supervisor_name,
           staff_staff_id,
           staff_staff_name,
           dates_month,
           dates_month_num,
           dates_year,
           balance, --case when balance=0 then 40 else balance end as balance,
           total_balance, --case when total_balance=0 then 40 else total_balance end as total_balance,
           sc_attendance_id
           from
           (
              select manager_staff_id,
                     manager_name,
                     supervisor_staff_id,
                     supervisor_name,
                     staff_staff_id,
                     staff_staff_name,
                     dates_month,
                     dates_month_num,
                     dates_year,
                     balance,
                     total_balance,
                     sc_attendance_id,
                     rn,
                     rank() over(partition by staff_staff_id, dates_month_num order by sc_attendance_id desc) as rnk
                from rolled_balances
             ) where rnk=1 order by staff_staff_id, dates_month_num;
else
      Delete from scorecard_attendance_mthly
      where staff_staff_id = in_staff_id;   
    
    insert INTO scorecard_attendance_mthly (MANAGER_STAFF_ID, MANAGER_NAME, SUPERVISOR_STAFF_ID, SUPERVISOR_NAME, STAFF_STAFF_ID, STAFF_STAFF_NAME, DATES_MONTH, DATES_MONTH_NUM, DATES_YEAR, BALANCE, TOTAL_BALANCE, SC_ATTENDANCE_ID)
    with all_recs as
    (
    select manager_staff_id,
           manager_name,
           supervisor_staff_id,
           supervisor_name,
           staff_staff_id,
           staff_staff_name,
           dates,
           to_char(dates, 'Month') as dates_month,
           to_char(dates, 'YYYYMM') as dates_month_num,
           to_char(dates, 'Month YYYY') as dates_year,
           balance,
           total_balance,
           sc_attendance_id,
           create_datetime,
           rownum as rn
      from dp_scorecard.scorecard_attendance_score_sv
      where staff_staff_id = in_staff_id
      order by staff_staff_id, dates_month_num, dates desc, create_datetime desc --staff_staff_id, dates_month_num, create_datetime
    ),
    ranked as
    (
    select manager_staff_id,
           manager_name,
           supervisor_staff_id,
           supervisor_name,
           staff_staff_id,
           staff_staff_name,
           dates,
           dates_month,
           dates_month_num,
           dates_year,
           balance,
           total_balance,
           sc_attendance_id,
           create_datetime,
           rn
      from (select manager_staff_id,
                   manager_name,
                   supervisor_staff_id,
                   supervisor_name,
                   staff_staff_id,
                   staff_staff_name,
                   dates,
                   dates_month,
                   dates_month_num,
                   dates_year,
                   balance,
                   total_balance,
                   sc_attendance_id,
                   create_datetime,
                   rn,
                   rank() over(partition by staff_staff_id, dates_month_num order by dates/*rn*/ desc, create_datetime desc) as rnk
              from all_recs) y
    where y.rnk = 1
    ),
    just_months as
    (
         SELECT
          to_char(add_months (trunc (to_date('01/01/2012','MM/DD/YYYY'), 'MM'), 1*Level -1), 'MM/DD/YYYY') as dates,
          to_char(add_months (trunc (to_date('01/01/2012','MM/DD/YYYY'), 'MM'), 1*Level -1), 'Month') as dates_month,
          to_char(add_months (trunc (to_date('01/01/2012','MM/DD/YYYY'), 'MM'), 1*Level -1), 'YYYYMM') as dates_month_num,
          to_char(add_months (trunc (to_date('01/01/2012','MM/DD/YYYY'), 'MM'), 1*Level -1), 'Month YYYY') as dates_year,
          0 as balance,
          0 as total_balance,
          -1 as sc_attendance_id,
          0 as rn
        FROM Dual
        CONNECT BY Level <= MONTHS_BETWEEN(trunc(SYSDATE), to_date('01/01/2012','MM/DD/YYYY')) + 1
    ),
    combined as
    (
      select r.manager_staff_id,
             r.manager_name,
             r.supervisor_staff_id,
             r.supervisor_name,
             r.staff_staff_id,
             r.staff_staff_name,
             jm.dates_month,
             jm.dates_month_num,
             jm.dates_year,
             jm.balance,
             jm.total_balance,
             jm.sc_attendance_id,
             jm.rn from ranked r, just_months jm
             where jm.dates_month_num <> r.dates_month_num
      union
      select manager_staff_id,
             manager_name,
             supervisor_staff_id,
             supervisor_name,
             staff_staff_id,
             staff_staff_name,
             dates_month,
             dates_month_num,
             dates_year,
             balance,
             total_balance,
             sc_attendance_id,
             rn
           from ranked
           order by staff_staff_id, dates_month_num
    ),
    lead_balance as
    (
    select manager_staff_id,
           manager_name,
           supervisor_staff_id,
           supervisor_name,
           staff_staff_id,
           staff_staff_name,
           to_number(dates_month_num) as dates_month_num,
           balance,
           total_balance,
           to_number(coalesce(lead (dates_month_num,1) over (partition by staff_staff_id ORDER BY staff_staff_id, dates_month_num ),'207707')) AS end_dates_month_num
    from ranked
    ),
    rolled_balances as
    (
    select c.manager_staff_id,
           c.manager_name,
           c.supervisor_staff_id,
           c.supervisor_name,
           c.staff_staff_id,
           c.staff_staff_name,
           c.dates_month,
           c.dates_month_num,
           c.dates_year,
           coalesce((select balance
                      from lead_balance
                     where staff_staff_id = c.staff_staff_id
                       and (to_number(c.dates_month_num) >= dates_month_num and
                           to_number(c.dates_month_num) < end_dates_month_num)),
                    0) as balance,
           coalesce((select total_balance
                      from lead_balance
                     where staff_staff_id = c.staff_staff_id
                       and (to_number(c.dates_month_num) >= dates_month_num and
                           to_number(c.dates_month_num) < end_dates_month_num)),
                    0) as total_balance,
           --c.total_balance as original_balance,
           c.sc_attendance_id,
           c.rn
      from combined c
     where c.dates_month_num in
           (select to_number(dates_month_num)
              from just_months
             where to_date(dates, 'mm/dd/yyyy') >= trunc(sysdate - 365))
    )
    select
           manager_staff_id,
           manager_name,
           supervisor_staff_id,
           supervisor_name,
           staff_staff_id,
           staff_staff_name,
           dates_month,
           dates_month_num,
           dates_year,
           balance, --case when balance=0 then 40 else balance end as balance,
           total_balance, --case when total_balance=0 then 40 else total_balance end as total_balance,
           sc_attendance_id
           from
           (
              select manager_staff_id,
                     manager_name,
                     supervisor_staff_id,
                     supervisor_name,
                     staff_staff_id,
                     staff_staff_name,
                     dates_month,
                     dates_month_num,
                     dates_year,
                     balance,
                     total_balance,
                     sc_attendance_id,
                     rn,
                     rank() over(partition by staff_staff_id, dates_month_num order by sc_attendance_id desc) as rnk
                from rolled_balances
             ) where rnk=1 order by staff_staff_id, dates_month_num;
end if;
commit;
end update_sc_attendance_mthly;
/

CREATE OR REPLACE FORCE VIEW "DP_SCORECARD"."SCORECARD_SUMMARY_CC_SV" ("STAFF_STAFF_ID", "STAFF_STAFF_NAME", "DATES_MONTH", "DATES_MONTH_NUM", "DATES_YEAR", "EXCLUSION_FLAG", "TOT_CALLS_ANSWERED", "TOT_SHORT_CALLS_ANSWERED", "TOT_TOT_RETURN_TO_QUEUE", "TOT_AVERAGE_HANDLE_TIME", "TOT_SCHED_PRODUCTIVE_TIME", "TOT_ACTUAL_PRODUCTIVE_TIME", "TOT_TALK_TIME", "TOT_WRAP_UP_TIME", "TOT_LOGGED_IN_TIME", "TOT_NOT_READY_TIME", "TOT_BREAK_TIME", "TOT_LUNCH_TIME", "QCS_PERFORMED", "AVG_QC_SCORE", "TOT_INCIDENTS_COMPLETED", "DAYS_INCIDENTS_COMPLETED", "TOT_DEFECTS_COMPLETED", "DAYS_DEFECTS_COMPLETED", "LAG_TIME_TOT_SCHED_PROD_TIME", "TOT_CALL_RECORDS", "TOT_CUSTOMER_COUNT", "TOT_CALL_WRAP_UP_COUNT", "TOT_WRAP_UP_ERROR", "DAYS_SHORT_CALLS_GT_10", "DAYS_CALLS_ANSWERED", "BALANCE", "TOTAL_BALANCE") AS 
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
        a11.total_balance
        from ATTEND_Metrics a11
   LEFT OUTER JOIN dp_scorecard.sc_summary_cc a10 ON a11.staff_staff_id=a10.staff_staff_id
   and  a11.dates_month_num=a10.dates_month_num  /*order by a11.staff_staff_id, a11.dates_month_num*/
;

GRANT select on DP_SCORECARD.SCORECARD_SUMMARY_CC_SV to MAXDAT_READ_ONLY;
GRANT select on DP_SCORECARD.SCORECARD_SUMMARY_CC_SV to MAXDAT; 

DECLARE
   
   cursor c1 is
     select distinct staff_staff_id
         from DP_SCORECARD.SCORECARD_ATTENDANCE_SCORE_SV
         where staff_staff_id is not null;

BEGIN
  FOR RECS IN c1
  LOOP
    DP_SCORECARD.calc_attendance_score(RECS.staff_staff_id);  
  END LOOP;
  DP_SCORECARD.update_sc_attendance_mthly();
END;

/

commit;
