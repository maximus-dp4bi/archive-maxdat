CREATE OR REPLACE FORCE VIEW DP_SCORECARD.SCORECARD_SUMMARY_CC_ROLLUP_SV
AS 
select supervisor_staff_id,
       to_date(dates_month_num,'YYYYMM') as d_date,
       dates_month,
       dates_month_num,
       dates_year,
		  'Q'||to_char(add_months(to_date(dates_month_num,'yyyymm'),+3),'Q')
		     ||' '||to_char(add_months(to_date(dates_month_num,'yyyymm'),+3),'YYYY')  as dates_qtr_year,
       BUILDING,
       DEPARTMENT,
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
