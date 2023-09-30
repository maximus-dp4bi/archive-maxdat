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
