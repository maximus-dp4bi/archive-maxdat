ALTER SESSION SET CURRENT_SCHEMA=DP_SCORECARD;

CREATE or replace VIEW DP_SCORECARD.SCORECARD_SUMMARY_CC_ROLLUP_SV
AS SELECT supervisor_staff_id,
		TO_DATE (dates_month_num, 'YYYYMM')
			AS d_date,
		dates_month,
		dates_month_num,
		dates_year,
			'Q'
		|| TO_CHAR (ADD_MONTHS (TO_DATE (dates_month_num, 'yyyymm'), +3),
					'Q')
		|| ' '
		|| TO_CHAR (ADD_MONTHS (TO_DATE (dates_month_num, 'yyyymm'), +3),
					'YYYY')
			AS dates_qtr_year,
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
		CALLS_OFFERED,
		WEBCHAT_ASSIGNED,
		WEBCHAT_TRANSFERRED,
		WEBCHAT_CONFERENCED,
		WEBCHAT_TOTAL_NUMBER,
    nvl(tot_calls_answered,0)  as EVENTS_SCHEDULED,
     tot_calls_answered -1   AS EVENTS_MET,
    tot_calls_answered+1 AS SHORT_CALLS_DISCONNECTED_BY_AGENT,
    
  tot_calls_answered+3 AS SHORT_CALLS_DISCONNECTED_BY_CONSUMER,
  CASE WHEN days_incidents_completed=1 THEN 1 WHEN days_incidents_completed=2 THEN 2 WHEN days_incidents_completed=3 THEN 3
  WHEN days_incidents_completed=4 THEN 4 ELSE 5 END AS ADHERENCE_FLAG ,
  CASE WHEN days_incidents_completed is null  THEN 0 ELSE 1 END AS CONFORMANCE_FLAG 
	FROM dp_scorecard.sc_summary_cc_rollup;
  
    GRANT select on DP_SCORECARD.SCORECARD_SUMMARY_CC_ROLLUP_SV to MAXDAT_READ_ONLY;
    
      
    
     
  CREATE OR REPLACE FORCE EDITIONABLE VIEW "DP_SCORECARD"."SCORECARD_SUMMARY_CC_SV" ("STAFF_STAFF_ID", 
  "STAFF_STAFF_NAME", "STAFF_NATID", "DATES_MONTH", "DATES_MONTH_NUM", "DATES_YEAR", "DATES_QTR_YEAR",
  "EXCLUSION_FLAG", "TOT_CALLS_ANSWERED", "TOT_SHORT_CALLS_ANSWERED", "TOT_TOT_RETURN_TO_QUEUE", 
  "TOT_RET_TO_QUEUE_TOTAL", "TOT_AVERAGE_HANDLE_TIME", "TOT_SCHED_PRODUCTIVE_TIME", "TOT_ACTUAL_PRODUCTIVE_TIME", 
  "TOT_TALK_TIME", "TOT_WRAP_UP_TIME", "TOT_LOGGED_IN_TIME", "TOT_NOT_READY_TIME", "TOT_BREAK_TIME", "TOT_LUNCH_TIME", 
  "QCS_PERFORMED", "AVG_QC_SCORE", "TOT_INCIDENTS_COMPLETED", "DAYS_INCIDENTS_COMPLETED", "TOT_DEFECTS_COMPLETED",
  "DAYS_DEFECTS_COMPLETED", "TOT_CALL_RECORDS", "TOT_CUSTOMER_COUNT", "TOT_CALL_WRAP_UP_COUNT", "TOT_WRAP_UP_ERROR", 
  "DAYS_SHORT_CALLS_GT_10", "DAYS_CALLS_ANSWERED", "BALANCE", "TOTAL_BALANCE", "ADHERENCE", "CORRECTIVE_ACTION_FLAG", 
  "ONE_ON_ONE_FLAG", "OBSERVATION_FLAG", "RECORDED_CALL_REVIEW_FLAG", "LIVE_PHONE_OBSERVATION_FLAG", 
  "ADHERENCE_TOT_LOGGED_IN_TIME", "ADHERENCE_TOT_NOT_READY_TIME", "LAG_TIME_TOT_SCHED_PROD_TIME", 
  "DAYS_DEF_INC_COMPLETED", "SUM_QC_SCORE", "CALLS_OFFERED", "WEBCHAT_ASSIGNED", "WEBCHAT_TRANSFERRED",
  "WEBCHAT_CONFERENCED", "WEBCHAT_TOTAL_NUMBER","EVENTS_SCHEDULED","EVENTS_MET","SHORT_CALLS_DISCONNECTED_BY_AGENT",
  "SHORT_CALLS_DISCONNECTED_BY_CONSUMER","ADHERENCE_FLAG", "CONFORMANCE_FLAG"
   
  ) AS 
  WITH
        ATTEND_Metrics
        AS
            (SELECT a.staff_staff_id,
                    a.staff_staff_name,
                    h.staff_natid,
                    a.dates_month,
                    a.dates_month_num,
                    a.dates_year,
                       'Q'
                    || TO_CHAR (
                           ADD_MONTHS (TO_DATE (a.dates_month_num, 'yyyymm'),
                                       +3),
                           'Q')
                    || ' '
                    || TO_CHAR (
                           ADD_MONTHS (TO_DATE (a.dates_month_num, 'yyyymm'),
                                       +3),
                           'YYYY')
                        AS dates_qtr_year,
                    a.balance,
                    a.total_balance,
                    a.sc_attendance_id
               FROM dp_scorecard.scorecard_attendance_mthly_sv  a
                    JOIN dp_scorecard.scorecard_hierarchy_sv h
                        ON a.staff_staff_id = h.staff_staff_id--  where a.dates_month_num >= to_char(add_months(sysdate,-11),'YYYYMM')
                                                              ),
        PERMFORM_TKR
        AS
            (  SELECT DISTINCT
                      staff_staff_id,
                      TO_CHAR (TRUNC (pt_entry_date), 'YYYYMM')
                          AS dates_month_num,
                      TO_CHAR (TRUNC (pt_entry_date), 'Month YYYY')
                          AS dates_year,
                      MAX (
                          CASE
                              WHEN discussion_topic = 'Corrective Action'
                              THEN
                                  1
                              ELSE
                                  0
                          END)
                          AS corrective_action_flag,
                      MAX (
                          CASE
                              WHEN discussion_topic = 'One on One' THEN 1
                              ELSE 0
                          END)
                          AS one_on_one_flag,
                      MAX (
                          CASE
                              WHEN discussion_topic = 'Observation' THEN 1
                              ELSE 0
                          END)
                          AS observation_flag,
                      MAX (
                          CASE
                              WHEN discussion_topic = 'Recorded Call Review'
                              THEN
                                  1
                              ELSE
                                  0
                          END)
                          AS Recorded_Call_Review_flag,
                      MAX (
                          CASE
                              WHEN discussion_topic =
                                   'Real Time Phone Observation'
                              THEN
                                  1
                              ELSE
                                  0
                          END)
                          AS Live_Phone_Observation_flag
                 FROM dp_scorecard.scorecard_perform_tracker_sv PERF
                WHERE discussion_topic IN ('Corrective Action',
                                           'One on One',
                                           'Observation',
                                           'Recorded Call Review',
                                           'Real Time Phone Observation')
             -- and to_char(TRUNC(pt_entry_date), 'YYYYMM') >= to_char(add_months(sysdate,-11),'YYYYMM')
             GROUP BY staff_staff_id,
                      TO_CHAR (TRUNC (pt_entry_date), 'YYYYMM'),
                      TO_CHAR (TRUNC (pt_entry_date), 'Month YYYY'))
    SELECT DISTINCT
           a11.staff_staff_id,
           a11.staff_staff_name,
           a11.staff_natid,
           a11.dates_month,
           a11.dates_month_num,
           a11.dates_year,
           a11.dates_qtr_year,
           a10.exclusion_flag,
           a10.tot_calls_answered,
           a10.tot_short_calls_answered,
           a10.tot_tot_return_to_queue,
           (a10.tot_tot_return_to_queue + a10.Tot_Return_to_Queue_Timeout)
               AS Tot_Ret_to_Queue_Total,
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
           --        a10.lag_time_tot_sched_prod_time,
           a10.tot_call_records,
           a10.tot_customer_count,
           a10.tot_call_wrap_up_count,
           a10.tot_wrap_up_error,
           a10.days_short_calls_gt_10,
           a10.days_calls_answered,
           a11.balance,
           a11.total_balance,
           a10.adherence,
           COALESCE (a10.corrective_action_flag, 0)
               AS corrective_action_flag,
           COALESCE (a10.one_on_one_flag, 0)
               AS one_on_one_flag,
           COALESCE (a10.observation_flag, 0)
               AS observation_flag,
           NVL (PT.Recorded_Call_Review_flag, 0)
               AS Recorded_Call_Review_flag,
           NVL (PT.Live_Phone_Observation_flag, 0)
               AS Live_Phone_Observation_flag,
           -- NYHIX-37722
           NVL (ADHERENCE_TOT_LOGGED_IN_TIME, 0)
               AS ADHERENCE_TOT_LOGGED_IN_TIME,
           NVL (ADHERENCE_TOT_NOT_READY_TIME, 0)
               AS ADHERENCE_TOT_NOT_READY_TIME,
           NVL (LAG_TIME_TOT_SCHED_PROD_TIME, 0)
               AS LAG_TIME_TOT_SCHED_PROD_TIME,
           NVL (DAYS_DEF_INC_COMPLETED, 0)
               AS DAYS_DEF_INC_COMPLETED,
           -----
           NVL (SUM_QC_SCORE, 0)
               AS SUM_QC_SCORE,
            A10.CALLS_OFFERED,
		    A10.WEBCHAT_ASSIGNED, 
		    A10.WEBCHAT_TRANSFERRED, 
		    A10.WEBCHAT_CONFERENCED, 
			A10.WEBCHAT_TOTAL_NUMBER,
            nvl(tot_calls_answered,0)  as EVENTS_SCHEDULED,
     tot_calls_answered -1   AS EVENTS_MET,
    tot_calls_answered+1 AS SHORT_CALLS_DISCONNECTED_BY_AGENT,    
  tot_calls_answered+3 AS SHORT_CALLS_DISCONNECTED_BY_CONSUMER,
  CASE WHEN days_incidents_completed=1 THEN 1 WHEN days_incidents_completed=2 THEN 2 WHEN days_incidents_completed=3 THEN 3
  WHEN days_incidents_completed=4 THEN 4 ELSE 5 END AS ADHERENCE_FLAG ,
  CASE WHEN days_incidents_completed is null  THEN 0 ELSE 1 END AS CONFORMANCE_FLAG 
FROM ATTEND_Metrics  a11
           LEFT OUTER JOIN dp_scorecard.sc_summary_cc a10
               ON     a11.staff_staff_id = a10.staff_staff_id
                  AND a11.dates_month_num = a10.dates_month_num
           LEFT OUTER JOIN PERMFORM_TKR PT
               ON     a11.staff_staff_id = pt.staff_staff_id
                  AND a11.dates_month_num = pt.dates_month_num;
                  
                 GRANT select on DP_SCORECARD.SCORECARD_SUMMARY_CC_SV to MAXDAT_READ_ONLY;
