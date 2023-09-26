CREATE OR REPLACE VIEW DP_SCORECARD.SCORECARD_PROD_BO_MTHLY_SV
AS
with total_logged as
(
select staff_id, dates_month_num as month_id, dates_year as month_name, event_name, event_name_sort, metric as total_logged from dp_scorecard.sc_summary_bo
where event_subname='Total Logged'
),
activity_time as
(
select staff_id, dates_month_num as month_id, dates_year as month_name, event_name, event_name_sort, metric as activity_time from dp_scorecard.sc_summary_bo
where event_subname='Total Activity Time'
),
targets as
(
select scorecard_group, target, ops_group, start_date, end_date from
    (select distinct
           case
             when upper(scorecard_group) like 'OTHER%' then
              'All Other Tasks'
             else
              scorecard_group
           end as scorecard_group,
           target,
           ops_group,
           start_date,
           end_date
      from maxdat.PP_BO_EVENT_TARGET_LKUP
     where SCORECARD_FLAG = 'Y')
)
select a10.staff_id,
       (select staff_natid from dp_scorecard.scorecard_hierarchy_sv where staff_staff_id=a10.staff_id) as staff_natid,
       a10.month_id,
       a10.month_name,
       a10.event_name_sort as event_sort_id,
       a10.event_name || ' >= 100%' as event_name,
       a10.total_logged,
       a11.activity_time,
       (to_char(trunc((a11.activity_time * 3600) / 3600), 'FM999999990') || ':' || to_char(trunc(mod((a11.activity_time * 3600), 3600) / 60), 'FM00') || ':' || to_char(mod((a11.activity_time * 3600), 60), 'FM00')) as activity_time_in_hhmmss,
       (select DISTINCT target from targets where scorecard_group = a10.event_name AND  a10.month_id >= to_char(targets.start_date,'YYYYMM') AND (targets.end_date IS NULL OR a10.month_id <= to_char(targets.end_date,'YYYYMM')) ) as target,
       (select DISTINCT ops_group from targets where scorecard_group = a10.event_name AND  a10.month_id >= to_char(targets.start_date,'YYYYMM') AND (targets.end_date IS NULL OR a10.month_id <= to_char(targets.end_date,'YYYYMM')) ) as ops_group
  from total_logged a10
  left outer join activity_time a11
    on a10.staff_id = a11.staff_id
   and a10.month_id = a11.month_id
   and a10.event_name = a11.event_name;

GRANT SELECT ON DP_SCORECARD.SCORECARD_PROD_BO_MTHLY_SV TO MAXDAT;
GRANT SELECT ON DP_SCORECARD.SCORECARD_PROD_BO_MTHLY_SV TO MAXDAT_READ_ONLY;

CREATE OR REPLACE VIEW DP_SCORECARD.SCORECARD_PROD_DP_BO_MTHLY_SV
AS
with overall as
(
select staff_id, dates_month_num as month_id, dates_year as month_name, event_name || ' >= 100%' as event_name, event_name_sort, metric as overall from dp_scorecard.sc_summary_bo
where event_name='Overall'
),
adherence as
(
select staff_id, dates_month_num as month_id, dates_year as month_name, event_name, event_name_sort, metric as overall from dp_scorecard.sc_summary_bo
where event_name='Monthly Adherence'
)
select a10.staff_id,
       (select staff_natid from dp_scorecard.scorecard_hierarchy_sv where staff_staff_id=a10.staff_id) as staff_natid,
       a10.month_id,
       a10.month_name,
       a10.event_name_sort as event_sort_id,
       a10.event_name,
       a10.overall
  from overall a10
union
select a10.staff_id,
       (select staff_natid from dp_scorecard.scorecard_hierarchy_sv where staff_staff_id=a10.staff_id) as staff_natid,
       a10.month_id,
       a10.month_name,
       a10.event_name_sort as event_sort_id,
       a10.event_name,
       a10.overall
  from adherence a10
;

GRANT SELECT ON DP_SCORECARD.SCORECARD_PROD_DP_BO_MTHLY_SV TO MAXDAT_READ_ONLY;
GRANT SELECT ON DP_SCORECARD.SCORECARD_PROD_DP_BO_MTHLY_SV TO MAXDAT;

CREATE OR REPLACE VIEW DP_SCORECARD.SCORECARD_SUMMARY_CC_SV
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
        a10.adherence
        from ATTEND_Metrics a11
   LEFT OUTER JOIN dp_scorecard.sc_summary_cc a10 ON a11.staff_staff_id=a10.staff_staff_id
   and  a11.dates_month_num=a10.dates_month_num  /*order by a11.staff_staff_id, a11.dates_month_num*/
;

GRANT SELECT ON DP_SCORECARD.SCORECARD_SUMMARY_CC_SV TO MAXDAT_READ_ONLY;
GRANT SELECT ON DP_SCORECARD.SCORECARD_SUMMARY_CC_SV TO MAXDAT;

