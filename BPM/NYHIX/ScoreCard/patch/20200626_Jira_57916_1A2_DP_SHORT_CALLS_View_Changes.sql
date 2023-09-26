--------------------------------------------------------------------------------------
-----------------------SCORECARD_SUMMARY_CC_SV VIEW UPDATES---------------------------
--------------------------------------------------------------------------------------
  CREATE OR REPLACE FORCE EDITIONABLE VIEW "DP_SCORECARD"."SCORECARD_SUMMARY_CC_SV" ("STAFF_STAFF_ID", "STAFF_STAFF_NAME", "STAFF_NATID", "DATES_MONTH", "DATES_MONTH_NUM", "DATES_YEAR", "DATES_QTR_YEAR", "EXCLUSION_FLAG", "TOT_CALLS_ANSWERED", 
  "TOT_SHORT_CALLS_ANSWERED", "TOT_TOT_RETURN_TO_QUEUE", "TOT_RET_TO_QUEUE_TOTAL", "TOT_AVERAGE_HANDLE_TIME", "TOT_SCHED_PRODUCTIVE_TIME", "TOT_ACTUAL_PRODUCTIVE_TIME", "TOT_TALK_TIME", "TOT_WRAP_UP_TIME", "TOT_LOGGED_IN_TIME", 
  "TOT_NOT_READY_TIME", "TOT_BREAK_TIME", "TOT_LUNCH_TIME", "QCS_PERFORMED", "AVG_QC_SCORE", "TOT_INCIDENTS_COMPLETED", "DAYS_INCIDENTS_COMPLETED", "TOT_DEFECTS_COMPLETED", "DAYS_DEFECTS_COMPLETED", "TOT_CALL_RECORDS", "TOT_CUSTOMER_COUNT", 
  "TOT_CALL_WRAP_UP_COUNT", "TOT_WRAP_UP_ERROR", "DAYS_SHORT_CALLS_GT_10", "DAYS_CALLS_ANSWERED", "BALANCE", "TOTAL_BALANCE", "ADHERENCE", "CORRECTIVE_ACTION_FLAG", "ONE_ON_ONE_FLAG", "OBSERVATION_FLAG", "RECORDED_CALL_REVIEW_FLAG",
  "LIVE_PHONE_OBSERVATION_FLAG", "ADHERENCE_TOT_LOGGED_IN_TIME", "ADHERENCE_TOT_NOT_READY_TIME", "LAG_TIME_TOT_SCHED_PROD_TIME", "DAYS_DEF_INC_COMPLETED", "SUM_QC_SCORE", "CALLS_OFFERED", "WEBCHAT_ASSIGNED", "WEBCHAT_TRANSFERRED", 
  "WEBCHAT_CONFERENCED", "WEBCHAT_TOTAL_NUMBER", "SHORT_CALLS_DISCONNECTED_BY_AGENT", "SHORT_CALLS_DISCONNECTED_BY_CONSUMER", "CURRENT_MONTH_EVENTS_SCHEDULED", "CURRENT_MONTH_EVENTS_MET", "FIRST_PRIOR_MONTH_EVENTS_SCHEDULED", 
  "FIRST_PRIOR_MONTH_EVENTS_MET", "SECOND_PRIOR_MONTH_EVENTS_SCHEDULED", "SECOND_PRIOR_MONTH_EVENTS_MET", "FIRST_PRIOR_MONTH_ADHERENCE_TOT_LOGGED_IN_TIME", "FIRST_PRIOR_MONTH_ADHERENCE_TOT_NOT_READY_TIME", 
  "FIRST_PRIOR_MONTH_ADHERENCE_LAG_TIME_TOT_SCHED_PROD_TIME", "SECOND_PRIOR_MONTH_ADHERENCE_TOT_LOGGED_IN_TIME", "SECOND_PRIOR_MONTH_ADHERENCE_TOT_NOT_READY_TIME", "SECOND_PRIOR_MONTH_ADHERENCE_LAG_TIME_TOT_SCHED_PROD_TIME", 
  "THREE_MONTH_CONFORMANCE_MISSED_COUNT", "THREE_MONTH_AVG_ADHERENCE", "THREE_MONTH_ADHERENCE_CONFORMANCE_FLAG", "MONTHLY_CONFORMANCE_FLAG", "CC_QIP_FLAG", 
  "THREE_MONTH_ADHERENCE_MISSED_COUNT","THREE_MONTH_SHORT_CALLS_REQ_MISSED_COUNT","THREE_MONTH_ADHERENCE_FLAG", "THREE_MONTH_SHORT_CALLS_FLAG", "MONTHLY_SHORT_CALLS_FLAG") AS 
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
                        ON a.staff_staff_id = h.staff_staff_id),
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
           (a10.tot_tot_return_to_queue + a10.Tot_Return_to_Queue_Timeout) AS Tot_Ret_to_Queue_Total,
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
           a10.tot_call_records,
           a10.tot_customer_count,
           a10.tot_call_wrap_up_count,
           a10.tot_wrap_up_error,
           a10.days_short_calls_gt_10,
           a10.days_calls_answered,
           a11.balance,
           a11.total_balance,
           a10.adherence,
           COALESCE (a10.corrective_action_flag, 0) AS corrective_action_flag,
           COALESCE (a10.one_on_one_flag, 0) AS one_on_one_flag,
           COALESCE (a10.observation_flag, 0) AS observation_flag,
           NVL (PT.Recorded_Call_Review_flag, 0) AS Recorded_Call_Review_flag,
           NVL (PT.Live_Phone_Observation_flag, 0) AS Live_Phone_Observation_flag,
           NVL (ADHERENCE_TOT_LOGGED_IN_TIME, 0) AS ADHERENCE_TOT_LOGGED_IN_TIME,
           NVL (ADHERENCE_TOT_NOT_READY_TIME, 0) AS ADHERENCE_TOT_NOT_READY_TIME,
           NVL (LAG_TIME_TOT_SCHED_PROD_TIME, 0) AS LAG_TIME_TOT_SCHED_PROD_TIME,
           NVL (DAYS_DEF_INC_COMPLETED, 0) AS DAYS_DEF_INC_COMPLETED,
           NVL (SUM_QC_SCORE, 0) AS SUM_QC_SCORE,
            A10.CALLS_OFFERED,
		    A10.WEBCHAT_ASSIGNED, 
		    A10.WEBCHAT_TRANSFERRED, 
		    A10.WEBCHAT_CONFERENCED, 
			A10.WEBCHAT_TOTAL_NUMBER,
			A10.AGENT_DISCONNECTED_SHORT_CALLS		AS SHORT_CALLS_DISCONNECTED_BY_AGENT,    
			A10.CONSUMER_DISCONNECTED_SHORT_CALLS	AS SHORT_CALLS_DISCONNECTED_BY_CONSUMER,
			A10.CURRENT_MONTH_EVENTS_SCHEDULED,    
			A10.CURRENT_MONTH_EVENTS_MET,          
			A10.FIRST_PRIOR_MONTH_EVENTS_SCHEDULED,   
			A10.FIRST_PRIOR_MONTH_EVENTS_MET,         
			A10.SECOND_PRIOR_MONTH_EVENTS_SCHEDULED,  
			A10.SECOND_PRIOR_MONTH_EVENTS_MET,
			A10.FIRST_PRIOR_MONTH_ADHERENCE_TOT_LOGGED_IN_TIME,
			A10.FIRST_PRIOR_MONTH_ADHERENCE_TOT_NOT_READY_TIME,
			A10.FIRST_PRIOR_MONTH_ADHERENCE_LAG_TIME_TOT_SCHED_PROD_TIME,
			A10.SECOND_PRIOR_MONTH_ADHERENCE_TOT_LOGGED_IN_TIME,
			A10.SECOND_PRIOR_MONTH_ADHERENCE_TOT_NOT_READY_TIME,
			A10.SECOND_PRIOR_MONTH_ADHERENCE_LAG_TIME_TOT_SCHED_PROD_TIME,
			A10.THREE_MONTH_CONFORMANCE_MISSED_COUNT,
			A10.THREE_MONTH_AVG_ADHERENCE,
			nvl(A10.THREE_MONTH_ADHERENCE_CONFORMANCE_FLAG,0) as THREE_MONTH_ADHERENCE_CONFORMANCE_FLAG,
            nvl(A10.MONTHLY_CONFORMANCE_FLAG,0) as MONTHLY_CONFORMANCE_FLAG,
            nvl(a10.CC_QIP_FLAG,0)             as CC_QIP_FLAG,
            A10.THREE_MONTH_ADHERENCE_MISSED_COUNT,
            A10.THREE_MONTH_SHORT_CALLS_REQ_MISSED_COUNT,
            nvl(A10.THREE_MONTH_ADHERENCE_FLAG,0) as THREE_MONTH_ADHERENCE_FLAG,
			nvl(A10.THREE_MONTH_SHORT_CALLS_FLAG,0) as THREE_MONTH_SHORT_CALLS_FLAG,
            nvl(A10.MONTHLY_SHORT_CALLS_FLAG,0) as MONTHLY_SHORT_CALLS_FLAG
FROM ATTEND_Metrics  a11
           LEFT OUTER JOIN dp_scorecard.sc_summary_cc a10
               ON     a11.staff_staff_id = a10.staff_staff_id
                  AND a11.dates_month_num = a10.dates_month_num
           LEFT OUTER JOIN PERMFORM_TKR PT
               ON     a11.staff_staff_id = pt.staff_staff_id
                  AND a11.dates_month_num = pt.dates_month_num;
/
SHOW ERRORS
commit;
grant select on "DP_SCORECARD"."SCORECARD_SUMMARY_CC_SV" to MAXDAT;
grant select on "DP_SCORECARD"."SCORECARD_SUMMARY_CC_SV" to MAXDAT_REPORTS;
grant select on "DP_SCORECARD"."SCORECARD_SUMMARY_CC_SV" to MAXDAT_READ_ONLY;
grant select on "DP_SCORECARD"."SCORECARD_SUMMARY_CC_SV" to DP_SCORECARD_READ_ONLY;
commit;
--------------------------------------------------------------------------------------
--------------------SCORECARD_SUMMARY_CC_ROLLUP_SV VIEW UPDATES-----------------------
--------------------------------------------------------------------------------------
 CREATE OR REPLACE FORCE EDITIONABLE VIEW "DP_SCORECARD"."SCORECARD_SUMMARY_CC_ROLLUP_SV" ("SUPERVISOR_STAFF_ID", "D_DATE", "DATES_MONTH", "DATES_MONTH_NUM", "DATES_YEAR", "DATES_QTR_YEAR", "BUILDING", "DEPARTMENT", "EXCLUSION_FLAG", 
  "TOT_CALLS_ANSWERED", "TOT_SHORT_CALLS_ANSWERED", "TOT_TOT_RETURN_TO_QUEUE", "TOT_AVERAGE_HANDLE_TIME", "TOT_SCHED_PRODUCTIVE_TIME", "TOT_ACTUAL_PRODUCTIVE_TIME", "TOT_TALK_TIME", "TOT_WRAP_UP_TIME", "TOT_LOGGED_IN_TIME", "TOT_NOT_READY_TIME", 
  "TOT_BREAK_TIME", "TOT_LUNCH_TIME", "QCS_PERFORMED", "AVG_QC_SCORE", "TOT_INCIDENTS_COMPLETED", "DAYS_INCIDENTS_COMPLETED", "TOT_DEFECTS_COMPLETED", "DAYS_DEFECTS_COMPLETED", "LAG_TIME_TOT_SCHED_PROD_TIME", "TOT_CALL_RECORDS",
  "TOT_CUSTOMER_COUNT", "TOT_CALL_WRAP_UP_COUNT", "TOT_WRAP_UP_ERROR", "DAYS_SHORT_CALLS_GT_10", "DAYS_CALLS_ANSWERED", "ADHERENCE", "TOT_RETURN_TO_QUEUE_TIMEOUT", "AVG_ATTENDANCE_BALANCE", "AVG_ATTENDANCE_TOTAL_BALANCE", "STAFF_COUNT", 
  "SUM_QC_SCORE", "COUNT_QC_SCORE", "QCS_REMAINING", "TOT_HANDLE_TIME", "TOT_HANDLE_TIME_COUNT", "STAFF_TRTQ_COUNT", "SHORT_CALL_AGENT_COUNT", "ADHERENCE_TOT_LOGGED_IN_TIME", "ADHERENCE_TOT_NOT_READY_TIME", "CALLS_OFFERED", 
  "WEBCHAT_ASSIGNED", "WEBCHAT_TRANSFERRED", "WEBCHAT_CONFERENCED", "WEBCHAT_TOTAL_NUMBER", "SHORT_CALLS_DISCONNECTED_BY_AGENT", "SHORT_CALLS_DISCONNECTED_BY_CONSUMER", "CURRENT_MONTH_EVENTS_SCHEDULED", "CURRENT_MONTH_EVENTS_MET", 
  "FIRST_PRIOR_MONTH_EVENTS_SCHEDULED", "FIRST_PRIOR_MONTH_EVENTS_MET", "SECOND_PRIOR_MONTH_EVENTS_SCHEDULED", "SECOND_PRIOR_MONTH_EVENTS_MET", "FIRST_PRIOR_MONTH_ADHERENCE_TOT_LOGGED_IN_TIME", "FIRST_PRIOR_MONTH_ADHERENCE_TOT_NOT_READY_TIME", 
  "FIRST_PRIOR_MONTH_ADHERENCE_LAG_TIME_TOT_SCHED_PROD_TIME", "SECOND_PRIOR_MONTH_ADHERENCE_TOT_LOGGED_IN_TIME", "SECOND_PRIOR_MONTH_ADHERENCE_TOT_NOT_READY_TIME", "SECOND_PRIOR_MONTH_ADHERENCE_LAG_TIME_TOT_SCHED_PROD_TIME", 
  "THREE_MONTH_CONFORMANCE_MISSED_COUNT", "THREE_MONTH_AVG_ADHERENCE", "THREE_MONTH_ADHERENCE_FLAG", "MONTHLY_CONFORMANCE_FLAG", "THREE_MONTH_TRTQ_TSC_FLAG", "THREE_MONTH_TEAM_QUALITY_DT_AGG_FLAG", "THREE_MONTH_TEAM_ADHERENCE_DT_AGG_FLAG") AS 
  SELECT 
  SUPERVISOR_STAFF_ID,
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
  BUILDING, DEPARTMENT, EXCLUSION_FLAG, 
 TOT_CALLS_ANSWERED, TOT_SHORT_CALLS_ANSWERED, TOT_TOT_RETURN_TO_QUEUE, TOT_AVERAGE_HANDLE_TIME, 
 TOT_SCHED_PRODUCTIVE_TIME, TOT_ACTUAL_PRODUCTIVE_TIME, TOT_TALK_TIME, TOT_WRAP_UP_TIME, TOT_LOGGED_IN_TIME, TOT_NOT_READY_TIME, 
 TOT_BREAK_TIME, TOT_LUNCH_TIME, QCS_PERFORMED, AVG_QC_SCORE, 
 TOT_INCIDENTS_COMPLETED, DAYS_INCIDENTS_COMPLETED, TOT_DEFECTS_COMPLETED, DAYS_DEFECTS_COMPLETED, 
 LAG_TIME_TOT_SCHED_PROD_TIME, TOT_CALL_RECORDS, TOT_CUSTOMER_COUNT, 
 TOT_CALL_WRAP_UP_COUNT, TOT_WRAP_UP_ERROR, DAYS_SHORT_CALLS_GT_10, DAYS_CALLS_ANSWERED, 
 ADHERENCE, TOT_RETURN_TO_QUEUE_TIMEOUT, AVG_ATTENDANCE_BALANCE, AVG_ATTENDANCE_TOTAL_BALANCE, 
 STAFF_COUNT, SUM_QC_SCORE, COUNT_QC_SCORE, QCS_REMAINING, TOT_HANDLE_TIME, TOT_HANDLE_TIME_COUNT, 
 STAFF_TRTQ_COUNT, SHORT_CALL_AGENT_COUNT, ADHERENCE_TOT_LOGGED_IN_TIME, 
 ADHERENCE_TOT_NOT_READY_TIME, CALLS_OFFERED, WEBCHAT_ASSIGNED, WEBCHAT_TRANSFERRED, WEBCHAT_CONFERENCED, 
 WEBCHAT_TOTAL_NUMBER, 
 AGENT_DISCONNECTED_SHORT_CALLS		AS SHORT_CALLS_DISCONNECTED_BY_AGENT, 
 CONSUMER_DISCONNECTED_SHORT_CALLS	AS SHORT_CALLS_DISCONNECTED_BY_CONSUMER, 
 CURRENT_MONTH_EVENTS_SCHEDULED, CURRENT_MONTH_EVENTS_MET, 
 FIRST_PRIOR_MONTH_EVENTS_SCHEDULED, FIRST_PRIOR_MONTH_EVENTS_MET, 
 SECOND_PRIOR_MONTH_EVENTS_SCHEDULED, SECOND_PRIOR_MONTH_EVENTS_MET, 
 FIRST_PRIOR_MONTH_ADHERENCE_TOT_LOGGED_IN_TIME, FIRST_PRIOR_MONTH_ADHERENCE_TOT_NOT_READY_TIME, 
 FIRST_PRIOR_MONTH_ADHERENCE_LAG_TIME_TOT_SCHED_PROD_TIME, 
 SECOND_PRIOR_MONTH_ADHERENCE_TOT_LOGGED_IN_TIME, SECOND_PRIOR_MONTH_ADHERENCE_TOT_NOT_READY_TIME, 
 SECOND_PRIOR_MONTH_ADHERENCE_LAG_TIME_TOT_SCHED_PROD_TIME, 
 THREE_MONTH_CONFORMANCE_MISSED_COUNT, 
 THREE_MONTH_AVG_ADHERENCE, 
 THREE_MONTH_ADHERENCE_FLAG, 
 MONTHLY_CONFORMANCE_FLAG,
 THREE_MONTH_TRTQ_TSC_FLAG,
 THREE_MONTH_TEAM_QUALITY_DT_AGG_FLAG,
 THREE_MONTH_TEAM_ADHERENCE_DT_AGG_FLAG
 FROM DP_SCORECARD.SC_SUMMARY_CC_ROLLUP;
/
SHOW ERRORS
commit;
grant select on "DP_SCORECARD"."SCORECARD_SUMMARY_CC_ROLLUP_SV" to MAXDAT;
grant select on "DP_SCORECARD"."SCORECARD_SUMMARY_CC_ROLLUP_SV" to MAXDAT_REPORTS;
grant select on "DP_SCORECARD"."SCORECARD_SUMMARY_CC_ROLLUP_SV" to MAXDAT_READ_ONLY;
grant select on "DP_SCORECARD"."SCORECARD_SUMMARY_CC_ROLLUP_SV" to DP_SCORECARD_READ_ONLY;
commit;