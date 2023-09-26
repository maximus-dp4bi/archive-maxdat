DROP VIEW DP_SCORECARD.SCORECARD_SUMMARY_CC_ROLLUP_SV;

CREATE OR REPLACE FORCE VIEW DP_SCORECARD.SCORECARD_SUMMARY_CC_ROLLUP_SV
(SUPERVISOR_STAFF_ID, D_DATE, DATES_MONTH, DATES_MONTH_NUM, DATES_YEAR, 
 DATES_QTR_YEAR, BUILDING, DEPARTMENT, EXCLUSION_FLAG, TOT_CALLS_ANSWERED, 
 TOT_SHORT_CALLS_ANSWERED, TOT_TOT_RETURN_TO_QUEUE, TOT_AVERAGE_HANDLE_TIME, TOT_SCHED_PRODUCTIVE_TIME, TOT_ACTUAL_PRODUCTIVE_TIME, 
 TOT_TALK_TIME, TOT_WRAP_UP_TIME, TOT_LOGGED_IN_TIME, TOT_NOT_READY_TIME, TOT_BREAK_TIME, 
 TOT_LUNCH_TIME, QCS_PERFORMED, AVG_QC_SCORE, QCS_REMAINING, TOT_INCIDENTS_COMPLETED, 
 DAYS_INCIDENTS_COMPLETED, TOT_DEFECTS_COMPLETED, DAYS_DEFECTS_COMPLETED, LAG_TIME_TOT_SCHED_PROD_TIME, TOT_CALL_RECORDS, 
 TOT_CUSTOMER_COUNT, TOT_CALL_WRAP_UP_COUNT, TOT_WRAP_UP_ERROR, DAYS_SHORT_CALLS_GT_10, DAYS_CALLS_ANSWERED, 
 ADHERENCE, TOT_RETURN_TO_QUEUE_TIMEOUT, AVG_ATTENDANCE_BALANCE, AVG_ATTENDANCE_TOTAL_BALANCE, STAFF_COUNT, 
 SUM_QC_SCORE, COUNT_QC_SCORE, TOT_HANDLE_TIME, TOT_HANDLE_TIME_COUNT, STAFF_TRTQ_COUNT, 
 SHORT_CALL_AGENT_COUNT, ADHERENCE_TOT_LOGGED_IN_TIME, ADHERENCE_TOT_NOT_READY_TIME, CALLS_OFFERED)
BEQUEATH DEFINER
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
       Short_Call_Agent_Count,
		ADHERENCE_TOT_LOGGED_IN_TIME,
		ADHERENCE_TOT_NOT_READY_TIME,
		CALLS_OFFERED
  from dp_scorecard.sc_summary_cc_rollup;


GRANT INSERT, SELECT, UPDATE ON DP_SCORECARD.SCORECARD_SUMMARY_CC_ROLLUP_SV TO DP_SCORECARD_OLTP_SIU;

GRANT DELETE, INSERT, SELECT, UPDATE ON DP_SCORECARD.SCORECARD_SUMMARY_CC_ROLLUP_SV TO DP_SCORECARD_OLTP_SIUD;

GRANT SELECT ON DP_SCORECARD.SCORECARD_SUMMARY_CC_ROLLUP_SV TO DP_SCORECARD_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.SCORECARD_SUMMARY_CC_ROLLUP_SV TO MAXDAT;

GRANT SELECT ON DP_SCORECARD.SCORECARD_SUMMARY_CC_ROLLUP_SV TO MAXDAT_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.SCORECARD_SUMMARY_CC_ROLLUP_SV TO MAXDAT_REPORTS;
